//
//  ComponentViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentViewController: UIViewController {

    struct MyComponentProps: MyComponentPropType {
        let backgroundColor: UIColor
        let title: String
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let container = Container(components: [
            MyComponent(props: MyComponentProps(backgroundColor: .green, title: "Hello")),
            MyComponent(props: MyComponentProps(backgroundColor: .blue, title: "World")),
            GenericComponent<UIButton> { (button) in
                button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
                button.backgroundColor = .red
                button.setTitle("Press me", for: .normal)
            }
        ])

        let containerView = container.render()
        self.view.addSubview(containerView)
    }
}
