//
//  SectionTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class SectionTests: XCTestCase {
    let parentFrame = CGRect(x: 0, y: 0, width: 100, height: 500)
    let mockLayout = ComponentLayout(frame: .zero)

    /*
    func testThatSectionIsLeafWhenNoChildren() {
        let section = Section(index: 0, layout: mockLayout)
        XCTAssertTrue(section.isLeaf)
    }

    func testThatSectionIsNotLeafWhenChildren() {
        let section = Section(index: 0, layout: mockLayout)
        section.children = [Section(index: 1, layout: mockLayout)]

        XCTAssertFalse(section.isLeaf)
    }

    func testThatSectionCalculatesHeightOfChildSectionsInline() {
        let children = [
            Section(index: 1, layout: SectionLayout(frame: CGRect(x: 0, y: 0, width: 50, height: 100))),
            Section(index: 2, layout: SectionLayout(frame: CGRect(x: 50, y: 0, width: 50, height: 100)))
        ]

        let section = Section(index: 0, layout: SectionLayout(frame: parentFrame))
        section.children = children

        XCTAssertEqual(section.totalHeight(), 100)
    }

    func testThatSectionCalculatesHeightOfChildSectionsStacked() {
        let children = [
            Section(index: 1, layout: SectionLayout(frame: CGRect(x: 0, y: 0, width: 100, height: 100))),
            Section(index: 2, layout: SectionLayout(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ]

        let section = Section(index: 0, layout: SectionLayout(frame: parentFrame))
        section.children = children

        XCTAssertEqual(section.totalHeight(), 200)
    }

    func testThatSectionCalculatesHeightOfChildSectionsUnevenStack() {
        let children = [
            Section(index: 1, layout: SectionLayout(frame: CGRect(x: 0, y: 0, width: 100, height: 100))),
            Section(index: 2, layout: SectionLayout(frame: CGRect(x: 0, y: 100, width: 50, height: 25))),
            Section(index: 3, layout: SectionLayout(frame: CGRect(x: 50, y: 100, width: 50, height: 100))),
        ]

        let section = Section(index: 0, layout: SectionLayout(frame: parentFrame))
        section.children = children

        XCTAssertEqual(section.totalHeight(), 200)
    }

    func testThatSectionUpdatesLayoutHeight() {
        let children = [
            Section(index: 1, layout: SectionLayout(frame: CGRect(x: 0, y: 0, width: 50, height: 100))),
            Section(index: 2, layout: SectionLayout(frame: CGRect(x: 50, y: 0, width: 50, height: 100)))
        ]

        let section = Section(index: 0, layout: SectionLayout(frame: parentFrame))
        section.children = children

        section.calculateHeight()
        XCTAssertEqual(section.layout.frame.height, 100)
    }
     */
}
