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
    
    override func setUp() {
        super.setUp()
    }

    // MARK: - Translate Container with only Components

    func testWhenRootComponentIsAnEmptyContainer() {
        let container = Container(components: [], layout: MockComponents.containerLayoutFill)
        let result = Translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 0))
        XCTAssertEqual(result[0].rows.count, 0)
    }

    func testWhenContainerHasLabelComponent() {
        let container = MockComponents.containerWithLabel(with: .fill, labelHeight: 100)
        let result = Translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].rows.count, 1)
        XCTAssertEqual(result[0].rows[0].index, 0)
        XCTAssertEqual(result[0].rows[0].section, 0)
    }

    func testWhenContainerHasTwoLabelComponentsWithSameLayouts() {
        let container = MockComponents.containerWithSameTwoLabels(with: .ratio(ratio: 0.5), labelHeight: 100)
        let result = Translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].rows.count, 2)

        XCTAssertEqual(result[0].rows[0].index, 0)
        XCTAssertEqual(result[0].rows[0].section, 0)
        XCTAssertEqual(result[0].rows[0].layout.dimension, FlexDimension.ratio(ratio: 0.5))
        XCTAssertEqual(result[0].rows[0].layout.height, 100)

        XCTAssertEqual(result[0].rows[1].index, 1)
        XCTAssertEqual(result[0].rows[1].section, 0)
        XCTAssertEqual(result[0].rows[1].layout.dimension, FlexDimension.ratio(ratio: 0.5))
        XCTAssertEqual(result[0].rows[1].layout.height, 100)

        XCTAssertEqual(result[0].layout.frame.height, 100)
    }

    func testWhenContainerHasMultipleLabels() {
        let container = MockComponents.containerWithMultipleLabels()
        let result = Translator.translateSections(from: container, in: parentFrame, at: 0)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[0].rows.count, 4)

        XCTAssertEqual(result[0].rows[0].index, 0)
        XCTAssertEqual(result[0].rows[0].section, 0)
        XCTAssertEqual(result[0].rows[0].layout.dimension, FlexDimension.ratio(ratio: 0.75))
        XCTAssertEqual(result[0].rows[0].layout.height, 100)

        XCTAssertEqual(result[0].rows[1].index, 1)
        XCTAssertEqual(result[0].rows[1].section, 0)
        XCTAssertEqual(result[0].rows[1].layout.dimension, FlexDimension.ratio(ratio: 0.5))
        XCTAssertEqual(result[0].rows[1].layout.height, 200)

        XCTAssertEqual(result[0].rows[2].index, 2)
        XCTAssertEqual(result[0].rows[2].section, 0)
        XCTAssertEqual(result[0].rows[2].layout.dimension, FlexDimension.ratio(ratio: 0.25))
        XCTAssertEqual(result[0].rows[2].layout.height, 25)

        XCTAssertEqual(result[0].rows[3].index, 3)
        XCTAssertEqual(result[0].rows[3].section, 0)
        XCTAssertEqual(result[0].rows[3].layout.dimension, FlexDimension.ratio(ratio: 1.0))
        XCTAssertEqual(result[0].rows[3].layout.height, 100)

        XCTAssertEqual(result[0].layout.frame.height, 400)
    }

    // MARK: - Translate Container with Containers

    func testThatContainersWithChildContainersHaveIndex() {
        let container = MockComponents.containerWithContainers()
        let result = Translator.translateSections(from: container, in: CGRect(origin: CGPoint(x: 0 , y: 0), size: CGSize(width: 300, height: 0)), at: 0)

        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[1].index, 1)
        XCTAssertEqual(result[2].index, 2)
    }

    func testThatContainersCanLayoutChildContainers() {
        let container = MockComponents.containerWithContainers()
        let result = Translator.translateSections(from: container, in: CGRect(origin: CGPoint(x: 0 , y: 0), size: CGSize(width: 300, height: 0)), at: 0)

        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 400))
        XCTAssertEqual(result[1].layout.frame, CGRect(x: 0, y: 0, width: 150, height: 200))
        XCTAssertEqual(result[2].layout.frame, CGRect(x: 150, y: 0, width: 150, height: 200))
    }

    // MARK: - Translate Components to Rows

    func testThatComponentIsTranslatedToRow() {
        guard let row = Translator.translateRows(from: MockComponents.labelComponent(), in: 0, at: 1) else {
            XCTFail("Component was not reducible to a UIView")
            return
        }

        XCTAssertEqual(row.section, 0)
        XCTAssertEqual(row.index, 1)
        XCTAssertNotNil(row.view)
    }

    func testThatCompositeIsNotTranslated() {
        let inputComponent = MockComponents.composite()
        let outputRow = Translator.translateRows(from: inputComponent, in: 0, at: 0)
        XCTAssertNil(outputRow)
    }

    // MARK: Calculate Flow Origin

    func testThatOriginIsInlineStartingAtZeroOrigin() {
        let prevFrame = CGRect(x: 0, y: 0, width: 100, height: 0)
        let outputOrigin = Translator.originFor(width: 100, previousFrame: prevFrame, inSectionWidth: 400, newLineXPos: 0, maxY: 0)
        XCTAssertEqual(outputOrigin.x, 100)
        XCTAssertEqual(outputOrigin.y, 0)
    }

    func  testThatOriginIsInLineStartingNotZeroOrigin() {
        let prevFrame = CGRect(x: 100, y: 0, width: 100, height: 100)
        let outputOrigin = Translator.originFor(width: 100, previousFrame: prevFrame, inSectionWidth: 400, newLineXPos: 0, maxY: 0)
        XCTAssertEqual(outputOrigin.x, 200)
        XCTAssertEqual(outputOrigin.y, 0)
    }

    func testThatOriginIsWrapStartingAtZeroOrigin() {
        let prevFrame = CGRect(x: 0, y: 0, width: 300, height: 100)
        let outputOrigin = Translator.originFor(width: 200, previousFrame: prevFrame, inSectionWidth: 400, newLineXPos: 0, maxY: 100)
        XCTAssertEqual(outputOrigin.x, 0)
        XCTAssertEqual(outputOrigin.y, 100)
    }

    func testThatOriginIsWrapStartNotZeroOrigin() {
        let prevFrame = CGRect(x: 100, y: 0, width: 200, height: 100)
        let outputOrigin = Translator.originFor(width: 200, previousFrame: prevFrame, inSectionWidth: 400, newLineXPos: 0, maxY: 100)
        XCTAssertEqual(outputOrigin.x, 0)
        XCTAssertEqual(outputOrigin.y, 100)
    }

    // MARK: - Max Y

    func testThatMaxYIsOverridenAtZeroY() {
        let inputMaxY: CGFloat = 0
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let outputMaxY = Translator.getMaxY(for: inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 100)
    }

    func testThatMaxYIsOverridenAtNonZeroY() {
        let inputMaxY: CGFloat = 0
        let inputFrame = CGRect(x: 0, y: 100, width: 100, height: 200)
        let outputMaxY = Translator.getMaxY(for: inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 300)
    }

    func testThatMaxYIsOverridenWithNonZeroMaxY() {
        let inputMaxY: CGFloat = 100
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 200)
        let outputMaxY = Translator.getMaxY(for: inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 200)
    }

    func testThatMaxYIsSame() {
        let inputMaxY: CGFloat = 100
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let outputMaxY = Translator.getMaxY(for: inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 100)
    }

    // MARK: - Width

    func testThatFillEqualsParentWidth() {
        let inputWidth: CGFloat = 100
        let outputWidth = Translator.widthFor(dimension: .fill, in: inputWidth)
        XCTAssertEqual(outputWidth, 100)
    }

    func testThatRatioEqualsParentWidthMultipliedByRatio() {
        let inputWidth: CGFloat = 100
        let outputWidth = Translator.widthFor(dimension: .ratio(ratio: 0.75), in: inputWidth)
        XCTAssertEqual(outputWidth, 75)

        let inputWidth2: CGFloat = 100
        let outputWidth2 = Translator.widthFor(dimension: .ratio(ratio: 1.0), in: inputWidth2)
        XCTAssertEqual(outputWidth2, 100)
    }

    func testThatFixedEqualsFixedValue() {
        let inputWidth: CGFloat = 100
        let outputWidth = Translator.widthFor(dimension: .fixed(size: CGSize(width: 75, height: 0)), in: inputWidth)
        XCTAssertEqual(outputWidth, 75)
    }

    // MARK: - Calculate Row Layout

    func testThatRowLayoutIsCalculatedForASingleRow() {
        let inputRows = MockRowComponents.singleRow
        let outputRows = Translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0)).rows

        XCTAssertEqual(outputRows.count, 1)
        outputRows.forEach { XCTAssertNotNil($0.layout) }

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 400, height: 100))
    }

    func testThatRowLayoutIsCalculatedForRows() {
        let inputRows = MockRowComponents.rows
        let rowData = Translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0))
        let outputRows = rowData.rows
        let outputHeight = rowData.height

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 200, height: 100))
        XCTAssertEqual(outputRows[1].layout.frame, CGRect(x: 200, y: 0, width: 200, height: 100))
        XCTAssertEqual(outputRows[2].layout.frame, CGRect(x: 0, y: 100, width: 200, height: 100))
        XCTAssertEqual(outputHeight, 200)
    }

    // 0.75, 0.5, 0.25, 1.0
    func testThatRowLayoutIsCalculatedForRowsWithMultipleDimensions() {
        let inputRows = MockRowComponents.rowsMultipleDimensions
        let rowData = Translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0))
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
        let inputRows = MockRowComponents.rowsMultipleDimensionsMultipleHeights
        let rowData = Translator.calculateRowData(from: inputRows, in: 400, at: CGPoint(x: 0, y: 0))
        let outputRows = rowData.rows
        let outputHeight = rowData.height

        XCTAssertEqual(outputRows[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(outputRows[1].layout.frame, CGRect(x: 0, y: 100, width: 200, height: 200))
        XCTAssertEqual(outputRows[2].layout.frame, CGRect(x: 200, y: 100, width: 100, height: 10))
        XCTAssertEqual(outputRows[3].layout.frame, CGRect(x: 0, y: 300, width: 400, height: 75))
        XCTAssertEqual(outputHeight, 375)
    }
}
