//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
///
///
class ComponentRender {
    let componentDataSource: ComponentDataSource
    let reconciler: ComponentReconciler

    init(componentDataSource: ComponentDataSource, reconciler: ComponentReconciler) {
        self.componentDataSource = componentDataSource
        self.reconciler = reconciler
    }

    /// 
    ///
    ///
    func render(_ rootComponent: Component) -> [IndexPath] {
        let tree = Node(type: .root, props: rootComponent.componentProps)

        if let subtree = renderNodeSubtreeFrom(rootComponent) {
            tree.children.append(subtree)
            print("NODE TREE: \(tree)")
        }

        //let updatedComponents = reconciler.reconcile(components, with: props)
        //componentDataSource.indexPathsToReloadFor(renderedComponents: components, updatedComponents: updatedComponents)
        return []
    }


    func renderNodeSubtreeFrom(_ currentComponent: BaseComponent) -> Node? {
        switch currentComponent.componentType {
        case .view: return Node(type: .leaf)
        case .component(let component): return nodeFor(component, with: component.props)
        case .container(let container): return nodeFor(container)
        case .undefined: return nil
        }
    }

    fileprivate func nodeFor(_ component: Component, with props: PropType) -> Node {
        let node = Node(type: .node, props: props)

        // recurse if there is a child (multiple children are handled in containers)
        if let childComponent = component.render(),
           let childNode = renderNodeSubtreeFrom(childComponent) {
            node.children.append(childNode)
            return node
        } else {
            return node
        }
    }

    fileprivate func nodeFor(_ container: Container) -> Node? {
        let children: [Node] = container.items.flatMap { (renderedComponent) in
            guard let component = renderedComponent else {
                return nil
            }
            return renderNodeSubtreeFrom(component)
        }

        return Node(type: .container, children: children)
    }

}



