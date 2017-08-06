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
        return sections.first?.layout?.frame.size ?? .zero
    }

    /// called for every section + row
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }

    /// called for current rect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        _ = super.layoutAttributesForElements(in: rect)

        var attributes: [UICollectionViewLayoutAttributes] = []

        sections.forEach { section in
            guard let sectionAttributes = section.layoutAttributesForElements(in: rect) else {
                return
            }
            attributes.append(contentsOf: sectionAttributes)
        }

        return attributes
    }

    static func calculateLayout(for sections: inout [Section], at index: Int, in frame: CGRect) {
        guard index >= 0, index < sections.count else {
            return
        }

        let section = sections[index]
        section.layout = ComponentLayout(frame: frame)

        for (index, child) in section.children.enumerated() {
            if let row = child as? Row {
                let childWidth = child.props?.layout?.dimension.width(in: frame.width) ?? 0
                let childHeight = child.props?.layout?.height ?? 0
                let childFrame = section.layout?.flow.calculateNextFrame(forWidth: childWidth, height: childHeight) ?? frame
                let updatedRow = Row(row: row, layout: ComponentLayout(frame: childFrame))

                section.children.insert(updatedRow, at: index)
            } else if let childSection = child as? Section {
                let childWidth = child.props?.layout?.dimension.width(in: frame.width) ?? 0

                // origin is set from previous section
                let estimatedFrame = section.layout?.flow.calculateNextFrame(forWidth: childWidth, height: 0) ?? frame

                // recurse in order to get height of children
                calculateLayout(for: &sections, at: childSection.index, in: estimatedFrame)

                // height of children has been calculated
                let childHeight = childSection.layout?.frame.height ?? 0

                // new frame has Y based on parent's flow layout
                // update Y of flow layout?
                section.layout?.flow.previousFrame?.size = CGSize(width: childWidth, height: childHeight)

                childSection.layout?.updateHeight(childHeight)
            }
        }

        // sets frame height as the Max Y of flow layout
        section.updateHeight()
    }
}
