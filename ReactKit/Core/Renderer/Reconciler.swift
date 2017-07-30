//
//  Reconciler.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// - parameters: Current Components with new props
/// - returns: IndexPaths to update
class Reconciler {
    func reconcile(_ currentSections: [Section], cachedSections: [Section]?) -> [IndexPath] {
        guard let cachedSections = cachedSections else {
            return currentSections
            // convert sections to array of rows to update
            .reduce([]) { (result, section) in
                return result + section.rows
            }
            .map { $0.indexPath }
        }

        var updatedIndexPaths: [IndexPath] = []

        // TODO: improve algorithm
        for (sectionIndex, _) in currentSections.enumerated() {
            for (rowIndex, row) in currentSections[sectionIndex].rows.enumerated() {
                let currentProps = row.props
                let cachedProps = cachedSections[sectionIndex].rows[rowIndex].props

                if currentProps.isEqualTo(other: cachedProps) {
                    print("EQUAL")
                } else {
                    print("NOT EQUAL")
                    updatedIndexPaths.append(IndexPath(row: row.index, section: row.section))
                }
            }
        }

        return updatedIndexPaths
    }
}
