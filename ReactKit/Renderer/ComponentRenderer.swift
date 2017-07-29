//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol ComponentDataSource {

    var numberOfSections: Int { get }

    func numberOfItems(in section: Int) -> Int

    func component(at indexPath: IndexPath) -> UIView?
}

///
///
///
class ComponentRenderer {

    /// dependencies
    let translator: ComponentTranslator
    let reconciler: ComponentReconciler
    let cacher: ComponentCacher
    let layout: ComponentFlowLayout

    /// private vars
    private var sections: [SectionComponent] = []

    init(reconciler: ComponentReconciler) {
        self.reconciler = reconciler
        self.cacher = ComponentCacher()
        self.translator = ComponentTranslator()
        self.layout = ComponentFlowLayout()
    }

    /// 
    ///
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

extension ComponentRenderer: ComponentDataSource {
    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(in section: Int) -> Int {
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


