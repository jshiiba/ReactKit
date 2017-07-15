//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
///
///
class ComponentRenderer {
    let componentDataSource: ComponentDataSource
    let translator: ComponentTranslator
    let reconciler: ComponentReconciler
    let cacher: ComponentCacher

    init(componentDataSource: ComponentDataSource, reconciler: ComponentReconciler) {
        self.componentDataSource = componentDataSource
        self.reconciler = reconciler
        self.cacher = ComponentCacher()
        self.translator = ComponentTranslator()
    }

    /// 
    ///
    ///
    func render(_ rootComponent: Component) -> [IndexPath] {
        
        let sections = translator.translateToSections(from: rootComponent)

        componentDataSource.update(sections)

        let cachedSections = cacher.cache(sections)

        let rowsToUpdate = reconciler.reconcile(sections, cachedSections: cachedSections)

        return rowsToUpdate.map { row in
            return IndexPath(row: row.row, section: row.section)
        }
    }
}



