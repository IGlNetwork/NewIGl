//
//  AppDelegate.swift
//  IGL
//
//  Created by Mac Min on 26/09/18.
//  Copyright © 2018 Mac Min. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

// MARK:- For Push Notification
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import UserNotifications  // For Local Notification

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
   
    let cometChat : CometChat = CometChat();
    let licenseKey: String = "COMETCHAT-QQWLI-A1O8B-MAQIT-PBIZQ";
    let apiKey: String = "53496x614953047c26aaa7ac08222ceae01f35";
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.cometChat.initializeCometChat("", licenseKey:licenseKey, apikey:apiKey, isCometOnDemand:true,
        success: {(response) in
            print("Success Initialization cometChat.......")
        },failure:{(error) in
            print("Error Initialization cometChat.......")
        })
        //  import IQKeyboardManagerSwift
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
       
         let notificationCenter = UNUserNotificationCenter.current()
        // It is For Notification Allow Authentications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
            
            guard isGranted else { return }
            self.getNotificationSettings()
            if err != nil {
                //Something bad happend
            } else {
                print(" if err != nil else......")
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self   // it is very important to Generate Firebase registration token, otherwise "didReceiveRegistrationToken" method will not called.
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        FirebaseApp.configure()
        
        
        
        
        
        let storyboardobj = UIStoryboard(name: "Main", bundle: nil)
        let SwreavelObj = storyboardobj.instantiateViewController(withIdentifier:"SW-Reaveal") as! SWRevealViewController
        
        let storyboardobj1 = UIStoryboard(name: "Main", bundle: nil)
        let LoginVC = storyboardobj1.instantiateViewController(withIdentifier:"LoginViewController") as! LoginViewController
    
        if UserDefaults.standard.value(forKey: "isLoggedIn") == nil
        {
            UserDefaults.standard.set("0", forKey: "isLoggedIn")
          // self.window?.rootViewController?.present(LoginVC, animated: true, completion: nil)
              self.window?.rootViewController = LoginVC
            print("AppDelegate LoginEmail Value in UserDefault:::::::::::::::::",UserDefaults.standard.value(forKey: "isLoggedIn") as! String)
        }
        else if UserDefaults.standard.value(forKey: "isLoggedIn") as! String == "1"
        {
            self.window?.rootViewController = SwreavelObj   //?.present(TeamViewController, animated: false, completion: nil)
        }
        else if UserDefaults.standard.value(forKey: "isLoggedIn") as! String == "0"
        {
            self.window?.rootViewController?.present(LoginVC, animated: true, completion: nil)
        }
        
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        let appId: String = FBSDKSettings.appID()
//        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
//            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
//        }
//        return false
//    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async(execute: { UIApplication.shared.registerForRemoteNotifications() })
        }
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String)
    {
        
        print("Firebase registration token::::::: \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "deviceToken")
    }
    
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {    print("Device Token...... = ", deviceToken)
        // Convert token to string
        let chars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var token = ""
        for i in 0..<deviceToken.count
        {
            token += String(format: "%02.2hhx", arguments: [chars[i]])
        }
        print("Token2222222222222222222222222...... = ", token)
        
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //NSLog("[RemoteNotification] applicationState: \(applicationStateString) didReceiveRemoteNotification for iOS9: \(userInfo)")
        if UIApplication.shared.applicationState == .active {
            //TODO: Handle foreground notification
        } else {
            //TODO: Handle background notification
        }
    }
    
    // This function will be called when the app receive notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // show the notification alert (banner), and with sound
        completionHandler([.alert, .sound])
    }
    
    // This function will be called right after user tap on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // tell the app that we have finished processing the user’s action / response
        
        
        let application = UIApplication.shared
        
        if(application.applicationState == .active){
            print("user tapped the notification bar when the app is in foreground")
            
        }
        
        if(application.applicationState == .inactive)
        {
            print("user tapped the notification bar when the app is in background")
        }
        
        /* Change root view controller to a specific viewcontroller */
        // let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // let vc = storyboard.instantiateViewController(withIdentifier: "ViewControllerStoryboardID") as? ViewController
        // self.window?.rootViewController = vc
        
        completionHandler()
    }
    
    
    
    
    
    
func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "IGL")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

