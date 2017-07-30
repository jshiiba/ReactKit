//
//  ReduxExample.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

class ReduxViewController: BaseComponentViewController {
    let props = ReduxProps(
        counter: CounterViewProps(count: 1, layout: ComponentLayout(dimension: .fill, height: 100)),
        buttons: [
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
