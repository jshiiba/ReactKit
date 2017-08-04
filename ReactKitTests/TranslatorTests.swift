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

    let parentWidth: CGFloat = 300
    var translator: Translator!
    
    override func setUp() {
        super.setUp()
        translator = Translator()
    }

    // MARK: - Translate Container with only Components

    func testWhenRootComponentIsAnEmptyContainer() {
        let container = Container(components: [], props: MockComponents.containerProps)
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections.count, 1)
        XCTAssertEqual(dataSource.sections[0].index, 0)
        XCTAssertEqual(dataSource.sections[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 0))
        XCTAssertEqual(dataSource.sections[0].rows.count, 0)
    }


    func testWhenContainerHasLabelComponent() {
        let container = MockComponents.containerWithLabel(with: .fill, labelHeight: 100)
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections.count, 1)
        XCTAssertEqual(dataSource.sections[0].index, 0)
        XCTAssertEqual(dataSource.sections[0].rows.count, 1)
        XCTAssertEqual(dataSource.sections[0].rows[0].indexPath.row, 0)
        XCTAssertEqual(dataSource.sections[0].rows[0].indexPath.section, 0)
    }

    func testWhenContainerHasTwoLabelComponentsWithSameLayouts() {
        let container = MockComponents.containerWithSameTwoLabels(with: .ratio(ratio: 0.5), labelHeight: 100)
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections.count, 1)
        XCTAssertEqual(dataSource.sections[0].index, 0)
        XCTAssertEqual(dataSource.sections[0].rows.count, 2)

        XCTAssertEqual(dataSource.sections[0].rows[0].indexPath, IndexPath(row: 0, section: 0))
        XCTAssertEqual(dataSource.sections[0].rows[0].layout.frame, CGRect(x: 0, y: 0, width: 150, height: 100))

        XCTAssertEqual(dataSource.sections[0].rows[1].indexPath, IndexPath(row: 1, section: 0))
        XCTAssertEqual(dataSource.sections[0].rows[1].layout.frame, CGRect(x: 150, y: 0, width: 150, height: 100))

        XCTAssertEqual(dataSource.sections[0].layout.frame.height, 100)
    }

    func testWhenContainerHasMultipleLabels() {
        let container = MockComponents.containerWithMultipleLabels()
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections.count, 1)
        XCTAssertEqual(dataSource.sections[0].index, 0)
        XCTAssertEqual(dataSource.sections[0].rows.count, 4)

        XCTAssertEqual(dataSource.sections[0].rows[0].indexPath, IndexPath(row: 0, section: 0))
        XCTAssertEqual(dataSource.sections[0].rows[0].layout.frame, CGRect(x: 0, y: 0, width: 225, height: 100))

        XCTAssertEqual(dataSource.sections[0].rows[1].indexPath, IndexPath(row: 1, section: 0))
        XCTAssertEqual(dataSource.sections[0].rows[1].layout.frame, CGRect(x: 0, y: 100, width: 150, height: 200))

        XCTAssertEqual(dataSource.sections[0].rows[2].indexPath, IndexPath(row: 2, section: 0))
        XCTAssertEqual(dataSource.sections[0].rows[2].layout.frame, CGRect(x: 150, y: 100, width: 75, height: 25))


        XCTAssertEqual(dataSource.sections[0].rows[3].indexPath, IndexPath(row: 3, section: 0))
        XCTAssertEqual(dataSource.sections[0].rows[3].layout.frame, CGRect(x: 0, y: 300, width: 300, height: 100))

        XCTAssertEqual(dataSource.sections[0].layout.frame.height, 400)
    }


    func testThatContainersCanLayoutChildContainers() {
        let container = MockComponents.containerWithContainers()
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections.count, 3)
        XCTAssertEqual(dataSource.sections[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(dataSource.sections[1].layout.frame, CGRect(x: 0, y: 0, width: 150, height: 100))
        XCTAssertEqual(dataSource.sections[2].layout.frame, CGRect(x: 150, y: 0, width: 150, height: 100))
    }

    func testMultilevelContainers() {
        let container = MockComponents.multiLevelContainers()
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections.count, 4)
        XCTAssertEqual(dataSource.sections[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
        XCTAssertEqual(dataSource.sections[1].layout.frame, CGRect(x: 0, y: 0, width: 150, height: 100))
        XCTAssertEqual(dataSource.sections[2].layout.frame, CGRect(x: 0, y: 0, width: 75, height: 100))
        XCTAssertEqual(dataSource.sections[3].layout.frame, CGRect(x: 75, y: 0, width: 75, height: 100))
    }


    // MARK: - Translate Non SingleComponentViews


//    func testThatNonSingleComponentViewsAreRendered() {
//        let inputComponent = MockComponents.composite()
//        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
//        Translator.translate(fromComponent: inputComponent, in: parentWidth, to: &dataSource)
//
//        XCTAssertEqual(dataSource.sections[0].rows.count, 1)
//        XCTAssertEqual(dataSource.sections[0].rows[0].layout.frame, CGRect(x: 0, y: 0, width: 300, height: 100))
//        XCTAssertNotNil(dataSource.sections[0].rows[0].view)
//    }
     /*

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
     */
}
