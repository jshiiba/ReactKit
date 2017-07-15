//
//  Node.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/12/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

enum NodeType {
    case root
    case node
    case container // FIXME: might not be necessary
    case leaf
}

class Node {

    var type: NodeType = .node

    var props: PropType?

    var children: [Node]

    var section: Int = 0

    init(type: NodeType, props: PropType? = nil, children: [Node] = [], section: Int = 0) {
        self.type = type
        self.props = props
        self.children = children
        self.section = section
    }

}
