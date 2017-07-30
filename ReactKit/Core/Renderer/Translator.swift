//
//  Translator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

// TODO: Separate Layout code from translation code
///
/// Translates an external View representation (Containers and Component) into an internal
/// virutal representation (Sections and Rows).
///
final class Translator {

    /// Data calculated from rows in a section
    struct RowCalculation {
        let rows: [Row]
        let height: CGFloat
    }


    static func translateSections(from component: Component, in frame: CGRect) -> [Section] {
        guard let container = component.render() as? Container else {
            return []
        }

        /// translator builds from leaf components back to root, so height will be
        /// calculated last
        let startingFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        return translateSections(from: container, in: startingFrame, at: 0)
    }

    static func translateSections(from container: Container, in frame: CGRect, at index: Int) -> [Section] {
        // vars for rows
        var currentRowIndex = 0
        var currentRows: [Row] = []

        // vars for sections
        var currentSectionIndex = index
        var childSections: [Section] = []
        var previousSectionFrame = frame
        let sectionNewLineX = frame.origin.x
        var sectionMaxY = getMaxY(for: previousSectionFrame, currentMaxY: frame.origin.y)

        container.components.forEach { baseComponent in
            switch baseComponent.componentType {
            case .container(let childContainer): // recurse

                let childSectionWidth = widthFor(dimension: childContainer.layout.dimension, in: frame.width)
                let childSectionOrigin = originFor(width: childSectionWidth,
                                                   previousFrame: previousSectionFrame,
                                                   inSectionWidth: frame.width,
                                                   sectionOrigin: frame.origin,
                                                   newLineXPos: sectionNewLineX,
                                                   maxY: sectionMaxY)

                let childSectionFrame = CGRect(origin: childSectionOrigin,
                                               size: CGSize(width: childSectionWidth,
                                                            height: frame.height))

                sectionMaxY = getMaxY(for: childSectionFrame, currentMaxY: sectionMaxY)
                previousSectionFrame = childSectionFrame
                currentSectionIndex = currentSectionIndex + 1

                let children = translateSections(from: childContainer, in: childSectionFrame, at: currentSectionIndex)
                childSections.append(contentsOf: children)

            case .component(let component): // base case
                if let row = translateRows(from: component, in: currentSectionIndex, at: currentRowIndex) {
                    currentRowIndex = currentRowIndex + 1
                    currentRows.append(row)
                }
            }
        }

        let sectionWidth = frame.width
        let rowsCalculation = calculateRowData(from: currentRows, in: sectionWidth, at: frame.origin)
        currentRows = rowsCalculation.rows

        let sectionHeight = childSections.reduce(0) { (height, section) in
            return getMaxY(for: section.layout.frame, currentMaxY: height)
        }

        let totalSectionHeight = sectionHeight + rowsCalculation.height

        let sectionLayout = SectionLayout(width: sectionWidth,
                                                   height: totalSectionHeight,
                                                   parentOrigin: frame.origin)

        let section = Section(index: index,
                                       rows: currentRows,
                                       layout: sectionLayout)

        return [section] + childSections
    }

    static func translateRows(from component: Component, in section: Int, at index: Int) -> Row? {
        guard let view = component as? SingleViewComponent else {
            return nil
        }
        let dimension = component.props.layout?.dimension ?? .fill
        let height = component.props.layout?.height ?? 0

        let row = Row(view: view.reduce(),
                      props: component.props,
                      index: index,
                      section: section,
                      layout: RowLayout(dimension: dimension, height: height))
        return row
    }

    // MARK: -  Layout

    static func calculateRowData(from rows: [Row], in width: CGFloat, at origin: CGPoint) -> RowCalculation  {
        var previousFrame = CGRect(origin: origin, size: .zero)
        let newLineX = origin.x
        var maxY = getMaxY(for: previousFrame, currentMaxY: 0) // next Y pos, also total height of rows in section

        let calculatedRows: [Row] = rows.map { row in
            let height = row.layout.height

            let rowWidth = widthFor(dimension: row.layout.dimension, in: width)

            let newOrigin = originFor(width: rowWidth,
                                      previousFrame: previousFrame,
                                      inSectionWidth: width,
                                      sectionOrigin: origin,
                                      newLineXPos: newLineX,
                                      maxY: maxY)

            let newFrame = CGRect(x: newOrigin.x,
                                  y: newOrigin.y,
                                  width: rowWidth,
                                  height: height)

            maxY = getMaxY(for: newFrame, currentMaxY: maxY)
            previousFrame = newFrame

            let layout = RowLayout(layout: row.layout, newFrame: newFrame)
            return Row(row: row, layout: layout)
        }

        return RowCalculation(rows: calculatedRows, height: maxY)
    }

    static func originFor(width: CGFloat, previousFrame: CGRect, inSectionWidth sectionWidth: CGFloat, sectionOrigin: CGPoint, newLineXPos: CGFloat, maxY: CGFloat) -> CGPoint {

        // need to account for a secion origin being non-zero
        let originXFromSectionOrigin = sectionOrigin.x == 0 ? previousFrame.origin.x : sectionOrigin.x - previousFrame.origin.x

        let remainder = sectionWidth - (originXFromSectionOrigin + previousFrame.width)

        if width > remainder {
            // wrap
            return CGPoint(x: newLineXPos, y: maxY)
        } else {
            // inline
            return CGPoint(x: (previousFrame.origin.x + previousFrame.size.width), y: previousFrame.origin.y)
        }
    }

    static func getMaxY(for newFrame: CGRect, currentMaxY: CGFloat) -> CGFloat {
        return newFrame.origin.y + newFrame.height > currentMaxY ? (newFrame.origin.y + newFrame.height) : currentMaxY
    }

    static func widthFor(dimension: FlexDimension, in parentWidth: CGFloat) -> CGFloat {
        switch dimension {
        case .fill:
            return parentWidth
        case .fixed(let size):
            return size.width
        case .ratio(let ratio):
            return round(parentWidth * ratio)
        }
    }
}

