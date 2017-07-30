//
//  ReduxExample.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

protocol ReduxPropType: PropType {
    var buttons: [ButtonPropType] { get }
}

struct ReduxProps: ReduxPropType {
    let buttons: [ButtonPropType]
}

class ReduxView: Component, ComponentLike {
    typealias ComponentPropType = ReduxPropType
    let props: PropType

    init(props: ReduxPropType) {
        self.props = props
    }

    func render() -> BaseComponent? {
        let count = Label(props: LabelProps(title: "Count: 0", textAlignment: .center, layout: ComponentLayout(dimension: .fill, height: 100)))

        let buttons = _props.buttons.map { buttonProp in
            return Button(props: buttonProp)
        }

        let components: [Component] = [count] + buttons
        return Container(components: components, layout: ContainerLayout(dimension: .ratio(ratio: 1.0)))
    }
}

class ReduxViewController: BaseComponentViewController {
    let props = ReduxProps(buttons: [
        ButtonProps(title: "Increase",
                    titleColor: .black,
                    layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 50),
                    handler: { control in
            print("increase")
        }),
        ButtonProps(title: "Decrease",
                    titleColor: .black,
                    layout: ComponentLayout(dimension: .ratio(ratio: 0.5), height: 50),
                    handler: { control in
            print("decrease")
        }),
    ])

    override func render() -> Component {
        return ReduxView(props: props)
    }
}
