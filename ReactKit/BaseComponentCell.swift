//
//  BaseComponentCell.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class BaseComponentCell: UICollectionViewCell {

    var previousView: UIView?

    func configure(with view: UIView) {
        if let previousView = previousView {
            previousView.removeFromSuperview()
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)

        let top = view.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let right = view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        let bottom = view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let left = view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)

        previousView = view

        self.contentView.addConstraints([top, right, bottom, left])
        self.contentView.setNeedsUpdateConstraints()
    }
}
