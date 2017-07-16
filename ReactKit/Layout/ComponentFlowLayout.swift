//
//  ComponentFlowLayout.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/8/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ComponentFlowLayout: UICollectionViewFlowLayout {

    var sections: [SectionComponent] = []

    override func prepare() {
        super.prepare()
        //opportunity to prepare and perform any calculations required to determine the collection view
        // size and the positions of the items
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let indexPaths = indexPathsOfItems(in: rect)
        return attributesForItems(at: indexPaths)
    }

    func indexPathsOfItems(in rect: CGRect) -> [IndexPath] {
        // TODO: calculate index of items in rect
        return sections.reduce([]) { (result, section) in
            return result + section.rows
        }.map { IndexPath(row: $0.row, section: $0.section) }
    }

    func attributesForItems(at indexPaths: [IndexPath]) -> [UICollectionViewLayoutAttributes]? {
        let props: [LayoutComponentProps] = indexPaths.flatMap { (indexPath) in
            let row = sections[indexPath.section].row(at: indexPath)
            return row.layout
        }

        let layoutAttributes = FlexLayout.attributes(forComponentProps: props, in: sections[1].layout)

        let attributes = indexPaths.map { UICollectionViewLayoutAttributes(forCellWith: $0) }

        for (index, attributes) in attributes.enumerated() {
            attributes.frame = layoutAttributes[index].frame
        }

        return attributes
    }

}
