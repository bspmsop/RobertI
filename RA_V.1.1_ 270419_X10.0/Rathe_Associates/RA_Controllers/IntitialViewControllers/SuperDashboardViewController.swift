//
//  SuperDashboardViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 24/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
class SuperDashboardViewController: UIViewController {
    @IBOutlet var mechCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tokenddata = cachem.string(forKey: "userdto")
        if tokenddata != nil
        {
            DispatchQueue.main.async {
                self.movetokentoserver(tokenddata!);
            }
            
            
        }
        
        
        let defaultValues = UserDefaults.standard
        if let mcount = defaultValues.string(forKey: "mcount")
        {
            mechCount.text = mcount
        }
        mechview.isHidden = true;
        loadingDefaultUI()
    }
     var hud = MBProgressHUD();
    @IBOutlet weak var mechview: UIView!
    @IBOutlet weak var menuButton: UIButton!
    func loadingDefaultUI()
    {
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 130;
        }
        self.navigationController?.navigationBar.isHidden = true;
        CompatibleStatusBar(self.view);
        callingDashboardData()
    }
    
    @IBAction func mechroomtapped(_ sender: Any) {
        
        if self.revealViewController() != nil
        {
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MechanicalRoomSignInViewController") as! MechanicalRoomSignInViewController
            let naver = UINavigationController.init(rootViewController: controller);
            self.revealViewController()?.pushFrontViewController(naver, animated: true);
            
            
            
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
            print("sent device token to  server");
            
        }
        
        
    }
    
    
    func callingDashboardData()
    {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check your network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil)
            }
            
            
            return;
        }
        
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vDashboardDataApi)\(userid)/\(usertype)"
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value)
                var fdata =  JSON(resp.result.value!);
                
                isOfflineMode = false
                
                DispatchQueue.main.async {
                    
                    self.mechCount.text = fdata["mcount"].stringValue
                    self.mechview.isHidden = false;
                    
                    self.hud.hide(animated: true);
                }
                
                
                
                
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        
                        self.callingDashboardData();
                        //self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
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
