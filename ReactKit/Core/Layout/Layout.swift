//
//  Layout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

struct Layout {
    let dimension: ComponentDimension
    let height: CGFloat

    init(dimension: ComponentDimension, height: CGFloat = 0) {
        self.dimension = dimension
        self.height = height
    }
}
