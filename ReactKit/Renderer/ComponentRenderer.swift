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
    func render(_ components: [Component], with props: PropType) -> [IndexPath] {
        let tree = Node(type: .root, props: props)

        print("Input components: \(components)")

        guard let rootComponent = components.first?.render(props: props) else {
            return []
        }

        if let subtree = renderNodeSubtreeFrom(rootComponent) {
            tree.children.append(subtree)
            print("NODE TREE: \(tree)")
        }



        let updatedComponents = reconciler.reconcile(components, with: props)
        return componentDataSource.indexPathsToReloadFor(renderedComponents: components, updatedComponents: updatedComponents)
    }


    func renderNodeSubtreeFrom(_ currentComponent: RenderedComponent) -> Node? {
        switch currentComponent.type {
        case .view: return Node(type: .leaf, props: currentComponent.props)
        case .component(let component): return nodeFor(component, with: currentComponent.props)
        case .container(let container): return nodeFor(container, with: currentComponent.props)
        case .undefined: return nil
        }
    }

    fileprivate func nodeFor(_ component: Component, with props: PropType) -> Node {
        let node = Node(type: .node, props: props)

        // recurse if there is a child (multiple children are handled in containers)
        if let childComponent = component.render(props: props),
           let childNode = renderNodeSubtreeFrom(childComponent) {
            node.children.append(childNode)
            return node
        } else {
            return node
        }
    }

    fileprivate func nodeFor(_ container: Container, with props: PropType) -> Node? {
        let nodes: [Node] = container.items.flatMap { (renderedComponent) in
            guard let component = renderedComponent else {
                return nil
            }
            return renderNodeSubtreeFrom(component)
        }

        let nodeWithChildren = Node(type: .node, props: props)
        nodeWithChildren.children = nodes
        return nodeWithChildren
    }

}



