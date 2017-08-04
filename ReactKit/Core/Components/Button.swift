//
//  Button.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct Button: ComponentReducing, ComponentLike {
    typealias ComponentPropType = ButtonPropType

    let props: PropType
    init(props: ButtonPropType) {
        self.props = props
    }

    func reduce() -> UIView? {
        let view = UIKitComponent<UIButton>(props: _props) { button in
            button.setTitle(_props.title, for: .normal)
            button.setTitleColor(_props.titleColor, for: .normal)
            button.add(for: .touchUpInside, _props.handler)
        }.view

        return view
    }
}

// MARK: - ButtonProps

protocol ButtonPropType: PropType {
    var title: String { get }
    var titleColor: UIColor { get }
    var handler: (UIControl) -> () { get }
}

struct ButtonProps: ButtonPropType {
    let layout: Layout?
    let title: String
    let titleColor: UIColor
    let handler: (UIControl) -> ()

    init(title: String, titleColor: UIColor, layout: Layout? = nil, handler: @escaping ((UIControl) ->())) {
        self.title = title
        self.titleColor = titleColor
        self.layout = layout
        self.handler = handler
    }
}
