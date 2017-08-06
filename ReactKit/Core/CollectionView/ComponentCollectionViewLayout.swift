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

    private(set) var sections: [Section] = []

    /// First Section will contain the height of its sub sections
    /// TODO: Fix height
    override var collectionViewContentSize: CGSize {
        let width = sections.first?.layout?.frame.width ?? 0
        let height = sections.first?.layout?.flow.totalHeight ?? 0
        return CGSize(width: width, height: height)
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

    // MARK: - Layout Calculations

    /// Calculates the layout for each Section
    /// - parameters:
    ///     - sections: inout reference to the array of sections
    ///     - frame: the frame of reference to layout the sections
    func calculateLayout(for sections: inout [Section], in frame: CGRect) {
        calculateLayout(for: &sections, at: 0, in: frame)
        self.sections = sections
    }

    /// Recursive algorithm to calculate the layout for each section and row
    /// Similar to a Post-order Depth first search. Must calculate the heights of all children
    /// before finishing the calculation of the current sections height and origin
    /// - parameters:
    ///     - sections: the section array
    ///     - index: indicates the current section to access within the sections array
    ///     - frame: the current frame to layout the section or view
    fileprivate func calculateLayout(for sections: inout [Section], at index: Int, in frame: CGRect) {
        guard index >= 0, index < sections.count else {
            return
        }

        let section = sections[index]
        section.layout = RenderedLayout(frame: frame)

        for (index, child) in section.children.enumerated() {
            switch child {
            case .row(let row):
                let childWidth = row.props?.layout?.dimension.width(in: frame.width) ?? 0
                let childHeight = row.props?.layout?.height ?? 0
                let childFrame = section.layout?.flow.calculateNextFrame(forWidth: childWidth, height: childHeight) ?? frame
                let updatedRow = Row(row: row, layout: RenderedLayout(frame: childFrame))

                section.children.remove(at: index)
                section.children.insert(.row(updatedRow), at: index)
            case .section(let index):
                let childSection = sections[index]
                let childSectionWidth = childSection.props?.layout?.dimension.width(in: frame.width) ?? 0
                let estimatedChildFrame = section.layout?.flow.calculateNextFrame(forWidth: childSectionWidth, height: 0) ?? .zero

                calculateLayout(for: &sections, at: childSection.index, in: estimatedChildFrame)

                let childHeight = childSection.layout?.frame.height ?? 0

                section.layout?.flow.updatePreviousSize(CGSize(width: childSectionWidth, height: childHeight))
            }
        }

        section.updateHeight()
    }
}
