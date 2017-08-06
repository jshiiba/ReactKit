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
    var layout: ComponentLayout? { get }
    var props: PropType? { get }
}

///
/// Represents a Section in an IndexPath containing a row of Components
///
class Section: ComponentRepresentable {

    let index: Int
    let props: PropType?

    var children: [ComponentRepresentable] = []
    var rowCount: Int = 0

    // FIXME
    var rows: [Row] {
        return children.flatMap { $0 as? Row }
    }

    var layout: ComponentLayout?

    init(index: Int, props: PropType? = nil) {
        self.index = index
        self.props = props
    }

    func add(_ child: ComponentRepresentable) {
        if child is Row {
            rowCount = rowCount + 1
        }
        children.append(child)
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
            if let row = child as? Row {
                let newAttribute = UICollectionViewLayoutAttributes(forCellWith: row.indexPath)
                newAttribute.frame = row.layout?.frame ?? .zero
                attributes.append(newAttribute)
            } else {
                print("I'm a section")
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
