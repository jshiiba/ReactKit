//
//  FlexDimension.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents the dimensions of a component's layout
///
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
