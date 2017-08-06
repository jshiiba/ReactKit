//
//  Reconciler.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

/// Performs reconcilation between a new virtual datasource and a cached datasource
/// It determines what has changed between the old and new versions and outputs those
/// components (represented as IndexPaths) to update due to dirty data
/// - parameters: Current Components with new props
/// - returns: IndexPaths to update
final class Reconciler {
    func reconcile(_ currentSections: [Section], cachedSections: [Section]?) -> [IndexPath] {

        // TODO: Change to BFS

        guard let cachedSections = cachedSections else {
            return currentSections
            // convert sections to array of rows to update
            .reduce([]) { (result, section) in
                return result + section.rows
            }
            .map { $0.indexPath }
        }

        var updatedIndexPaths: [IndexPath] = []

        // TODO: improve algorithm, this is a naive implementation
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
