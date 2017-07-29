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

        return translateSections(from: container, in: frame)
    }

    static func translateSections(from container: Container, in frame: CGRect) -> [SectionComponent] {
        let currentSectionIndex = 0
        var currentRowIndex = 0
        var currentRows: [RowComponent] = []

        container.components.forEach { baseComponent in
            switch baseComponent.componentType {
            case .container(let _): break// recurse
            case .component(let component): // base case
                // create RowComponent
                if let row = translateRows(from: component, in: currentSectionIndex, at: currentRowIndex) {
                    currentRowIndex = currentRowIndex + 1
                    currentRows.append(row)
                }
            }
        }

        let sectionWidth = widthFor(dimension: container.layout.dimension, in: frame.width)
        let rowData = calculateRowData(from: currentRows, in: sectionWidth, at: frame.origin)
        currentRows = rowData.rows

        let sectionLayout = SectionComponentLayout(width: sectionWidth,
                                                   height: rowData.height,
                                                   parentOrigin: .zero) // TODO: change parentOrigin

        let section = SectionComponent(index: currentSectionIndex,
                                       rows: currentRows,
                                       layout: sectionLayout)

        return [section]
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

            let newOrigin = originFor(rowWidth: rowWidth,
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

    static func originFor(rowWidth: CGFloat, previousFrame: CGRect, inSectionWidth sectionWith: CGFloat, newLineXPos: CGFloat, maxY: CGFloat) -> CGPoint {
        let remainder = sectionWith - (previousFrame.origin.x + previousFrame.width)

        if rowWidth > remainder {
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

