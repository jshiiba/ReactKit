//
//  ComponentTranslator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/14/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
///
///
class ComponentTranslator {
    private let rootSection: Int = 0 // TODO: figure out how to avoid Section 0 always being empty

    func translateToSections(from rootComponent: Component, in frame: CGRect) -> [SectionComponent] {

        let defaultLayout = SectionComponentLayout(dimension: .fill, parentFrame: frame)
        var sections: [SectionComponent] = [SectionComponent(index: rootSection, rows: [], layout: defaultLayout)]

        translate(rootComponent, into: &sections, at: rootSection, within: frame)

        return sections
    }

    func translate(_ base: BaseComponent, into sections: inout [SectionComponent], at sectionIndex: Int, within parentFrame: CGRect) {
        switch base.componentType {
        case .component(let component): translate(component, into: &sections, at: sectionIndex, within: parentFrame)
        case .container(let container): translate(container, into: &sections, at: sectionIndex, within: parentFrame)
        }
    }

    func translate(_ component: Component, into sections: inout [SectionComponent], at sectionIndex: Int, within parentFrame: CGRect) {
        if let singleComponent = component as? SingleViewComponent {  // Base Case

            let row = RowComponent(view: singleComponent.reduce(),
                                   props: component.props,
                                   layout: RowComponentLayout(dimension: component.props.layout?.dimension, sectionFrame: parentFrame),
                                   index: sections[sectionIndex].rows.count,
                                   section: sectionIndex)

            sections[sectionIndex].rows.append(row)

        } else if let child = component.render() {
            translate(child, into: &sections, at: sectionIndex, within: parentFrame)
        }
    }

    func translate(_ container: Container, into sections: inout [SectionComponent], at sectionIndex: Int, within parentFrame: CGRect) {
        let newSectionIndex = sectionIndex + 1
        let newSectionLayout = SectionComponentLayout(dimension: container.layout.dimension, parentFrame: parentFrame)
        let newSection = SectionComponent(index: newSectionIndex, rows: [], layout: newSectionLayout)
        sections.append(newSection)
        container.components.forEach { component in
            translate(component, into: &sections, at: newSectionIndex, within: newSection.layout.frame)
        }
    }
}
