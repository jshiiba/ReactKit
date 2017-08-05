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
    var layout: LayoutType { get }
}

///
/// Represents a Section in an IndexPath containing a row of Components
///
class Section: ComponentRepresentable {
    typealias LayoutType = SectionLayout

    let index: Int
    
    var rows: [Row] = []
    var children: [Section] = []

    var layout: LayoutType

    var isLeaf: Bool {
        return children.isEmpty
    }

    init(index: Int, layout: SectionLayout) {
        self.index = index
        self.layout = layout
    }

    func calculateHeight() {
        layout.updateHeight(totalHeight())
    }

    func totalHeight() -> CGFloat {
        return layout.flow.totalHeight + children.reduce(0) { (height, child) in
            return layout.flow.maxYFor(child.layout.frame, currentMaxY: height)
        }
    }

    func layout() {

    }

    func layoutRows() {

    }

    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard rect.intersects(layout.frame) else {
            return nil
        }

        var attributes: [UICollectionViewLayoutAttributes] = []

        for row in rows {
            let newAttribute = UICollectionViewLayoutAttributes(forCellWith: row.indexPath)
            newAttribute.frame = row.layout.frame
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
