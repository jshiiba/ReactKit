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

    static let containerProps = ContainerProps(layout: Layout(dimension: .fill))

    static func labelComponent() -> ComponentReducing {
        return Label(props: LabelProps(title: "Label 1", layout: Layout(dimension: .fill, height: 100)))
    }

    static func composite() -> CompositeComponent {
        return MockComposite(props: NilProps())
    }

    static func containerWithLabel(with labelDimension: ComponentDimension, labelHeight: CGFloat) -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label", layout: Layout(dimension: labelDimension, height: labelHeight)))
        ], props: containerProps)
    }

    static func containerWithSameTwoLabels(with labelDimension: ComponentDimension, labelHeight: CGFloat) -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label 1", layout: Layout(dimension: labelDimension, height: labelHeight))),
            Label(props: LabelProps(title: "Label 2", layout: Layout(dimension: labelDimension, height: labelHeight)))
        ], props: containerProps)
    }

    static func containerWithMultipleLabels() -> Container {
        return Container(components: [
            Label(props: LabelProps(title: "Label 1", layout: Layout(dimension: .ratio(ratio: 0.75), height: 100))),
            Label(props: LabelProps(title: "Label 2", layout: Layout(dimension: .ratio(ratio: 0.5), height: 200))),
            Label(props: LabelProps(title: "Label 3", layout: Layout(dimension: .ratio(ratio: 0.25), height: 25))),
            Label(props: LabelProps(title: "Label 4", layout: Layout(dimension: .ratio(ratio: 1.0), height: 100))),
        ], props: containerProps)
    }

    static func containerWithContainers() -> Container {
        return Container(components: [
            Container(components: [
                Label(props: LabelProps(title: "Label 1", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 2", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)))
            ], props: ContainerProps(layout: Layout(dimension: .ratio(ratio: 0.5)))),
            Container(components: [
                Label(props: LabelProps(title: "Label 3", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100))),
                Label(props: LabelProps(title: "Label 4", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)))
            ], props: ContainerProps(layout: Layout(dimension: .ratio(ratio: 0.5)))),
        ], props: containerProps)
    }

    static func multiLevelContainers() -> Container {
        return Container(components: [
            Container(components: [
                Container(components: [
                    Label(props: LabelProps(title: "Label 1", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 2", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], props: ContainerProps(layout: Layout(dimension: .ratio(ratio: 0.5)))),
                Container(components: [
                    Label(props: LabelProps(title: "Label 3", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100))),
                    Label(props: LabelProps(title: "Label 4", layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)))
                ], props: ContainerProps(layout: Layout(dimension: .ratio(ratio: 0.5)))),
            ], props: ContainerProps( layout: Layout(dimension: .ratio(ratio: 0.5)))),
        ], props: containerProps)
    }
}

struct MockRows {
    static let singleRow: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .fill, height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .fill, height: 100))
    ]

    static let rows: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
    ]

    static let rowsMultipleDimensions: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.75), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.75), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.5), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.25), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.25), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 1.0), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 1.0), height: 100)),
    ]

    static let rowsMultipleDimensionsMultipleHeights: [Row] = [
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.75), height: 100)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.75), height: 100)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.5), height: 200)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.5), height: 200)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 0.25), height: 10)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 0.25), height: 10)),
        Row(view: nil,
                     props: MockProps(layout: Layout(dimension: .ratio(ratio: 1.0), height: 75)),
                     index: 0,
                     section: 0,
                     layout: RowLayout(dimension: .ratio(ratio: 1.0), height: 75)),
    ]
}

struct MockProps: PropType {
    let layout: Layout
}

struct MockLabelProps: PropType {
    let labelProps: LabelPropType
    let layout: Layout
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
                                                   layout: Layout(dimension: .fill, height: 100)))
    }
}
