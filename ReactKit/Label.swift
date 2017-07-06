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

class Label: Component {

    func render(props: PropType) -> UIView {
        return GenericComponent<UILabel> { label in
            label.text = "Hello world" // props.title
        }.view
    }
}

