//
//  ComponentTranslator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/14/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct Attributes {
    let sectionIndex: Int
    let rowIndex: Int
    let frame: CGRect
}

///
///
///
final class ComponentTranslator {
    private let rootSection: Int = 0 // TODO: figure out how to avoid Section 0 always being empty

    func translateToSections(from rootComponent: Component, in frame: CGRect) -> [SectionComponent] {
        guard let container = rootComponent.render() as? Container else {
            return [] // TODO: for now only worry about containers or single components
        }

        let attributes = Attributes(sectionIndex: 0,
                                    rowIndex: 0,
                                    frame: frame)

        let sections: [SectionComponent] = translateContainer(container, with: attributes)
        // sort by section index
        return sections.sorted(by: { $0.index < $1.index })
    }


    func translateContainer(_ container: Container, with attributes: Attributes) -> [SectionComponent] {
        var currentRows: [RowComponent] = []
        var currentRowIndex = 0
        var sections: [SectionComponent] = []
        let currentAttributes = attributes
        var currentSectionIndex = attributes.sectionIndex

        // recurse on components in container for rows
        container.components.forEach { baseComponent in
            switch baseComponent.componentType {
            case .component(let component):
                let newRowAttributes = Attributes(sectionIndex: currentAttributes.sectionIndex,
                                                  rowIndex: currentRowIndex,
                                                  frame: attributes.frame)
                if let single = component as? SingleViewComponent,
                   let row = translateSingleViewComponent(single, with: newRowAttributes) {
                    currentRows.append(row)
                    currentRowIndex = currentRowIndex + 1
                }
            case .container(let container):
                currentSectionIndex = currentSectionIndex + 1
                let newSectionAttributes = Attributes(sectionIndex: currentSectionIndex,
                                                      rowIndex: 0,
                                                      frame: currentAttributes.frame)
                let childSections = translateContainer(container, with: newSectionAttributes) // recurse
                sections.append(contentsOf: childSections)
            }
        }

        let layout = SectionComponentLayout(dimension: container.layout.dimension, parentFrame: currentAttributes.frame)
        let currentSection = SectionComponent(index: currentAttributes.sectionIndex,
                                              rows: currentRows,
                                              layout: layout)
        sections.append(currentSection)
        return sections
    }

    func translateSingleViewComponent(_ component: SingleViewComponent, with attributes: Attributes) -> RowComponent? {
        let props = (component as! Component).props

        return createRow(for: component, with: props, attributes: attributes)
    }

    func createRow(for component: SingleViewComponent, with props: PropType, attributes: Attributes) -> RowComponent {
        return RowComponent(view: component.reduce(),
                            props: props,
                            layout: RowComponentLayout(dimension: props.layout?.dimension, sectionFrame: attributes.frame),
                            index: attributes.rowIndex,
                            section: attributes.sectionIndex)
    }
}
