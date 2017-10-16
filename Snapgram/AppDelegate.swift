//
//  AppDelegate.swift
//  Snapgram
//
//  Created by Guilherme Souza on 12/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = SignInViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

