//
//  TranslatorTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import XCTest
@testable import ReactKit

class TranslatorTests: XCTestCase {

    let parentFrame = CGRect(x: 0, y: 0, width: 300, height: 500)
    var translator: Translator!
    
    override func setUp() {
        super.setUp()
        translator = Translator()
    }

    // MARK: - Translate Container with only Components

    func testWhenRootComponentIsAnEmptyContainer() {
        let container = Container(components: [], layout: MockComponents.containerLayoutFill)
        let result = translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 0))
        XCTAssertEqual(result[0].rows.count, 0)
    }

    func testWhenContainerHasLabelComponent() {
        let container = MockComponents.containerWithLabel(with: .fill, labelHeight: 100)
        let result = translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].rows.count, 1)
        XCTAssertEqual(result[0].rows[0].index, 0)
        XCTAssertEqual(result[0].rows[0].section, 0)
    }

    func testWhenContainerHasTwoLabelComponentsWithSameLayouts() {
        let container = MockComponents.containerWithSameTwoLabels(with: .ratio(ratio: 0.5), labelHeight: 100)
        let result = translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].rows.count, 2)

        XCTAssertEqual(result[0].rows[0].index, 0)
        XCTAssertEqual(result[0].rows[0].section, 0)
        XCTAssertEqual(result[0].rows[0].layout.dimension, ComponentDimension.ratio(ratio: 0.5))
        XCTAssertEqual(result[0].rows[0].layout.height, 100)

        XCTAssertEqual(result[0].rows[1].index, 1)
        XCTAssertEqual(result[0].rows[1].section, 0)
        XCTAssertEqual(result[0].rows[1].layout.dimension, ComponentDimension.ratio(ratio: 0.5))
        XCTAssertEqual(result[0].rows[1].layout.height, 100)

        XCTAssertEqual(result[0].layout.frame.height, 100)
    }

    func testWhenContainerHasMultipleLabels() {
        let container = MockComponents.containerWithMultipleLabels()
        let result = translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].rows.count, 4)

        XCTAssertEqual(result[0].rows[0].index, 0)
        XCTAssertEqual(result[0].rows[0].section, 0)
        XCTAssertEqual(result[0].rows[0].layout.dimension, ComponentDimension.ratio(ratio: 0.75))
        XCTAssertEqual(result[0].rows[0].layout.height, 100)

        XCTAssertEqual(result[0].rows[1].index, 1)
        XCTAssertEqual(result[0].rows[1].section, 0)
        XCTAssertEqual(result[0].rows[1].layout.dimension, ComponentDimension.ratio(ratio: 0.5))
        XCTAssertEqual(result[0].rows[1].layout.height, 200)

        XCTAssertEqual(result[0].rows[2].index, 2)
        XCTAssertEqual(result[0].rows[2].section, 0)
        XCTAssertEqual(result[0].rows[2].layout.dimension, ComponentDimension.ratio(ratio: 0.25))
        XCTAssertEqual(result[0].rows[2].layout.height, 25)

        XCTAssertEqual(result[0].rows[3].index, 3)
        XCTAssertEqual(result[0].rows[3].section, 0)
        XCTAssertEqual(result[0].rows[3].layout.dimension, ComponentDimension.ratio(ratio: 1.0))
        XCTAssertEqual(result[0].rows[3].layout.height, 100)

        XCTAssertEqual(result[0].layout.frame.height, 400)
    }

    // MARK: - Translate Container with Containers

    func testThatContainersWithChildContainersHaveIndex() {
        let container = MockComponents.containerWithContainers()
        let result = translator.translateSections(from: container, in: CGRect(origin: .zero, size: CGSize(width: 300, height: 0)), at: 0)

        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[1].index, 1)
        XCTAssertEqual(result[2].index, 2)
    }

    func testThatContainersCanLayoutChildContainers() {
        let container = MockComponents.containerWithContainers()
        let result = translator.translateSections(from: container, in: CGRect(origin: .zero, size: CGSize(width: 300, height: 0)), at: 0)

        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(result[1].layout.frame, CGRect(x: 0, y: 0, width: 150, height: 100))
        XCTAssertEqual(result[2].layout.frame, CGRect(x: 150, y: 0, width: 150, height: 100))
    }

    /* TODO: Fix
    func testMultilevelContainers() {
        let container = MockComponents.multiLevelContainers()
        let result = translator.translateSections(from: container, in: CGRect(origin: .zero, size: CGSize(width: 300, height: 0)), at: 0)

        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(result[1].layout.frame, CGRect(x: 0, y: 0, width: 150, height: 100))
        XCTAssertEqual(result[2].layout.frame, CGRect(x: 0, y: 0, width: 75, height: 100))
        XCTAssertEqual(result[3].layout.frame, CGRect(x: 75, y: 0, width: 75, height: 100))
    }
     */

    // MARK: - Translate Non SingleComponentViews

    /* TODO: fix when composite view are renderable
    func testThatNonSingleComponentViewsAreRendered() {
        let inputComponent = MockComponents.composite()
        let result = translator.translateSections(from: inputComponent, in: CGRect(origin: .zero, size: CGSize(width: 300, height: 0)))
        XCTAssertEqual(result[0].rows.count, 1)
        XCTAssertEqual(result[0].rows[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertNotNil(result[0].rows[0].view)
    }
     */

    // MARK: - Translate Components to Rows

    func testThatComponentIsTranslatedToRow() {
        guard let row = translator.translateRows(from: MockComponents.labelComponent(), in: 0, at: 1) else {
            XCTFail("Component was not reducible to a UIView")
            return
        }

        XCTAssertEqual(row.section, 0)
        XCTAssertEqual(row.index, 1)
        XCTAssertNotNil(row.view)
    }

    func testThatCompositeIsNotTranslated() {
        let inputComponent = MockComponents.composite()
        let outputRow = translator.translateRows(from: inputComponent, in: 0, at: 0)
        XCTAssertNil(outputRow)
    }

    // MARK: - Calculate Row Layout

    func testThatRowLayoutIsCalculatedForASingleRow() {
        let inputRows = MockRows.singleRow
        let outputRows = translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0)).rows

        XCTAssertEqual(outputRows.count, 1)
        outputRows.forEach { XCTAssertNotNil($0.layout) }

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 400, height: 100))
    }

    func testThatRowLayoutIsCalculatedForRows() {
        let inputRows = MockRows.rows
        let rowData = translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0))
        let outputRows = rowData.rows
        let outputHeight = rowData.height

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 200, height: 100))
        XCTAssertEqual(outputRows[1].layout.frame, CGRect(x: 200, y: 0, width: 200, height: 100))
        XCTAssertEqual(outputRows[2].layout.frame, CGRect(x: 0, y: 100, width: 200, height: 100))
        XCTAssertEqual(outputHeight, 200)
    }

    // 0.75, 0.5, 0.25, 1.0
    func testThatRowLayoutIsCalculatedForRowsWithMultipleDimensions() {
        let inputRows = MockRows.rowsMultipleDimensions
        let rowData = translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0))
        let outputRows = rowData.rows
        let outputHeight = rowData.height

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(outputRows[1].layout.frame, CGRect(x: 0, y: 100, width: 200, height: 100))
        XCTAssertEqual(outputRows[2].layout.frame, CGRect(x: 200, y: 100, width: 100, height: 100))
        XCTAssertEqual(outputRows[3].layout.frame, CGRect(x: 0, y: 200, width: 400, height: 100))
        XCTAssertEqual(outputHeight, 300)
    }

    // 0.75-100, 0.5-200, 0.25-10, 1.0-75
    func testThatRowLayoutIsCalculatedForRowsWithMultipleDimensionsAndHeights() {
        let inputRows = MockRows.rowsMultipleDimensionsMultipleHeights
        let rowData = translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0))
        let outputRows = rowData.rows
        let outputHeight = rowData.height

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(outputRows[1].layout.frame, CGRect(x: 0, y: 100, width: 200, height: 200))
        XCTAssertEqual(outputRows[2].layout.frame, CGRect(x: 200, y: 100, width: 100, height: 10))
        XCTAssertEqual(outputRows[3].layout.frame, CGRect(x: 0, y: 300, width: 400, height: 75))
        XCTAssertEqual(outputHeight, 375)
    }
}
