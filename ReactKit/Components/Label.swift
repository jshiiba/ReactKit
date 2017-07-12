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

class Label: Component {
    func render(props: PropType) -> RenderedComponent? {
        guard let props = props as? LabelProps else {
            return nil
        }

        let view = UIKitComponent<UILabel> { label in
            label.text = props.title
            label.sizeToFit()
        }.view

        return RenderedComponent(component: view, props: props)
    }
}

