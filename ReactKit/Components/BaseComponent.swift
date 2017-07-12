//
//  BaseComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/12/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

enum BaseComponentType {
    case view(UIView)
    case component(Component)
    case container(Container)
    case undefined

    init(baseComponent: BaseComponent) {
        if let container = baseComponent as? Container {
            self = .container(container)
        } else if let view = baseComponent as? UIView {
            self = .view(view)
        } else if let component = baseComponent as? Component {
            self = .component(component)
        } else {
            self = .undefined
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
}

extension UIView: BaseComponent {}
