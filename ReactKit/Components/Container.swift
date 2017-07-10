//
//  Container.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

 class Container: Renderable {
    let items: [Renderable?]

    init(items: [Renderable?]) {
        self.items = items
    }

    static func render(items: [RenderItems?]) -> [Renderable] {

        // Maybe dont flatmap?
        let result = items.flatMap { $0 }
        return result
    }
}
