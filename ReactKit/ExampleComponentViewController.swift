//
//  ExampleComponentViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ExampleComponentViewController: BaseComponentViewController {

    struct ExampleProps: ExampleComponentPropType {
        let title: String
        let backgroundColor: UIColor

        static let ex1: ExampleProps = ExampleProps(title: "Title", backgroundColor: .blue)
        static let ex2: ExampleProps = ExampleProps(title: "Title 2", backgroundColor: .green)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let components = [
            ExampleComponent(props: ExampleProps.ex1),
            ExampleComponent(props: ExampleProps.ex2)
        ]

        setComponents(components, withProps: NilProps())
    }
}
