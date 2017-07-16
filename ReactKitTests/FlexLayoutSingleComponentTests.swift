//
//  FlexLayoutSingleComponentTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 7/16/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import XCTest
@testable import ReactKit

class FlexLayoutSingleComponentTests: XCTestCase {

    func testFlex100() {
        let container = LayoutContainerProps(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let component = LayoutComponentProps(flex: 1, size: CGSize(width: 0, height: 50))
        let attribute = FlexLayout.attributes(forComponentProp: component, in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        XCTAssertEqual(attribute.frame, expectedFrame)
    }

    func testThatFlexTakesPrecedentOverStaticFrameLessThanContainer() {
        let container = LayoutContainerProps(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let component = LayoutComponentProps(flex: 1, size: CGSize(width: 50, height: 50))
        let attribute = FlexLayout.attributes(forComponentProp: component, in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        XCTAssertEqual(attribute.frame, expectedFrame)
    }

    func testThatFlexIsSetForStaticFrameGreaterThanContainer() {
        let container = LayoutContainerProps(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let component = LayoutComponentProps(flex: 1, size: CGSize(width: 150, height: 50))
        let attribute = FlexLayout.attributes(forComponentProp: component, in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        XCTAssertEqual(attribute.frame, expectedFrame)
    }

    func testFlexLessThan100() {
        let container = LayoutContainerProps(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let component = LayoutComponentProps(flex: 0.75, size: CGSize(width: 0, height: 50))
        let attribute = FlexLayout.attributes(forComponentProp: component, in: container)

        let expectedFrame = CGRect(x: 0, y: 0, width: 75, height: 50)
        XCTAssertEqual(attribute.frame, expectedFrame)
    }
}
