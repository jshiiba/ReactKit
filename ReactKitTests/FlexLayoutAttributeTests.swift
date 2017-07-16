//
//  FlexLayoutAttributeTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import XCTest
@testable import ReactKit

class FlexLayoutAttributeTests: XCTestCase {

    var container: LayoutContainerProps!

    override func setUp() {
        super.setUp()
        container = LayoutContainerProps(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    // MARK: - Single Component
    func testFlex100() {
        let component = LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))
        let attribute = FlexLayout.attributes(forComponentProps: [component], in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        XCTAssertEqual(attribute[0].frame, expectedFrame)
    }

    func testThatFlexTakesPrecedentOverStaticFrameLessThanContainer() {
        let component = LayoutComponentProps(flex: 1, size: CGSize(width: 50, height: 50))
        let attribute = FlexLayout.attributes(forComponentProps: [component], in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        XCTAssertEqual(attribute[0].frame, expectedFrame)
    }

    func testThatFlexIsSetForStaticFrameGreaterThanContainer() {
        let component = LayoutComponentProps(flex: 1, size: CGSize(width: 150, height: 50))
        let attribute = FlexLayout.attributes(forComponentProps: [component], in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        XCTAssertEqual(attribute[0].frame, expectedFrame)
    }

    func testFlexLessThan100() {
        let component = LayoutComponentProps(flex: 0.75, size: CGSize(width: 0, height: 50))
        let attribute = FlexLayout.attributes(forComponentProps: [component], in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 75, height: 50)
        XCTAssertEqual(attribute[0].frame, expectedFrame)
    }

    // MARK: - Multiple Components

    func testThatMultipleWithFlex100StackInContainer() {
        let c1 = LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))
        let c2 = LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))
        let attributes = FlexLayout.attributes(forComponentProps: [c1, c2], in: container)

        let c1ExpectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let c2ExpectedFrame = CGRect(x: 0, y: 50, width: 100, height: 50)

        XCTAssertEqual(attributes[0].frame, c1ExpectedFrame)
        XCTAssertEqual(attributes[1].frame, c2ExpectedFrame)
    }

    func testThatMultipleWithFlex75And50StackInContainer() {
        let c1 = LayoutComponentProps(flex: 0.75, size: CGSize(width: 0, height: 50))
        let c2 = LayoutComponentProps(flex: 0.5, size: CGSize(width: 0, height: 50))
        let attributes = FlexLayout.attributes(forComponentProps: [c1, c2], in: container)

        let c1ExpectedFrame = CGRect(x: 0, y: 0, width: 75, height: 50)
        let c2ExpectedFrame = CGRect(x: 0, y: 50, width: 50, height: 50)

        XCTAssertEqual(attributes[0].frame, c1ExpectedFrame)
        XCTAssertEqual(attributes[1].frame, c2ExpectedFrame)
    }

    func testThatMultipleWithFlex50EachAreOnSameRowInContainer() {
        let c1 = LayoutComponentProps(flex: 0.5, size: CGSize(width: 0, height: 50))
        let c2 = LayoutComponentProps(flex: 0.5, size: CGSize(width: 0, height: 50))
        let attributes = FlexLayout.attributes(forComponentProps: [c1, c2], in: container)

        let c1ExpectedFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let c2ExpectedFrame = CGRect(x: 50, y: 0, width: 50, height: 50)

        XCTAssertEqual(attributes[0].frame, c1ExpectedFrame)
        XCTAssertEqual(attributes[1].frame, c2ExpectedFrame)
    }
}
