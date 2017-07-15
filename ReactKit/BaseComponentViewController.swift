//
//  ViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class BaseComponentViewController: UIViewController {

    var renderer: ComponentRenderer!

    var dataSource: ComponentCollectionViewDataSource!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        renderer = ComponentRenderer(componentDataSource: ComponentDataSource(), reconciler: ComponentReconciler())
        dataSource = ComponentCollectionViewDataSource(renderer: renderer)

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = dataSource

        // TODO: prevent retain cycle
        dataSource.componentCollectionView = collectionView

        self.view.addSubview(collectionView)

        triggerRender()
    }

    func triggerRender() {
        dataSource.setComponent(render())
    }

    func render() -> Component {
        fatalError("Override method required")
    }
}

