//
//  ClosureSleeveTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/14/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import UIKit
import XCTest

class ClosureSleeveTests: XCTestCase {
    
    func testThatClosureSleeveIsCalledOnButton() {
        let button = UIButton()

        var closureCalled = false
        button.add(for: .touchUpInside) { control in
            closureCalled = true
        }

        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(closureCalled)
    }

    func testThatClosureSleeveReturnsUIButton() {
        let button = UIButton()

        button.add(for: .touchUpInside) { control in
            XCTAssertTrue(control is UIButton)
        }

        button.sendActions(for: .touchUpInside)
    }
}
