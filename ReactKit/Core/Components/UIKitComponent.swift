//
//  UIKitComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/12/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// A component that wraps a UIKit element
///
final class UIKitComponent<V: UIView>: ComponentReducing {
    typealias Configuration = (V) -> ()
    let view: V
    let props: PropType

    init(props: PropType, configure: Configuration) {
        self.view = V()
        self.props = props

        configure(self.view)
    }

    func reduce() -> UIView? {
        return self.view
    }
}
