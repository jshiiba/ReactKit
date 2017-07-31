//
//  UIButton+React.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/25919472/adding-a-closure-as-target-to-a-uibutton
class ClosureSleeve {
    let control: UIControl // TODO: make generic if possible
    let closure: (UIControl)->()

    init(_ control: UIControl, _ closure: @escaping (UIControl)->()) {
        self.control = control
        self.closure = closure
    }

    @objc func invoke () {
        closure(control)
    }
}

extension UIControl {
    func add(for controlEvents: UIControlEvents, _ closure: @escaping (UIControl)->()) {
        let sleeve = ClosureSleeve(self, closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
