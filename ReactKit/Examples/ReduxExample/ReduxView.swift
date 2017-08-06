//
//  ReduxView.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

// MARK: - Redux View

protocol ReduxPropType: PropType {
    var counter: CounterViewPropType { get }
    var buttons: [ButtonPropType] { get }
}

struct ReduxProps: ReduxPropType {
    let counter: CounterViewPropType
    let buttons: [ButtonPropType]
}

final class ReduxView: CompositeComponent, ComponentLike {
    typealias ComponentPropType = ReduxPropType
    let props: PropType

    init(props: ReduxPropType) {
        self.props = props
    }

    func render() -> Component? {
        let counter = CounterView(props: _props.counter)

        let buttons = _props.buttons.map { buttonProp in
            return Button(props: buttonProp)
        }

        let components: [Component] = [counter] + buttons
        return Container(components: components, props: ContainerProps(layout: Layout(dimension: .ratio(ratio: 1.0))))
    }
}

// MARK: - Counter View

protocol CounterViewPropType: PropType {
    var count: Int { get }
}

struct CounterViewProps: CounterViewPropType {
    let count: Int
    let layout: Layout?

    init(count: Int, layout: Layout? = nil) {
        self.count = count
        self.layout = layout
    }
}

final class CounterView: CompositeComponent, ComponentLike {
    typealias ComponentPropType = CounterViewPropType
    let props: PropType
    init(props: CounterViewPropType) {
        self.props = props
    }

    func render() -> Component? {
        let title = "Count: \(_props.count)"
        return Label(props: LabelProps(title: title,
                                       textAlignment: .center,
                                       layout: Layout(dimension: .fill, height: 100)))
    }
}
