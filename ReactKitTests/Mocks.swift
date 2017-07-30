//
//  Mocks.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit
@testable import ReactKit

struct MockComponents {

    static let containerLayoutFill = ContainerLayout(dimension: .fill)

    static func labelComponent() -> Component {
        return Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .fill, height: 100)))
    }

    static func composite() -> Component {
        return MockComposite(props: NilProps())
    }

    static func containerWithLabel(with labelDimension: FlexDimension, labelHeight: CGFloat) -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label", layout: ComponentLayout(dimension: labelDimension, height: labelHeight)))
        ], layout: MockComponents.containerLayoutFill)
    }

    static func containerWithSameTwoLabels(with labelDimension: FlexDimension, labelHeight: CGFloat) -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: labelDimension, height: labelHeight))),
            Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: labelDimension, height: labelHeight)))
        ], layout: MockComponents.containerLayoutFill)
    }

    static func containerWithMultipleLabels() -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.75), height: 100))),
            Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 200))),
            Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.25), height: 25))),
            Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 1.0), height: 100))),
        ], layout: MockComponents.containerLayoutFill)
    }

    static func containerWithContainers() -> Container {
        return Container(components: [
            Container(components: [
                Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
            ], layout: ContainerLayout(dimension: .ratio(ratio: 0.5))),
            Container(components: [
                Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
            ], layout: ContainerLayout(dimension: .ratio(ratio: 0.5))),
        ], layout: MockComponents.containerLayoutFill)
    }

    static func multiLevelContainers() -> Container {
        return Container(components: [
            Container(components: [
                Container(components: [
                    Label(props: LabelProps(title: "Label 1", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 2", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], layout: ContainerLayout(dimension: .ratio(ratio: 0.5))),
                Container(components: [
                    Label(props: LabelProps(title: "Label 3", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 4", layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], layout: ContainerLayout(dimension: .ratio(ratio: 0.5))),
            ], layout: ContainerLayout(dimension: .ratio(ratio: 0.5))),
        ], layout: MockComponents.containerLayoutFill)
    }
}

struct MockRows {
    static let singleRow: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .fill, height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .fill, height: 100))
    ]

    static let rows: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
    ]

    static let rowsMultipleDimensions: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.75), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.75), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.25), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.25), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 1.0), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 1.0), height: 100)),
    ]

    static let rowsMultipleDimensionsMultipleHeights: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.75), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.75), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 200)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 200)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 0.25), height: 10)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.25), height: 10)),
        Row(view: nil,
                     props: MockProps(layout: ComponentLayout(dimension: .ratio(ratio: 1.0), height: 75)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 1.0), height: 75)),
    ]
}

struct MockProps: PropType {
    let layout: ComponentLayout
}

struct MockLabelProps: PropType {
    let labelProps: LabelPropType
    let layout: ComponentLayout
}

struct MockComponent: Component, ComponentLike {
    typealias ComponentPropType = MockLabelProps
    let props: PropType

    init(props: MockLabelProps) {
        self.props = props
    }

    func render() -> BaseComponent? {
        return Label(props: _props.labelProps)
    }
}

struct NilProps: PropType {}

struct MockComposite: Component {
    let props: PropType
    init(props: PropType) {
        self.props = props
    }
    func render() -> BaseComponent? {
        return MockComponent(props: MockLabelProps(labelProps: LabelProps(title: "composite"),
                                                   layout: ComponentLayout(dimension: .fill, height: 100)))
    }
}
