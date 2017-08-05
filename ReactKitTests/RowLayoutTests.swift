//
//  RowLayoutTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class RowLayoutTests: XCTestCase {
    
    func testThatRowFrameIsInRelationToSectionFrame() {
        let sectionFrame = CGRect(x: 100, y: 100, width: 500, height: 500)
        let rowFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let layout = RowLayout(frame: rowFrame, sectionFrame: sectionFrame)

        XCTAssertEqual(layout.origin.x, 100)
        XCTAssertEqual(layout.origin.y, 100)
    }

    func testThatRowFrameIsSetWithoutSectionFrame() {
        let rowFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let layout = RowLayout(frame: rowFrame, sectionFrame: nil)

        XCTAssertEqual(layout.origin.x, 0)
        XCTAssertEqual(layout.origin.y, 0)
    }
}
