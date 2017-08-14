//
//  ViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// The base class view controller that renders Components in a UICollectionView
///
class ComponentViewController: UIViewController {

    internal var dataSourceProvider: ComponentCollectionViewDataSourceProvider = ComponentDataSourceProvider()
    internal var dataSource: ComponentCollectionViewDataSource!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = dataSourceProvider.provide()

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: dataSource.collectionViewLayout)
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

