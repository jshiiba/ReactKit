//
//  Renderer.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import Foundation
import UIKit

protocol Renderable {
    func render(component: Component) -> UIView
}

class Renderer: Renderable {

    /**
     Root of the virtual tree
     */
    //    var root: Node?

    func render(component: Component) -> UIView {

        let view = UIView()

        return view
    }
}
