//
//  Translator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

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

    func translate(fromComponent component: Component, in frame: CGRect) -> [Section] {
        /// translator builds from leaf components back to root, so height will be
        /// calculated last
        let startingFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        return translate(fromComponent: component, in: startingFrame, at: 0)
    }

    func translate(fromComponent component: Component, in frame: CGRect, at index: Int) -> [Section] {
        switch component.type {
        case .container(let container):
            return translate(fromContainer: container, in: frame, at: index)
        case .composite(let composite):
            if let renderedComposite = composite.render() {
                return translate(fromComponent: renderedComposite, in: frame, at: index)
            }
        case .view(let view):
            return translate(fromView: view, at: index)
        }
    }

    func translate(fromContainer container: ComponentContaining, in frame: CGRect, at sectionIndex: Int) -> [Section] {
        // vars for sections
        var currentSectionIndex = sectionIndex

        let sectionFlowLayout = ComponentFlowLayout(parentFrame: frame)
        var childSections: [Section] = []

        container.components.forEach { component in
            let width = container.props.layout?.dimension.width(in: frame.width) ?? frame.width
            let containerSectionFrame = sectionFlowLayout.calculateNextFrame(forWidth: width, height: frame.height)

            currentSectionIndex = currentSectionIndex + 1

            let children = translate(fromComponent: container, in: containerSectionFrame, at: currentSectionIndex)
            childSections.append(contentsOf: children)
        }


        let sectionWidth = frame.width
        let rowsCalculation = calculateRowData(from: currentRows, in: sectionWidth, at: frame.origin) // TODO: Move inside Section
        currentRows = rowsCalculation.rows

        let sectionHeight = childSections.reduce(0) { (height, section) in
            return sectionFlowLayout.maxYFor(section.layout.frame, currentMaxY: height)
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

    func translate(fromView view: ComponentReducing, at sectionIndex: Int) -> [Section] {
        // vars for rows
        var currentRowIndex = 0
        var currentRows: [Row] = []

        if let row = translateRows(from: view, in: currentRowIndex, at: sectionIndex) {
            currentRowIndex = currentRowIndex + 1
            currentRows.append(row)
        }

        // FIXME
        let sectionLayout = SectionLayout(width: 0,
                                          height: 0,
                                          parentOrigin: .zero)

        return [Section(index: sectionIndex, rows: currentRows, layout: sectionLayout)]
    }

    func translateRows(from component: ComponentReducing, in section: Int, at index: Int) -> Row? {
        guard let view = component.reduce() else {
            return nil
        }

        let dimension = component.props.layout?.dimension ?? .fill
        let height = component.props.layout?.height ?? 0

        let row = Row(view: view,
                      props: component.props,
                      index: index,
                      section: section,
                      layout: RowLayout(dimension: dimension, height: height))
        return row
    }

    /// Calculates the layout for Rows in a Section. Updates each Row's RowLayout with new layout properties.
    /// Also calculates total height of rows in section
    /// - parameters:
    ///     - rows: an array of rows in a section
    ///     - width: width of current section
    ///     - origin: origin of current section
    /// - returns:
    ///     - row calcuation including rows and total height
    func calculateRowData(from rows: [Row], in width: CGFloat, at origin: CGPoint) -> RowCalculation  {
        let rowFlowLayout = ComponentFlowLayout(parentFrame: CGRect(x: origin.x, y: origin.y, width: width, height: 0))

        let calculatedRows: [Row] = rows.map { row in
            let rowHeight = row.layout.height
            let rowWidth = row.layout.dimension.width(in: width)
            let rowFrame = rowFlowLayout.calculateNextFrame(forWidth: rowWidth, height: rowHeight)
            let layout = RowLayout(layout: row.layout, frame: rowFrame)
            return Row(row: row, layout: layout)
        }

        return RowCalculation(rows: calculatedRows, height: rowFlowLayout.totalHeight)
    }
}

