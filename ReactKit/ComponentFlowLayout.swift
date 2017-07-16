//
//  ComponentFlowLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        self.itemSize = CGSize(width: 300, height: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
