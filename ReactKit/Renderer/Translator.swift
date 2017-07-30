//
//  Translator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

final class Translator {

    struct RowData {
        let rows: [RowComponent]
        let height: CGFloat
    }

    static func translateSections(from component: Component, in frame: CGRect) -> [SectionComponent] {
        guard let container = component.render() as? Container else {
            return []
        }

        let newFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        return translateSections(from: container, in: newFrame, at: 0)
    }

    static func translateSections(from container: Container, in frame: CGRect, at index: Int) -> [SectionComponent] {
        // vars for rows
        var currentRowIndex = 0
        var currentRows: [RowComponent] = []

        // vars for sections
        var currentSectionIndex = index
        var childSections: [SectionComponent] = []
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
                                                   newLineXPos: sectionNewLineX,
                                                   maxY: sectionMaxY)

                let childSectionFrame = CGRect(origin: childSectionOrigin, size: CGSize(width: childSectionWidth, height: frame.height))
                sectionMaxY = getMaxY(for: childSectionFrame, currentMaxY: sectionMaxY)
                previousSectionFrame = childSectionFrame
                currentSectionIndex = currentSectionIndex + 1

                let children = translateSections(from: childContainer, in: childSectionFrame, at: currentSectionIndex)
                childSections.append(contentsOf: children)

            case .component(let component): // base case
                // create RowComponent
                if let row = translateRows(from: component, in: currentSectionIndex, at: currentRowIndex) {
                    currentRowIndex = currentRowIndex + 1
                    currentRows.append(row)
                }
            }
        }

        let sectionWidth = frame.width
        let rowData = calculateRowData(from: currentRows, in: sectionWidth, at: frame.origin)
        currentRows = rowData.rows

        // TODO: FIX Total height of child sections to be sectionMaxY
        let sectionHeight = childSections.reduce(0) { $0 + $1.layout.frame.height }
        let totalSectionHeight = sectionHeight + rowData.height

        let sectionLayout = SectionComponentLayout(width: sectionWidth,
                                                   height: totalSectionHeight,
                                                   parentOrigin: frame.origin)

        let section = SectionComponent(index: index,
                                       rows: currentRows,
                                       layout: sectionLayout)

        return [section] + childSections
    }

    static func translateRows(from component: Component, in section: Int, at index: Int) -> RowComponent? {
        guard let view = component as? SingleViewComponent else {
            return nil
        }
        let dimension = component.props.layout?.dimension ?? .fill
        let height = component.props.layout?.height ?? 0

        let row = RowComponent(view: view.reduce(),
                               props: component.props,
                               index: index,
                               section: section,
                               layout: RowComponentLayout(dimension: dimension, height: height))
        return row
    }

    // MARK: -  Layout

    static func calculateRowData(from rows: [RowComponent], in width: CGFloat, at origin: CGPoint) -> RowData  {
        var previousFrame = CGRect(origin: origin, size: .zero)
        let newLineX = origin.x
        var maxY = getMaxY(for: previousFrame, currentMaxY: 0) // next Y pos, also total height of rows in section

        let calculatedRows: [RowComponent] = rows.map { row in
            let height = row.layout.height

            let rowWidth = widthFor(dimension: row.layout.dimension, in: width)

            let newOrigin = originFor(width: rowWidth,
                                      previousFrame: previousFrame,
                                      inSectionWidth: width,
                                      newLineXPos: newLineX,
                                      maxY: maxY)

            let newFrame = CGRect(x: newOrigin.x,
                                  y: newOrigin.y,
                                  width: rowWidth,
                                  height: height)

            maxY = getMaxY(for: newFrame, currentMaxY: maxY)
            previousFrame = newFrame

            let layout = RowComponentLayout(layout: row.layout, newFrame: newFrame)
            return RowComponent(rowComponent: row, layout: layout)
        }

        return RowData(rows: calculatedRows, height: maxY)
    }

    static func originFor(width: CGFloat, previousFrame: CGRect, inSectionWidth sectionWith: CGFloat, newLineXPos: CGFloat, maxY: CGFloat) -> CGPoint {
        let remainder = sectionWith - (previousFrame.origin.x + previousFrame.width)

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
            return parentWidth * ratio
        }
    }
}

