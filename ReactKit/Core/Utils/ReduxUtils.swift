//
//  ReduxUtils.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/31/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

/// Performs transform on object T at index in array [T]
/// - parameter elements: the given array
/// - parameter index: index to perform transform, returns array if out of bounds
/// - parameter transform: function that transforms value at index
///
/// - returns [T]: immutable array of [T]
func modify<T>(_ elements: [T], at index: Int, transform: ((T) -> (T))? = nil) -> [T] {
    guard index >= 0 && index < elements.count, let transform = transform else {
        return elements
    }

    // preforms tranform on object at index in array and returns new immutable array
    return elements[0..<index] + [transform(elements[index])] + elements[index+1..<elements.count]
}

func remove<T>(at index: Int, from elements: [T]) -> [T] {
    guard index >= 0 && index < elements.count else {
        return elements
    }

    // weird compiler error if Array() isnt used?
    return Array(elements[0..<index]) + elements[index+1..<elements.count]
}
