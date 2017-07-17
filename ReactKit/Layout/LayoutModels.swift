//
//  Layout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct LayoutAttribute {
    let frame: CGRect
}

struct ComponentLayout {
    let flex: CGFloat   // 0-1.0
    let size: CGSize
}


struct ContainerLayout {
    let frame: CGRect
}
