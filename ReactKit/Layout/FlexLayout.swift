//
//  FlexLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/17/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
///
///
struct FlexLayout {

    static func sectionWidth(for dimension: FlexDimension, in frame: CGRect) -> CGFloat {
        switch dimension {
        case .fill:
            return frame.size.width
        case .fixed(let size):
            return size.width
        case .ratio(let ratio):
            return frame.size.width * ratio
        }
    }

    static func width(for dimension: FlexDimension, in parentWidth: CGFloat) -> CGFloat {
        switch dimension {
        case .fill:
            return parentWidth
        case .fixed(let size):
            return size.width
        case .ratio(let ratio):
            return parentWidth * ratio
        }
    }

    static func attributes(forComponentsLayout components: [RowComponentLayout], in section: SectionComponentLayout) -> [LayoutAttribute] {
        let sectionFrame = section.frame
        var prevFrame = CGRect(origin: section.frame.origin, size: .zero)
        var currentFrame = CGRect(origin: section.frame.origin, size: .zero)

        let attributes: [LayoutAttribute] = components.map { component in

            currentFrame.size = CGSize(width: component.rowWidth(in: sectionFrame.width), height: 50/*component.height*/)
            currentFrame.origin = origin(fromPreviousFrame: prevFrame, currentFrame: currentFrame, in: sectionFrame)

            prevFrame = currentFrame

            return LayoutAttribute(frame: currentFrame)
        }

        return attributes
    }

    static func origin(fromPreviousFrame prev: CGRect, currentFrame curr: CGRect, in sectionFrame: CGRect) -> CGPoint {
        let remainder = sectionFrame.width - (prev.origin.x + prev.size.width)
        if curr.size.width > remainder {
            // wrap
            return CGPoint(x: sectionFrame.origin.x, y: prev.origin.y + prev.size.height)
        } else {
            // inline
            return CGPoint(x: prev.origin.x + prev.size.width, y: prev.origin.y)
        }
    }
}
