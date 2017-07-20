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

    init(view: UIView?, props: PropType, layout: RowComponentLayout, index: Int, section: Int) {
        self.view = view
        self.props = props
        self.layout = layout
        self.index = index
        self.section = section
    }
}

struct RowComponentLayout {
    let sectionFrame: CGRect // might not need this
    let dimension: FlexDimension

    // TODO: Origin modifiers, adjust height by content
    init(dimension: FlexDimension?, sectionFrame: CGRect) {
        self.dimension = dimension ?? .fill
        self.sectionFrame = sectionFrame
    }

    func rowWidth(in sectionWidth: CGFloat) -> CGFloat {
        switch dimension {
        case .fixed(let size):
            if size.width > sectionWidth {
                return sectionWidth
            } else {
                return size.width
            }
        case .ratio(let ratio):
            return sectionWidth * ratio
        case .fill:
            return sectionWidth
        }
    }
}
