//
//  AppDelegate.swift
//  Pitch Perfect
//
//  Created by Ben Juhn on 8/18/17.
//  Copyright © 2017 Ben Juhn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let recordSoundsVC = RecordSoundsViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window!.rootViewController = UINavigationController(rootViewController: recordSoundsVC)
        window!.makeKeyAndVisible()
        return true
    }

}

