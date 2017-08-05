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
struct Row: ComponentRepresentable {
    typealias LayoutType = RowLayout

    let props: PropType
    let indexPath: IndexPath
    let layout: LayoutType
    let view: UIView?

    init(row: Row, layout: RowLayout) {
        self.init(view: row.view, props: row.props, indexPath: row.indexPath, layout: layout)
    }

    init(view: UIView?, props: PropType, indexPath: IndexPath, layout: RowLayout) {
        self.view = view
        self.props = props
        self.indexPath = indexPath
        self.layout = layout
    }
}

struct RowLayout: ComponentRepresentableLayout {

    var frame: CGRect {
        return CGRect(origin: origin, size: rowFrame.size)
    }

    var origin: CGPoint {
        if let sectionFrame = sectionFrame {
            return CGPoint(x: rowFrame.origin.x + sectionFrame.origin.x, y: rowFrame.origin.y + sectionFrame.origin.y)
        } else {
            return rowFrame.origin
        }
    }

    private let rowFrame: CGRect
    private let sectionFrame: CGRect?

    init(frame: CGRect, sectionFrame: CGRect?) {
        self.rowFrame = frame
        self.sectionFrame = sectionFrame
    }
}
