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
class Renderer {

    /// dependencies
    let reconciler: Reconciler
    let cacher: Cacher
    let layout: ComponentCollectionViewLayout

    /// private vars
    private var sections: [Section] = []

    init(reconciler: Reconciler) {
        self.reconciler = reconciler
        self.cacher = Cacher()
        self.layout = ComponentCollectionViewLayout()
    }

    /// 
    /// Renders the Component Tree into Sections.
    /// Then determines the indexPaths that need to be updated through reconciliation
    ///
    func render(_ rootComponent: Component, in frame: CGRect) -> [IndexPath] {
        
        sections =  Translator.translateSections(from: rootComponent, in: frame)
        layout.sections = sections

        let cachedSections = cacher.cache(sections)

        let updatedItems = reconciler.reconcile(sections, cachedSections: cachedSections)

        return updatedItems.map { item in
            return IndexPath(row: item.row, section: item.section)
        }
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
        return sections[section].rows.count
    }

    func component(at indexPath: IndexPath) -> UIView? {
        guard indexPath.section >= 0 && indexPath.section < sections.count &&
              indexPath.row >= 0 && indexPath.row < sections[indexPath.section].rows.count else {
                return nil
        }

        return sections[indexPath.section].rows[indexPath.row].view
    }
}


