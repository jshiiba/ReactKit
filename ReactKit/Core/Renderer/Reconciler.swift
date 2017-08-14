//
//  Reconciler.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

typealias Reconciliation = (inout [Section], inout [Section]?) -> [IndexPath]

/// Performs reconcilation between a new virtual datasource and a cached datasource
/// It determines what has changed between the old and new versions and outputs those
/// components (represented as IndexPaths) to update due to dirty data
/// - parameters: Current Components with new props
/// - returns: IndexPaths to update
final class Reconciler {
    static func reconcile(_ currentSections: inout [Section], cachedSections: inout [Section]?) -> [IndexPath] {
        guard let cachedSections = cachedSections else {
            return currentSections
            .reduce([]) { (result, section) in
                return result + section.rowIndexPaths()
            }
        }

        var updatedIndexPaths: [IndexPath] = []

        /// TODO: improve algorithm, this is a naive implementation. Improved algo would be:
        /// Perform a BFS starting at the Root section and reconcile each child down the tree
        /// until dirty data is found. Mark all sections/rows under as also dirty and reload
        for (sectionIndex, _) in currentSections.enumerated() {
            for (rowIndex, row) in currentSections[sectionIndex].rows.enumerated() {
                let currentProps = row.props
                let cachedProps = cachedSections[sectionIndex].rows[rowIndex].props

                if let current = currentProps, let cached = cachedProps, current != cached {
                    updatedIndexPaths.append(row.indexPath)
                }
            }
        }

        return updatedIndexPaths
    }
}
