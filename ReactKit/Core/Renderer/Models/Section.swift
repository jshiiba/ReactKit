//
//  Section.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/15/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

///
/// Allows sections to hold an array of children containing either
/// rows or sections. When a section is the child, only store a reference to its index.
///
enum SectionChild {
    case section(index: Int) // hold reference index to child section
    case row(Row) // hold row model
}

///
/// Represents a Section in an IndexPath containing a row of Components
///
class Section {

    let index: Int
    let props: PropType?

    var children: [SectionChild] = []
    var rowCount: Int = 0

    var layout: ComponentLayout?

    init(index: Int, props: PropType? = nil) {
        self.index = index
        self.props = props
    }

    var rows: [Row] {
        return children.flatMap { child in
            switch child {
            case .row(let row): return row
            default: return nil
            }
        }
    }

    func rowIndexPaths() -> [IndexPath] {
        return rows.map { $0.indexPath }
    }

    func view(at index: Int) -> UIView? {
        return rows[index].view
    }

    func addChild(_ child: SectionChild) {
        children.append(child)
        switch child {
        case .row(_):
            rowCount = rowCount + 1
        default: break
        }
    }

    func updateHeight() {
        if let height = layout?.flow.totalHeight {
            layout?.updateHeight(height)
        }
    }

    func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let frame = layout?.frame, rect.intersects(frame) else {
            return nil
        }

        var attributes: [UICollectionViewLayoutAttributes] = []

        for child in children {
            switch child {
            case .row(let row):
                let newAttribute = UICollectionViewLayoutAttributes(forCellWith: row.indexPath)
                newAttribute.frame = row.layout?.frame ?? .zero
                attributes.append(newAttribute)
            default: break
            }
        }

        return attributes
    }
}

struct ComponentLayout {
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
