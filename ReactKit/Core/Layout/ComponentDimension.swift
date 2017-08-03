//
//  ComponentDimension.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents the dimensions of a component's layout
///
enum ComponentDimension {
    case ratio(ratio: CGFloat)
    case fixed(size: CGSize)
    case fill

    func width(in parentWidth: CGFloat) -> CGFloat {
        switch self {
        case .fill:
            return parentWidth
        case .fixed(let size):
            return size.width
        case .ratio(let ratio):
            return round(parentWidth * ratio)
        }
    }
}

extension ComponentDimension: Equatable {
    static func == (lhs: ComponentDimension, rhs: ComponentDimension) -> Bool {
        switch (rhs, lhs) {
        case (.fill, .fill): return true
        case (.ratio(let lhsRatio), .ratio(let rhsRatio)): return lhsRatio == rhsRatio
        case (.fixed(let lhsSize), .fixed(let rhsSize)): return lhsSize == rhsSize
        default: return false
        }
    }
}
