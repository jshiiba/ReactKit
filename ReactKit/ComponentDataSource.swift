//
//  ComponentDataSource.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentDataSource {

    var components: [Component] = []

    var numberOfSections: Int {
        return 1
    }

    func numberOfItems(in section: Int) -> Int {
        return 1
    }

    func component(at indexPath: IndexPath) -> UIView? {
        let component = components[indexPath.row]
        return component.render()
    }
}
