//
//  ComponentRendererProvider.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

///
/// Resolves dependencies for Renderer and Provides a ComponentRendererDataSource
///
final class ComponentRendererProvider {
    static func provide() -> ComponentRendererDataSource {
        return Renderer(cacher: Cacher(), layout: ComponentCollectionViewLayout())
    }
}
