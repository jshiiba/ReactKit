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

}
