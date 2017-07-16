//
//  InternalComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a Section in an IndexPath containing a row of Components
///
struct SectionComponent {
    let section: Int
    var rows: [RowComponent]
    let layout: LayoutContainerProps

    init(section: Int, rows: [RowComponent], layout: LayoutContainerProps) {
        self.section = section
        self.rows = rows
        self.layout = layout
    }
}

///
/// Represents a Row in an IndexPath that contains a UIView
///
struct RowComponent {
    let props: PropType
    let section: Int
    let row: Int
    let view: UIView?

    init(view: UIView?, props: PropType, row: Int, section: Int) {
        self.view = view
        self.props = props
        self.row = row
        self.section = section
    }
}
