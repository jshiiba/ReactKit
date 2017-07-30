////
////  Components.swift
////  ReactKit
////
////  Created by Justin Shiiba on 7/5/17.
////  Copyright © 2017 Shiiba. All rights reserved.
////

import UIKit

///
///
///
protocol Component: BaseComponent {
    var props: PropType { get }
    func render() -> BaseComponent?
}

///
/// Conforming to ComponentLike will allow access to an internal _props variable casted
/// as the associated type of ComponentPropType
///
protocol ComponentLike {
    associatedtype ComponentPropType
}

extension ComponentLike where Self : Component {
    var _props: ComponentPropType {
        return props as! ComponentPropType
    }
}
