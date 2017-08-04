//
//  Section.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a Section in an IndexPath containing a row of Components
///
class Section {
    let index: Int
    var rows: [Row]
    var layout: SectionLayout

    // could store child section indexes

    fileprivate var cachedAttributes: [UICollectionViewLayoutAttributes]?

    init(index: Int, rows: [Row], layout: SectionLayout) {
        self.index = index
        self.rows = rows
        self.layout = layout
    }

    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard rect.intersects(layout.frame) else {
            return nil
        }

        if let cachedAttributes = cachedAttributes {
            return cachedAttributes
        }

        var attributes: [UICollectionViewLayoutAttributes] = []

        for row in rows {
            let newAttribute = UICollectionViewLayoutAttributes(forCellWith: row.indexPath)
            newAttribute.frame = row.layout.frame
            attributes.append(newAttribute)
        }

        if !attributes.isEmpty {
            cachedAttributes = attributes
        }

        return attributes
    }
}

struct SectionLayout {
    var frame: CGRect
    let flow: ComponentFlowLayout

    init(frame: CGRect) {
        self.frame = frame
        self.flow = ComponentFlowLayout(parentFrame: self.frame)
    }

    mutating func updateHeight(_ height: CGFloat) {
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: height)
    }
}
