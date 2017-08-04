//
//  CompositeComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/3/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

/// Represents a combination of Components
protocol CompositeComponent: Component {
    func render() -> Component?
}
