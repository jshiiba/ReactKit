//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentCollectionViewDataSource: NSObject {
    var componentDataSource: ComponentDataSource!
    private let identifier = "ID"

}

extension ComponentCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseComponentCell

        if let component = componentDataSource.component(at: indexPath) {
            cell.configure(with: component)
        }

        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return componentDataSource.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return componentDataSource.numberOfItems(in: section)
    }
}

