//
//  Container.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// A container can hold an array of components.
/// Allows for components to be grouped in separate sections
///
 struct Container: BaseComponent {
    let components: [BaseComponent]
    let layout: ContainerLayout

    init(components: [BaseComponent], layout: ContainerLayout) {
        self.components = components
        self.layout = layout
    }
}
