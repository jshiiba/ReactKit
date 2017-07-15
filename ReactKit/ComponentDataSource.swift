//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentDataSource {

    private(set) var sections: [SectionComponent] = []
    func update(_ sections: [SectionComponent]) {
        self.sections = sections
    }

    /// Finds the indexPaths in renderedComponents that matches the updatedComponents
    /// - parameters:
    ///     - renderedComponents: Components that were originally rendered from the view
    ///     - updatedComponents: Components that were actually updated via the reconciler
    /// - returns: IndexPaths of the cells to reload
    func indexPathsToReloadFor(renderedComponents: [Component], updatedComponents: [Component]) -> [IndexPath] {

        // TODO: get index paths by searching through renderedComponents for matching components in updatedComponents
        let indexPathsToReload: [IndexPath] = []

        return indexPathsToReload
    }
}

// TODO: make this a protocol
extension ComponentDataSource {
    var numberOfSections: Int {
        // TODO: return number of sections within Components
        return sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        // TODO: get components within a section
        return sections[section].rows.count
    }

    func component(at indexPath: IndexPath) -> UIView? {
        guard indexPath.section >= 0 && indexPath.section < sections.count &&
            indexPath.row >= 0 && indexPath.row < sections[indexPath.section].rows.count else {
                return nil
        }
        // return component from tree
        return sections[indexPath.section].rows[indexPath.row].view
    }
}
