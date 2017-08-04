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

///
/// Allows for easier access to cast the base into its true type
///
enum ComponentType {

    case composite(CompositeComponent)
    case container(ComponentContaining)
    case view(ComponentReducing)

    init(component: Component) {
        if let container = component as? ComponentContaining {
            self = .container(container)
        } else if let composite = component as? CompositeComponent {
            self = .composite(composite)
        } else if let view = component as? ComponentReducing {
            self = .view(view)
        } else {
            fatalError("Component type must be of View, Composite, or Container")
        }
    }
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
