//
//  Container.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

 class Container: BaseComponent {
    let items: [BaseComponent?]

    init(items: [BaseComponent?]) {
        self.items = items
    }

    static func render(items: [BaseComponent?]) -> [BaseComponent] {

        // Maybe dont flatmap?
        let result = items.flatMap { $0 }
        return result
    }
}
