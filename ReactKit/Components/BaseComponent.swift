//
//  BaseComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/12/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

enum BaseComponentType {

    // TODO singular --> Component, Component --> Composite
    case singular(SingularComponent)
    case component(Component)
    case container(Container)

    init(baseComponent: BaseComponent) {
        if let container = baseComponent as? Container {
            self = .container(container)
        } else if let single = baseComponent as? SingularComponent {
            self = .singular(single)
        } else if let component = baseComponent as? Component {
            self = .component(component)
        } else {
            fatalError("BaseComponentType must be a UIView, Component or Container")
        }
    }
}

///
/// can be a UIView, Component or Container
///
protocol BaseComponent {}

extension BaseComponent {
    var componentType: BaseComponentType {
        return BaseComponentType(baseComponent: self)
    }

    var componentProps: PropType? {
        guard case .component(let component) = BaseComponentType(baseComponent: self) else {
            return nil
        }
        return component.props
    }
}

extension UIView: BaseComponent {}
