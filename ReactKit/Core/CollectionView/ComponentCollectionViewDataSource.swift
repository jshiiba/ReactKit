//
//  ComponentCollectionViewDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

private let identifier = "Identifier"

///
/// Main DataSource for a ComponentViewController that uses a Renderer
///
final class ComponentCollectionViewDataSource: NSObject {

    fileprivate let renderer: Renderer = Renderer()

    var collectionViewLayout: ComponentCollectionViewLayout {
        return renderer.layout
    }

    var componentCollectionView: UICollectionView! {
        didSet {
            configure(componentCollectionView)
        }
    }

    /// Configures the collectionview with properties needed for rendering
    /// - parameters:
    ///     - collectionView
    private func configure(_ collectionView: UICollectionView) {
        collectionView.register(BaseComponentCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
    }

    /// Updates collectionview with new components and props, reloads updated cells
    /// - parameters:
    ///     - component: component to update
    func setComponent(_ component: Component) {
        let updatedIndexPaths = renderer.render(component, in: componentCollectionView.frame)
        componentCollectionView.reloadItems(at: updatedIndexPaths)
    }
}

// MARK: - UICollectionViewDataSource

extension ComponentCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! BaseComponentCell

        cell.removeView()

        if let component = renderer.component(at: indexPath) {
            cell.configure(with: component)
        }

        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return renderer.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return renderer.numberOfItems(in: section)
    }
}
