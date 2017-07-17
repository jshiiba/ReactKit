//
//  SectionComponent.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Represents a Section in an IndexPath containing a row of Components
///
class SectionComponent {
    let index: Int
    var rows: [RowComponent]
    let layout: ContainerLayout

    fileprivate var cachedAttributes: [UICollectionViewLayoutAttributes]?

    init(index: Int, rows: [RowComponent], layout: ContainerLayout) {
        self.index = index
        self.rows = rows
        self.layout = layout
    }

    func row(at indexPath: IndexPath) -> RowComponent {
        return self.rows[indexPath.row]
    }

    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard rect.intersects(layout.frame) else {
            return nil
        }

        if let cachedAttributes = cachedAttributes {
            return cachedAttributes
        }

        var attributes: [UICollectionViewLayoutAttributes] = []

        let rowLayouts: [ComponentLayout] = rows.flatMap { $0.layout }
        let indexPaths: [IndexPath] = rows.flatMap { IndexPath(row: $0.index, section: $0.section) }
        let layoutAttributes = FlexLayout.attributes(forComponentProps: rowLayouts, in: layout)

        for (layoutAttribute, indexPath) in zip(layoutAttributes, indexPaths) {
            let newAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            newAttribute.frame = layoutAttribute.frame
            attributes.append(newAttribute)
        }

        cachedAttributes = attributes

        return attributes
    }
}
