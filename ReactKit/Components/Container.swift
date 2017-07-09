//
//  Container.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/6/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class Container: Component {

    var components: [Component]

    var childrenCount: Int {
        return components.count
    }

    init(components: [Component]) {
        self.components = components
    }

    /**
     TODO: layout calculations for subviews
     */
    func render(props: PropType) -> [Renderable] {
        let view = UIView()
        var currentY: CGFloat = 0

//        components.forEach { component in
//            guard let subView = component.render(props: props) as? UIView else {
//                return
//            }
//            subView.frame = CGRect(x: 0, y: currentY, width: subView.frame.width, height: subView.frame.height)
//            view.addSubview(subView)
//            currentY = currentY + subView.frame.height
//        }
        view.sizeToFit()

        return [view]
    }
}

extension Container: Renderable {}
