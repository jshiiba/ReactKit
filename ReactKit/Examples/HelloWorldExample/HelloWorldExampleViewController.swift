//
//  HelloWorldExampleViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

class HelloWorldViewController: ComponentViewController {
    override func render() -> Component {
        return Label(props: LabelProps(title: "Hello World!",
                                       textAlignment: .center,
                                       layout: ComponentLayout(dimension: .fill, height: 100)))
    }
}
