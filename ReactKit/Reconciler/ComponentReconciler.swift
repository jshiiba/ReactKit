//
//  ComponentRenderer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// - parameters: Current Components with new props
/// - returns: IndexPaths to update
class ComponentReconciler {
    func reconcile(_ currentSections: [SectionComponent], cachedSections: [SectionComponent]?) -> [IndexPath] {
        // TODO: Diff

        return currentSections
        // convert sections to array of rows to update
        .reduce([]) { (result, section) in
            return result + section.rows
        }
        // convert rows to IndexPath
        .map { path in
            return IndexPath(row: path.row, section: path.section)
        }
    }
}
