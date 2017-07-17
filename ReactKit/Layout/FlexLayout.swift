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

    static func attributes(forComponentProps components: [ComponentLayout], in container: ContainerLayout) -> [LayoutAttribute] {
        let containerFrame = container.frame
        var prevFrame = CGRect(origin: container.frame.origin, size: .zero)
        var currentFrame = CGRect(origin: container.frame.origin, size: .zero)

        let attributes: [LayoutAttribute] = components.map { component in
            currentFrame.size = CGSize(width: containerFrame.width * component.flex, height: component.size.height)
            currentFrame.origin = origin(forPreviousFrame: prevFrame, currentFrame: currentFrame, in: container.frame)

            prevFrame = currentFrame

            return LayoutAttribute(frame: currentFrame)
        }

        return attributes
    }

    static func origin(forPreviousFrame prev: CGRect, currentFrame curr: CGRect, in containerFrame: CGRect) -> CGPoint {
        let remainder = containerFrame.width - (prev.origin.x + prev.size.width)
        if curr.size.width > remainder {
            // wrap
            return CGPoint(x: containerFrame.origin.x, y: prev.origin.y + prev.size.height)
        } else {
            // inline
            return CGPoint(x: prev.origin.x + prev.size.width, y: prev.origin.y)
        }
    }
}
