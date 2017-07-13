//
//  ComponentRenderer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// - parameters: Current Components with new props
/// - returns: Components to update
class ComponentReconciler {
    func reconcile(_ currentTree: Node, cachedTree: Node?) -> [Node] {
        let updatedComponents = ComponentDiffer.diff(currentTree, cachedTree)
        return updatedComponents
    }
}

///
/// - parameters: currentTree and cached tree
/// - returns: an array of components to update
class ComponentDiffer {
    static func diff(_ currentTree: Node, _ cachedTree: Node?, _ updatedNodes: [Node] = []) -> [Node] {

        // base case
        if case NodeType.leaf = currentTree.type {
            return updatedNodes
        }

//        if currentTree.props?.isEqualTo(other: cachedTree?.props) {
//
//        }

        return updatedNodes
    }
}
