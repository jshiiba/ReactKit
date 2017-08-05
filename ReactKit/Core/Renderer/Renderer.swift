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

    /// private vars
    fileprivate var dataSource: VirtualDataSource!

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

        var virtualDataSource: VirtualDataSource = ComponentVirtualDataSource()

        Translator.translate(fromComponent: rootComponent, to: &virtualDataSource)
        dataSource = virtualDataSource

        // recalculate layout
        layout.sections = virtualDataSource.sections

        let cachedSections = cacher.cache(virtualDataSource.sections)

        return reconciler.reconcile(virtualDataSource.sections, cachedSections: cachedSections)
    }
}

// MARK: -  ComponentDataSource

extension Renderer: ComponentDataSource {
    var numberOfSections: Int {
        return dataSource.sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < dataSource.sections.count else {
            return 0
        }
        return dataSource.sections[section].rows.count
    }

    func component(at indexPath: IndexPath) -> UIView? {
        guard indexPath.section >= 0 && indexPath.section < dataSource.sections.count &&
              indexPath.row >= 0 && indexPath.row < dataSource.sections[indexPath.section].rows.count else {
                return nil
        }

        return dataSource.sections[indexPath.section].rows[indexPath.row].view
    }
}
