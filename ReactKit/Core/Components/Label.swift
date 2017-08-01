//
//  Label.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct Label: Component, ComponentLike {
    typealias ComponentPropType = LabelPropType

    let props: PropType
    init(props: LabelPropType) {
        self.props = props
    }

    func render() -> BaseComponent? {
        let view = UIKitComponent<UILabel>(props: _props) { label in
            label.text = _props.title
            label.textAlignment = _props.textAlignment
            label.sizeToFit()
        }.view

        return view
    }
}

extension Label: SingleViewComponent {}

// MARK: - Label Props

protocol LabelPropType: PropType {
    var title: String { get }
    var textAlignment: NSTextAlignment { get }
}

struct LabelProps: LabelPropType {
    let layout: Layout?
    let title: String
    let textAlignment: NSTextAlignment

    init(title: String, textAlignment: NSTextAlignment = .left, layout: Layout? = nil) {
        self.title = title
        self.textAlignment = textAlignment
        self.layout = layout
    }
}

// might not be needed
func ==(lhs: LabelPropType, rhs: LabelPropType) -> Bool {
    return lhs.isEqualTo(rhs)
}

extension LabelProps: Equatable {
    static func ==(lhs: LabelProps, rhs: LabelProps) -> Bool {
        return lhs.title == rhs.title
    }
}
