//
//  ComponentDimensionTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/3/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class ComponentDimensionTests: XCTestCase {
    
    func testWidthForFillDimension() {
        let dimension = ComponentDimension.fill
        let width = dimension.width(in: 100)
        XCTAssertEqual(width, 100)
    }

    func testWidthForFixedDimension() {
        let dimension = ComponentDimension.fixed(size: CGSize(width: 100, height: 100))
        let width = dimension.width(in: 200)
        XCTAssertEqual(width, 100)
    }

    func testWidthFor100RatioDimension() {
        let dimension = ComponentDimension.ratio(ratio: 0.75)
        let width = dimension.width(in: 100)
        XCTAssertEqual(width, 75)
    }

    func testWidthForRatioDimensionGetFloor() {
        let dimension = ComponentDimension.ratio(ratio: 0.75)
        let width = dimension.width(in: 414)
        XCTAssertEqual(width, 310)
    }
}
