//
//  Row.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/17/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a Row in an IndexPath that contains a UIView
///
struct Row {
    let props: PropType
    let indexPath: IndexPath
    let section: Int
    let index: Int
    let layout: RowLayout
    let view: UIView?

    init(row: Row, layout: RowLayout) {
        self.init(view: row.view, props: row.props, index: row.index, section: row.section, layout: layout)
    }

    init(view: UIView?, props: PropType, index: Int, section: Int, layout: RowLayout) {
        self.view = view
        self.props = props
        self.index = index
        self.section = section
        self.indexPath = IndexPath(row: index, section: section)
        self.layout = layout
    }
}

struct RowLayout {

    var frame: CGRect
    let dimension: ComponentDimension
    let height: CGFloat

    init(layout: RowLayout, frame: CGRect) {
        self.init(dimension: layout.dimension, height: layout.height)
        self.frame = frame
    }

    init(dimension: ComponentDimension, height: CGFloat) {
        self.dimension = dimension
        self.height = height
        self.frame = .zero
    }
}
