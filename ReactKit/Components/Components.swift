////
////  Components.swift
////  ReactKit
////
////  Created by Justin Shiiba on 7/5/17.
////  Copyright © 2017 Shiiba. All rights reserved.
////

import UIKit

struct RenderedComponent {
    enum ViewType {
        case view
        case container(Container)
        case component(Component)
        case undefined

        init(baseComponent: BaseComponent) {
            if let container = baseComponent as? Container {
                self = .container(container)
            } else if baseComponent is UIView {
                self = .view
            } else if let component = baseComponent as? Component {
                self = .component(component)
            } else {
                self = .undefined
            }
        }
    }

    let component: BaseComponent
    let props: PropType
    let type: ViewType

    init(component: BaseComponent, props: PropType) {
        self.component = component
        self.props = props
        self.type = ViewType(baseComponent: component)
    }
}

///
///
///
protocol Component: BaseComponent {
    func render(props: PropType) -> RenderedComponent?
}

class UIKitComponent<V: UIView>: Component {
    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render(props: PropType) -> RenderedComponent? {
        return RenderedComponent(component: self.view, props: props)
    }
}

