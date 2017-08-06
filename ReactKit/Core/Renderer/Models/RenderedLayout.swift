//
//  RenderedLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents the layout of a Section or Row after being rendered
/// from a Component
///
struct RenderedLayout {
    var frame: CGRect
    let flow: ComponentFlowLayout

    init(frame: CGRect) {
        self.frame = frame
        self.flow = ComponentFlowLayout(parentFrame: self.frame)
    }

    mutating func updateHeight(_ height: CGFloat) {
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: height)
    }
}
