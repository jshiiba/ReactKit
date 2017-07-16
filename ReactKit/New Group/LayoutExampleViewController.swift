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

        return Container(components: labels, layout: LayoutContainerProps(frame: CGRect(x: 0, y: 0, width: 300, height: 500)))
    }
}

class LayoutExampleViewController: BaseComponentViewController {
    struct Props: LayoutViewProps {
        let labels: [LabelPropType] = [
            LabelProps(title: "Label 1", layout: LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))),
            LabelProps(title: "Label 2", layout: LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))),
            LabelProps(title: "Label 3", layout: LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))),
            LabelProps(title: "Label 4", layout: LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))),
        ]
    }

    override func render() -> Component {
        return LayoutView(props: Props())
    }
}
