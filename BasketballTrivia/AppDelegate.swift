//
//  AppDelegate.swift
//  BasketballTrivia
//
//  Created by IOS on 18/02/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

//@available(iOS 13.0, *)


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        IQKeyboardManager.shared.enable = true
        
        if UserDefaults.standard.value(forKey: "userId") != nil
        {
            if "\(UserDefaults.standard.value(forKey: "userId")!)" != ""
            {
                let loginView = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                loginView.setViewControllers([vc], animated: true)
                self.window!.rootViewController = loginView
            }
            else
            {
                let loginView = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                loginView.setViewControllers([vc], animated: true)
                self.window!.rootViewController = loginView
            }
        }
        else
        {
            let loginView = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            loginView.setViewControllers([vc], animated: true)
            self.window!.rootViewController = loginView
        }
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    //    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    //        // Called when a new scene session is being created.
    //        // Use this method to select a configuration to create the new scene with.
    //        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    //    }
    //
    //    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    //        // Called when the user discards a scene session.
    //        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    //        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    //    }
    
    
}

