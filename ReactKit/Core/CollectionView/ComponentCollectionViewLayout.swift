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
        let width = sections.first?.layout?.frame.width ?? 0
        let height = sections.first?.layout?.flow.totalHeight ?? 0
        return CGSize(width: width, height: height)
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

    ///
    ///
    ///
    func calculateLayout(for sections: inout [Section], in frame: CGRect) {
        calculateLayout(for: &sections, at: 0, in: frame)
        self.sections = sections
    }

    fileprivate func calculateLayout(for sections: inout [Section], at index: Int, in frame: CGRect) {
        guard index >= 0, index < sections.count else {
            return
        }

        let section = sections[index]
        section.layout = ComponentLayout(frame: frame)

        for (index, child) in section.children.enumerated() {
            switch child {
            case .row(let row):
                let childWidth = row.props?.layout?.dimension.width(in: frame.width) ?? 0
                let childHeight = row.props?.layout?.height ?? 0
                let childFrame = section.layout?.flow.calculateNextFrame(forWidth: childWidth, height: childHeight) ?? frame
                let updatedRow = Row(row: row, layout: ComponentLayout(frame: childFrame))

                section.children.remove(at: index)
                section.children.insert(.row(row: updatedRow), at: index)
            case .section(let index):
                let childSection = sections[index]
                let childSectionWidth = childSection.props?.layout?.dimension.width(in: frame.width) ?? 0
                let estimatedChildFrame = section.layout?.flow.calculateNextFrame(forWidth: childSectionWidth, height: 0) ?? frame

                calculateLayout(for: &sections, at: childSection.index, in: estimatedChildFrame)

                let childHeight = childSection.layout?.frame.height ?? 0

                section.layout?.flow.updatePreviousSize(CGSize(width: childSectionWidth, height: childHeight))
                childSection.layout?.updateHeight(childHeight)
            }
        }

        section.updateHeight()
    }
}
