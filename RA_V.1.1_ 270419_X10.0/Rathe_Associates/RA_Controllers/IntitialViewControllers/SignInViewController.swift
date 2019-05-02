//
//  SignInViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 22/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import SWRevealViewController



class SignInViewController: UIViewController {
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDefaultUI();
        
        //devicetoken
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        Globalreveal = nil
        GlobalNav = nil
        
    }
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var cancelTextImg: UIImageView!
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var forgotPasswordBtn: UIButton!

    
    
    
    
    let cache = UserDefaults.standard;
    
    
    
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
         _password.text = "";
         emailBox.text = "";
        cancelTextImg.isHidden = true;
        emailImg.isHidden = true;
        self.performSegue(withIdentifier: "forgotPassward", sender: self);
    }
    @objc func cancelTextTaped(_ sender : UITapGestureRecognizer)
    {  _password.text = "";
        cancelTextImg.isHidden = true;
        
        
    }
    
    
    
    @IBOutlet weak var emailImg: UIImageView!
  
    
    @IBAction func emailEntering(_ sender: UITextField) {
        
        
        if sender == emailBox
        {
            
            if emailBox.text == "" || emailBox.text == nil
            {
                emailImg.isHidden = true;
            }
            else
            {
                let emailtext = sender.text
                if emailtext!.contains("@") && emailtext!.contains(".")
                {
                     emailImg.isHidden = false;
                    
                    
                }
                else
                {
                    emailImg.isHidden = true;
                }
                
            }
            
            
            
        }
        else
        {
            if _password.text == ""
            {
                
                cancelTextImg.isHidden = true
                
            }
            else
            {
                cancelTextImg.isHidden = false;
            }
            
            
            
            
        }
        
        
       
        
        
        
    }
    
    
    
    
    
    
    
    @IBAction func registerBtnTappd(_ sender: UIButton) {
        self.performSegue(withIdentifier: "register", sender: self);
    }
    
    @objc func  ClosedView(_ sender : UITapGestureRecognizer)
    {
    
        self.view.endEditing(true);
    
    }
    
    var hud = MBProgressHUD();
    @IBAction func signInTapped(_ sender: UIButton) {
        
        emailBox.resignFirstResponder()
         _password.resignFirstResponder()
        
        
        
        if(emailBox.text == "" || _password.text == "")
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter all the fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        else
        {
            let parameters: Parameters=[
                "username":emailBox.text!,
                "password":_password.text!
            ]
              hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            print("got paramsas \(parameters)  api is \(loginApi)")
            Alamofire.request(loginApi, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        print("login response as  \(jsonData)");
                        let error = jsonData.value(forKey: "error") as! String
                        if(error=="false"){
                            
                            
                            
                            print(response.result.value);
                            let user = jsonData.value(forKey: "user") as! NSDictionary
                            
                            let userStatus = user.value(forKey: "user_type") as! String
                            let userId = user.value(forKey: "id") as! Int
                            let userName = user.value(forKey: "username") as! String
                            let userEmail = user.value(forKey: "email") as! String
                            let useracess = user.value(forKey: "user_access") as? String
                            if useracess != nil
                            {
                                 self.cache.set(useracess!, forKey: "useraccess")
                            }
                            
                            
                            
                            
                            self.cache.set(userId, forKey: "userid")
                            self.cache.set(userStatus, forKey: "userType")
                            self.cache.set(userName, forKey: "username")
                            self.cache.set(userEmail, forKey: "useremail")
                            
                            
                           
                            self.emailBox.text = "";
                            self._password.text = "";
                           
                            
                          
                            self.getOfflineData(userId, userStatus)
                           
                            
                           
                            
                        }else{
                            self.hud.hide(animated: true);
                            let alert = UIAlertController(title: "Alert", message: "Invalid username or password", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                    }
                    else
                    {
                        self.hud.hide(animated: true);
                        let alert = UIAlertController(title: "Alert", message: "Please check your network and try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }
            }
            
        }
    }
    
    
    
    
    
    
    func getOfflineData(_ id : Int, _ type : String)
    {
        
        let offdataURL = offlineDataAPI + "/\(id)/\(type)"
        print(offdataURL);
         self.hud.label.text = "Downloading..."
        Alamofire.request(offdataURL).responseJSON { (resp) in
            
            DispatchQueue.main.async(execute: {
                
            
            if resp.result.value != nil
            {
                
                let respnese = JSON(resp.result.value!);
                
                let str = respnese.description;
                
                print("printed offline data");
                cachem.set(str, forKey: "offlinedata")
                
                
                isSyncRunning = true;
                
                

                DispatchQueue.global(qos: .background).async {
                    isSyncRunning = true;
                    isFromBackGround = true
                      self.savingtoLocalDataBase(respnese);

                }

  
                
                
                print(type);
                if type == "2" || type == "3"  || type == "0" || type == "4"
                {
                    
                    
                    self.cache.set("en", forKey: "lang")
                    self.cache.set(DlData, forKey: "dlang");
                    
                    
                    self.cache.set(true, forKey: logstatus)
                    self.hud.hide(animated: true);
                    let vController = UIStoryboard(name: "SubMain", bundle: nil).instantiateViewController(withIdentifier: "RevealViewController");
                    self.present(vController, animated: false, completion: nil)
                    
                }
                
                
               else if type == "1"
                {
                    
                    self.cache.set("en", forKey: "lang")
                    self.cache.set(DlData, forKey: "dlang");
                    
                    
                    self.cache.set(true, forKey: logstatus)
                    self.hud.hide(animated: true);
                    let vController = UIStoryboard(name: "super", bundle: nil).instantiateViewController(withIdentifier: "superRevealViewController");
                    self.present(vController, animated: false, completion: nil)
                    
                }
                
                else
                {
                    self.hud.hide(animated: true);
                    
                }
                
                
            }
            else
            {
                self.hud.hide(animated: true);
                let alert = UIAlertController(title: "Alert", message: "An internal error occured please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
             })
            }
        
    }
    
    
    
    
    
    
    
    
    func convertIntoData(_ sender : URL,  _ fileNmae : String) -> Bool
    {
         let myfilePath =  getPath(fileName: fileNmae)
        
        if !fileManag.fileExists(atPath: myfilePath)
        {
            
            
        do
        {
           
            let mydata = try Data.init(contentsOf: sender);
            fileManag.createFile(atPath: myfilePath, contents: mydata, attributes: nil);
             print("saved file");
            
           
            
            return true;
            
        }
        catch
        {
                print(sender);
                print("unabletosave")
                return false
            
        }
        }
        print("already exists");
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func savingtoLocalDataBase(_ jdata : JSON)
    {
        isSyncCompleted = true;
        let buildingsData = jdata["buildings"].arrayObject
        
        if buildingsData != nil
        {
            
        let anyData = buildingsData!
            
            if anyData.count > 0
            {
                
        for vl in 0..<anyData.count
        {
            let builer = anyData[vl] as! Dictionary<String, Any>;
            let mymechDataDuplicate =  builer["mechanicals"] as? Array<Any>
            
            if mymechDataDuplicate != nil
            {
             
                let mymechData =  builer["mechanicals"] as! Array<Any>
                
                if mymechData.count > 0
                {
                  
                for i1 in 0..<mymechData.count
                {
                    
                    let mediator = mymechData[i1] as! Dictionary<String, Any>
                    
                    let equipdataDuplicate = mediator["equipments"] as? Array<Any>
                    
                    if equipdataDuplicate != nil
                    {
                        
                    let equipdata = mediator["equipments"] as! Array<Any>
                    
                      if equipdata.count > 0
                      {
                        
                        
                    
                    for i in 0..<equipdata.count
                    {
                        
                        let mediatro2 = equipdata[i] as! Dictionary<String, Any>
                         let mediatrorDuplicate = mediatro2["drawings"] as? Array<Any>;
                        
                        if mediatrorDuplicate != nil
                        {
                           
                        let mediatror = mediatro2["drawings"] as! Array<Any>;
                        
                            if mediatror.count > 0
                            {
                             
                            
                        for f in 0..<mediatror.count
                        {
                            
                            var media3 =  mediatror[f] as! Dictionary<String, Any>
                            
                            let fileNmaeDulicate = media3["file_path"] as? String;
                            
                            if  fileNmaeDulicate != nil
                            {
                                
                             var fileNmae = media3["file_path"] as! String;
                            
                            
                            fileNmae = fileNmae.replacingOccurrences(of: " ", with: "%20");
                            
                            
                            let fileUrl =  URL.init(string: ImgFilePathAPI + fileNmae)
                            fileNmae = fileNmae.replacingOccurrences(of: "/", with: "_");
                            print(fileNmae);
                             
                            for _ in 0..<4
                            {
                                
                                
                                let result =  convertIntoData(fileUrl!, fileNmae);
                                
                                if result
                                {
                                    break;
                                }
                                
                            }
                            
                             print(vl);
                             print(i1);
                             print(i)
                             print(f);
                             
                            
                                }
                        }
                        }
                        }
                    }
                    }
                 }
            }
                }
            }
        }
        }
        }
        print("im form bottom")
        
         completeSync() 
    }
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func completeSync()
    {
        
        print("sync completed sign in");
        isSyncRunning = false;
        
        isFromBackGround = false;
    }
    
    
    
    
    
    
    
    
    @objc func addShortCode2(_ sender : UIBarButtonItem)
    {
        
        emailBox.text = emailBox.text! + ".com"
        
        
    }
    
    @objc func doneBtnTapped(_ sender : UIBarButtonItem)
    {
        
        self.view.endEditing(true);
        
        
    }
    
    
   
    
    
    
    func loadingDefaultUI()
    {
        
         cancelTextImg.isHidden = true;
         emailImg.isHidden = true;
        let mytool = UIToolbar();
        mytool.tintColor = UIColor.black;
        
        let shortBtn2 = UIBarButtonItem.init(title: ".com", style: .done, target: self, action: #selector(addShortCode2(_:)));
         let doneBtn = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneBtnTapped(_:)));
        let spaceBtn = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        
        mytool.tintColor = .white;
        mytool.setItems([shortBtn2,spaceBtn,doneBtn ], animated: true);
        mytool.sizeToFit();
        mytool.barStyle = .blackTranslucent
        
        
        mytool.isTranslucent = true
        
       //-- emailBox.inputAccessoryView = mytool;
        
        self.navigationController?.navigationBar.isHidden = true;
        signInBtn.layer.cornerRadius = 5.0;
        signInBtn.clipsToBounds = true;
        registerBtn.layer.cornerRadius = 5.0;
        let tapped = UITapGestureRecognizer.init(target: self, action: #selector(cancelTextTaped(_:)))
        cancelTextImg.addGestureRecognizer(tapped);
        let myhop = UITapGestureRecognizer.init(target: self, action: #selector(ClosedView(_:)));
        self.view.addGestureRecognizer(myhop)
        registerBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
         self.view.endEditing(true);
        
        
    }
 }
