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
/// virtual representation (Sections and Rows).
///
final class Translator {

    /// Translates a Component View hierarchy to a VirtualDataSource represented as Sections with Rows
    /// - parameters:
    ///     - component: The root component in the tree
    ///     - virtualDataSource: data structure that holds Sections
    static func translate(fromComponent component: Component) -> [Section] {

        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        translate(fromComponent: component, to: &dataSource, parent: nil)

        return dataSource.sections
    }

    fileprivate static func translate(fromComponent component: Component, to dataSource: inout VirtualDataSource, parent: Section?) {
        switch component.type {
        case .container(let container):
            translate(fromContainer: container, to: &dataSource, parent: parent)
        case .composite(let composite):
            if let renderedComposite = composite.render() {
                translate(fromComponent: renderedComposite, to: &dataSource, parent: parent)
            }
        case .view(let view):
            translate(fromViewComponent: view, to: &dataSource)
        }
    }

    fileprivate static func translate(fromContainer container: ComponentContaining, to dataSource: inout VirtualDataSource, parent: Section?) {

        let section = Section(index: dataSource.nextSectionIndex(), props: container.props)

        dataSource.insert(section, at: section.index)
        parent?.children.append(section)

        container.components.forEach { component in
            translate(fromComponent: component, to: &dataSource, parent: section)
        }
    }

    fileprivate static func translate(fromViewComponent viewComponent: ComponentReducing, to dataSource: inout VirtualDataSource) {
        guard let view = viewComponent.reduce() else {
            return
        }

        var section: Section
        if let currentSection = dataSource.current {
            section = currentSection
        } else {
            section = Section(index: dataSource.nextSectionIndex())
            dataSource.insert(section, at: section.index)
        }

        let rowIndex = section.rows.count
        let row = Row(view: view, props: viewComponent.props, indexPath: IndexPath(row: rowIndex, section: section.index))
        section.rows.insert(row, at: rowIndex)
    }
}


