//
//  ComponentContaining.swift
//  ReactKit
//
//  Created by Justin Shiiba on 8/3/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation

protocol ComponentContaining: Component {
    var components: [Component] { get }
    var props: PropType { get }
}
