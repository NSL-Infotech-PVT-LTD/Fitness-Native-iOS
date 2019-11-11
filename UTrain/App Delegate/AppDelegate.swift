//
//  AppDelegate.swift
//  UTrain
//
//  Created by osx on 24/09/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FacebookCore
import FacebookLogin
import GooglePlaces
import GoogleMaps
import SideMenuSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        Thread.sleep(forTimeInterval: 3.0)
     GMSPlacesClient.provideAPIKey("AIzaSyDbJ8lP6uUOsHNa4VzK5_jjPSmGY9k7uPo")
        GMSServices.provideAPIKey("AIzaSyDbJ8lP6uUOsHNa4VzK5_jjPSmGY9k7uPo")
//        if (UserDefaults.standard.value(forKey: "token") as? [String:Any]) == nil{
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            let navigationController = UINavigationController(rootViewController: loginViewController)
//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            appdelegate.window!.rootViewController = navigationController
//
//
//        }else{
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
//            let navigationController = UINavigationController(rootViewController: nextViewController)
//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            appdelegate.window!.rootViewController = navigationController
//
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let appId: String = Settings.appID
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return false
    }

}

