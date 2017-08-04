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

    func translate(fromComponent component: Component, in frame: CGRect) -> [Section] {
        /// translator builds from leaf components back to root, so height will be
        /// calculated last
        let startingFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)

        var dataSource: TranslatorDataSource = TranslatorSectionDataSource() // TODO: inject for easier unit testing

        translate(fromComponent: component, in: startingFrame, dataSource: &dataSource)

        return dataSource.sections
    }

    fileprivate func translate(fromComponent component: Component, in frame: CGRect, dataSource: inout TranslatorDataSource) {
        switch component.type {
        case .container(let container):
            translate(fromContainer: container, in: frame, dataSource: &dataSource)
        case .composite(let composite):
            if let renderedComposite = composite.render() {
                translate(fromComponent: renderedComposite, in: frame, dataSource: &dataSource)
            }
        case .view(let view):
            translate(fromViewComponent: view, in: frame, dataSource: &dataSource)
        }
    }

    fileprivate func translate(fromContainer container: ComponentContaining, in frame: CGRect, dataSource: inout TranslatorDataSource) {
        let sectionLayout = SectionLayout(width: frame.width, height: frame.height, parentOrigin: frame.origin)
        let section = Section(index: dataSource.nextSectionIndex(), rows: [], layout: sectionLayout)

        dataSource.insert(section, at: section.index)

        container.components.forEach { component in
            let width = component.props.layout?.dimension.width(in: frame.width) ?? frame.width
            let height = component.props.layout?.height ?? frame.height
            let componentFrame = section.layout.flow.calculateNextFrame(forWidth: width, height: height)

            translate(fromComponent: component, in: componentFrame, dataSource: &dataSource)
        }

        // need to get height of child sections
        let height = section.layout.flow.totalHeight
        let width = frame.width

        let layout = SectionLayout(width: width, height: height, parentOrigin: frame.origin)
        section.layout = layout
    }

    func translate(fromViewComponent viewComponent: ComponentReducing, in frame: CGRect, dataSource: inout TranslatorDataSource) {
        guard let section = dataSource.current, let view = viewComponent.reduce() else {
            return
        }

        let rowIndex = section.rows.count
        let row = Row(view: view,
                      props: viewComponent.props,
                      indexPath: IndexPath(row: rowIndex, section: section.index),
                      layout: RowLayout(frame: frame))

        section.rows.insert(row, at: rowIndex)
    }
}


