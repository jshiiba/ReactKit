//
//  ComponentCacher.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/13/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

/// Takes input and caches it and returns last cached sections
/// - parameters: sections
/// - returns: Recently Cached sections
class ComponentCacher {
    var cachedSections: [SectionComponent]?

    func cache(_ sections: [SectionComponent]) -> [SectionComponent]? {
        defer {
            cachedSections = sections
        }
        return cachedSections
    }
}
