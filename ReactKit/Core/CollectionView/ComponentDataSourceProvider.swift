//
//  ComponentRendererProvider.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

protocol ComponentCollectionViewDataSourceProvider: class {
    func provide() -> ComponentCollectionViewDataSource
}

///
/// Resolves dependencies for Renderer and Provides a ComponentCollectionViewDataSource
///
final class ComponentDataSourceProvider: ComponentCollectionViewDataSourceProvider {
    func provide() -> ComponentCollectionViewDataSource {
        let renderer = Renderer(cacher: Cacher(), layout: ComponentCollectionViewLayout())
        return ComponentViewControllerDataSource(rendererDataSource: renderer)
    }
}
