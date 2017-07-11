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

///
///
///
protocol Component: BaseComponent {
    func render(props: PropType) -> BaseComponent?
}

class GenericComponent<V: UIView>: Component {
    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render(props: PropType) -> BaseComponent? {
        return self.view
    }
}

