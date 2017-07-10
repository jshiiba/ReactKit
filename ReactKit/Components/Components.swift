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
protocol PropType {}
struct NilProps: PropType {}

///
/// can be a UIView, Component or Container
///
protocol Renderable {}

typealias RenderItems = [Renderable]

extension UIView: Renderable {}

///
///
///
protocol Component: Renderable {
    func render(props: PropType) -> RenderItems
}

class GenericComponent<V: UIView>: Component {
    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render(props: PropType) -> RenderItems {
        return [self.view]
    }
}

