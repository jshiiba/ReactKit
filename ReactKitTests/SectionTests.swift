//
//  SectionTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class MockSectionProps: PropType {
    var layout: ComponentLayout? = ComponentLayout(dimension: .ratio(ratio: 1.0))
}

class SectionTests: XCTestCase {
    let parentFrame = CGRect(x: 0, y: 0, width: 100, height: 500)
    let mockLayout = RenderedLayout(frame: .zero)
    var props: MockSectionProps!
    var section: Section!

    override func setUp() {
        super.setUp()
        props = MockSectionProps()
        section = Section(index: 0, props: props)
        section.layout = RenderedLayout(frame: parentFrame)
        addChildren()
    }

    fileprivate func addChildren() {
        section.addChild(.row(Row(view: UIView(), props: nil, indexPath: IndexPath(row: 0, section: 0), layout: RenderedLayout(frame: parentFrame))))
        section.addChild(.row(Row(view: nil, props: nil, indexPath: IndexPath(row: 1, section: 0))))
        section.addChild(.section(index: 1))
    }

    func testThatRowsFiltersOutChildSections() {
        XCTAssertEqual(section.rows.count, 2)
    }

    func testRowIndexPaths() {
        let indexPaths = section.rowIndexPaths()
        XCTAssertEqual(indexPaths.count, 2)
        XCTAssertEqual(indexPaths[0], IndexPath(row: 0, section: 0))
        XCTAssertEqual(indexPaths[1], IndexPath(row: 1, section: 0))
    }

    func testViewForRowAtIndexPath() {
        XCTAssertNotNil(section.view(fromRowAt: 0))
    }

    func testNilViewForRowAtIndexPath() {
        XCTAssertNil(section.view(fromRowAt: 1))
    }

    func testThatAddingChildIncreasesRowCount() {
        XCTAssertEqual(section.rowCount, 2)
        section.addChild(.row(Row(view: nil, props: nil, indexPath: IndexPath(row: 2, section: 0))))
        XCTAssertEqual(section.rowCount, 3)
    }

    func testThatAddingChildSectionDoesNotIncreaseRowCount() {
        XCTAssertEqual(section.rowCount, 2)
        section.addChild(.section(index: 2))
        XCTAssertEqual(section.rowCount, 2)
    }

    func testLayoutAttributesForRowsInRect() {
        let attributes = section.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: 200, height: 500))
        XCTAssertEqual(attributes?.count, 1)
        XCTAssertEqual(attributes?[0].frame, parentFrame)
    }

    func testLayoutAttributesReturnsNilForNonIntersectingRect() {
        let attributes = section.layoutAttributesForElements(in: CGRect(x: 0, y: 600, width: 200, height: 500))
        XCTAssertNil(attributes)
    }
}
