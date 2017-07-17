//
//  RowComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/17/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a Row in an IndexPath that contains a UIView
///
struct RowComponent {
    let props: PropType
    let section: Int
    let index: Int
    let layout: ComponentLayout?
    let view: UIView?

    init(view: UIView?, props: PropType, index: Int, section: Int) {
        self.view = view
        self.props = props
        self.layout = props.layout
        self.index = index
        self.section = section
    }
}
