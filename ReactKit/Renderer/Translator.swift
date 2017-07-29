//
//  Translator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

final class Translator {

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
                if let row = Translator.translateRows(from: component, in: currentSectionIndex, at: currentRowIndex) {
                    currentRowIndex = currentRowIndex + 1
                    currentRows.append(row)
                }
            }
        }

        let flexWidth = FlexLayout.sectionWidth(for: container.layout.dimension, in: frame)
        let calculations = Translator.calculateRowLayout(from: currentRows, in: flexWidth, at: frame.origin)

        currentRows = calculations.rows
        let calculatedHeight = calculations.totalHeight

        let sectionLayout = SectionComponentLayout(width: flexWidth, height: calculatedHeight, parentOrigin: .zero)

        let section = SectionComponent(index: currentSectionIndex,
                                       rows: currentRows,
                                       layout: sectionLayout)

        return [section]
    }

    static func calculateRowLayout(from rows: [RowComponent], in width: CGFloat, at origin: CGPoint) -> (rows: [RowComponent], totalHeight: CGFloat)  {
        var previousFrame = CGRect(origin: origin, size: .zero)
        let newLineX = origin.x
        var maxY = getMaxY(for: previousFrame, currentMaxY: 0) // next Y pos, also total height of rows in section

        return (rows.map { row in
            let height = row.layout.height

            let rowWidth = FlexLayout.width(for: row.layout.dimension, in: width)

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
        }, maxY)
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
}

