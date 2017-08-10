//
//  Cacher.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/13/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

protocol ComponentCache: class {
    func cache(_ sections: [Section]) -> [Section]?
}

/// Takes input and caches it and returns last cached sections
/// - parameters: sections
/// - returns: Recently Cached sections
final class Cacher: ComponentCache {
    private var cachedSections: [Section]?

    func cache(_ sections: [Section]) -> [Section]? {
        defer {
            cachedSections = sections
        }
        return cachedSections
    }
}
