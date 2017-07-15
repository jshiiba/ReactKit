//
//  AppDelegate.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let props = ExampleComponentViewControllerProps(
            exampleComponentProps: ExampleProps(title: "Hello world!", backgroundColor: .green),
            labels: [
                LabelProps(title: "Hello again!"),
                LabelProps(title: "I like saying hello!")
            ]
        )
        let exampleController = ExampleComponentViewController(props: props)
        let nav = UINavigationController(rootViewController: exampleController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
