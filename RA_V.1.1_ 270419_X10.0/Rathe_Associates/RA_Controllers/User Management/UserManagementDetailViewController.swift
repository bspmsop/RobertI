//
//  UserManagementDetailViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 11/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import SwiftHEXColors
import SwiftyJSON
import Alamofire
import MBProgressHUD
import Reachability

class UserManagementDetailViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loadingDefaultUI()
    }
    
    
    
    @IBOutlet weak var detailVw: UIView!
    
   let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
     var hud = MBProgressHUD();
    var selectedUse_id = "";
    
    @IBOutlet weak var uname: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var usertype: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var pushnotification: UILabel!
    
    @IBOutlet var buildingfullBtn: [UIButton]!
    
    
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         warningMessage = "You are about to delete jean@cc.com";
    }
    
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        if Gmenu.count > 10
        {
            let isread =  Gmenu[10]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditUserManagemetViewController") as! EditUserManagemetViewController
        vController.sUser_id = selectedUse_id
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    
    
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        
        
        if Gmenu.count > 10
        {
            let isread =  Gmenu[10]["isread"]!
            let isnodelete =  Gmenu[10]["isnodelete"]!
            
            if isread == "1" || isnodelete == "1"
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
        self.view.addSubview(alertview);
        alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.deleteBtn.addTarget(self, action: #selector(deletebuilding(_:)), for: .touchUpInside);
        alertview.descText.text = "You are about to delete \(self.uname.text!) user";
        
    }
    
    @objc func deletebuilding(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        let Buildingapi = "\(vUseraDeleteAPI)\(selectedUse_id)"
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =    Buildingapi
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
        
        
        
        
        
        
        
        print(Buildingapi)
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                if resp.result.isSuccess
                {
                    isOfflineMode = false
                    
                    let alerrt = UIAlertController.init(title: "Success!", message: "User  deleted successfully", preferredStyle: .alert);
                    alerrt.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                        
                        self.navigationController?.popViewController(animated: true);
                        
                        
                    }));
                    self.present(alerrt, animated: true, completion: nil);
                    
                    
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed!"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            //  self.getOfflineBuildingData()
                            
                            
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
    func callingBuildingDetail()
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
        
        
        //let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi = "\(vUserDetailAPI)\(selectedUse_id)/\(usertype)"
        print(buildingdetailapi)
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
 
                let datam = buildinginfo["data"].arrayValue
                if datam.count > 0
                {
                    let insdata = datam[0];
                    
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                        
                        
                        self.uname.text = insdata["fullname"].stringValue;
                        self.companyName.text = insdata["companyname"].stringValue;
                        self.phoneNum.text = insdata["phone"].stringValue;
                        self.useremail.text = insdata["email"].stringValue;
                        self.usertype.text = insdata["type"].stringValue;
                        self.status.text = insdata["status"].stringValue;
                        self.pushnotification.text = "Push Notifications - \(insdata["notify"].stringValue)";
                        let useraccess = insdata["user_access"].stringValue;
                        let accessarray = useraccess.split(separator: ",")
                        
                        for btn in self.buildingfullBtn
                        {
                            
                            for d in 0..<accessarray.count
                            {
                                
                                if btn.currentTitle! == accessarray[d]
                                {
                                    
                                    switch btn.tag
                                    {
                                    case 0:
                                        btn.setImage(UIImage.init(named: "edit2.png"), for: .normal)
                                    case 1:
                                        btn.setImage(UIImage.init(named: "view2.png"), for: .normal)
                                    case 2:
                                        btn.setImage(UIImage.init(named: "delete2.png"), for: .normal)
                                    default:
                                        print("im default");
                                    }
                                    
                                }
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        self.detailVw.isHidden = false;
                        
                        self.hud.hide(animated: true);
                    }
                    
                    
                    
                }
                else{
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
    
  
    
    func loadingDefaultUI(){
      
        for btn in buildingfullBtn
        {
            btn.setTitleColor(UIColor.clear, for: .normal);
           btn.setImage(UIImage.init(named: "test"), for: .normal)
        }
        
        detailVw.isHidden = true;
        callingBuildingDetail();
        
        
        
        
        
    }
    

}
