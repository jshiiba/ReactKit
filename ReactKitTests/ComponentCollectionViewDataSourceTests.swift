//
//  ComponentCollectionViewDataSourceTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/10/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class MockComponentRendererDataSource: ComponentRendererDataSource {

    var componentLayout: ComponentCollectionViewLayout = ComponentCollectionViewLayout()

    var numberOfSections: Int = 0

    func numberOfItems(in section: Int) -> Int {
        return 0
    }

    func component(at indexPath: IndexPath) -> UIView? {
        return nil
    }

    func render(_ rootComponent: Component, in frame: CGRect, translation: Translation, reconciliation: Reconciliation) -> [IndexPath] {
        return []
    }
}

class MockComponentCollectionView: UICollectionView {

    var reloadItemsCalled = false
    override func reloadItems(at indexPaths: [IndexPath]) {
        reloadItemsCalled = true
        super.reloadItems(at: indexPaths)
    }

    var usedCellIdentifier: String?
    var usedCellClass: AnyClass!
    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        usedCellIdentifier = identifier
        usedCellClass = cellClass
        super.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
}

class ComponentCollectionViewDataSourceTests: XCTestCase {
    var mockRendererDataSource: MockComponentRendererDataSource!
    var mockCollectionView: MockComponentCollectionView!
    var dataSource: ComponentCollectionViewDataSource!
    override func setUp() {
        super.setUp()
        mockRendererDataSource = MockComponentRendererDataSource()
        mockCollectionView = MockComponentCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        dataSource = ComponentCollectionViewDataSource(rendererDataSource: mockRendererDataSource)
        dataSource.componentCollectionView = mockCollectionView
    }

    // MARK: - CollectionView Config

    func testThatCellWasRegisteredWithIdentifier() {
        XCTAssertEqual(mockCollectionView.usedCellIdentifier, "Identifier")
    }

    func testThatCellWasRegisteredWithClass() {
        XCTAssertNotNil(mockCollectionView.usedCellClass as? BaseComponentCell.Type)
    }

    func testThatCollectionViewIsAutoResizing() {
        XCTAssertEqual(mockCollectionView.autoresizingMask, [.flexibleWidth, .flexibleHeight])
    }
}
