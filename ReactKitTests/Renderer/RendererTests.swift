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

    // MARK: Test ComponentRenderer

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

class RendererComponentDataSourceTests: RendererTests {
    fileprivate func setupRenderer(with sections: [Section]){
        let mockTranslation: Translation = { (_) in
            return sections
        }
        _ = renderer.render(MockComponents.labelComponent(), in: .zero, translation: mockTranslation, reconciliation: reconciliation)
    }

    fileprivate func setupRendererWithSectionRow(at indexPath: IndexPath) {
        let section = Section(index: 0)
        section.addChild(.row(Row(view: UIView(), props: nil, indexPath: indexPath)))
        setupRenderer(with: [section])
    }

    func testNumberOfSection() {
        setupRenderer(with: [Section(index: 0)])
        XCTAssertEqual(renderer.numberOfSections, 1)
    }

    func testNumberOfItemsInSection() {
        setupRendererWithSectionRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(renderer.numberOfItems(in: 0), 1)
    }

    func testNumberOfItemsInSectionAtLessThanZeroReturnsZero() {
        XCTAssertEqual(renderer.numberOfItems(in: -1), 0)
    }

    func testNumberOfItemsInSectionAtGreaterThanSectioCountReturnsZero() {
        setupRenderer(with: [Section(index: 0)])
        XCTAssertEqual(renderer.numberOfItems(in: 2), 0)
    }

    func testComponentAtPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        setupRendererWithSectionRow(at: indexPath)
        XCTAssertNotNil(renderer.component(at: indexPath))
    }

    func testComponentAtPathOutOfSectionRange() {
        var indexPath = IndexPath(row: 0, section: -1)
        setupRendererWithSectionRow(at: indexPath)
        XCTAssertNil(renderer.component(at: indexPath))

        indexPath = IndexPath(row: 0, section: 2)
        setupRendererWithSectionRow(at: indexPath)
        XCTAssertNil(renderer.component(at: indexPath))
    }

    func testComponentAtPathOutOfRowRange() {
        var indexPath = IndexPath(row: -1, section: 0)
        setupRendererWithSectionRow(at: indexPath)
        XCTAssertNil(renderer.component(at: indexPath))

        indexPath = IndexPath(row: 2, section: 0)
        setupRendererWithSectionRow(at: indexPath)
        XCTAssertNil(renderer.component(at: indexPath))
    }
}
