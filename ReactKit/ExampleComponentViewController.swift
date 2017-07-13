//
//  ExampleComponentViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol ExampleComponentViewControllerPropType: PropType {
    var exampleComponentProps: ExampleComponentPropType { get }
    var labelProps: LabelPropType { get }
}

class ExampleComponentViewController: BaseComponentViewController {

    var props: ExampleComponentViewControllerProps
    var count = 1

    init(props: ExampleComponentViewControllerProps) {
        self.props = props
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Example Component"

        let rightItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(triggerState))
        navigationItem.setRightBarButton(rightItem, animated: false)
    }

    override func render() -> Component {
        return ExampleComponentView(props: self.props)
    }
}

extension ExampleComponentViewController {
    @objc func triggerState() {
        if count % 2 == 0 {
            count = count + 1
            props = ExampleComponentViewControllerProps(
                exampleComponentProps: ExampleProps(title: "Hello world!", backgroundColor: .green),
                labelProps: LabelProps(title: "Hello again!")
            )
        } else {
            count = count + 1
            props = ExampleComponentViewControllerProps(
                exampleComponentProps: ExampleProps(title: "Goodbye world!", backgroundColor: .red),
                labelProps: LabelProps(title: "Goodbye again!")
            )
        }
        triggerRender()
    }
}

