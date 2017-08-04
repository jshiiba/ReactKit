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

    typealias SectionTable = [Int: Section]
    var table: SectionTable = [:]

    func translate(fromComponent component: Component, in frame: CGRect) -> [Section] {
        /// translator builds from leaf components back to root, so height will be
        /// calculated last
        let startingFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)

        var table: SectionTable = [:]

        translate(fromComponent: component, in: startingFrame, at: -1, table: &table)

        return table.map { $0.value }
    }

    fileprivate func translate(fromComponent component: Component, in frame: CGRect, at sectionIndex: Int, table: inout SectionTable) {
        switch component.type {
        case .container(let container):
            translate(fromContainer: container, in: frame, at: sectionIndex + 1, table: &table)
        case .composite(let composite):
            if let renderedComposite = composite.render() {
                translate(fromComponent: renderedComposite, in: frame, at: sectionIndex, table: &table)
            }
        case .view(let view):
            translate(fromViewComponent: view, in: frame, at: sectionIndex, table: &table)
        }
    }

    fileprivate func translate(fromContainer container: ComponentContaining, in frame: CGRect, at sectionIndex: Int, table: inout SectionTable) {
        let flowLayout = ComponentFlowLayout(parentFrame: frame)
        let sectionLayout = SectionLayout(width: frame.width, height: 0, parentOrigin: frame.origin)
        let section = Section(index: sectionIndex, rows: [], layout: sectionLayout)

        table[sectionIndex] = section

        container.components.forEach { component in
            let width = component.props.layout?.dimension.width(in: frame.width) ?? frame.width
            let height = component.props.layout?.height ?? frame.height
            let componentFrame = flowLayout.calculateNextFrame(forWidth: width, height: height)

            translate(fromComponent: component, in: componentFrame, at: sectionIndex, table: &table)
        }

        let height = flowLayout.totalHeight
        let width = frame.width

        let layout = SectionLayout(width: width, height: height, parentOrigin: frame.origin)
        section.layout = layout
    }

    func translate(fromViewComponent viewComponent: ComponentReducing, in frame: CGRect, at sectionIndex: Int, table: inout SectionTable) {
        guard let section = table[sectionIndex], let view = viewComponent.reduce() else {
            return
        }

        let rowIndex = section.rows.count
        let height = viewComponent.props.layout?.height ?? 0
        let frame = section.layout.flow.calculateNextFrame(forWidth: frame.width, height: height)

        let row = Row(view: view,
                      props: viewComponent.props,
                      indexPath: IndexPath(row: rowIndex, section: sectionIndex),
                      layout: RowLayout(frame: frame))

        section.rows.insert(row, at: rowIndex)
    }
}


