//
//  TranslatorTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 7/29/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class TranslatorTests: XCTestCase {

    func testRootIsTranslatedToSection() {
        let container = Container(components: [], props: MockComponents.containerProps)
        let sections = Translator.translate(fromComponent: container)
        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0].index, 0)
        XCTAssertEqual(sections[0].rows.count, 0)
    }

    func testWhenContainerHasLabelComponent() {
        let container = MockComponents.containerWithLabel(with: .fill, labelHeight: 100)
        let sections = Translator.translate(fromComponent: container)

        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0].index, 0)
        XCTAssertEqual(sections[0].rows.count, 1)
        XCTAssertEqual(sections[0].rows[0].indexPath.row, 0)
        XCTAssertEqual(sections[0].rows[0].indexPath.section, 0)
    }

    func testLabelIsTranslatedToSection() {
        // TODO: work on creating a section if none exists
    }

    func testCompositeIsTranslatedToSection() {
        let composite = MockComponents.composite()
        let sections = Translator.translate(fromComponent: composite)

        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections[0].index, 0)
        XCTAssertEqual(sections[0].rows.count, 1)
        XCTAssertEqual(sections[0].rows[0].indexPath.row, 0)
        XCTAssertEqual(sections[0].rows[0].indexPath.section, 0)
    }


    // TODO: OLD Translation tests
    // MARK: - Translate Container with only Components

    /*

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
     */
}
