//
//  SingleViewComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a component that reduces down to a single UIView
///
protocol ComponentReducing: Component {
    func reduce() -> UIView?
}
