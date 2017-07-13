//
//  ComponentCacher.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/13/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

/// Takes input and caches it and returns last cached tree
/// - parameters: root of the tree
/// - returns: Recently Cached Tree
class ComponentCacher {
    var cachedTree: Node?

    func cache(_ treeRoot: Node) -> Node? {
        defer {
            cachedTree = treeRoot
        }

        return cachedTree
    }
}
