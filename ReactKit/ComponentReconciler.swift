//
//  ComponentRenderer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

// Temp
typealias Tree = Int

///
/// - parameters: Current Components with new props
/// - returns: Components to update
class ComponentReconciler {
    let cacher = ComponentCacher()

    func reconcile(_ components: [Component], with props: PropType) -> [Component] {
        let nodeTree = ComponentTranslator.translate(components, with: props)
        let cachedTree = cacher.cache(nodeTree)
        let updatedComponents = ComponentDiffer.diff(nodeTree, cachedTree)
        return updatedComponents
    }
}

///
/// - parameters: Current Components with new props
/// - returns: Tree - A virtual representation of the Components that can be diffed
class ComponentTranslator {
    static func translate(_ components: [Component], with props: PropType) -> Tree {
        return 1
    }
}

/// Takes input and caches it and returns last cached tree
/// - parameters: A Tree
/// - returns: Recently Cached Tree
class ComponentCacher {
    var cachedTree: Tree?

    func cache(_ tree: Tree) -> Tree? {
        defer {
            cachedTree = tree
        }

        return cachedTree
    }
}

///
/// - parameters: currentTree and cached tree
/// - returns: an array of components to update
class ComponentDiffer {
    static func diff(_ currentTree: Tree, _ cachedTree: Tree?) -> [Component] {
        return []
    }
}
