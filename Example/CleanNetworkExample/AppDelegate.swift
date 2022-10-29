//
//  AppDelegate.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 15.05.2022.
//

import UIKit
import CleanNetwork

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set a base URL for CLNetworkEndpoint
        CLURLComponent.baseURL = "jsonplaceholder.typicode.com"
        CLNetworkService.shared.config.sharedHeaders = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        return true
    }
}

