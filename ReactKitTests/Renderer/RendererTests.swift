//
//  RendererTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/9/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class MockCacher: ComponentCache {
    var cacherCalled = false
    func cache(_ sections: [Section]) -> [Section]? {
        cacherCalled = true
        return []
    }
}

class MockLayout: ComponentLayoutCalculator {
    var calculateLayoutCalled = false
    var frameCalculated: CGRect?
    func calculateLayout(for sections: inout [Section], in frame: CGRect) {
        frameCalculated = frame
        calculateLayoutCalled = true
    }
}

class RendererTests: XCTestCase {
    var cacher: MockCacher!
    var layout: MockLayout!
    var renderer: Renderer!
    var translation: Translation = { (_) in return [] }
    var reconciliation: Reconciliation = { (_, _) in return[] }

    override func setUp() {
        super.setUp()
        layout = MockLayout()
        cacher = MockCacher()
        renderer = Renderer(cacher: cacher, layout: layout)
    }
    
    func testThatRendererCallsTranslation() {
        var translated = false
        let mockTranslation: Translation = { (_) in
            translated = true
            return []
        }

        let frame = CGRect(x: 0, y: 0, width: 100, height: 500)
        _ = renderer.render(MockComponents.labelComponent(), in: frame, translation: mockTranslation, reconciliation: reconciliation)
        XCTAssertTrue(translated)
    }

    func testThatRendererCallsReconcilation() {
        var reconciled = false
        let mockReconciliation: Reconciliation = { (_, _) in
            reconciled = true
            return []
        }

        _ = renderer.render(MockComponents.labelComponent(), in: .zero, translation: translation, reconciliation: mockReconciliation)
        XCTAssertTrue(reconciled)
    }

    func testThatRendererCachesWithCacher() {
        _ = renderer.render(MockComponents.labelComponent(), in: .zero, translation: translation, reconciliation: reconciliation)
        XCTAssertTrue(cacher.cacherCalled)
    }

    func testThatRendererCalculatesLayout() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 500)
        _ = renderer.render(MockComponents.labelComponent(), in: frame, translation: translation, reconciliation: reconciliation)
        XCTAssertTrue(layout.calculateLayoutCalled)
        XCTAssertEqual(layout.frameCalculated, frame)
    }
}
