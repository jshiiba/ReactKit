//
//  Mocks.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import UIKit

struct MockComponents {

    static let containerProps = ContainerProps(layout: ComponentLayout(dimension: .fill))

    static func labelComponent() -> ComponentReducing {
        return Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .fill, height: 100)))
    }

    static func composite() -> CompositeComponent {
        return MockComposite(props: NilProps())
    }

    static func containerWithLabel(with labelDimension: ComponentDimension, labelHeight: CGFloat) -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label", layout: ComponentLayout(dimension: labelDimension, height: labelHeight)))
        ], props: containerProps)
    }

    static func containerWithSameTwoLabels(with labelDimension: ComponentDimension, labelHeight: CGFloat) -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: labelDimension, height: labelHeight))),
            Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: labelDimension, height: labelHeight)))
        ], props: containerProps)
    }

    static func containerWithMultipleLabels() -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.75), height: 100))),
            Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 200))),
            Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.25), height: 25))),
            Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 1.0), height: 100))),
        ], props: containerProps)
    }

    static func containerWithContainers() -> Container {
        return Container(components: [
            Container(components: [
                Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
            ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
            Container(components: [
                Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
            ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
        ], props: containerProps)
    }

    static func multiLevelContainers() -> Container {
        return Container(components: [
            Container(components: [
                Container(components: [
                    Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
                Container(components: [
                    Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
            ], props: ContainerProps( layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
        ], props: containerProps)
    }

    static func wrappingMultilevelContainers() -> Container {
        return Container(components: [
                Container(components: [
                    Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
                Container(components: [
                    Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 5", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 6", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
            ], props: containerProps)
    }

    static func flowWrappingContainers() -> Container {
        return Container(components: [
            Container(components: [
                Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
            ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
            Container(components: [
                Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
            ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
            Container(components: [
                Label(props: LabelProps(title: "Label 5", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 6", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
            ], props: ContainerProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5)))),
        ], props: containerProps)
    }
}

struct MockProps: PropType {
    let layout: ComponentLayout?
}

struct MockLabelProps: PropType {
    let labelProps: LabelPropType
    let layout: ComponentLayout?

    init(labelProps: LabelPropType, layout: ComponentLayout?) {
        self.labelProps = labelProps
        self.layout = layout
    }

    static let fill = MockLabelProps(labelProps: LabelProps(title: ""), layout: ComponentLayout(dimension: .fill, height: 100))
}

struct MockComponent: CompositeComponent, ComponentLike {
    typealias ComponentPropType = MockLabelProps
    let props: PropType

    init(props: MockLabelProps) {
        self.props = props
    }

    func render() -> Component? {
        return Label(props: _props.labelProps)
    }
}

struct NilProps: PropType {}

struct MockComposite: CompositeComponent {
    let props: PropType
    init(props: PropType) {
        self.props = props
    }
    func render() -> Component? {
        return MockComponent(props: MockLabelProps(labelProps: LabelProps(title: "composite"),
                                                   layout: ComponentLayout(dimension: .fill, height: 100)))
    }
}
