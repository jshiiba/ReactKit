////
////  Components.swift
////  ReactKit
////
////  Created by Justin Shiiba on 7/5/17.
////  Copyright © 2017 Shiiba. All rights reserved.
////

import UIKit

protocol PropType {}

struct NilProps: PropType {}

/**
 All components must be able to return a UIView
 */
protocol Component {
    func render(props: PropType) -> UIView
}


class GenericComponent<V: UIView>: Component {

    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render(props: PropType) -> UIView {
        return self.view
    }
}

class MyComponent: Component {
    func render(props: PropType) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
        view.backgroundColor = .gray

        let label = GenericComponent<UILabel> { (label) in
            label.text = "Hello world"  // label.text = props.title
            label.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
            label.backgroundColor = .green
        }

        view.addSubview(label.view)
        return view
    }
}

