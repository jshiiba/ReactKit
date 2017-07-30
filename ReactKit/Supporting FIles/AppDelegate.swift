//
//  AppDelegate.swift
//  ReactKit
//
//  Created by Justin Shiiba on 7/5/17.
//  Copyright © 2017 Shiiba. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

//        let props = ExampleComponentViewControllerProps(
//            exampleComponentProps: ExampleProps(title: "I change backgrounds!", backgroundColor: .green),
//            labels: [
//                LabelProps(title: "I change text"),
//                LabelProps(title: "I stay the same")
//            ]
//        )
//        let exampleController = ExampleComponentViewController(props: props)

//        let exampleController = LayoutExampleViewController()

        let exampleController = ReduxViewController()

        let nav = UINavigationController(rootViewController: exampleController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
