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
    func render() -> UIView
}


class GenericComponent<V: UIView>: Component {

    typealias Config = (V) -> ()
    let view: V

    init(config: Config) {
        self.view = V()

        config(self.view)
    }

    func render() -> UIView {
        return self.view
    }
}

protocol MyComponentPropType: PropType {
    var title: String { get }
    var backgroundColor: UIColor { get }
}

class MyComponent: Component {
    let props: MyComponentPropType

    init(props: MyComponentPropType) {
        self.props = props
    }

    func render() -> UIView {

        let view = UIView()

        let label = GenericComponent<UILabel> { (label) in
            label.text = props.title
//            label.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
            label.backgroundColor = props.backgroundColor
            label.sizeToFit()
        }

        view.addSubview(label.view)

        return view
    }
}

