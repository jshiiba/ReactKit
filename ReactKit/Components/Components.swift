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
protocol Component: BaseComponent {
    var props: PropType { get }
    func render() -> BaseComponent?
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

protocol SingleViewComponent {
    func reduce() -> UIView?
}

extension SingleViewComponent where Self : Component {
    func reduce() -> UIView? {
        // TODO: Loop through renders until UIView

        guard var base = self.render() else {
            return nil
        }

        while !(base is UIView) {
            if let component = base as? Component, let rendered = component.render() {
                base = rendered
            } else {
                break
            }
        }
        return base as? UIView
    }
}
