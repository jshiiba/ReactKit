//
//  ComponentTranslator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/14/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

class ComponentTranslator {

    func translateToNodeTree(from rootComponent: Component) -> Node {
        let root = translate(rootComponent)
        return root
    }

    /*
     - Create node from component
     - if view return
     - if component
     - render for base component
         recurse set result to component.children
     - if container
         recurse on children, set result to container.children
     */
    func translate(_ base: BaseComponent) -> Node {
        let node = createNode(from: base)

        switch base.componentType {
        case .view(_): return node
        case .component(let component):
            if let childComponent = component.render() {
                node.children.append(translate(childComponent))
            }
        case .container(let container):
            node.children = container.items.flatMap { baseComponent in
                guard let component = baseComponent else { return nil }
                return translate(component)
            }
        }

        return node
    }

    func createNode(from base: BaseComponent) -> Node {
        switch base.componentType {
        case .view(_): return Node(type: .leaf)
        case .component(let component): return Node(type: .node, props: component.componentProps)
        case .container(_): return Node(type: .container)
        }
    }
}
