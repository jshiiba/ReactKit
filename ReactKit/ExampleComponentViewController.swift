//
//  ExampleComponentViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct ExampleProps: ExampleComponentPropType {
    let title: String
    let backgroundColor: UIColor
}

struct ExampleComponentViewControllerProps: ExampleComponentViewControllerPropType {
    let exampleComponentProps: ExampleComponentPropType
    let labelProps: LabelPropType
}

protocol ExampleComponentViewControllerPropType: PropType {
    var exampleComponentProps: ExampleComponentPropType { get }
    var labelProps: LabelPropType { get }
}

class ExampleComponentView: Component {
    func render(props: PropType) -> [Renderable] {
        guard let props = props as? ExampleComponentViewControllerProps else { return [] }

        return [
            ExampleComponent(initProps: props.exampleComponentProps),
            Label(props: props.labelProps)
        ]
    }
}

class ExampleComponentViewController: BaseComponentViewController {

    let props: ExampleComponentViewControllerProps

    init(props: ExampleComponentViewControllerProps) {
        self.props = props
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        renderComponents([ExampleComponentView()], with: self.props)
    }

}

