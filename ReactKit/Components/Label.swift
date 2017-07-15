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

func ==(lhs: LabelPropType, rhs: LabelPropType) -> Bool {
    return lhs.isEqualTo(other: rhs)
}

struct LabelProps: LabelPropType {
    let title: String
}

extension LabelProps: Equatable {
    static func ==(lhs: LabelProps, rhs: LabelProps) -> Bool {
        return lhs.title == rhs.title
    }
}

struct Label: Component, ComponentLike {
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

extension Label: SingleViewComponent {}

