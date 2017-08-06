//
//  Renderer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// DataSource for a BaseComponentViewController
///
protocol ComponentDataSource {
    var numberOfSections: Int { get }
    func numberOfItems(in section: Int) -> Int
    func component(at indexPath: IndexPath) -> UIView?
}

///
/// Object that renders Components into a virtual CollectionViewDataSource
/// and outputs the index paths that need to be updated
///
final class Renderer {

    /// dependencies
    let reconciler: Reconciler
    let cacher: Cacher
    let layout: ComponentCollectionViewLayout

    fileprivate var sections: [Section] = []

    init(reconciler: Reconciler) {
        self.reconciler = reconciler
        self.cacher = Cacher()
        self.layout = ComponentCollectionViewLayout()
    }

    /// Renders the Component Tree into Sections.
    /// Then determines the indexPaths that need to be updated through reconciliation
    /// - parameters:
    ///     - rootComponent: Root of the Component tree
    ///     - frame: frame of the collection view
    /// - returns:
    ///     - indexPaths: which indexPaths to update in the collection view
    func render(_ rootComponent: Component, in frame: CGRect) -> [IndexPath] {

        sections = Translator.translate(fromComponent: rootComponent)

        layout.calculateLayout(for: &sections, in: frame)

        let cachedSections = cacher.cache(sections)

        return reconciler.reconcile(sections, cachedSections: cachedSections)
    }
}

// MARK: -  ComponentDataSource

extension Renderer: ComponentDataSource {
    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < sections.count else {
            return 0
        }
        return sections[section].rowCount
    }

    func component(at indexPath: IndexPath) -> UIView? {
        guard indexPath.section >= 0 && indexPath.section < sections.count &&
              indexPath.row >= 0 && indexPath.row < sections[indexPath.section].rowCount else {
                return nil
        }

        return sections[indexPath.section].view(at: indexPath.row)
    }
}
