//
//  LayoutExampleViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol LayoutViewProps: PropType {
    var labels: [LabelPropType] { get }
}

class LayoutView: Component, ComponentLike {
    typealias ComponentPropType = LayoutViewProps
    let props: PropType
    init(props: LayoutViewProps) {
        self.props = props
    }

    func render() -> BaseComponent? {
        let labels = _props.labels.map { label in
            return Label(props: label)
        }

        return Container(components: labels, layout: ContainerLayout(dimension: .ratio(ratio: 1.0)))
    }
}

class LayoutExampleViewController: BaseComponentViewController {
    struct Props: LayoutViewProps {
        let labels: [LabelPropType] = [
            LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5))),
            LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5))),
            LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .fill)),
            LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .fill)),
        ]
    }

    override func render() -> Component {
        return LayoutView(props: Props())
    }
}
