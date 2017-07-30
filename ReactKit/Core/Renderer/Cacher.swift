//
//  Cacher.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/13/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

/// Takes input and caches it and returns last cached sections
/// - parameters: sections
/// - returns: Recently Cached sections
class Cacher {
    var cachedSections: [Section]?

    func cache(_ sections: [Section]) -> [Section]? {
        defer {
            cachedSections = sections
        }
        return cachedSections
    }
}
