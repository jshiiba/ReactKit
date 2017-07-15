//
//  ComponentTranslator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/14/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

class ComponentTranslator {
    private let rootSection: Int = 0

    func translateToSections(from rootComponent: Component) -> [SectionComponent] {

        var sections: [SectionComponent] = [SectionComponent(section: rootSection, rows: [])]

        translate(rootComponent, in: &sections, at: rootSection)

        return sections
    }

    func translate(_ base: BaseComponent, in sections: inout [SectionComponent], at sectionIndex: Int) {
        switch base.componentType {
        case .component(let component): translate(component, in: &sections, at: sectionIndex)
        case .container(let container): translate(container, in: &sections, at: sectionIndex)
        }
    }

    func translate(_ component: Component, in sections: inout [SectionComponent], at sectionIndex: Int) {
        if let singleComponent = component as? SingleViewComponent {  // Base Case

            let row = RowComponent(view: singleComponent.reduce(),
                                   props: component.props,
                                   section: sectionIndex)
            sections[sectionIndex].rows.append(row)
        } else if let child = component.render() {
            translate(child, in: &sections, at: sectionIndex)
        }
    }

    func translate(_ container: Container, in sections: inout [SectionComponent], at sectionIndex: Int) {
        let newSectionIndex = sectionIndex + 1
        let newSection = SectionComponent(section: newSectionIndex, rows: [])
        sections.append(newSection)
        container.items.forEach { baseComponent in
            guard let component = baseComponent else { return }
            translate(component, in: &sections, at: newSectionIndex)
        }
    }
}
