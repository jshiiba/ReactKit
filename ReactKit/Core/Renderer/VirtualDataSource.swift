//
//  VirtualDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/4/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

protocol VirtualDataSource: class {
    var sections: [Section] { get }
    var current: Section? { get }
    func nextSectionIndex() -> Int
    func insert(_ section: Section, at index: Int)
}

final class TranslatorVirtualDataSource: VirtualDataSource {
    private var currentSectionIndex: Int = 0
    private var values: [Section] = []

    var current: Section? {
        guard currentSectionIndex >= 0, currentSectionIndex < values.count else {
            return nil
        }

        return values[currentSectionIndex]
    }

    var sections: [Section] {
        return values
    }

    func nextSectionIndex() -> Int {
        return values.isEmpty ? 0 : currentSectionIndex + 1
    }

    func insert(_ section: Section, at index: Int) {
        values.insert(section, at: index)
        currentSectionIndex = index
    }
}
