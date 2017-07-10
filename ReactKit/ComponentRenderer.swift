//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Right now this classes only job is to hide the use of the reconciler. Might not be necessary.
///
class ComponentRender {
    let componentDataSource: ComponentDataSource
    let reconciler: ComponentReconciler

    init(componentDataSource: ComponentDataSource, reconciler: ComponentReconciler) {
        self.componentDataSource = componentDataSource
        self.reconciler = reconciler
    }

    /// 
    ///
    ///
    func render(_ components: [Component], with props: PropType) -> [IndexPath] {
        let _ = Node(type: .root, props: NilProps())

        print(components)

        print("\n\n\n")

        // Iterating through all root level components and rendering each subtree
        let result = components.flatMap { $0.render(props: props) }.flatMap { ($0 as? Container)?.items }

        print(result)


        let updatedComponents = reconciler.reconcile(components, with: props)
        return componentDataSource.indexPathsToReloadFor(renderedComponents: components, updatedComponents: updatedComponents)
    }

}



