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

    let props: PropType?
    let indexPath: IndexPath
    let layout: RenderedLayout?
    let view: UIView?

    init(row: Row, layout: RenderedLayout) {
        self.init(view: row.view, props: row.props, indexPath: row.indexPath, layout: layout)
    }

    init(view: UIView?, props: PropType?, indexPath: IndexPath, layout: RenderedLayout? = nil) {
        self.view = view
        self.props = props
        self.indexPath = indexPath
        self.layout = layout
    }
}

