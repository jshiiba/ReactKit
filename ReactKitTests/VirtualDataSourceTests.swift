//
//  VirtualDataSourceTests.swift
//  ReactKitTests
//
//  Created by Justin Shiiba on 8/10/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

@testable import ReactKit
import XCTest

class VirtualDataSourceTests: XCTestCase {
    var dataSource: VirtualDataSource!
    override func setUp() {
        super.setUp()
        dataSource = TranslatorVirtualDataSource()
    }

    fileprivate func insertSection() {
        let section = Section(index: 0)
        dataSource.insert(section, at: section.index)
    }

    fileprivate func insertSections() {
        let sections = [
            Section(index: 0),
            Section(index: 1),
            Section(index: 2),
        ]

        sections.forEach { section in
            dataSource.insert(section, at: section.index)
        }
    }

    // MARK: - No Insertion

    func testThatNextSectionIdIs0WhenValueDictIsEmpty() {
        XCTAssertEqual(dataSource.nextSectionIndex(), 0)
    }

    func testThatSectionsIsEmptyWhenNoSectionsInserted() {
        XCTAssertTrue(dataSource.sections.isEmpty)
    }

    func testThatCurrentIsNilWhenNoSectionsInserted() {
        XCTAssertNil(dataSource.current)
    }

    // MARK: - With Section(s) Inserted

    func testThatNextSectionIdIsIndexOfInsertedSectionPlus1() {
        insertSection()
        XCTAssertEqual(dataSource.nextSectionIndex(), 1)
    }

    func testThatCurrentIsInsertedSection() {
        insertSection()
        XCTAssertNotNil(dataSource.current)
        XCTAssertEqual(dataSource.current?.index, 0)
    }

    func testThatSectionsContainsAllInsertedSections() {
        insertSections()
        XCTAssertEqual(dataSource.sections.count, 3)
        XCTAssertEqual(dataSource.sections[0].index, 0)
        XCTAssertEqual(dataSource.sections[1].index, 1)
        XCTAssertEqual(dataSource.sections[2].index, 2)
    }
}
