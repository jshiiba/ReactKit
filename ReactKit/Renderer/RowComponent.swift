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
    let layout: RowComponentLayout
    let view: UIView?

    init(rowComponent: RowComponent, layout: RowComponentLayout) {
        self.init(view: rowComponent.view, props: rowComponent.props, index: rowComponent.index, section: rowComponent.section, layout: layout)
    }

    init(view: UIView?, props: PropType, index: Int, section: Int, layout: RowComponentLayout) {
        self.view = view
        self.props = props
        self.index = index
        self.section = section
        self.layout = layout
    }
}

struct RowComponentLayout {

    var frame: CGRect
    let dimension: FlexDimension
    let height: CGFloat

    init(layout: RowComponentLayout, newFrame: CGRect) {
        self.init(dimension: layout.dimension, height: layout.height)
        self.frame = newFrame
    }

    init(dimension: FlexDimension, height: CGFloat) {
        self.dimension = dimension
        self.height = height
        self.frame = .zero
    }

    func rowWidth(in sectionWidth: CGFloat) -> CGFloat {
//        switch dimension {
//        case .fixed(let size):
//            if size.width > sectionWidth {
//                return sectionWidth
//            } else {
//                return size.width
//            }
//        case .ratio(let ratio):
//            return sectionWidth * ratio
//        case .fill:
//            return sectionWidth
//        }
        return 0
    }
}
