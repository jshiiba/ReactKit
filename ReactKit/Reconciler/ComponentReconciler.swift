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
        guard let cachedSections = cachedSections else {
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
                    updatedIndexPaths.append(IndexPath(row: row.row, section: row.section))
                }
            }
        }

        return updatedIndexPaths
    }
}
