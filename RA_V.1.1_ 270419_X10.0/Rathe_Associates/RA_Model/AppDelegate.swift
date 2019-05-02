//
//  AppDelegate.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

import SwiftyStoreKit
import Reachability
import Alamofire
import UserNotifications
import IQKeyboardManager
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        
        
        defaultSettings(application, launchOptions)
        
        return true
    }

    
    let cache = UserDefaults.standard;
    
    
   
    
    
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
    }

    
    func defaultSettings(_ app : UIApplication, _ opt : [UIApplicationLaunchOptionsKey: Any]?)
    {
        
       // no delete company
//        Admin -> 0
//        Rathe Admin -> 4 all except sub
//
//        Building Manager -> 2 
//        Corporate Manager -> 3 sub notifi, no company adding,
//
       // Super -> 1
       
        self.cache.set("en", forKey: "lang")
        self.cache.set(DlData, forKey: "dlang");
        
        
        
        let isExist = fileManag.fileExists(atPath: getPath(fileName: locale_DB));
        if !isExist
        {
            do{
                
                let BundlefileURL = Bundle.main.resourceURL;
               // let BundlefilePath = BundlefileURL!.appendingPathComponent("Rathe_Associates/RA_Model/FMDatabase.sqlite")
                let BundlefilePath = BundlefileURL!.appendingPathComponent(bundle_DB)
                
            let defaultPath = getPath(fileName: locale_DB)
                print(BundlefilePath.path);
            try fileManag.copyItem(atPath: BundlefilePath.path, toPath: defaultPath )
                print("file copied");
            }
            catch
            {
                print("Unable to copy the  file");
            }
        }
        else
        {
            print("file exists");
        }
        
        
        IQKeyboardManager.shared().isEnabled = true
        
        
        window = UIWindow.init()
        viewWindow = window!
        let status = cache.bool(forKey: logstatus)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { ( isgranted, ero) in
            
            if isgranted
            {
                UIApplication.shared.registerForRemoteNotifications();
                
            }
            
            
            
            
            
        }
        
        
        
        
        
      
       
        
        
        
        
        if status != false
        {
            let typeOfUser = cache.string(forKey: "userType")




            if typeOfUser == "0" || typeOfUser == "2" || typeOfUser == "3"  || typeOfUser == "4"
            {
                
                
                let vController = UIStoryboard(name: "SubMain", bundle: nil).instantiateViewController(withIdentifier: "RevealViewController")
                window!.rootViewController = vController;
                
                
            }
            else if typeOfUser == "1"
            {
                
                let vController = UIStoryboard(name: "super", bundle: nil).instantiateViewController(withIdentifier: "superRevealViewController");
                 window!.rootViewController = vController;
            }
            else{
                
                
                let controlller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInNav")
                window!.rootViewController = controlller;
                
                
            }




        }
        else
        {
            let controlller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInNav")
            window!.rootViewController = controlller;
        }
    }
    
    
    func movetokentoserver(_ uidid : String)
    {
        
        var pjson = Dictionary<String, Any>();
        pjson["token"] = uidid;
        let vCustomInspectionSaveAsAPIss = registrationStatesAPI;
        print(vCustomInspectionSaveAsAPIss);
        Alamofire.request(vCustomInspectionSaveAsAPIss, method: .get, parameters: pjson).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            
        }
        
        
    }
    
    
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        print("register remote notification device token");
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined();
        print(token);
        
         cache.set(token, forKey: "userdto")
        movetokentoserver(token);
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}

