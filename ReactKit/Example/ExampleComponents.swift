//
//  ExampleComponents.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct ExampleProps: ExampleComponentPropType {
    let title: String
    let backgroundColor: UIColor
}

struct ExampleComponentViewControllerProps: ExampleComponentViewControllerPropType {
    let exampleComponentProps: ExampleComponentPropType
    let labelProps: LabelPropType
}

class ExampleComponentView: Component, ComponentLike {
    typealias ComponentPropType = ExampleComponentViewControllerProps
    let props: PropType
    init(props: ExampleComponentViewControllerProps) {
        self.props = props
    }

    func render() -> BaseComponent? {
        return Container(items: [
            ExampleComponent(props: _props.exampleComponentProps),
            Label(props: _props.labelProps),
            Label(props: _props.labelProps),
        ])
    }
}

protocol ExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class ExampleComponent: Component, ComponentLike {
    typealias ComponentPropType = ExampleComponentPropType
    let props: PropType
    init(props: ExampleComponentPropType) {
        self.props = props
    }

    func render() -> BaseComponent? {
        return Container(items: [
            UIKitComponent<UILabel>(props: _props) { (label) in
                label.text = _props.title
                label.backgroundColor = _props.backgroundColor
                label.sizeToFit()
            }
        ])
    }
}
//
//class ChildExampleComponent: Component {
//    func render(props: PropType) -> BaseComponent? {
//        guard let props = props as? ExampleComponentPropType else {
//            return nil
//        }
//
//        let view = UIView()
//        let label = GenericComponent<UILabel> { (label) in
//            label.text = props.title
//            label.backgroundColor = props.backgroundColor
//            label.textAlignment = .right
//            label.sizeToFit()
//        }
//        view.addSubview(label.view)
//        return view
//    }
//}

