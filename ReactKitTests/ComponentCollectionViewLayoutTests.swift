//
//  ComponentCollectionViewLayoutTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class ComponentCollectionViewLayoutTests: XCTestCase {
    var layout: ComponentCollectionViewLayout!
    override func setUp() {
        super.setUp()
        layout = ComponentCollectionViewLayout()
    }

    func testThatRootSectionLayoutIsCalculated() {
        let expectedFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
        let section = Section(index: 0)
        section.children = [
            .row(Row(view: nil, props: MockLabelProps.fill, indexPath: IndexPath()))
        ]

        var sections = [section]

        layout.calculateLayout(for: &sections, in: CGRect(x: 0, y: 0, width: 200, height: 400))

        XCTAssertEqual(sections[0].layout?.frame, expectedFrame)
    }
}
