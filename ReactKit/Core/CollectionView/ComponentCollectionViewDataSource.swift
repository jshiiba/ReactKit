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

    fileprivate let rendererDataSource: ComponentRendererDataSource

    var collectionViewLayout: ComponentCollectionViewLayout {
        return rendererDataSource.componentLayout
    }

    var componentCollectionView: UICollectionView! {
        didSet {
            configure(componentCollectionView)
        }
    }

    init(rendererDataSource: ComponentRendererDataSource) {
        self.rendererDataSource = rendererDataSource
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
        let updatedIndexPaths = rendererDataSource.render(component, in: componentCollectionView.frame,
                                                          translation: Translator.translate,
                                                          reconciliation: Reconciler.reconcile)

        componentCollectionView.reloadItems(at: updatedIndexPaths)
    }
}
// MARK: - UICollectionViewDataSource

extension ComponentCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)

        if let componentCell = cell as? ComponentDisplayable {
            configureDisplayable(componentCell, at: indexPath)
        }

        return cell
    }

    internal func configureDisplayable(_ displayable: ComponentDisplayable, at indexPath: IndexPath) {
        displayable.removeView()

        if let component = rendererDataSource.component(at: indexPath) {
            displayable.configure(with: component)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rendererDataSource.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rendererDataSource.numberOfItems(in: section)
    }
}
