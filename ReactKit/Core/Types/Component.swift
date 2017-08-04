////
////  Components.swift
////  ReactKit
////
////  Created by Justin Shiiba on 7/5/17.
////  Copyright © 2017 Shiiba. All rights reserved.
////

import UIKit

///
/// An object that be rendered into a View. Components can be composed together
/// to create a View hierarchy.
///
protocol Component {
    var props: PropType { get }
}

extension Component {
    var type: ComponentType {
        return ComponentType(component: self)
    }
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
