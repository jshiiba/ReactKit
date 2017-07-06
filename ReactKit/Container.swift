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

    init(components: [Component]) {
        self.components = components
    }

    func render(props: PropType) -> UIView {

        let view = UIView()
        var currentY: CGFloat = 0

        components.forEach { component in
            let subView = component.render(props: NilProps())
            subView.frame = CGRect(x: 0, y: currentY, width: subView.frame.width, height: subView.frame.height)
            view.addSubview(subView)
            currentY = currentY + subView.frame.height
        }

        return view
    }
}
