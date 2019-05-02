//
//  RegistrationViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON
import Reachability

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }

    @IBOutlet weak var myscroller: UIScrollView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var infoImg: UIImageView!
    let statepickerview = UIPickerView();
    @IBOutlet weak var _firstName: UITextField!
    @IBOutlet weak var _lastName: UITextField!
    var pickerDataList = Array<JSON>();
    @IBOutlet weak var _companyName: UITextField!
    @IBOutlet weak var _titleName: UITextField!
    @IBOutlet weak var _emailAddress: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var cPassword: UITextField!
    @IBOutlet weak var _address: UITextField!
    @IBOutlet weak var _address2: UITextField!
    @IBOutlet weak var _city: UITextField!
    @IBOutlet weak var _state: UITextField!
    @IBOutlet weak var _zip: UITextField!
    @IBOutlet weak var _phone: UITextField!
    @IBOutlet weak var _AccountType: UITextField!
    @IBOutlet weak var _subscriptionRequested: UITextField!
    
    
    let viw = UIView();
    let tview = UITextView();
    var arrRes = [[String:AnyObject]]()
   var statesLists = Array<JSON>();
    var stateid = "";
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        pickerView.backgroundColor = UIColor.black;
        
        let attributed = NSAttributedString.init(string: pickerDataList[row]["name"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        
        return attributed;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.backgroundColor = UIColor.black;
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView.backgroundColor = UIColor.black;
        
        return pickerDataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.backgroundColor = UIColor.black;
        if row < pickerDataList.count{
           _state.text = pickerDataList[row]["name"].stringValue;
             stateid = pickerDataList[row]["id"].stringValue;
        }
    }
    
    
    
    
    @objc func popuptapped(_ sender: UITapGestureRecognizer) {
        
        
        tview.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width * 0.8, height: viw.frame.height);
        tview.backgroundColor = UIColor.clear;
        
        
        let mystr = NSMutableAttributedString.init(string: "Super:", attributes: [NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue", size: 18)!])
        let mystr1 = NSMutableAttributedString.init(string: " Access to their mechanical rooms \n \n", attributes: [NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue-Light", size: 17.0)!])
        let mystr2 = NSMutableAttributedString.init(string: "Building Manager:", attributes: [NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue", size: 18)!])
        let mystr3 = NSMutableAttributedString.init(string: " Manages Supers and mechanical rooms. \n \n", attributes: [NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue-Light", size: 17.0)!])
        let mystr4 = NSMutableAttributedString.init(string: "Corporate manager:", attributes: [NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue", size: 18)!])
        let mystr5 = NSMutableAttributedString.init(string: " Manages all users, buildings, mechanical rooms and equipment \n", attributes: [NSAttributedString.Key.font : UIFont.init(name: "HelveticaNeue-Light", size: 17.0)!])
        mystr.append(mystr1);
        mystr.append(mystr2);
        mystr.append(mystr3);
        mystr.append(mystr4);
        mystr.append(mystr5);
        tview.attributedText = mystr;
        tview.textColor = UIColor.init(hexString: "8E908E")
        
        viw.addSubview(tview);
        viw.backgroundColor =  UIColor.init(hexString: "F1F1F1");
        
        
        
        viw.isHidden = !viw.isHidden
        
        
        
        self.view.endEditing(true);
        
    }
    
    
    
    func checkvalidation() -> Dictionary<String, String>
    {
        var dict = ["msg" : "", "status" : "0"]
        let fname = _firstName.text!
        let lnames = _lastName.text!
        let comname = _companyName.text!;
        let titleN = _titleName.text!
        let emailN = _emailAddress.text!
        let passn = _password.text!;
        let cpassn = cPassword.text!
        let address1N = _address.text!
        let address2N = _address2.text!
        let cityN = _city.text!
        let stateN = _state.text!;
        let zipN = _zip.text!;
        let phoneN = _phone.text!;
        
        if fname.isEmpty
        {
            dict["msg"] = "Please enter first name";
            dict["status"] = "1"
            
        }
        else if lnames.isEmpty
        {
            dict["msg"] = "Please enter last name";
            dict["status"] = "1"
            
        }
        else if comname.isEmpty
        {
            dict["msg"] = "Please enter company name";
            dict["status"] = "1"
            
        }
        else if titleN.isEmpty
        {
            dict["msg"] = "Please enter title";
            dict["status"] = "1"
            
        }
        else if phoneN.isEmpty
        {
            dict["msg"] = "Please enter phone number";
            dict["status"] = "1"
            
        }
        else if phoneN.count != 10
        {
            dict["msg"] = "Please enter valid 10 digit phone number";
             dict["status"] = "1"
        }
        else if emailN.isEmpty
        {
            dict["msg"] = "Please enter email address";
            dict["status"] = "1"
            
        }
            else if !emailN.contains(".") || !emailN.contains("@")
        {
            dict["msg"] = "Please enter valid email address";
            dict["status"] = "1"
            
            
            
        }
        else if stateN.isEmpty || stateid.isEmpty
        {
            dict["msg"] = "Please enter state";
            dict["status"] = "1"
            
        }
        else if cityN.isEmpty
        {
            dict["msg"] = "Please enter city";
            dict["status"] = "1"
            
        }
        else if zipN.isEmpty
        {
            dict["msg"] = "Please enter zip";
            dict["status"] = "1"
            
        }
        else if !isvalidzipcode(zipN)
        {
            dict["msg"] = "Please enter valid zip code";
            dict["status"] = "1"
            
        }
            
        else if address1N.isEmpty
        {
            dict["msg"] = "Please enter address1";
            dict["status"] = "1"
            
        }
        else if address2N.isEmpty
        {
            dict["msg"] = "Please enter address2";
            dict["status"] = "1"
            
        }
        else if passn.isEmpty
        {
            dict["msg"] = "Please enter password";
            dict["status"] = "1"
            
        }
        else if !passwordValidateion(passn)
        {
            dict["msg"] = "Password must constains atleast one uppercase letter and one special character";
            dict["status"] = "1"
            
        }
        else if cpassn.isEmpty
        {
            dict["msg"] = "Please enter confirm password";
            dict["status"] = "1"
            
        }
        else if passn != cpassn
        {
            dict["msg"] = "Password and confirm password does not match";
            dict["status"] = "1"
            
        }
       
        
        
        
      
        return dict;
        
        
    }
    
    
    
    
    
    
    @IBAction func submitTapped(_ sender: Any) {
         resignFields()
        let hud:MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
         hud.bezelView.color = UIColor.lightGray;
          hud.bezelView.style = .solidColor
          let checkNetwork = Reachability()!;
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                hud.hide(animated: true);
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check your network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler:   nil));
                self.present(alert, animated: true, completion: nil);
            }
            
            return;
        }
        
      let mydict =  checkvalidation()
        let validcheck = mydict["status"]!
        
        if validcheck == "1"
        {
            hud.hide(animated: true)
            let alert = UIAlertController(title: "Alert", message: mydict["msg"]!, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        let arraynum = Array(_phone.text!);
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
        
            var paramjson = Dictionary<String, String>();
            paramjson["first_name"] = _firstName.text!
            paramjson["last_name"] = _lastName.text!
            paramjson["company_name"] = _companyName.text!
            paramjson["title"] = _titleName.text!;
            paramjson["address1"] = _address.text!
            paramjson["address2"] = _address2.text!
            paramjson["city"] =  _city.text!
            paramjson["state"] = stateid
            paramjson["zip"] = _zip.text!
            paramjson["phone"] = usformateNo
            paramjson["email"] = _emailAddress.text!
            paramjson["password"] = _password.text!
            paramjson["password_confirmation"] = cPassword.text!
        print(paramjson);
        print(registrationApi);
            Alamofire.request(registrationApi, method: .post, parameters : paramjson).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    let mydon = JSON(resp.result.value!)
                    let status = mydon["status"].stringValue
                    let mess = mydon["msg"].stringValue
                    if status == "200"
                    {
                        let alert = UIAlertController.init(title: translator("Success!"), message: translator("Registration completed"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            self.performSegue(withIdentifier: "valid", sender: self);
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                    }
                    else
                    {
                        
                        DispatchQueue.main.async {
                            
                            hud.hide(animated: true);
                            let alert = UIAlertController.init(title: translator("Alert"), message: mess, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                isOfflineMode = true;
                                
                                //  self.getOfflineBuildingData()
                                
                                
                            }))
                            
                            
                            self.present(alert, animated: true, completion: nil);
                        
                    }
                    
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                         hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            //  self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
            
            
            
            
   
        
        
       
        
        
        
        
    }
    
    
    func resignFields()
    {
        _firstName.resignFirstResponder();
        _lastName.resignFirstResponder();
        _companyName.resignFirstResponder();
        _emailAddress.resignFirstResponder();
        _password.resignFirstResponder();
        cPassword.resignFirstResponder();
        _address.resignFirstResponder();
        _address2.resignFirstResponder();
        _city.resignFirstResponder();
        _state.resignFirstResponder();
        _zip.resignFirstResponder();
        _phone.resignFirstResponder();
        _AccountType.resignFirstResponder();
        _subscriptionRequested.resignFirstResponder();
        
        
        
        
        
    }
    
    
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "signInBack", sender: self);
        
        
    }
    
    func isvalidzipcode(_ zipcode: String) -> Bool {
        
        
        let emailRegEx = "(^[0-9]{5}(-[0-9]{4})?$)"
        
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let bool = pinPredicate.evaluate(with: zipcode) as Bool
        
        return bool
        
        
        
        
    }
   
    func passwordValidateion(_ passworder: String) -> Bool {
        
        
        let emailRegEx = "(^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^(w(s]).{8,}$)"
        
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let bool = pinPredicate.evaluate(with: passworder) as Bool
        
        return bool
        
        
        
        
    }
    
    func callingBuildingData()
    {
        
       let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            //getOfflineBuildingData()
            DispatchQueue.main.async {
                hud.hide(animated: true);
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check your network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler:   nil));
                self.present(alert, animated: true, completion: nil);
            }
            
            
            return;
        }
        
        
        
        //registrationStatesAPI
        
        
        let companylists = registrationStatesAPI
        
        Alamofire.request(companylists, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
               
                DispatchQueue.main.async {
                    print(resp.result.value)
                    let resultdata =  JSON(resp.result.value!);
                    hud.hide(animated: true);
                    isOfflineMode = false
                    
                    
                    self.statesLists = resultdata["states"].arrayValue;
                    self.pickerDataList = self.statesLists
                    self.statepickerview.reloadAllComponents();
                }
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                     hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        
                        self.callingBuildingData();
                        
                        
                        
                    }))
                    alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    //--------  Default Func
    func loadingDefaultUI()
    {
        
        
        submitBtn.layer.cornerRadius = 5.0;
        submitBtn.clipsToBounds = true;
        
        viw.frame = CGRect.init(x: 0, y: 995, width: self.view.frame.width * 0.8 , height: 220);
        
        viw.center.x = self.view.center.x
        
        viw.layer.cornerRadius = 3.0;
        
        viw.layer.borderWidth = 1.0
        viw.layer.borderColor = UIColor.lightGray.cgColor;
        
        viw.isHidden = true;
        tview.isEditable = false;
        statepickerview.dataSource = self;
        statepickerview.delegate = self;
        _state.inputView = statepickerview;
        
        
        myscroller.addSubview(viw);
        
        let path = UIBezierPath()
        let path1 = UIBezierPath()
        let shapeLayer = CAShapeLayer()
        let shapeLayer1 = CAShapeLayer()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 8, y: -12))
        path.addLine(to: CGPoint(x: 16, y: 0))
        shapeLayer.path = path.cgPath;
        
        path1.move(to: CGPoint(x: 0, y: 1))
        path1.addLine(to: CGPoint(x: 0, y: -1.5))
        path1.addLine(to: CGPoint(x: 16, y: -1.5))
        path1.addLine(to: CGPoint(x: 16, y: 1))
        shapeLayer1.path = path1.cgPath;
        
        shapeLayer.strokeColor = UIColor.lightGray.cgColor;
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.init(hexString: "F1F1F1")?.cgColor;
        shapeLayer.position = CGPoint.init(x: (self.view.frame.width * 0.8 - 22), y: 0)
        
        shapeLayer1.strokeColor = UIColor.clear.cgColor;
        shapeLayer1.fillColor = UIColor.init(hexString: "F1F1F1")?.cgColor;
        shapeLayer1.position = CGPoint.init(x: (self.view.frame.width * 0.8 - 22), y: 1)
        
        viw.layer.addSublayer(shapeLayer);
        viw.layer.addSublayer(shapeLayer1);
        infoImg.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(popuptapped(_:))))
        CompatibleStatusBar(self.view);
        callingBuildingData()
        
    }
    
    
    

    

}
