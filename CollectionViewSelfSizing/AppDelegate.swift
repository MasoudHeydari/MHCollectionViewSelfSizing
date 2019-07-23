//
//  AppDelegate.swift
//  CollectionViewSelfSizing
//
//  Created by Masoud Heydari on 2019-07-23.
//  Copyright © 2019 Masoud Heydari. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupApp()
        return true
    }

    private func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootViewController = ViewController()
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
    }

}
