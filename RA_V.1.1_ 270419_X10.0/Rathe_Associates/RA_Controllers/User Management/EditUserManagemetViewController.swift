//
//  EditUserManagemetViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 27/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import SwiftHEXColors
import SwiftyJSON

import Alamofire
import MBProgressHUD
import Reachability

class EditUserManagemetViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI()
    }
    
    
    @IBOutlet weak var aditVw: UIView!
    @IBOutlet weak var ovht: NSLayoutConstraint!
    @IBOutlet weak var compnayField: UITextFeild!
    @IBOutlet weak var comyView: UIView!
    
    
    @IBOutlet weak var accesshview: NSLayoutConstraint!
    var sUser_id = ""
    @IBOutlet weak var comView: UIView!
    @IBOutlet weak var compnayFBtn: UIBotton!
    @IBOutlet weak var companyDeleteBtn: UIBotton!
    @IBOutlet weak var companyRBtn: UIBotton!
    @IBOutlet weak var inctDeleteBtn: UIBotton!
    @IBOutlet weak var inctRBtn: UIBotton!
    var allbtns = [UIBotton]();
     var hud = MBProgressHUD();
    let companyDropDown = UIPickerView();
    let userDropdown = UIPickerView();
    @IBOutlet weak var inctFBtn: UIBotton!
    @IBOutlet weak var eqpformDeleteBtn: UIBotton!
    @IBOutlet weak var eqpformRBtn: UIBotton!
    @IBOutlet weak var eqpformFBtn: UIBotton!
    @IBOutlet weak var userRole: UITextFeild!
    @IBOutlet weak var custFBtn: UIBotton!
    @IBOutlet weak var custDeleteBtn: UIBotton!
    @IBOutlet weak var custRBtn: UIBotton!
    @IBOutlet weak var auditRBtn: UIBotton!
    @IBOutlet weak var auditFBtn: UIBotton!
    @IBOutlet weak var usRBtn: UIBotton!
    @IBOutlet weak var usFullBtn: UIBotton!
    @IBOutlet weak var eqptestFullBtn: UIBotton!
    @IBOutlet weak var eqptestRBtn: UIBotton!
    @IBOutlet weak var eqptestDeleteBtn: UIBotton!
    @IBOutlet weak var signFBtn: UIBotton!
    @IBOutlet weak var signRBtn: UIBotton!
    @IBOutlet weak var insreportFBtn: UIBotton!
    @IBOutlet weak var insreportRBtn: UIBotton!
    @IBOutlet weak var repairFBtn: UIBotton!
    @IBOutlet weak var repairRBtn: UIBotton!
    
    @IBOutlet weak var usDeleteBtn: UIBotton!
    @IBOutlet weak var eqDeleteBtn: UIBotton!
    @IBOutlet weak var eqRBtn: UIBotton!
    @IBOutlet weak var eqFullBtn: UIBotton!
    @IBOutlet weak var muDeleteBtn: UIBotton!
    @IBOutlet weak var muRBtn: UIBotton!
    @IBOutlet weak var meFullBtn: UIBotton!
    @IBOutlet weak var budeleteBtn: UIBotton!
    @IBOutlet weak var buRBtn: UIBotton!
    @IBOutlet weak var sfullBtn: UIBotton!
    @IBOutlet weak var sreadBtn: UIBotton!
    @IBOutlet weak var sdeleteBtn: UIBotton!
    @IBOutlet weak var buFBtn: UIBotton!
    
    @IBOutlet weak var upadateBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var notiView: UIView!
    @IBOutlet weak var uView: UIView!
    @IBOutlet weak var lView: UIView!
    @IBOutlet weak var fView: UIView!
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var eidView: UIView!
    @IBOutlet weak var eView: UIView!
    @IBOutlet weak var pView: UIView!
    @IBOutlet weak var notifulBtn: UIBotton!
    @IBOutlet weak var notireadBtn: UIBotton!
    @IBOutlet weak var notideleteBtn: UIBotton!
    @IBOutlet weak var comfieldsdataview: UIView!
    @IBOutlet weak var comFielddataHt: NSLayoutConstraint!
    @IBOutlet weak var accessView: UIView!
    
    
    @IBOutlet weak var fname: UITextFeild!
    @IBOutlet weak var lname: UITextFeild!
    @IBOutlet weak var phonenum: UITextFeild!
    @IBOutlet weak var empId: UITextFeild!
    @IBOutlet weak var emailAddresss: UITextFeild!
    @IBOutlet weak var pword: UITextFeild!
    @IBOutlet weak var statusswitch: UISwitch!
    @IBOutlet weak var pushSwitch: UISwitch!
    
   
    
    
    var pickerDataList = [JSON]();
    let userRolesData = [["id" : "1", "name" : "Super"],["id" : "2", "name" : "Building Manager"], ["id" : "3", "name" : "Corporate Manager"], ["id" : "4", "name" : "Admin"] ]
    let adminUsers = [["id" : "1", "name" : "Super"],["id" : "2", "name" : "Building Manager"], ["id" : "3", "name" : "Corporate Manager"], ["id" : "4", "name" : "Admin"] ]
    let cormporateUsers = [["id" : "1", "name" : "Super"],["id" : "2", "name" : "Building Manager"], ["id" : "3", "name" : "Corporate Manager"] ]
    let buildingUsers = [["id" : "1", "name" : "Super"] ]
    
    var companieslistt = [JSON]();
    
    var comId = "";
    var roleId = "";
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
       self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == userDropdown
        {
            pickerView.backgroundColor = UIColor.black;
            let attributed = NSAttributedString.init(string: pickerDataList[row]["name"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            return attributed;
        }
        else
        {
            pickerView.backgroundColor = UIColor.black;
            let attributed = NSAttributedString.init(string: pickerDataList[row]["companyName"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            return attributed;
        }
        
        
        
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
        if row < pickerDataList.count
        {
            if pickerView == userDropdown
            {
                roleId = pickerDataList[row]["id"].stringValue
                userRole.text = pickerDataList[row]["name"].stringValue
                
                
                userselectedhere(roleId);
                
                
            }
            else{
                comId = pickerDataList[row]["id"].stringValue
                compnayField.text = pickerDataList[row]["cname"].stringValue
                
                
            }
            
        }
        
        
    }
    
    
    func userselectedhere(_ id : String)
    {
        
        for btn in allbtns
        {
            btn.isSelected = false;
        }
        
        if id == "1"
        {
            comfieldsdataview.isHidden = false;
            comFielddataHt.constant = 66.5
            accessView.isHidden = true;
            ovht.constant = 920;
            
            accesshview.constant = 0.0;
            
        }
        else if id == "4"
        {
            comId = "";
            compnayField.text = "";
            comfieldsdataview.isHidden = true;
            comFielddataHt.constant = 0.0
            aditVw.isHidden = false;
            comyView.isHidden = false;
            notiView.isHidden = false;
            accessView.isHidden = false;
            ovht.constant = 1500
            self.accesshview.constant = 580;
        }
        else   if id == "3"
        {
            // corporate
            
            comfieldsdataview.isHidden = false;
            comFielddataHt.constant = 66.5
            notiView.isHidden = true;
            aditVw.isHidden = false;
            comyView.isHidden = false;
            accessView.isHidden = false;
            ovht.constant = 1500
            self.accesshview.constant = 580;
            
        }
        else   if id == "2"
        {
            //buildingma
            comfieldsdataview.isHidden = false;
            comFielddataHt.constant = 66.5
            notiView.isHidden = true;
            comyView.isHidden = true;
            accessView.isHidden = false;
            ovht.constant = 1500
            aditVw.isHidden = true;
            self.accesshview.constant = 580;
            
        }
            
        else{
            
            accessView.isHidden = false;
            ovht.constant = 1500
            self.accesshview.constant = 580;
            
        }
        
    }
    
    
    
    
    
    @IBAction func showingcellnum(_ sender: UITextField) {
        var finalstr = "";
        
        var enteredNum = sender.text;
        
        enteredNum = enteredNum!.replacingOccurrences(of:  " ", with: "")
        if(!enteredNum!.isEmpty)
        {
            let characterarray = Array(enteredNum!);
            
            if characterarray.count < 11
            {
                for char in  characterarray{
                    
                    finalstr = finalstr + "  " + String(char);
                    
                }
                sender.text = finalstr
                
            }
            else
            {
                for i in  0..<10{
                    
                    finalstr = finalstr + "  " + String(characterarray[i]);
                    
                }
                sender.text = finalstr
                
                
            }
            
        }
        else
        {
            sender.text = finalstr
            
        }
        
        
    }
    
    
    @IBAction func textfieldtesting(_ sender: UITextFeild) {
        
        if sender.tag == 1
        {
            let usertype = cachem.string(forKey: "userType")!;
            switch usertype {
            case "0":
                pickerDataList = JSON(adminUsers).arrayValue;
                userDropdown.reloadAllComponents();
                break;
            case "4":
                
                pickerDataList = JSON(adminUsers).arrayValue;
                userDropdown.reloadAllComponents();
            case "3":
                
                pickerDataList = JSON(cormporateUsers).arrayValue;
                userDropdown.reloadAllComponents();
                break;
                
            case "2":
                
                pickerDataList = JSON(buildingUsers).arrayValue;
                userDropdown.reloadAllComponents();
                break;
            default:
                pickerDataList = [JSON]();
                userDropdown.reloadAllComponents();
                break;
            }
            
            
            
            
        }
        else{
            pickerDataList = companieslistt;
            companyDropDown.reloadAllComponents();
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func checkBoxTapped(_ sender: UIBotton) {
        
        switch sender.setTitlein.section
        {
            
        case 0:
            
            if sender.isSelected
            {
                if sender.setTitlein.row == 0
                {
                    for btn in allbtns
                    {
                        if btn.setTitlein.row == 0 ||  btn.setTitlein.row == 2
                        {
                            btn.isSelected = false;
                            
                        }
                        
                    }
                    
                }
                else
                {
                    for btn in allbtns
                    {
                        if btn.setTitlein.row == sender.setTitlein.row
                        {
                            btn.isSelected = false;
                            
                        }
                        
                    }
                }
                
                
                
            }
            else{
                if sender.setTitlein.row == 0
                {
                    for btn in allbtns
                    {
                        if btn.setTitlein.row == 0
                        {
                            btn.isSelected = true;
                            
                        }
                        if btn.setTitlein.row == 1
                        {
                            btn.isSelected = false;
                            
                        }
                        
                    }
                    
                }
                else if sender.setTitlein.row == 1
                {
                    for btn in allbtns
                    {
                        if btn.setTitlein.row == 0
                        {
                            btn.isSelected = false;
                            
                        }
                        if btn.setTitlein.row == 1
                        {
                            btn.isSelected = true;
                            
                        }
                        if btn.setTitlein.row == 2
                        {
                            btn.isSelected = false;
                            
                        }
                        
                    }
                    
                    
                }
                else if sender.setTitlein.row == 2
                {
                    for btn in allbtns
                    {
                        if btn.setTitlein.row == 0
                        {
                            btn.isSelected = true;
                            
                        }
                        if btn.setTitlein.row == 1
                        {
                            btn.isSelected = false;
                            
                        }
                        if btn.setTitlein.row == 2
                        {
                            btn.isSelected = true;
                            
                        }
                        
                    }
                    
                    
                }
                else
                {
                    
                }
            }
            
            
            break;
            
            
        default:
            
            if sender.isSelected
            {
                for btn in allbtns
                {
                    if btn.setTitlein.section == 0
                    {
                        btn.isSelected = false;
                        
                    }
                    
                    if sender.setTitlein.section == btn.setTitlein.section
                    {
                        
                        if sender.setTitlein.row == 0
                        {
                            if btn.setTitlein.row == 2
                            {
                                btn.isSelected = false;
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                sender.isSelected = false;
                
                
                
            }
            else
            {
                
                
                for btn in allbtns
                {
                    
                    if btn.setTitlein.section == 0
                    {
                        btn.isSelected = false;
                        
                    }
                    
                    
                    
                    if sender.setTitlein.section == btn.setTitlein.section
                    {
                        if sender.setTitlein.row == 0
                        {
                            if btn.setTitlein.row == 0
                            {
                                btn.isSelected = true;
                                
                            }
                            else if btn.setTitlein.row == 1
                            {
                                btn.isSelected = false;
                            }
                            
                            
                        }
                        else if sender.setTitlein.row == 1
                        {
                            
                            
                            if btn.setTitlein.row == 1
                            {
                                btn.isSelected = true;
                            }
                            else
                            {
                                btn.isSelected = false;
                                
                            }
                            
                            
                            
                            
                        }
                        else if sender.setTitlein.row == 2
                        {
                            if btn.setTitlein.row == 0
                            {
                                btn.isSelected = true;
                            }
                            else if btn.setTitlein.row == 1
                            {
                                btn.isSelected = false;
                                
                            }
                            else if btn.setTitlein.row == 2
                            {
                                btn.isSelected = true;
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                    
                }
                
                
                
                
                
            }
            
      
            break;
            
            
        }
        
    }
    func sendAlert(_ msg : String)
    {
        let alert = UIAlertController.init(title: "Alert!", message: msg, preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion:  nil);
        
        
        
    }
   
    @IBAction func updateUSerTapped(_ sender: UIButton) {
        
        
        let firstname = fname.text!;
        let lastnmae = lname.text!;
        var mobilenum = phonenum.text!;
        mobilenum = mobilenum.replacingOccurrences(of: " ", with: "");
        print(mobilenum);
        let emailText = emailAddresss.text!;
        
        
        
        
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
        else if roleId.isEmpty
        {
            
            sendAlert("Please select user role");
            return
        }
        else if comId.isEmpty && roleId != "4"
        {
            sendAlert("Please select company");
            return
        }
        else if emailText.isEmpty
        {sendAlert("Please enter email");
            return
        }
        else if !emailText.contains(".")  ||  !emailText.contains("@")
        {
            sendAlert("Please enter valid email");
            return
        }
        
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        var paramjson = Dictionary<String, Any>();
        
        if roleId != "4"
        {
            paramjson["company_name"] = comId
        }
        else
        {
            paramjson["company_name"] = "";
        }
        
        
        //mobilenum
        
        paramjson["type_of_user"] = roleId
        paramjson["log_id"] = userid
        paramjson["id"] = sUser_id
        
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
        paramjson["emplyee_no"] = empId.text!
        paramjson["email"] = emailText
        paramjson["password"] = pword.text!;
        
        if statusswitch.isOn
        {
            
            
            paramjson["status"] = "0"
        }
        else{
            paramjson["status"] = "1"
        }
        
        if pushSwitch.isOn
        {
            paramjson["notification"] = "0"
            
        }
        else{
            paramjson["notification"] = "1"
        }
        
        var accessarray = Array<String>();
        for btn in self.allbtns
        {
            if btn.isSelected && btn.currentTitle != nil
            {
                let atitle = btn.currentTitle!
                if !atitle.isEmpty
                {
                    
                    if roleId == "3"
                    {
                        if btn.currentTitle! == "notifications_full" ||  btn.currentTitle! == "notifications_ronly" || btn.currentTitle! == "notifications_ndelete"
                        {
                            
                            
                        }
                            
                        else{
                            accessarray.append(btn.currentTitle!)
                        }
                        
                        
                    }
                    else if roleId == "2"
                    {
                        if btn.currentTitle! == "notifications_full" ||  btn.currentTitle! == "notifications_ronly" || btn.currentTitle! == "notifications_ndelete" || btn.currentTitle! == "company_settings_full" ||  btn.currentTitle! == "company_settings_ronly" || btn.currentTitle! == "company_settings_ndelete"  || btn.currentTitle! == "audit_reports_full" ||  btn.currentTitle! == "audit_reports_ronly" || btn.currentTitle! == "audit_reports_ndelete"
                        {
                            
                            
                            
                            
                        }
                        else{
                            accessarray.append(btn.currentTitle!)
                        }
                    }
                    else
                    {
                        accessarray.append(btn.currentTitle!)
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        
        if roleId == "1"
        {
            accessarray = Array<String>();
            accessarray.append("mechanical_room_full")
            
        }
        
        paramjson["user_access"] = accessarray
        let parameters = [
            "userdata":  JSON(paramjson)
        ]
        print(parameters);
        
        print(vUsereditUpdateAPI);
        
        
        
        
        if checkNetwork.connection == .none
        {
            
            
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =    JSON(paramjson)
                    let jdata =  deleteapidata.description
                    
                    let savestatsu =   saetolocaldatabase(jdata, "updateuser");
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
            
            
            
            return;
        }
        
        
            
        Alamofire.request(vUsereditUpdateAPI, method: .post, parameters : parameters).responseJSON { (resp) in
            
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
        
        let buildingdetailapi = "\(vUsereditDetailAPI)\(userid)/\(usertype)/\(sUser_id)"
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
                let cominfo = buildinginfo["com"].arrayValue
                if datainfo.count > 0
                {
                    
                    
                    DispatchQueue.main.async {
                        self.roleId = datainfo[0]["role"].stringValue
                        self.userselectedhere(self.roleId);
                        self.fname.text = datainfo[0]["first_name"].stringValue
                         self.lname.text = datainfo[0]["last_name"].stringValue
                        
                        var mediiator = datainfo[0]["phone"].stringValue.replacingOccurrences(of: "(", with: "")
                         mediiator = mediiator.replacingOccurrences(of: ")", with: "")
                        mediiator = mediiator.replacingOccurrences(of: "-", with: "")
                        let phonconst = Array(mediiator)
                        
                           var finalstr = "";
                            for char in  phonconst{
                                
                                finalstr = finalstr + "  " + String(char);
                                
                            }
                        
                        
                        
                          self.phonenum.text = finalstr
                        
                        
                         self.empId.text = datainfo[0]["emplyee_no"].stringValue
                         self.emailAddresss.text = datainfo[0]["email"].stringValue
                         self.pword.text = datainfo[0]["password"].stringValue
                        let useraccess = datainfo[0]["user_access"].stringValue
                        let accessarray = useraccess.split(separator: ",");
                        
                         self.userRole.text = datainfo[0]["type"].stringValue
                       
                        
                        for btn in self.allbtns
                        {
                            let titles  = btn.currentTitle
                            if titles != nil
                            {
                                for i in 0..<accessarray.count
                                {
                                    if titles! == accessarray[i]
                                    {
                                        
                                        btn.isSelected = true;
                                    }
                                }
                                
                            }
                            
                        }
                        
                        
                            self.compnayField.text = datainfo[0]["cname"].stringValue
                            self.comId = datainfo[0]["cid"].stringValue
                        
                        
                        self.companieslistt = cominfo;
                        
                        
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
        upadateBtn.layer.cornerRadius = 4.0
        upadateBtn.clipsToBounds = true;
        
        cancelBtn.layer.cornerRadius = 4.0
        cancelBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
        addGrayBorders([uView, lView, fView,eView, cView, eidView, pView, comView]);
        compnayFBtn.setTitlein = IndexPath.init(row: 0, section: 13);
        usRBtn.setTitlein = IndexPath.init(row: 1, section: 4);
        repairRBtn.setTitlein = IndexPath.init(row: 1, section: 8);
        sreadBtn.setTitlein = IndexPath.init(row: 1, section: 0);
        eqDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 3);
        buFBtn.setTitlein = IndexPath.init(row: 0, section: 1);
        companyDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 13);
        budeleteBtn.setTitlein = IndexPath.init(row: 2, section: 1);
        usFullBtn.setTitlein = IndexPath.init(row: 0, section: 4);
        muRBtn.setTitlein = IndexPath.init(row: 1, section: 2);
        signRBtn.setTitlein = IndexPath.init(row: 1, section: 6);
        eqFullBtn.setTitlein = IndexPath.init(row: 0, section: 3);
        notifulBtn.setTitlein = IndexPath.init(row: 0, section: 14);
        sdeleteBtn.setTitlein = IndexPath.init(row: 2, section: 0);
        sfullBtn.setTitlein = IndexPath.init(row: 0, section: 0);
        insreportRBtn.setTitlein = IndexPath.init(row: 1, section: 7);
        custDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 10);
        eqRBtn.setTitlein = IndexPath.init(row: 1, section: 3);
        meFullBtn.setTitlein = IndexPath.init(row: 0, section: 2);
        inctRBtn.setTitlein = IndexPath.init(row: 1, section: 12);
        usDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 4);
        notideleteBtn.setTitlein = IndexPath.init(row: 2, section: 14);
        custFBtn.setTitlein = IndexPath.init(row: 0, section: 10);
        eqpformRBtn.setTitlein = IndexPath.init(row: 1, section: 11);
        eqptestFullBtn.setTitlein = IndexPath.init(row: 0, section: 5);
        eqptestRBtn.setTitlein = IndexPath.init(row: 1, section: 5);
        notireadBtn.setTitlein = IndexPath.init(row: 1, section: 14);
        buRBtn.setTitlein = IndexPath.init(row: 1, section: 1);
        eqpformFBtn.setTitlein = IndexPath.init(row: 0, section: 11);
        muDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 2);
        signFBtn.setTitlein = IndexPath.init(row: 0, section: 6);
        inctDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 12);
        insreportFBtn.setTitlein = IndexPath.init(row: 0, section: 7);
        companyRBtn.setTitlein = IndexPath.init(row: 1, section: 13);
        auditFBtn.setTitlein = IndexPath.init(row: 0, section: 9);
        auditRBtn.setTitlein = IndexPath.init(row: 1, section: 9);
        custRBtn.setTitlein = IndexPath.init(row: 1, section: 10);
        eqpformDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 11);
        inctFBtn.setTitlein = IndexPath.init(row: 0, section: 12);
        repairFBtn.setTitlein = IndexPath.init(row: 0, section: 8);
        eqptestDeleteBtn.setTitlein = IndexPath.init(row: 2, section: 5);
        
        companyDropDown.dataSource = self;
        companyDropDown.delegate = self;
        userDropdown.dataSource = self;
        userDropdown.delegate = self;
        compnayField.inputView = companyDropDown;
        userRole.inputView = userDropdown;
        userDropdown.backgroundColor = UIColor.black;
        companyDropDown.backgroundColor = UIColor.black;
        let usertype = cachem.string(forKey: "userType")!;
        if(usertype == "0")  || (usertype == "4")
        {
            compnayField.isUserInteractionEnabled = true;
            
        }
        else
        {
            compnayField.isUserInteractionEnabled =   false;
        }
        
      
        allbtns = [sreadBtn,sdeleteBtn,sfullBtn,buFBtn,buRBtn,budeleteBtn,meFullBtn,muRBtn,muDeleteBtn,eqFullBtn,eqRBtn,eqDeleteBtn,usFullBtn,usRBtn,usDeleteBtn,eqptestFullBtn,eqptestRBtn,eqptestDeleteBtn,signFBtn,signRBtn,insreportFBtn,insreportRBtn,repairFBtn,repairRBtn,auditFBtn,auditRBtn,custFBtn,custRBtn,custDeleteBtn,eqpformFBtn,eqpformRBtn,eqpformDeleteBtn,inctFBtn,inctRBtn,inctDeleteBtn,compnayFBtn,companyRBtn,companyDeleteBtn, notifulBtn, notireadBtn, notideleteBtn];
        callingBuildingDetail();
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        // [["id" : "", "name" : "Super"],["id" : "", "name" : "Building Manager"], ["id" : "",
    }

}
