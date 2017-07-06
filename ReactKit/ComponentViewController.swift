//
//  ComponentViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentViewController: UIViewController {

    //let renderer : Renderable = Renderer()

    override func viewDidLoad() {
        super.viewDidLoad()

        let container = Container(components: [
            MyComponent(),
            MyComponent()
        ])

        let containerView = container.render(props: NilProps())
        self.view.addSubview(containerView)
    }
}
