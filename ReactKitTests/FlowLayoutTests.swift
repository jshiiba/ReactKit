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

    var layout: ComponentFlowLayout!

    override func setUp() {
        super.setUp()
        let parent = CGRect(origin: .zero, size: CGSize(width: 400, height: 0))
        layout = ComponentFlowLayout(parentFrame: parent)
    }

    override func tearDown() {
        super.tearDown()
        layout.previousFrame = nil
    }

    private func setPreviousFrame(_ frame: CGRect) {
        layout.previousFrame = frame
        layout.maxY = layout.maxYFor(frame, currentMaxY: layout.maxY)
    }

    private func setParentFrame(_ frame: CGRect) {
        layout.parentFrame = frame
    }

    // MARK: Calculate Flow Origin

    func testThatOriginIsInlineStartingAtZeroOrigin() {
        setPreviousFrame(CGRect(x: 0, y: 0, width: 100, height: 0))
        let output = layout.calculateNextFrame(forWidth: 100, height: 0)

        XCTAssertEqual(output.origin.x, 100)
        XCTAssertEqual(output.origin.y, 0)
    }

    func  testThatOriginIsInLineStartingNotZeroOrigin() {
        setPreviousFrame(CGRect(x: 100, y: 0, width: 100, height: 100))
        let output = layout.calculateNextFrame(forWidth: 100, height: 0)

        XCTAssertEqual(output.origin.x, 200)
        XCTAssertEqual(output.origin.y, 0)
    }

    func testThatOriginIsInLineStartingNotZeroOriginWithinSection() {
        setPreviousFrame(CGRect(x: 100, y: 0, width: 100, height: 100))
        setParentFrame(CGRect(origin: CGPoint(x: 100, y: 0), size: CGSize(width: 200, height: 0)))

        let output = layout.calculateNextFrame(forWidth: 100, height: 0)

        XCTAssertEqual(output.origin.x, 200)
        XCTAssertEqual(output.origin.y, 0)
    }

    func testThatOriginIsInLineWithDifferentHeights() {
        setPreviousFrame(CGRect(x: 0, y: 0, width: 100, height: 200))
        let output = layout.calculateNextFrame(forWidth: 100, height: 0)

        XCTAssertEqual(output.origin.x, 100)
        XCTAssertEqual(output.origin.y, 0)
        XCTAssertEqual(layout.maxY, 200)
    }

    func testThatOriginIsWrapStartingAtZeroOrigin() {
        setPreviousFrame(CGRect(x: 0, y: 0, width: 300, height: 100))
        let output = layout.calculateNextFrame(forWidth: 200, height: 0)

        XCTAssertEqual(output.origin.x, 0)
        XCTAssertEqual(output.origin.y, 100)
    }

    func testThatOriginIsWrapStartNotZeroOrigin() {
        setPreviousFrame(CGRect(x: 100, y: 0, width: 200, height: 100))
        let output = layout.calculateNextFrame(forWidth: 200, height: 0)

        XCTAssertEqual(output.origin.x, 0)
        XCTAssertEqual(output.origin.y, 100)
    }

    // MARK: - Max Y

    func testThatMaxYIsOverridenAtZeroY() {
        let inputMaxY: CGFloat = 0
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let outputMaxY = layout.maxYFor(inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 100)
    }

    func testThatMaxYIsOverridenAtNonZeroY() {
        let inputMaxY: CGFloat = 0
        let inputFrame = CGRect(x: 0, y: 100, width: 100, height: 200)
        let outputMaxY = layout.maxYFor(inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 300)
    }

    func testThatMaxYIsOverridenWithNonZeroMaxY() {
        let inputMaxY: CGFloat = 100
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 200)
        let outputMaxY = layout.maxYFor(inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 200)
    }

    func testThatMaxYIsSame() {
        let inputMaxY: CGFloat = 100
        let inputFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let outputMaxY = layout.maxYFor(inputFrame, currentMaxY: inputMaxY)
        XCTAssertEqual(outputMaxY, 100)
    }

    // MARK: - Width
/*
    func testThatFillEqualsParentWidth() {
        let inputWidth: CGFloat = 100
        let outputWidth = ComponentFlowLayout.widthFor(dimension: .fill, in: inputWidth)
        XCTAssertEqual(outputWidth, 100)
    }

    func testThatRatioEqualsParentWidthMultipliedByRatio() {
        let inputWidth: CGFloat = 100
        let outputWidth = ComponentFlowLayout.widthFor(dimension: .ratio(ratio: 0.75), in: inputWidth)
        XCTAssertEqual(outputWidth, 75)

        let inputWidth2: CGFloat = 100
        let outputWidth2 = ComponentFlowLayout.widthFor(dimension: .ratio(ratio: 1.0), in: inputWidth2)
        XCTAssertEqual(outputWidth2, 100)
    }

    func testThatFixedEqualsFixedValue() {
        let inputWidth: CGFloat = 100
        let outputWidth = ComponentFlowLayout.widthFor(dimension: .fixed(size: CGSize(width: 75, height: 0)), in: inputWidth)
        XCTAssertEqual(outputWidth, 75)
    }
 */
}
