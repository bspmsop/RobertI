//
//  SuperMenuViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 24/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class SuperMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
         loadingDefaultUI()
        
       
    }
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var dashboardView: UIView!
    @IBOutlet weak var mechanicalRoomView: UIView!
    @IBOutlet weak var syncView: UIView!
    @IBOutlet var loginUserName: UILabel!
    @IBOutlet var loginEmail: UILabel!
    @IBOutlet weak var startdash: UIView!
    
    @IBOutlet weak var dlabel: UILabel!
    @IBOutlet weak var syncLabel: UILabel!
    @IBOutlet weak var loguoutLabel: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func chooseLangBtnTapped(_ sender: UIButton) {
        
        /*
        let story = UIStoryboard.init(name: "Main", bundle: nil);
            
        
        let langController = story.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        langController.modalTransitionStyle = .coverVertical;
        
        self.present(langController, animated: true, completion: nil);
         */
       
        
    }
    
    
    
    
    
    
   
    
    
    
    
    
    
    func convertView(myview : UIView)
    {
        
        let views = [dashboardView , mechanicalRoomView, syncView, logoutView, startdash ]
        for viw in views
        {
            if viw == myview
            {
                viw?.backgroundColor = UIColor.init(hexString: "005462");
            }
            else
            {
                viw?.backgroundColor = UIColor.clear;
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        
        let identifier = segue.identifier
        
        
        if identifier == "desktops"
        {
            convertView(myview : startdash)
        }
        else if identifier == "superDash"
        {
            convertView(myview : dashboardView)
        }
        else if identifier == "mechRoom"
        {
            
            convertView(myview : mechanicalRoomView)
        }
        else if identifier == "mypro"
        {
            
            convertView(myview : logoutView)
        }
        else if identifier == "syncSuperSegue"
        {
            convertView(myview : syncView)
        }
        else
        {
            //convertView(myview : logoutView)
            convertView(myview : syncView)
        }
        
    }
    @IBAction func logoutTapped(_ sender: Any) {
        let cache = UserDefaults.standard;
        
        
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()
        
        convertView(myview : syncView);
        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Are you sure  want to logout from the app"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Yes"), style: .destructive, handler: { (_) in
             let fController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInNav");
            cache.set(false, forKey: logstatus);
            if backgroundThred != nil
            {
                backgroundThred?.cancel();
            }
            isEmergencyStop = true;
            netReach.stopNotifier();
            self.present(fController, animated: true, completion: nil)
        }))
       
        alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
        
        
        
    }
    
    
    
    
    
    
    func loadingDefaultUI()
    {
        
        
        let defaultValues = UserDefaults.standard
        if let ulname = defaultValues.string(forKey: "username"){
            loginUserName.text = ulname
        }
        if let uemail = defaultValues.string(forKey: "useremail"){
            loginEmail.text = uemail
        }
        
        
        
        dlabel.text = translator("Mechanical Rooms");
        syncLabel.text = translator("Sync");
        loguoutLabel.text = translator("Logout")
        
        
        
        
    }
    
    
    
    override var shouldAutorotate: Bool{
          return false;
     }
      override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
         return .portrait
         }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {  return .portrait
    }
    
}
