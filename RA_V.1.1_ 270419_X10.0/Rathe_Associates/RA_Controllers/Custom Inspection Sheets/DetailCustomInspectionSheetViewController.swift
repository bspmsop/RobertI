//
//  DetailCustomInspectionSheetViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 23/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import SwiftHEXColors
import SwiftyJSON
import Alamofire
import MBProgressHUD
import Reachability


class DetailCustomInspectionSheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loadingDefaultUI();
    }

    @IBOutlet weak var comtitle: UITextFeild!
    @IBOutlet weak var mechtitle: UITextFeild!
    @IBOutlet weak var insformname: UITextFeild!
    @IBOutlet weak var interval: UITextFeild!
    
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var myscroller: UIScrollView!
     var hud = MBProgressHUD();
    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var insView: UIView!
    @IBOutlet weak var intervalView: UIView!
    @IBOutlet weak var insNameheader: UILabel!
    
    var sinspectioon_id = "";
     var sinspectioon_name = "";
     let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true);
        
        
    }
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    
    
    @IBAction func previewBtnTapped(_ sender: UIButton) {
        
            hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            
            
            
            let checkNetwork = Reachability()!;
            
            
            if checkNetwork.connection == .none
            {
                DispatchQueue.main.async {
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: "Network Alert!", message: "Please check network connection and try again", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil);
                }
                
                // getOfflineBuildingData()
                return;
            }
            
            
            //let userid = cachem.string(forKey: "userid")!
            let usertype = cachem.string(forKey: "userType")!;
            
            let buildingdetailapi = "\(vCustomInspectionPreviewAPI)\(sinspectioon_id)/\(usertype)"
            print(buildingdetailapi);
            Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    print(resp.result.value!)
                    let buildinginfo =  JSON(resp.result.value!)
                    let sectiondataa = buildinginfo["sections"].arrayObject
                    if sectiondataa != nil
                    {
                        
                        let sdata = sectiondataa as? Array<Dictionary<String, Any>>
                        if sdata != nil
                        {
                            isOfflineMode = false
                            
                            DispatchQueue.main.async {
                                
                                // var sectionData : Array<Dictionary<String, Any>> = [["head" : "", "order" : "1", "ncolumns" : "1", "fields": [["label":"", "order" : "1", "itype" : "1","typename": "Text box", "ioptions" : "", "required" : "1", "ivalids" : "2", "idefault" : ""]]]];
                                let vController = self.storyboard?.instantiateViewController(withIdentifier: "InitialPreviewController") as! InitialPreviewController;
                                vController.loadedData = sdata!
                                vController.headertitleText =   self.insformname.text!
                                
                                self.navigationController?.pushViewController(vController, animated: true);
                                
                                self.hud.hide(animated: true);
                            }
                            
                            
                        }
                        else{
                            
                            DispatchQueue.main.async {
                                
                                self.hud.hide(animated: true);
                                
                            }
                            
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Unsupported Preview"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                isOfflineMode = true;
                                
                                //  self.getOfflineBuildingData()
                                
                                
                            }))
                            
                            
                            self.present(alert, animated: true, completion: nil);
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    else{
                        
                        DispatchQueue.main.async {
                            
                            self.hud.hide(animated: true);
                            
                        }
                        
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Unsupported Preview"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            //  self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                    }
                    
                    
                   
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        
                    }
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
       
        
    }
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        
        
        if Gmenu.count > 2
        {
            let isread =  Gmenu[2]["isread"]!
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditCustomInspectionSheetViewController") as! EditCustomInspectionSheetViewController
        vController.sinspectioon_id = self.sinspectioon_id;
        vController.sinspectioon_name = self.sinspectioon_name;
        self.navigationController?.pushViewController(vController, animated: true);
    }
    
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        
        
        
        
        if Gmenu.count > 2
        {
            let isnodele =  Gmenu[2]["isnodelete"]!
            let isread = Gmenu[2]["isread"]!
            if isnodele == "1" || isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        
        alertview.cancelBtn.layer.cornerRadius = 4.0
        alertview.deleteBtn.layer.cornerRadius = 4.0
        alertview.frame = self.view.frame;
        alertview.descText.text = "You are about to delete \(sinspectioon_name) custom inspection form.";
        self.view.addSubview(alertview);
        alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.deleteBtn.addTarget(self, action: #selector(deleteInspectionTapped(_:)), for: .touchUpInside);
        
    }
    
    
    @objc func deleteInspectionTapped(_ sender : UIBotton)
    {
        alertview.removeFromSuperview();
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        let buildingdetailapi = "\(vCustomInspectionDeleteAPI)\(sinspectioon_id)"
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =  buildingdetailapi
                    let jdata =  deleteapidata
                    
                    let savestatsu =   saetolocaldatabase(jdata, "deletebuilding");
                    if savestatsu
                    {
                        let alert = UIAlertController.init(title: "Success", message: "Successfully saved to local database", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                            self.navigationController?.popViewController(animated: true);
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
            
            // getOfflineBuildingData()
            return;
        }
        
        
        
        
        
        
        
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                let rjson = JSON(resp.result.value!);
                let status = rjson["status"].stringValue
                if resp.result.isSuccess && status == "200"
                {
                    isOfflineMode = false
                    
                    let alerrt = UIAlertController.init(title: "Success!", message: "Inspection deleted successfully", preferredStyle: .alert);
                    alerrt.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                        
                        self.navigationController?.popViewController(animated: true);
                        
                        
                    }));
                    self.present(alerrt, animated: true, completion: nil);
                    
                    
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed!"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Try Again"), style: .default, handler: { (_) in
                            self.deleteInspectionTapped(sender)
                            //  self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                            
                        }))
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                }
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Failed"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    func callingInspectionDetailData()
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
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil);
            }
            
            // getOfflineBuildingData()
            return;
        }
        
        
         let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi = "\(vCustomInspectionDetailAPI)\(userid)/\(usertype)/\(sinspectioon_id)"
        print(buildingdetailapi);
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                
             let tempdata = buildinginfo["template"]
                if tempdata != JSON.null
                {
                   
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                       
                        self.comtitle.text = tempdata["cname"].stringValue
                        self.mechtitle.text = tempdata["mtitle"].stringValue
                        self.insformname.text = tempdata["name"].stringValue
                        self.interval.text = tempdata["ctime"].stringValue
                        self.insNameheader.text = tempdata["name"].stringValue
                         self.myscroller.isHidden = false;
                        
                        
                        self.hud.hide(animated: true);
                    }
                    
                    
                }
                else
                {
                    
                    
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        
                    }
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    
                }
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    
                    //  self.getOfflineBuildingData()
                    
                    
                }))
                
                
                self.present(alert, animated: true, completion: nil);
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    func loadingDefaultUI()
    {
        
        
        addGrayBorders([intervalView, insView, cView, mView])
        CompatibleStatusBar(self.view);
        myscroller.isHidden = true;
        callingInspectionDetailData();
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
    }
    
    
    
    
    
    
    
    

}
