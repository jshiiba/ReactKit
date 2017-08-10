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
    /// index of section in IndexPath
    let index: Int

    /// properties of the Container Component
    let props: PropType?

    /// calculated layout determined from props
    var layout: RenderedLayout?

    /// child sections or rows
    var children: [SectionChild] = []

    /// current row count from children
    var rowCount: Int = 0

    /// Filters out references to Sections
    var rows: [Row] {
        return children.flatMap { child in
            if case let .row(row) = child {
                return row
            } else {
                return nil
            }
        }
    }

    init(index: Int, props: PropType? = nil) {
        self.index = index
        self.props = props
    }

    func rowIndexPaths() -> [IndexPath] {
        return rows.map { $0.indexPath }
    }

    func view(fromRowAt index: Int) -> UIView? {
        return rows[index].view
    }

    func addChild(_ child: SectionChild) {
        children.append(child)
        if case .row(_) = child {
            rowCount = rowCount + 1
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

        // TODO: cache attributes
        for row in rows {
            if let rowFrame = row.layout?.frame {
                let newAttribute = UICollectionViewLayoutAttributes(forCellWith: row.indexPath)
                newAttribute.frame = rowFrame
                attributes.append(newAttribute)
            }
        }

        return attributes
    }
}
