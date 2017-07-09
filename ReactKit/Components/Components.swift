////
////  Components.swift
////  ReactKit
////
////  Created by Justin Shiiba on 7/5/17.
////  Copyright © 2017 Shiiba. All rights reserved.
////

import UIKit

protocol PropType {}
struct NilProps: PropType {}

///
/// can be a UIView, Component or Container
///
protocol Renderable {}

extension UIView: Renderable {}

/**
 All components must be able to return a UIView
 */
protocol Component: Renderable {
    func render(props: PropType) -> [Renderable]
}

class GenericComponent<V: UIView>: Component {
    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render(props: PropType) -> [Renderable] {
        return [self.view]
    }
}

protocol ExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class ExampleComponent: Component {
    let initProps: ExampleComponentPropType?
    init(initProps: ExampleComponentPropType) {
        self.initProps = initProps
    }

    func render(props: PropType) -> [Renderable] {
        guard let props = props as? ExampleComponentPropType else {
            return []
        }

        let view = UIView()
        let label = GenericComponent<UILabel> { (label) in
            label.text = props.title
            label.backgroundColor = props.backgroundColor
            label.sizeToFit()
        }
        view.addSubview(label.view)
        return [view]
    }
}

protocol ChildExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class ChildExampleComponent: Component {
    func render(props: PropType) -> [Renderable] {
        guard let props = props as? ChildExampleComponentPropType else { return [] }

        let view = UIView()
        let label = GenericComponent<UILabel> { (label) in
            label.text = props.title
            label.backgroundColor = props.backgroundColor
            label.textAlignment = .right
            label.sizeToFit()
        }
        view.addSubview(label.view)
        return [view]
    }
}

