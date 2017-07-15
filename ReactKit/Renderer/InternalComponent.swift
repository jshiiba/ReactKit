//
//  InternalComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct SectionComponent {
    let section: Int
    var rows: [RowComponent]

    init(section: Int, rows: [RowComponent]) {
        self.section = section
        self.rows = rows
    }
}

struct RowComponent {
    let props: PropType
    let section: Int
    let view: UIView?

    init(view: UIView?, props: PropType, section: Int) {
        self.view = view
        self.props = props
        self.section = section
    }
}
