//
//  UIKitComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/12/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
///
///
class UIKitComponent<V: UIView>: Component {
    typealias Configuration = (V) -> ()
    let view: V
    let props: PropType

    init(props: PropType, configure: Configuration) {
        self.view = V()
        self.props = props

        configure(self.view)
    }

    func render() -> BaseComponent? {
        return self.view
    }
}
