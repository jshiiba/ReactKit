//
//  ComponentFlowLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentFlowLayout: UICollectionViewLayout {

    var sections: [SectionComponent] = []

    override var collectionViewContentSize: CGSize {
        if sections.isEmpty {
            return .zero
        } else {
            return sections[0].layout.frame.size
        }
    }

    override func prepare() {
        super.prepare()

        //opportunity to prepare and perform any calculations required to determine the collection view
        // size and the positions of the items
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes: [UICollectionViewLayoutAttributes] = []
        sections.forEach { section in
            guard let sectionAttributes = section.layoutAttributesForElements(in: rect) else {
                return
            }
            attributes.append(contentsOf: sectionAttributes)
        }

        return attributes
    }
}
