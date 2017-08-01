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
        var flowLayoutData = FlowLayoutData(previousFrame: frame, currentMaxY: frame.origin.y)

        container.components.forEach { baseComponent in
            switch baseComponent.componentType {
            case .container(let childContainer): // recurse

                let childSectionWidth = widthFor(dimension: childContainer.layout.dimension, in: frame.width)
                let childSectionOrigin = nextOrigin(for: childSectionWidth,
                                                    after: previousSectionFrame,
                                                    in: frame,
                                                    data: flowLayoutData)

                let childSectionFrame = CGRect(origin: childSectionOrigin,
                                               size: CGSize(width: childSectionWidth,
                                               height: frame.height))

                flowLayoutData.updateMaxY(for: childSectionFrame)
                previousSectionFrame = childSectionFrame
                currentSectionIndex = currentSectionIndex + 1

                let children = translateSections(from: childContainer, in: childSectionFrame, at: currentSectionIndex)
                childSections.append(contentsOf: children)

            case .component(let component): // base case
                if let row = translateRows(from: component, in: currentSectionIndex, at: currentRowIndex) {
                    currentRowIndex = currentRowIndex + 1
                    currentRows.append(row)
                } else if let _ = component.render() {
                    // translate on base
                    print("render from a composite")
                }
            }
        }

        let sectionWidth = frame.width
        let rowsCalculation = calculateRowData(from: currentRows, in: sectionWidth, at: frame.origin)
        currentRows = rowsCalculation.rows

        let sectionHeight = childSections.reduce(0) { (height, section) in
            return maxYFor(section.layout.frame, currentMaxY: height)
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

    // TODO: separate layout from translations

    ///
    /// Data needed to layout the rows in a section similar to a UICollectionViewFlowLayout
    ///
    struct FlowLayoutData {
        let startX: CGFloat
        var maxY: CGFloat

        var totalHeight: CGFloat {
            return maxY
        }

        init(previousFrame frame: CGRect, currentMaxY: CGFloat) {
            self.startX = frame.origin.x
            self.maxY = frame.origin.y + frame.height > currentMaxY ? (frame.origin.y + frame.height) : currentMaxY
        }

        mutating func updateMaxY(for frame: CGRect) {
            self.maxY = frame.origin.y + frame.height > self.maxY ? (frame.origin.y + frame.height) : self.maxY
        }
    }

    ///
    /// Calculates the layout for Rows in a Section. Updates each Row's RowLayout with new layout properties.
    /// Also calculates total height of rows in section
    /// - parameters:
    ///     - rows: an array of rows in a section
    ///     - width: width of current section
    ///     - origin: origin of current section
    /// - returns:
    ///     - row calcuation including rows and total height
    static func calculateRowData(from rows: [Row], in width: CGFloat, at origin: CGPoint) -> RowCalculation  {
        var previousFrame = CGRect(origin: origin, size: .zero)

        var flowLayoutData = FlowLayoutData(previousFrame: previousFrame, currentMaxY: 0)

        let calculatedRows: [Row] = rows.map { row in
            let height = row.layout.height

            let rowWidth = widthFor(dimension: row.layout.dimension, in: width)

            let origin = nextOrigin(for: rowWidth,
                                    after: previousFrame,
                                    in: CGRect(origin: origin, size: CGSize(width: width, height: 0)),
                                    data: flowLayoutData)

            let frame = CGRect(x: origin.x, y: origin.y, width: rowWidth, height: height)

            flowLayoutData.updateMaxY(for: frame)
            previousFrame = frame

            let layout = RowLayout(layout: row.layout, frame: frame)
            return Row(row: row, layout: layout)
        }

        return RowCalculation(rows: calculatedRows, height: flowLayoutData.totalHeight)
    }


    static func nextOrigin(for width: CGFloat, after previousFrame: CGRect, in sectionFrame: CGRect, data: FlowLayoutData) -> CGPoint {
        // need to account for a secion origin being non-zero
        let xOrigin = sectionFrame.origin.x == 0 ? previousFrame.origin.x : sectionFrame.origin.x - previousFrame.origin.x

        let remainder = sectionFrame.width - (xOrigin + previousFrame.width)

        if width > remainder {
            // wrap
            return CGPoint(x: data.startX, y: data.maxY)
        } else {
            // inline
            return CGPoint(x: (previousFrame.origin.x + previousFrame.size.width), y: previousFrame.origin.y)
        }
    }

    // TODO: remove in favor of FlowLayoutData
    ///
    /// Get the Maximum Y position of the current Section
    /// - parameters:
    ///     - frame: a new frame (row) to add to the Section
    ///     - currentMaxY: the current max Y positions in the Section
    /// - returns:
    ///     - Max Y after adding new frame to Section
    static func maxYFor(_ frame: CGRect, currentMaxY: CGFloat) -> CGFloat {
        return frame.origin.y + frame.height > currentMaxY ? (frame.origin.y + frame.height) : currentMaxY
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

