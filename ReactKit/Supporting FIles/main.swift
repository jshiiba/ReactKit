//
//  main.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//
import Foundation
import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil

if isRunningTests {
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(
                to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc)),
        nil,
        NSStringFromClass(TestingAppDelegate.self)
    )
} else {
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(
                to: UnsafeMutablePointer<Int8>.self,
                capacity: Int(CommandLine.argc)),
        nil,
        NSStringFromClass(AppDelegate.self)
    )
}
