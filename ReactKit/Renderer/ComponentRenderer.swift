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
class ComponentRender { // TODO: RenderER
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
        
        let tree = translator.translateToSections(from: rootComponent)

//        let cachedTree = cacher.cache(tree)
//
//        let updatedNodes = reconciler.reconcile(tree, cachedTree: cachedTree)
//        print("Nodes to update: \(updatedNodes)")

        //componentDataSource.indexPathsToReloadFor(renderedComponents: components, updatedComponents: updatedComponents)
        return []
    }
}



