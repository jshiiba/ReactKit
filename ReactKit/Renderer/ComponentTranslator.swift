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
        var childSections: [SectionComponent] = []
        let currentAttributes = attributes
        var currentSectionIndex = attributes.sectionIndex

        // recurse on components in container
        container.components.forEach { baseComponent in
            switch baseComponent.componentType {
            case .container(let childContainer): // recurse
                currentSectionIndex = currentSectionIndex + 1
                let newWidth = FlexLayout.sectionWidth(for: container.layout.dimension, in: attributes.frame)
                let newFrame = CGRect(x: currentAttributes.frame.origin.x, y: currentAttributes.frame.origin.y, width: newWidth, height: attributes.frame.size.height)
                let newSectionAttributes = Attributes(sectionIndex: currentSectionIndex,
                                                      rowIndex: 0,
                                                      frame: newFrame)
                let children = translateContainer(childContainer, with: newSectionAttributes)
                childSections.append(contentsOf: children)
            case .component(let component): // base case
                let newRowAttributes = Attributes(sectionIndex: currentAttributes.sectionIndex,
                                                  rowIndex: currentRowIndex,
                                                  frame: attributes.frame)
                let width = FlexLayout.sectionWidth(for: container.layout.dimension, in: attributes.frame)
                if let single = component as? SingleViewComponent,
                    let row = translateSingleViewComponent(single, with: newRowAttributes, width: width) {
                    currentRows.append(row)
                    currentRowIndex = currentRowIndex + 1
                }
            }
        }

        // Invariant: child section indexes are numbered after current section index

        // get layout of current section with rows
        let heightOfRows: CGFloat = currentRows.reduce(0) { (height, row) in
            return height + 0//row.layout.height
        }

        let heightOfChildSections: CGFloat = childSections.reduce(0) { (height, section) in
            return height + section.layout.frame.height
        }

        let height = heightOfRows + heightOfChildSections


        // get layout of current section with child sections
        let newWidth = FlexLayout.sectionWidth(for: container.layout.dimension, in: currentAttributes.frame)
        let layout = SectionComponentLayout(width: newWidth, height: height, parentOrigin: currentAttributes.frame.origin)
        let currentSection = [SectionComponent(index: currentAttributes.sectionIndex,
                                              rows: currentRows,
                                              layout: layout)]
        return currentSection + childSections
    }

    func translateSingleViewComponent(_ component: SingleViewComponent, with attributes: Attributes, width: CGFloat) -> RowComponent? {
        let props = (component as! Component).props
        let layout = props.layout!
        return nil
//        return RowComponent(view: component.reduce(),
//                            props: props,
//                            //layout: RowComponentLayout(dimension: layout.dimension, sectionWidth: width, height: layout.height),
//                            index: attributes.rowIndex,
//                            section: attributes.sectionIndex)
    }
}
