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

        // translate component Tree to Array of Sections, Rows
        var sections: [SectionComponent] = [SectionComponent(section: rootSection, rows: [])]

        translate(rootComponent, in: &sections, sectionIndex: rootSection)

        return sections
    }

    func translate(_ base: BaseComponent, in sections: inout [SectionComponent], sectionIndex: Int) {
        switch base.componentType {
        case .component(let component):
            if let singleComponent = component as? SingleViewComponent {  // Base Case
                let row = RowComponent(view: singleComponent.reduce(), props: component.props, section: sectionIndex)
                sections[sectionIndex].rows.append(row)
            } else if let child = component.render() {
                translate(child, in: &sections, sectionIndex: sectionIndex)
            }
        case .container(let container):
            let newSectionIndex = sectionIndex + 1
            let newSection = SectionComponent(section: newSectionIndex, rows: [])
            sections.append(newSection)
            container.items.forEach { baseComponent in
                guard let component = baseComponent else { return }
                translate(component, in: &sections, sectionIndex: newSectionIndex)
            }
        }
    }


    /// Tree version

//    func translateToNodeTree(from rootComponent: Component) -> Node {
//        let root = translate(rootComponent, in: rootSection)
//        return root
//    }

    /*
     - Create node from component
     - if view return
     - if component
     - render for base component
         recurse set result to component.children
     - if container
         recurse on children, set result to container.children
     */
//    func translate(_ base: BaseComponent, in section: Int) -> Node {
//        let node = createNode(from: base, in: section)
//
//        switch base.componentType {
//        case .view(_): return node
//        case .component(let component):
//            if let childComponent = component.render() {
//                node.children.append(translate(childComponent, in: node.section))
//            }
//
//        case .container(let container):
//            node.children = container.items.flatMap { baseComponent in
//                guard let component = baseComponent else { return nil }
//                return translate(component, in: node.section)
//            }
//        }
//
//        return node
//    }
//
//    func createNode(from base: BaseComponent, in section: Int) -> Node {
//        switch base.componentType {
//        case .view(_): return Node(type: .leaf, section: section)
//        case .component(let component): return Node(type: .node, props: component.componentProps, section: section + 1)
//        case .container(_): return Node(type: .container, section: section + 1)
//        }
//    }
}
