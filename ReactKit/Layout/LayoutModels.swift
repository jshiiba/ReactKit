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

enum FlexDimension {
    case ratio(ratio: CGFloat)
    case fixed(size: CGSize)
    case fill
}

struct ComponentLayout {
    let dimension: FlexDimension
}

struct ContainerLayout {
    let dimension: FlexDimension
}
