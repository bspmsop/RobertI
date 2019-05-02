//
//  MyProfileViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 23/04/19.
//  Copyright © 2019 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Reachability

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }
    
    @IBOutlet weak var menuButton: UIButton!
     var hud = MBProgressHUD();
 
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var lanmeView: UIView!
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var emailViw: UIView!
    @IBOutlet weak var pview: UIView!
    @IBOutlet weak var address2vw: UIView!
    @IBOutlet weak var addressvw: UIView!
    @IBOutlet weak var stateVw: UIView!
    @IBOutlet weak var cityviw: UIView!
    @IBOutlet weak var zipVw: UIView!
    
    @IBOutlet weak var updatebtn: UIButton!
    
    
    @IBOutlet weak var usertypefield: UITextFeild!
    
    @IBOutlet weak var fnameField: UITextFeild!
    @IBOutlet weak var lastnameField: UITextFeild!
    @IBOutlet weak var cellnumView: UITextFeild!
    @IBOutlet weak var emailField: UITextFeild!
    @IBOutlet weak var passwordField: UITextFeild!
    @IBOutlet weak var address1fd: UITextFeild!
    @IBOutlet weak var address2fd: UITextFeild!
    @IBOutlet weak var cityfd: UITextFeild!
    @IBOutlet weak var statefd: UITextFeild!
    @IBOutlet weak var zipfd: UITextFeild!
    var stateslistdata = [JSON]();
    var selectedstateid = "";
    
    
    
    func sendAlert(_ msg : String)
    {
        let alert = UIAlertController.init(title: "Alert!", message: msg, preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion:  nil);
        
        
        
    }
    
    
   
    
    func isvalidzipcode(zipcode: String) -> Bool {
        
        
        let emailRegEx = "(^[0-9]{5}(-[0-9]{4})?$)"
        
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let bool = pinPredicate.evaluate(with: zipcode) as Bool
        
        return bool
        
        
        
        
    }
    @IBAction func updateTapped(_ sender: UIButton) {
        
        
        let firstname = fnameField.text!;
        let lastnmae = lastnameField.text!;
        var mobilenum = cellnumView.text!;
         var emailnum = emailField.text!;
         var passowrdnum = passwordField.text!;
         var address1num = address1fd.text!;
         var address2num = address2fd.text!;
         var citynum = cityfd.text!;
         var statenum = statefd.text!;
        var zipnum = zipfd.text!;
        
       
        
        if firstname.isEmpty
        {  sendAlert("Please enter first name");
            return
        }
        else if lastnmae.isEmpty
        {sendAlert("Please enter last name");
            return
        }
        else if mobilenum.isEmpty
        {sendAlert("Please enter  phone number");
            return
        }
        else if mobilenum.count != 10
        {
            sendAlert("Please enter valid phone number");
            return
        }
        else if passowrdnum.isEmpty
        {
            sendAlert("Please enter password");
            return
        }
        
        else if emailnum.isEmpty
        {sendAlert("Please enter email");
            return
        }
        else if !emailnum.contains(".")  ||  !emailnum.contains("@")
        {
            sendAlert("Please enter valid email");
            return
        }
        else if zipnum.isEmpty
        {sendAlert("Please enter zip");
            return
        }
        else if selectedstateid.isEmpty
        {sendAlert("Please select state");
            return
        }
        else if address1num.isEmpty
        {sendAlert("Please enter address1");
            return
        }
        else if citynum.isEmpty
        {
            sendAlert("Please enter city");
            return
        }
        else if  !isvalidzipcode(zipcode: zipnum)
        {
            sendAlert("Please enter valid zip code");
            return
        }
       
        
        
        
        
        
        
        
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
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler:   nil));
                self.present(alert, animated: true, completion: nil);
            }
            
            
            
            return;
        }
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        var paramjson = Dictionary<String, Any>();
        
        
        //mobilenum
        
        
        paramjson["id"] = userid
        paramjson["first_name"] = firstname
        paramjson["last_name"] = lastnmae
        let arraynum = Array(mobilenum);
        var usformateNo = "(";
        for i in 0..<arraynum.count
        {
            
            if i == 3
            {
                usformateNo = usformateNo + ")" + String(arraynum[i])
            }
                
            else  if i == 6
            {
                usformateNo = usformateNo + "-" +   String(arraynum[i])
                
            }
            else
            {
                usformateNo =   usformateNo + String(arraynum[i])
                
            }
            
            
        }
        print(usformateNo)
        paramjson["phone"] = usformateNo;
       
        paramjson["email"] = emailnum
         paramjson["password"] = passowrdnum
         paramjson["address1"] = address1num
         paramjson["address2"] = address2num
         paramjson["city"] = citynum
         paramjson["state"] = selectedstateid
         paramjson["zip"] = zipnum
        
        
        
        
        
       
        
        
        
     
        
        
        
        print(myProfileupdate);
        
        Alamofire.request(myProfileupdate, method: .post, parameters : paramjson).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                let alert = UIAlertController.init(title: translator("Success!"), message: translator("User added successfully"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.navigationController?.popViewController(animated: true);
                    
                }))
                
                
                self.present(alert, animated: true, completion: nil);
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                }
                
                
            }}
        
        
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
        
        
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi = "\(vUseraaddCompaniesAPI)\(userid)/\(usertype)"
        print(buildingdetailapi)
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                isOfflineMode = false
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                
                let datainfo = buildinginfo["data"].arrayValue
                if datainfo.count > 0
                {
                    
                    
                    DispatchQueue.main.async {
                        let uid = cachem.string(forKey: "userType")!
                        if uid == "0" || uid == "4"
                        {
                            
                        }
                        else
                        {
                            
//                            self.compnayField.text = datainfo[0]["companyName"].stringValue
//                            self.comId = datainfo[0]["id"].stringValue
//                            self.compnayField.textColor = UIColor.lightGray;
                        }
                        
                        //self.companieslistt = datainfo;
                        
                        
                        self.hud.hide(animated: true);
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        
                    }
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("No companies are added"), preferredStyle: .alert);
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
        updatebtn.layer.cornerRadius = 4.0;
        addGrayBorders([lanmeView, zipVw, cityviw, stateVw, addressvw,address2vw, pview, fnameView, cellview, emailViw, userView])
        netReach.stopNotifier();
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
       
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            
        }
        self.navigationController?.navigationBar.isHidden = true;
        CompatibleStatusBar(self.view);
        callingBuildingDetail()
    }
}
