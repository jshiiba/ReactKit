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

    // MARK: - Dimension Width

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

    // MARK: - Equatable

    func testThatDimensionFillIsEquatable() {
        XCTAssertEqual(ComponentDimension.fill, ComponentDimension.fill)
    }

    func tesThatDimensionRatioIsEquatable() {
        XCTAssertEqual(ComponentDimension.ratio(ratio: 1.0), ComponentDimension.ratio(ratio: 1.0))
    }

    func testThatDifferentDimensionRatioIsNotEquatable() {
        XCTAssertNotEqual(ComponentDimension.ratio(ratio: 1.0), ComponentDimension.ratio(ratio: 0.5))
    }

    func testThatDimensionFixedIsEquatable() {
        XCTAssertEqual(ComponentDimension.fixed(size: CGSize(width: 100, height: 100)),
                       ComponentDimension.fixed(size: CGSize(width: 100, height: 100)))
    }

    func testThatDifferentDimensionFixedIsNotEquatable() {
        XCTAssertNotEqual(ComponentDimension.fixed(size: CGSize(width: 100, height: 100)),
                          ComponentDimension.fixed(size: CGSize(width: 100, height: 50)))
    }

    func testThatFillAndFixedDimensionsAreNotEquatable() {
        XCTAssertNotEqual(ComponentDimension.fill, ComponentDimension.fixed(size: CGSize(width: 100, height: 50)))
    }
}
