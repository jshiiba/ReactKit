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

//        container = Container(components: [
//            MyComponent(props: MyComponentProps(backgroundColor: .green, title: "Hello")),
//            MyComponent(props: MyComponentProps(backgroundColor: .blue, title: "World")),
//            MyComponent(props: MyComponentProps(backgroundColor: .green, title: "Hello")),
//            MyComponent(props: MyComponentProps(backgroundColor: .blue, title: "World")),
//            GenericComponent<UIButton> { [weak self] (button) in
//                button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//                button.backgroundColor = .red
//                button.setTitle("Press me", for: .normal)
//                button.add(for: .touchUpInside) {
//                    self?.dispatch()
//                }
//            }
//        ])
