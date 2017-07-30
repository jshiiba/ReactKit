//
//  PropType.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/11/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// Represents an object that contains properties for a component
///
protocol PropType {
    var layout: ComponentLayout? { get }
    func isEqualTo(_ other: PropType) -> Bool
}

extension PropType {
    var layout: ComponentLayout? {
        return nil
    }

    func isEqualTo(_ other: PropType) -> Bool {
        return false
    }
}

// MARK: - Equatable

func ==(lhs: PropType, rhs: PropType) -> Bool {
    return lhs.isEqualTo(rhs)
}

func !=(lhs: PropType, rhs: PropType) -> Bool {
    return !lhs.isEqualTo(rhs)
}

extension PropType where Self : Equatable {
    func isEqualTo(_ other: PropType) -> Bool {
        if let o = other as? Self {
            return self == o
        }
        return false
    }
}
