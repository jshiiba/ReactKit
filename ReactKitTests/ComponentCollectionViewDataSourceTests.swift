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

    var didGetComponentLayout = false
    var componentLayout: ComponentCollectionViewLayout {
        didGetComponentLayout = true
        return ComponentCollectionViewLayout()
    }

    var numberOfSections: Int = 1

    func numberOfItems(in section: Int) -> Int {
        return 2
    }

    func component(at indexPath: IndexPath) -> UIView? {
        if indexPath == IndexPath(row: 0, section: 0) {
            return UIView()
        } else {
            return nil
        }
    }

    func render(_ rootComponent: Component, in frame: CGRect, translation: Translation, reconciliation: Reconciliation) -> [IndexPath] {
        return [
            IndexPath(row: 0, section: 0),
            IndexPath(row: 1, section: 0)
        ]
    }
}

class MockComponentCollectionView: UICollectionView {

    var reloadItemsCalled = false
    var reloadedIndexPaths: [IndexPath] = []
    override func reloadItems(at indexPaths: [IndexPath]) {
        reloadItemsCalled = true
        reloadedIndexPaths = indexPaths
    }

    var usedCellIdentifier: String?
    var usedCellClass: AnyClass!
    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        usedCellIdentifier = identifier
        usedCellClass = cellClass
        super.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return BaseComponentCell()
    }
}

class MockBaseComponentCell: ComponentDisplayable {
    var removeViewCalled = false
    func removeView() {
        removeViewCalled = true
    }
    var configureViewCalled = false
    func configure(with view: UIView) {
        configureViewCalled = true
    }
}

class ComponentCollectionViewDataSourceTests: XCTestCase {
    var mockCell: MockBaseComponentCell!
    var mockRendererDataSource: MockComponentRendererDataSource!
    var mockCollectionView: MockComponentCollectionView!
    var dataSource: ComponentCollectionViewDataSource!
    override func setUp() {
        super.setUp()
        mockCell = MockBaseComponentCell()
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

    func testThatRenderingComponentGetsIndexPathsToUpdate() {
        dataSource.setComponent(MockComponents.labelComponent())

        XCTAssertTrue(mockCollectionView.reloadItemsCalled)
        XCTAssertEqual(mockCollectionView.reloadedIndexPaths[0], IndexPath(row: 0, section: 0))
        XCTAssertEqual(mockCollectionView.reloadedIndexPaths[1], IndexPath(row: 1, section: 0))
    }

    func testThatDataSourceGetsLayoutFromRenderer() {
        _ = dataSource.collectionViewLayout
        XCTAssertTrue(mockRendererDataSource.didGetComponentLayout)
    }

    // MARK: - UICollectionViewDataSource

    func testThatDequeueReturnsBaseComponentCell() {
        let cell = dataSource.collectionView(dataSource.componentCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is BaseComponentCell)
    }

    func testThatCellRemovesView() {
        dataSource.configureDisplayable(mockCell, at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockCell.removeViewCalled)
    }

    func testThatCellConfiguresViewForComponentAtValidIndexPath() {
        dataSource.configureDisplayable(mockCell, at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockCell.configureViewCalled)
    }

    func testThatCellDoesNotConfigureViewForComponentAtInvalidIndexPath() {
        dataSource.configureDisplayable(mockCell, at: IndexPath(row: 1, section: 0))
        XCTAssertFalse(mockCell.configureViewCalled)
    }

    func testNumberOfSections() {
        XCTAssertEqual(dataSource.numberOfSections(in: dataSource.componentCollectionView), 1)
    }

    func testNumberOfItemsInSection() {
        XCTAssertEqual(dataSource.collectionView(dataSource.componentCollectionView, numberOfItemsInSection: 0), 2)
    }
}
