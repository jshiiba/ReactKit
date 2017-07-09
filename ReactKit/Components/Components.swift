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

/**
 All components must be able to return a UIView
 */
protocol Component {
    func render() -> UIView
}

class GenericComponent<V: UIView>: Component {

    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render() -> UIView {
        return self.view
    }
}

protocol ExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class ExampleComponent: Component {
    let props: ExampleComponentPropType

    init(props: ExampleComponentPropType) {
        self.props = props
    }

    func render() -> UIView {
        let view = UIView()

        let label = GenericComponent<UILabel> { (label) in
            label.text = props.title
            label.backgroundColor = props.backgroundColor
            label.sizeToFit()
        }
        view.addSubview(label.view)
        return view
    }
}

protocol ChildExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class ChildExampleComponent: Component {
    let props: ChildExampleComponentPropType

    init(props: ChildExampleComponentPropType) {
        self.props = props
    }

    func render() -> UIView {
        let view = UIView()
        let label = GenericComponent<UILabel> { (label) in
            label.text = props.title
            label.backgroundColor = props.backgroundColor
            label.textAlignment = .right
            label.sizeToFit()
        }
        view.addSubview(label.view)
        return view
    }
}

