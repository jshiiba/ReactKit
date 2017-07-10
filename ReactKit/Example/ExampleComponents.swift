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

class ExampleComponentView: Component {
    func render(props: PropType) -> RenderItems {
        guard let props = props as? ExampleComponentViewControllerProps else { return [] }

        let items = ExampleComponent().render(props: props.exampleComponentProps) + Label().render(props: props.labelProps)
        return items
    }
}

protocol ExampleComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class ExampleComponent: Component {
    func render(props: PropType) -> RenderItems {
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

        return [view] + ChildExampleComponent().render(props: props)
    }
}

class ChildExampleComponent: Component {
    func render(props: PropType) -> RenderItems {
        guard let props = props as? ExampleComponentPropType else { return [] }

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
