//
//  Section.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

protocol ComponentRepresentableLayout {
    var frame: CGRect { get }
}

protocol ComponentRepresentable {
    associatedtype LayoutType: ComponentRepresentableLayout
    var layout: LayoutType? { get }
}

///
/// Represents a Section in an IndexPath containing a row of Components
///
class Section: ComponentRepresentable {
    typealias LayoutType = SectionLayout

    let index: Int
    let props: PropType
    
    var rows: [Row] = []
    var children: [Section] = []

    var layout: LayoutType?

    var isLeaf: Bool {
        return children.isEmpty
    }

    init(index: Int, props: PropType) {
        self.index = index
        self.props = props
    }

    func calculateHeight() {
        layout?.updateHeight(totalHeight())
    }

    func totalHeight() -> CGFloat {
        guard let layout = layout else {
            return 0
        }

        return layout.flow.totalHeight + children.reduce(0) { (height, child) in
            return layout.flow.maxYFor(child.layout!.frame, currentMaxY: height)
        }
    }

    func invalidateLayout(for newFrame: CGRect) {
        if isLeaf {
            layout = SectionLayout(frame: newFrame)
            rows = recalculateLayout(of: rows, layout!.flow.calculateNextFrame)
        }
    }

    func recalculateLayout(of rows: [Row], _ calculateNextFrame: (CGFloat, CGFloat) -> (CGRect)) -> [Row] {
        return rows.map { row in
            let rowWidth = row.layout?.frame.width ?? 0
            let rowHeight = row.layout?.frame.height ?? 0
            let rowFrame = calculateNextFrame(rowWidth, rowHeight)
            return Row(row: row, layout: RowLayout(frame: rowFrame))
        }
    }

    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let frame = layout?.frame, rect.intersects(frame) else {
            return nil
        }

        var attributes: [UICollectionViewLayoutAttributes] = []

        for row in rows {
            let newAttribute = UICollectionViewLayoutAttributes(forCellWith: row.indexPath)
            newAttribute.frame = row.layout?.frame ?? .zero
            attributes.append(newAttribute)
        }

        return attributes
    }
}

struct SectionLayout: ComponentRepresentableLayout {
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
