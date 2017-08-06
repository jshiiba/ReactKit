//
//  ComponentTypes.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
///
///
protocol ComponentContaining: Component {
    var components: [Component] { get }
}

///
/// Represents a component that reduces down to a single UIView
///
protocol ComponentReducing: Component {
    func reduce() -> UIView?
}

///
/// Represents a
///
protocol CompositeComponent: Component {
    func render() -> Component?
}
