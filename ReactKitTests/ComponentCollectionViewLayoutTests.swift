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

    func testThatRootSectionLayoutIsCalculated() {
        let expectedFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
        let section = Section(index: 0)
        section.children = [
            Row(view: nil, props: MockLabelProps.fill, indexPath: IndexPath())
        ]

        var sections = [section]

        ComponentCollectionViewLayout.calculateLayout(for: &sections, at: 0, in: CGRect(x: 0, y: 0, width: 200, height: 400))

        XCTAssertEqual(sections[0].layout?.frame, expectedFrame)
    }

    func testThatSectionInSectionIsCalculated() {
        let expectedFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
        let section = Section(index: 0)
        section.children = [
            Row(view: nil, props: MockLabelProps.fill, indexPath: IndexPath())
        ]

        var sections = [

        ]

        ComponentCollectionViewLayout.calculateLayout(for: &sections, at: 0, in: CGRect(x: 0, y: 0, width: 200, height: 400))

        XCTAssertEqual(sections[0].layout?.frame, expectedFrame)
    }
}
