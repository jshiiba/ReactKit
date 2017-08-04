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
        let result = translator.translate(fromComponent: container, in: parentFrame)

        XCTAssertEqual(result[0].index, 0)
        XCTAssertEqual(result[1].index, 1)
        XCTAssertEqual(result[2].index, 2)
    }

}
