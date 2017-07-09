//
//  ComponentsTypeErasure.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

/*
// MARK: - Abstract base class
class _AnyComponentBase<Props>: Component {
    init() {
        guard type(of: self) != _AnyComponentBase.self else {
            fatalError("_AnyComponentBase<Props> instances can not be created; create a subclass instance instead")
        }
    }

    func render(props: Props) -> UIView {
        fatalError("Must Override")
    }
}

// MARK: - Box container class
fileprivate final class _AnyComponentBox<Base: Component>: _AnyComponentBase<Base.Props> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }

    override func render(props: Base.Props) -> UIView {
        return base.render(props: props)
    }
}

// MARK: - AnyComponent Wrapper
final class AnyComponent<Props>: Component {
    private let box: _AnyComponentBase<Props>
    init<Base: Component>(_ base: Base) where Base.Props == Props {
        box = _AnyComponentBox(base)
    }

    func render(props: Props) -> UIView {
        return box.render(props: props)
    }
}
*/
