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

    func testThatFlowLayoutGetsInitializedWithParentOrigin() {
        layout = ComponentFlowLayout(parentFrame: CGRect(x: 100, y: 100, width: 100, height: 100))
        XCTAssertEqual(layout.startX, 100)
        XCTAssertEqual(layout.maxY, 100)
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

    func testOriginInParentSection() {
        let parentFrame = CGRect(x: 100, y: 0, width: 100, height: 200)
        let previousFrame = CGRect(x: 150, y: 0, width: 50, height: 100)
        let output = layout.calculateCurrentXOrigin(fromPreviousFrame: previousFrame, in: parentFrame)

        XCTAssertEqual(output, 150)
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
}
