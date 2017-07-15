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
    let labels: [LabelPropType]
}

struct ExampleComponentView: Component, ComponentLike {
    typealias ComponentPropType = ExampleComponentViewControllerProps
    let props: PropType
    init(props: ExampleComponentViewControllerProps) {
        self.props = props
    }

    func render() -> BaseComponent? {
        // example of repeat components
        let labels: [Component] = _props.labels.map { label in
            return Label(props: label)
        }

        let components = [ExampleComponent(props: _props.exampleComponentProps)] + labels
        return Container(components: components)
    }
}

protocol ExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

struct ExampleComponent: Component, ComponentLike {
    typealias ComponentPropType = ExampleComponentPropType
    let props: PropType
    init(props: ExampleComponentPropType) {
        self.props = props
    }

    func render() -> BaseComponent? {
        return UIKitComponent<UILabel>(props: _props) { (label) in
                label.text = _props.title
                label.backgroundColor = _props.backgroundColor
                label.sizeToFit()
        }
    }
}

