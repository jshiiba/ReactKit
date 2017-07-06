//
//  ViewController.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    private let identifier = "ID"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

}

