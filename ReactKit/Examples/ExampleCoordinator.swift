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

    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }

    func present(in window: UIWindow) {
        let exampleTableViewController = ExampleTableViewController()
        exampleTableViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: exampleTableViewController)

        window.rootViewController = navigationController
        rootViewController = window.rootViewController
    }
}

// MARK: - ExampleTableViewControllerDelegate

extension ExampleCoordinator: ExampleTableViewControllerDelegate {
    func didSelectLayoutExample() {
        let layoutExample = LayoutExampleViewController()

        navigationController?.pushViewController(layoutExample, animated: true)
    }

    func didSelectReduxExample() {
        let reduxExample = ReduxViewController()

        navigationController?.pushViewController(reduxExample, animated: true)
    }
}
