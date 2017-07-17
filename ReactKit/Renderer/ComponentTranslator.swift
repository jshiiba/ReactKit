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

    func translateToSections(from rootComponent: Component) -> [SectionComponent] {

        let defaultLayout = ContainerLayout(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        var sections: [SectionComponent] = [SectionComponent(index: rootSection, rows: [], layout: defaultLayout)]

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
                                   index: sections[sectionIndex].rows.count,
                                   section: sectionIndex)

            sections[sectionIndex].rows.append(row)

        } else if let child = component.render() {
            translate(child, in: &sections, at: sectionIndex)
        }
    }

    func translate(_ container: Container, in sections: inout [SectionComponent], at sectionIndex: Int) {
        let newSectionIndex = sectionIndex + 1
        let newSection = SectionComponent(index: newSectionIndex, rows: [], layout: container.layout)
        sections.append(newSection)
        container.components.forEach { component in
            translate(component, in: &sections, at: newSectionIndex)
        }
    }
}
