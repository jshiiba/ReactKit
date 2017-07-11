////
////  Components.swift
////  ReactKit
////
////  Created by Justin Shiiba on 7/5/17.
////  Copyright © 2017 Shiiba. All rights reserved.
////

import UIKit

///
/// can be a UIView, Component or Container
///
protocol BaseComponent {}

extension UIView: BaseComponent {}

struct RenderedComponent {
    let component: BaseComponent
    let props: PropType
}

///
///
///
protocol Component: BaseComponent {
    func render(props: PropType) -> RenderedComponent?
}

class GenericComponent<V: UIView>: Component {
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

