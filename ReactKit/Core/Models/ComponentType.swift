//
//  ComponentType.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/12/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

/// DEPRECATED

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
