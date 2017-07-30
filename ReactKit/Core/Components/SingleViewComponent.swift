//
//  SingleViewComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a component that reduces down to a single UIView
///
protocol SingleViewComponent {
    func reduce() -> UIView?
}

extension SingleViewComponent where Self : Component {
    func reduce() -> UIView? {

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
