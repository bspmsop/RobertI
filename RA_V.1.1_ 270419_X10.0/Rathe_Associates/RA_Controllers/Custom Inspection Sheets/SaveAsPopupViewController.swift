//
//  SaveAsPopupViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 30/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import ScrollingFollowView
import MBProgressHUD
import SwiftyJSON
import Reachability

import FMDB
import MobileCoreServices
import PEPhotoCropEditor



class SaveAsPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDefaultUI()
        
    }
    
    var isfrominspection = true;
   
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var backview: UIView!
    var sinsid = "";
    @IBOutlet weak var formName: UITextFeild!
    var cinshud = MBProgressHUD();
    
    
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        let fornameer = formName.text!
        
        
        if fornameer.isEmpty
        {
            let alert = UIAlertController.init(title: "Alert!", message: "Please enter form name", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
            self.present(alert, animated: true, completion: nil);
            return;
            
        }
        
        
        var pjson = Dictionary<String, Any>();
        var vCustomInspectionSaveAsAPIss = "";
        
        var insptertab = "";
        if !isfrominspection
        {
            pjson["uid"] = cachem.string(forKey: "userid")!
            insptertab = "saveaseffieciencytest"
            
            pjson["eff_id"] = sinsid;
            pjson["formName"] = fornameer;
            vCustomInspectionSaveAsAPIss = vEfficiencyTestSaveasAPI
        }
        else{
            insptertab = "custominspectionsaveas"
            pjson["uid"] = cachem.string(forKey: "userid")!
            
            pjson["inspection_id"] = sinsid;
            pjson["formName"] = fornameer;
            vCustomInspectionSaveAsAPIss = vCustomInspectionSaveAsAPI
        }
        print(pjson);
        
        print(vCustomInspectionSaveAsAPIss);
        
        
        let checkNetworks = Reachability()!;
        cinshud = MBProgressHUD.showAdded(to: self.view, animated: true);
        cinshud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        cinshud.bezelView.color = UIColor.white;
        self.cinshud.label.text = "Loading..."
        
        if checkNetworks.connection == .none
        {
            DispatchQueue.main.async {
                self.cinshud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =   JSON(pjson)
                    let jdata =  deleteapidata.description
                    
                    let savestatsu =   saetolocaldatabase(jdata, insptertab);
                    if savestatsu
                    {
                        let alert = UIAlertController.init(title: "Success", message: "Successfully saved to local database", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                            self.dismiss(animated: false, completion: nil)
                        }));
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else{
                        
                        let alert = UIAlertController.init(title: "Failed", message: "Failed to save to local database", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                }))
                self.present(alerts, animated: true, completion: nil);
            }
            
            return;
        }
        
        
        
        Alamofire.request(vCustomInspectionSaveAsAPIss, method: .post, parameters: pjson).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                let resultdata =  JSON(resp.result.value!)
                let statuscode = resultdata["status"].stringValue
                if statuscode == "200"
                {
                    isOfflineMode = false;
                    refreshdata = true;
                    
                    DispatchQueue.main.async {
                        self.cinshud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully copied form sheet"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            self.dismiss(animated: false, completion: nil);
                            
                        }))
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                }
                    
                    
                    // }
                else{
                    DispatchQueue.main.async(execute: {
                        self.cinshud.hide(animated: true);
                        
                        
                        let alert = UIAlertController.init(title: translator("Failed"), message: "Inspection name already exist", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.cinshud.hide(animated: true);
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        
                        
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                })
                
            }
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func canelBtnTapped(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil);
        
        
        
        
    }
    
    
    
    
    
 
func loadingDefaultUI()
{
    deleteBtn.layer.cornerRadius = 5.0;
    cancelBtn.layer.cornerRadius = 5.0;
    backview.layer.cornerRadius = 5.0
    addGrayBorders([backview]);
    cancelBtn.clipsToBounds = true;
    deleteBtn.clipsToBounds = true;
    CompatibleStatusBar(self.view);
    
    if !isfrominspection
    {
        headerTitle.text = "Equipment Test Form Copy"
        
    }
    
    isFromBackGround = true;
    GlobalTimer.backgroundSyn.startSync(self);
    }
    
    
    
}
