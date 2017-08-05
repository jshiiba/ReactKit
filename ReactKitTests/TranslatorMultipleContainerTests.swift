//
//  TranslatorMultipleContainerTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/4/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class TranslatorMultipleContainerTests: TranslatorTests {
    
    // MARK: - Translate Container with Containers

    func testThatContainersWithChildContainersHaveIndex() {
        let container = MockComponents.containerWithContainers()
        var dataSource: VirtualDataSource = ComponentVirtualDataSource()
        Translator.translate(fromComponent: container, in: parentWidth, to: &dataSource)

        XCTAssertEqual(dataSource.sections[0].index, 0)
        XCTAssertEqual(dataSource.sections[1].index, 1)
        XCTAssertEqual(dataSource.sections[2].index, 2)
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
}
