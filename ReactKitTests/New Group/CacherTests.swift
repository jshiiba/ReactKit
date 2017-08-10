//
//  CacherTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class CacherTests: XCTestCase {

    var cacher: ComponentCache!

    override func setUp() {
        super.setUp()
        cacher = Cacher()
    }
    
    func testThatCacherReturnsNilFOrFirstCache() {
        let sections = [Section(index: 0)]

        let outputSections = cacher.cache(sections)
        XCTAssertNil(outputSections)
    }

    func testThatCacherCachesPreviousSections() {
        let previous = [
            Section(index: 0),
            Section(index: 1)
        ]

        _ = cacher.cache(previous)

        let next = [Section(index: 0)]

        let outputSections = cacher.cache(next)

        XCTAssertEqual(outputSections?.count, 2)
        XCTAssertEqual(outputSections?[0].index, 0)
        XCTAssertEqual(outputSections?[1].index, 1)
    }
}
