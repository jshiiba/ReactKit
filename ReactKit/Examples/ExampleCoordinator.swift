//
//  ExampleCoordinator.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/30/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class ExampleCoordinator {

    var rootViewController: UIViewController?

    func present(in window: UIWindow) {
        let exampleTableViewController = ExampleTableViewController()
        let navigationController = UINavigationController(rootViewController: exampleTableViewController)

        window.rootViewController = navigationController
        rootViewController = window.rootViewController
    }
}
