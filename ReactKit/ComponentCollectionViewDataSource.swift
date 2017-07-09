//
//  ComponentCollectionViewDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

private let identifier = "Identifier"

class ComponentCollectionViewDataSource: NSObject {
    let componentDataSource: ComponentDataSource
    let renderer: ComponentRender

    var componentCollectionView: UICollectionView! {
        didSet {
            configure(componentCollectionView)
        }
    }

    init(renderer: ComponentRender) {
        self.renderer = renderer
        self.componentDataSource = renderer.componentDataSource
    }

    private func configure(_ collectionView: UICollectionView) {
        collectionView.register(BaseComponentCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white

        let componentLayout = ComponentFlowLayout()
        collectionView.collectionViewLayout = componentLayout
    }

    /// Updates collectionview with new components and props, reloads updated cells
    /// - parameters:
    ///     - components: components to update
    ///     - props: new properties
    func setComponents(_ components: [Component], with props: PropType) {
        componentDataSource.update(props)

        let indexPathsToReload = renderer.render(components, with: props)
        componentCollectionView.reloadItems(at: indexPathsToReload)
    }
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
