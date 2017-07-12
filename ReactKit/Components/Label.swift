//
//  Label.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol LabelPropType: PropType {
    var title: String { get }
}

struct LabelProps: LabelPropType {
    let title: String
}

class Label: Component, ComponentLike {
    typealias ComponentPropType = LabelPropType

    let props: PropType
    init(props: LabelPropType) {
        self.props = props
    }

    func render() -> BaseComponent? {
        let view = UIKitComponent<UILabel>(props: _props) { label in
            label.text = _props.title
            label.sizeToFit()
        }.view

        return view
    }
}

