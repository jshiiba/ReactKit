//
//  ComponentFlowLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/1/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Calculates the layout attributes for a layout similar to a UICollectionViewFlowLayout
///
final class ComponentFlowLayout {

    ///
    /// Attributes needed to layout the rows in a section
    ///
    struct Attributes {
        let startX: CGFloat
        var maxY: CGFloat

        var totalHeight: CGFloat {
            return maxY
        }

        init(previousFrame frame: CGRect, currentMaxY: CGFloat) {
            self.startX = frame.origin.x
            self.maxY = frame.origin.y + frame.height > currentMaxY ? (frame.origin.y + frame.height) : currentMaxY
        }

        mutating func updateMaxY(for frame: CGRect) {
            self.maxY = frame.origin.y + frame.height > self.maxY ? (frame.origin.y + frame.height) : self.maxY
        }
    }

    static func nextOrigin(for width: CGFloat, after previousFrame: CGRect, in sectionFrame: CGRect, attributes: Attributes) -> CGPoint {
        // need to account for a secion origin being non-zero, maybe use bounds instead?
        let xOrigin = sectionFrame.origin.x == 0 ? previousFrame.origin.x : sectionFrame.origin.x - previousFrame.origin.x

        let remainder = sectionFrame.width - (xOrigin + previousFrame.width)

        if width > remainder {
            // wrap
            return CGPoint(x: attributes.startX, y: attributes.maxY)
        } else {
            // inline
            return CGPoint(x: (previousFrame.origin.x + previousFrame.size.width), y: previousFrame.origin.y)
        }
    }

    // TODO: remove in favor of FlowLayoutData
    ///
    /// Get the Maximum Y position of the current Section
    /// - parameters:
    ///     - frame: a new frame (row) to add to the Section
    ///     - currentMaxY: the current max Y positions in the Section
    /// - returns:
    ///     - Max Y after adding new frame to Section
    static func maxYFor(_ frame: CGRect, currentMaxY: CGFloat) -> CGFloat {
        return frame.origin.y + frame.height > currentMaxY ? (frame.origin.y + frame.height) : currentMaxY
    }

    static func widthFor(dimension: ComponentDimension, in parentWidth: CGFloat) -> CGFloat {
        switch dimension {
        case .fill:
            return parentWidth
        case .fixed(let size):
            return size.width
        case .ratio(let ratio):
            return round(parentWidth * ratio)
        }
    }
}
