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

    var startX: CGFloat
    var maxY: CGFloat

    var totalHeight: CGFloat {
        return maxY
    }

    internal var parentFrame: CGRect
    internal var previousFrame: CGRect?

    init(parentFrame: CGRect) {
        self.parentFrame = parentFrame
        self.startX = parentFrame.origin.x
        self.maxY = parentFrame.origin.y
    }

    func calculateNextFrame(forWidth width: CGFloat, height: CGFloat) -> CGRect {
        let previous = previousFrame ?? CGRect(origin: parentFrame.origin, size: .zero)
        let origin = nextOrigin(for: width, after: previous, in: parentFrame, startX: startX, maxY: maxY)

        let frame = CGRect(origin: origin, size: CGSize(width: width, height: height))

        maxY = maxYFor(frame, currentMaxY: maxY)
        previousFrame = frame
        
        return frame
    }

    func nextOrigin(for width: CGFloat, after previousFrame: CGRect, in parentFrame: CGRect, startX: CGFloat, maxY: CGFloat) -> CGPoint {
        // need to account for a secion origin being non-zero, maybe use bounds instead?
        let currentXOrigin = calculateCurrentXOrigin(fromPreviousFrame: previousFrame, in: parentFrame)

        let remainder = parentFrame.width - (currentXOrigin + previousFrame.width)

        if width > remainder {
            // wrap
            return CGPoint(x: startX, y: maxY)
        } else {
            // inline
            return CGPoint(x: (previousFrame.origin.x + previousFrame.size.width), y: previousFrame.origin.y)
        }
    }

    func calculateCurrentXOrigin(fromPreviousFrame previousFrame: CGRect, in parentFrame: CGRect) -> CGFloat {
        let xOrigin = parentFrame.origin.x == 0 ? previousFrame.origin.x : parentFrame.origin.x - previousFrame.origin.x

        if xOrigin < 0 {
            return previousFrame.origin.x
        } else {
            return xOrigin
        }
    }

    func updatePreviousSize(_ size: CGSize) {
        previousFrame?.size = size

        if let previousFrame = previousFrame {
            maxY = maxYFor(previousFrame, currentMaxY: maxY)
        }
    }

    ///
    /// Get the Maximum Y position of the current Section
    /// - parameters:
    ///     - frame: a new frame (row) to add to the Section
    ///     - currentMaxY: the current max Y positions in the Section
    /// - returns:
    ///     - Max Y after adding new frame to Section
    func maxYFor(_ frame: CGRect, currentMaxY: CGFloat) -> CGFloat {
        return frame.origin.y + frame.height > currentMaxY ? (frame.origin.y + frame.height) : currentMaxY
    }
}
