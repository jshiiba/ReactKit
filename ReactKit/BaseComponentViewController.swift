//
//  ViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class BaseComponentViewController: UIViewController {

    var renderer: ComponentRender!

    var dataSource: ComponentCollectionViewDataSource!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        renderer = ComponentRender(componentDataSource: ComponentDataSource(), reconciler: ComponentReconciler())
        dataSource = ComponentCollectionViewDataSource(renderer: renderer)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource

        // TODO: prevent retain cycle
        dataSource.componentCollectionView = collectionView

        self.view.addSubview(collectionView)
    }

    func renderComponents(_ components: [Component], with props: PropType) {

        // trigger re-render with props
        dataSource.setComponents(components, with: props)
    }
}

