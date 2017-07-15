//
//  PropType.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/11/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
///
///
protocol PropType {
    func isEqualTo(other: PropType) -> Bool
}

extension PropType where Self : Equatable {
    func isEqualTo(other: PropType) -> Bool {
        if let o = other as? Self {
            return self == o
        }
        return false
    }
}

extension PropType {
    func isEqualTo(other: PropType) -> Bool {
        return false
    }
}
