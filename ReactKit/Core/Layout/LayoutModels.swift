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

extension FlexDimension: Equatable {
    static func == (lhs: FlexDimension, rhs: FlexDimension) -> Bool {
        switch (rhs, lhs) {
        case (.fill, .fill): return true
        case (.ratio(let lhsRatio), .ratio(let rhsRatio)): return lhsRatio == rhsRatio
        case (.fixed(let lhsSize), .fixed(let rhsSize)): return lhsSize == rhsSize
        default: return false
        }
    }
}

struct ComponentLayout {
    let dimension: FlexDimension
    let height: CGFloat
}

struct ContainerLayout {
    let dimension: FlexDimension
}
