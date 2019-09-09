//
//  AppDelegate.swift
//  Europe
//
//  Created by Riccardo on 08/09/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        loadCoordinator()
        
        return true
    }

    private func loadCoordinator() {
        
        let navController = UINavigationController()
        
        coordinator = Coordinator(with: navController)
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

