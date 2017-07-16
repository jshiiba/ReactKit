//
//  Container.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

 struct Container: BaseComponent {
    let components: [BaseComponent?]
    let layout: LayoutContainerProps

    init(components: [BaseComponent?], layout: LayoutContainerProps) {
        self.components = components
        self.layout = layout
    }
}
