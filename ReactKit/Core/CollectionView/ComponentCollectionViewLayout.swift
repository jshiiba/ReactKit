//
//  ComponentCollectionViewLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Custom UICollectionViewLayout
///
final class ComponentCollectionViewLayout: UICollectionViewLayout {

    var sections: [Section] = []

    /// First Section will contain the height of its sub sections
    override var collectionViewContentSize: CGSize {
        return sections.first?.layout.frame.size ?? .zero
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
