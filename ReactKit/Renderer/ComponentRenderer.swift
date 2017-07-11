//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Right now this classes only job is to hide the use of the reconciler. Might not be necessary.
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
        print("ROOT: \(rootComponent)")

        let subtree = renderBaseComponent(rootComponent)
        tree.children.append(subtree!)
        print("NODE TREE: \(tree)")

        // Iterating through all root level components and rendering each subtree
//        let result = components.flatMap { $0.render(props: props) }
//        print(result)


        let updatedComponents = reconciler.reconcile(components, with: props)
        return componentDataSource.indexPathsToReloadFor(renderedComponents: components, updatedComponents: updatedComponents)
    }


    func renderBaseComponent(_ renderedComponent: RenderedComponent) -> Node? {
        print("RENDERED COMP: \(renderedComponent)")

        if let view = renderedComponent.component as? UIView {
            print("VIEW: \(view), PROPS: \(renderedComponent.props)")
            return  Node(type: .leaf, props: renderedComponent.props)
        }

        if let component = renderedComponent.component as? Component {
            print("COMPONENT: \(component)")
            let nodeWithChildren = Node(type: .node, props: renderedComponent.props)

            if let childComponent = component.render(props: renderedComponent.props) {
                print("RENDER CHILD")
                if let childNode = renderBaseComponent(childComponent) {
                    nodeWithChildren.children.append(childNode)
                    return nodeWithChildren
                }
            }
        }

        // TODO: Containers with children

        return nil
    }

}



