//
//  ComponentTranslator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/10/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

// Temp
typealias Tree = Int

enum NodeType {
    case root
    case node
    case leaf
}

class Node {

    var type: NodeType = .node

    var props: PropType = NilProps() // temp

    var children: [Node] = []

    var sectionCount: Int = 0

    init(type: NodeType, props: PropType) {
        self.type = type
        self.props = props
    }

}

///
/// - parameters: Current Components with new props
/// - returns: Tree - A virtual representation of the Components that can be diffed
class ComponentTranslator {
    static func translate(_ components: [Component], with props: PropType) -> Tree {
        return 1
    }

    static func createNodeSection(component: Component) {

//        if component is UIView {
//            let node = Node(type: .leaf, props: <#T##PropType#>)
//        }
    }
}
