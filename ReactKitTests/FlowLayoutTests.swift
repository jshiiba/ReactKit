//
//  FlowLayoutTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/1/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class FlowLayoutTests: XCTestCase {
    
    // MARK: Calculate Flow Origin

    func testThatOriginIsInlineStartingAtZeroOrigin() {
        let prevFrame = CGRect(x: 0, y: 0, width: 100, height: 0)
        let outputOrigin = FlowLayout.nextOrigin(for: 100, after: prevFrame, in: CGRect(origin: .zero, size: CGSize(width: 400, height: 0)), attributes: FlowLayout.Attributes(previousFrame: prevFrame, currentMaxY: 0))
        XCTAssertEqual(outputOrigin.x, 100)
        XCTAssertEqual(outputOrigin.y, 0)
    }

    func  testThatOriginIsInLineStartingNotZeroOrigin() {
        let prevFrame = CGRect(x: 100, y: 0, width: 100, height: 100)
        let outputOrigin = FlowLayout.nextOrigin(for: 100, after: prevFrame, in: CGRect(origin: .zero, size: CGSize(width: 400, height: 0)), attributes: FlowLayout.Attributes(previousFrame: prevFrame, currentMaxY: 0))
        XCTAssertEqual(outputOrigin.x, 200)
        XCTAssertEqual(outputOrigin.y, 0)
    }

    func testThatOriginIsInLineStartingNotZeroOriginWithinSection() {
        let prevFrame = CGRect(x: 100, y: 0, width: 100, height: 100)
        let outputOrigin = FlowLayout.nextOrigin(for: 100, after: prevFrame, in: CGRect(origin: CGPoint(x: 100, y: 0), size: CGSize(width: 200, height: 0)), attributes: FlowLayout.Attributes(previousFrame: prevFrame, currentMaxY: 0))
        XCTAssertEqual(outputOrigin.x, 200)
        XCTAssertEqual(outputOrigin.y, 0)
    }

    func testThatOriginIsWrapStartingAtZeroOrigin() {
        let prevFrame = CGRect(x: 0, y: 0, width: 300, height: 100)
        let outputOrigin = FlowLayout.nextOrigin(for: 200, after: prevFrame, in: CGRect(origin: .zero, size: CGSize(width: 400, height: 0)), attributes: FlowLayout.Attributes(previousFrame: prevFrame, currentMaxY: 100))
        XCTAssertEqual(outputOrigin.x, 0)
        XCTAssertEqual(outputOrigin.y, 100)
    }

    // FIXME: not working
    func testThatOriginIsWrapStartNotZeroOrigin() {
        let prevFrame = CGRect(x: 100, y: 0, width: 200, height: 100)
        let outputOrigin = FlowLayout.nextOrigin(for: 200, after: prevFrame, in: CGRect(origin: .zero, size: CGSize(width: 400, height: 0)), attributes: FlowLayout.Attributes(previousFrame: prevFrame, currentMaxY: 100))
        XCTAssertEqual(outputOrigin.x, 0)
        XCTAssertEqual(outputOrigin.y, 100)
    }

    // MARK: - Max Y

    func testThatMaxYIsOverridenAtZeroY() {
        let inputMaxY: CGFloat = 0
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let outputMaxY =  FlowLayout.Attributes(previousFrame: inputFrame, currentMaxY: inputMaxY).maxY
        XCTAssertEqual(outputMaxY, 100)
    }

    func testThatMaxYIsOverridenAtNonZeroY() {
        let inputMaxY: CGFloat = 0
        let inputFrame = CGRect(x: 0, y: 100, width: 100, height: 200)
        let outputMaxY = FlowLayout.Attributes(previousFrame: inputFrame, currentMaxY: inputMaxY).maxY
        XCTAssertEqual(outputMaxY, 300)
    }

    func testThatMaxYIsOverridenWithNonZeroMaxY() {
        let inputMaxY: CGFloat = 100
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 200)
        let outputMaxY = FlowLayout.Attributes(previousFrame: inputFrame, currentMaxY: inputMaxY).maxY
        XCTAssertEqual(outputMaxY, 200)
    }

    func testThatMaxYIsSame() {
        let inputMaxY: CGFloat = 100
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let outputMaxY = FlowLayout.Attributes(previousFrame: inputFrame, currentMaxY: inputMaxY).maxY
        XCTAssertEqual(outputMaxY, 100)
    }

    // MARK: - Width

    func testThatFillEqualsParentWidth() {
        let inputWidth: CGFloat = 100
        let outputWidth = FlowLayout.widthFor(dimension: .fill, in: inputWidth)
        XCTAssertEqual(outputWidth, 100)
    }

    func testThatRatioEqualsParentWidthMultipliedByRatio() {
        let inputWidth: CGFloat = 100
        let outputWidth = FlowLayout.widthFor(dimension: .ratio(ratio: 0.75), in: inputWidth)
        XCTAssertEqual(outputWidth, 75)

        let inputWidth2: CGFloat = 100
        let outputWidth2 = FlowLayout.widthFor(dimension: .ratio(ratio: 1.0), in: inputWidth2)
        XCTAssertEqual(outputWidth2, 100)
    }

    func testThatFixedEqualsFixedValue() {
        let inputWidth: CGFloat = 100
        let outputWidth = FlowLayout.widthFor(dimension: .fixed(size: CGSize(width: 75, height: 0)), in: inputWidth)
        XCTAssertEqual(outputWidth, 75)
    }
}
