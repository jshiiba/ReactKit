//
//  ViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class BaseComponentViewController: UIViewController {

    let dataSource: ComponentCollectionViewDataSource = ComponentCollectionViewDataSource()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView = UICollectionView()
        collectionView.dataSource = dataSource
    }

    func dispatch() {
        print("dispatch action")
        // dispatch action to the store
    }

    func setState(state: Int) {
        // trigger re-render with state
    }
}

