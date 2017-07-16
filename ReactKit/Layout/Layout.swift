//
//  Layout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct LayoutContainerProps {

    let frame: CGRect
}

struct LayoutComponentProps {
    let flex: CGFloat   // 0-1.0
    let size: CGSize
}

struct LayoutAttribute {
    let frame: CGRect
}

struct FlexLayout {
    static func attributes(forComponentProp component: LayoutComponentProps, in container: LayoutContainerProps) -> LayoutAttribute {

        let flexWidth = container.frame.size.width * component.flex

        return LayoutAttribute(frame: CGRect(x: 0, y: 0, width: flexWidth, height: component.size.height))
    }
}
