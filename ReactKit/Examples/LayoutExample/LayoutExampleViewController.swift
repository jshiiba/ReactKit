//
//  LayoutExampleViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

final class LayoutExampleViewController: BaseComponentViewController {
    struct Props: LayoutViewProps {
        let labels: [LabelPropType] = [
            LabelProps(title: "Label 1", layout: Layout(dimension: .ratio(ratio: 0.25), height: 100)),
            LabelProps(title: "Label 2", layout: Layout(dimension: .ratio(ratio: 0.75), height: 100)),
            LabelProps(title: "Label 3", layout: Layout(dimension: .fill, height: 25)),
            LabelProps(title: "Label 4", layout: Layout(dimension: .ratio(ratio: 0.5), height: 200)),
            LabelProps(title: "Label 5", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)),
            LabelProps(title: "Label 6", layout: Layout(dimension: .ratio(ratio: 0.8), height: 100)),
            LabelProps(title: "Label 7", layout: Layout(dimension: .fill, height: 100)),
        ]
    }

    override func render() -> Component {
        return LayoutView(props: Props())
    }
}

// MARK: - LayoutViewProps

protocol LayoutViewProps: PropType {
    var labels: [LabelPropType] { get }
}

// MARK: - LayoutView

final class LayoutView: CompositeComponent, ComponentLike {
    typealias ComponentPropType = LayoutViewProps
    let props: PropType
    init(props: LayoutViewProps) {
        self.props = props
    }

    func render() -> Component? {
        let labels = _props.labels.map { label in
            return Label(props: label)
        }

        return Container(components: labels, props: ContainerProps(layout: Layout(dimension: .ratio(ratio: 1.0))))
    }
}
