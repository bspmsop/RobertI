//
//  NotificationDetailViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 26/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//


import UIKit
import ScrollingFollowView
import SwiftHEXColors
import SwiftyJSON
import Alamofire
import MBProgressHUD
import Reachability

class NotificationDetailViewController:  UIViewController,    UITableViewDelegate, UITableViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }
    @IBOutlet weak var sendLocation: UITextFeild!
    
    @IBOutlet weak var sendtocluster: UITextFeild!
    @IBOutlet weak var companyfields: UITextFeild!
    @IBOutlet weak var usertype: UITextFeild!
    @IBOutlet weak var tview: UIView!
    
    var addBuildingHud = MBProgressHUD();
    var sNotification_id = "";
    @IBAction func backBtnTapped(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true);
    }
    
    var alldata = [JSON]();
    var lemyvcar = -1
    @IBOutlet weak var messText: UITextView!
    
    var pickerDataList = Array<JSON>();
    var selectedcompany = -1
    var selecteduser = 0;
    var managersdata = [JSON]();
    var supersdata = [JSON]();
    var usersdata = ["Super", "Building Manager", "Corporate Manager", "Admin"]
    @IBOutlet weak var ResenfBtn: UIButton!
    @IBOutlet weak var superTableHt: NSLayoutConstraint!
    @IBOutlet weak var managersTable: NSLayoutConstraint!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var mtable: UITableView!
    @IBOutlet weak var stable: UITableView!
    @IBOutlet weak var overallViewHt: NSLayoutConstraint!
    @IBOutlet weak var suboverallView: NSLayoutConstraint!
    
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var uView: UIView!
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var scView: UIView!
    
    @IBOutlet weak var mview: UIView!
     var hud = MBProgressHUD();
    let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributed = NSAttributedString.init(string: "", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        if lemyvcar == 0
        {
            pickerView.backgroundColor = UIColor.black;
            attributed = NSAttributedString.init(string: pickerDataList[row]["cname"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            
            
        }
        else if lemyvcar == 1
        {
            
            pickerView.backgroundColor = UIColor.black;
            
            attributed = NSAttributedString.init(string: pickerDataList[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            
            
            
        }
        else if lemyvcar == 2
        {
            if selectedcomrow < alldata.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[selectedcomrow]["location"].arrayValue
                if row < locations.count
                {
                    attributed = NSAttributedString.init(string: locations[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                    
                }
                
            }
            
            
            
            
        }
        else if lemyvcar == 3
        {
            if selectedcomrow < alldata.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[selectedcomrow]["cluster"].arrayValue
                if row < locations.count
                {
                    attributed = NSAttributedString.init(string: locations[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                    
                }
                
            }
            
        }
        else if lemyvcar == 4
        {
            if selectedcomrow < pickerDataList.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[row]["fname"].stringValue
                
                attributed = NSAttributedString.init(string: locations, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                
                
                
            }
            
        }
        else if lemyvcar == 5
        {
            if selectedcomrow < pickerDataList.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[row]["fname"].stringValue
                
                attributed = NSAttributedString.init(string: locations, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                
                
                
            }
            
            
            
            
        }
        
        return attributed;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.backgroundColor = UIColor.black;
        return 1
    }
    var selectedtextfile = UITextField();
    
    var selectedcomrow = -1;
    var selectedcomid = "";
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    @IBAction func resendTapped(_ sender: UIButton) {
        if Gmenu.count > 7
        {
            let isread =  Gmenu[7]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        resendTheNotification();
        
        
    }
    
    
     func resendTheNotification()
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
            
            // getOfflineBuildingData()
            return;
        }
        
        
        
        
        
        let Buildingapi = "\(vNotificationResendAPI)\(sNotification_id)"
        
        print(Buildingapi)
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                if resp.result.isSuccess
                {
                    isOfflineMode = false
                     self.hud.hide(animated: true);
                    let alerrt = UIAlertController.init(title: "Success!", message: "Notification  sent successfully", preferredStyle: .alert);
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
    
    @IBAction func sendPushNotifiation(_ sender: UIButton) {
        if Gmenu.count > 7
        {
            let isread =  Gmenu[7]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        resendTheNotification()
        
    }
    
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        
        if Gmenu.count > 7
        {
            let isread =  Gmenu[7]["isread"]!
            let isnodete = Gmenu[7]["isnodelete"]!
            
            if isread == "1" || isnodete == "1"
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
        alertview.descText.text = "You are about to delete a past push notification.";
        alertview.deleteBtn.addTarget(self, action: #selector(deletebuilding(_:)), for: .touchUpInside);
        
        
    }
    
    @objc func deletebuilding(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
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
            
            // getOfflineBuildingData()
            return;
        }
        
        
        
        
        
        let Buildingapi = "\(vNotificationDeleteAPI)\(sNotification_id)"
        
        print(Buildingapi)
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                if resp.result.isSuccess
                {
                    isOfflineMode = false
                    
                    let alerrt = UIAlertController.init(title: "Success!", message: "Notification  deleted successfully", preferredStyle: .alert);
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mtable
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "mtablenotification") as! NotificationDetailDatacellClass
            
            cell.loadingdefaultUI();
            cell.titleFelds.text = self.managersdata[indexPath.row]["full_name"].stringValue
            
            
            
            return cell;
            
            
            
            
            
            
        }
        else if tableView == stable{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "stableNotification") as! NotificationDetailDatacellClass
            cell.loadingdefaultUI();
            cell.titleFelds.text = self.supersdata[indexPath.row]["full_name"].stringValue
            
            
            return cell;
            
            
            
            
        }
            
        else
        {
            let cell = UITableViewCell();
            return cell;
        }
        
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == mtable
        {
            
            
            return managersdata.count
            
            
        }
        else if tableView == stable
        {
            
            
            return supersdata.count
            
        }
            
        else{
            
            return 0;
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         warningMessage = "you are about to delete a past push notification";
    }
    
    
    func callinformationData()
    {
        
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
                
                
            }
            
            //getofflineStateCompanyList();
            return;
        }
        
        
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi =  "\(vNotificationDetailAPI)\(sNotification_id)"
        print(buildingdetailapi);
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                isOfflineMode = false
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                
                self.alldata = buildinginfo["data"].arrayValue
                if  self.alldata.count > 0
                {
                    
                    
                    
                    DispatchQueue.main.async {
                        self.tview.isHidden = false;
                        self.companyfields.text = self.alldata[0]["cname"].stringValue
                         self.usertype.text = self.alldata[0]["usertype"].stringValue
                         self.sendLocation.text = self.alldata[0]["location"].stringValue
                         self.sendtocluster.text = self.alldata[0]["cluster"].stringValue
                         self.managersdata = self.alldata[0]["bmnagers"].arrayValue
                        self.supersdata = self.alldata[0]["supers"].arrayValue
                        self.messText.text  = self.alldata[0]["message"].stringValue
                        self.adjustView();
                        self.mtable.reloadData();
                        self.stable.reloadData();
                        self.addBuildingHud.hide(animated: true);
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.addBuildingHud.hide(animated: true);
                        
                    }
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("No companies to display"), preferredStyle: .alert);
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
                    
                    self.addBuildingHud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_) in
                        self.callinformationData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    func adjustView()
    {
        var tcount = managersdata.count + supersdata.count;
        tcount = tcount * 65;
        overallViewHt.constant = CGFloat(800 + tcount)
        suboverallView.constant =  CGFloat(600 + tcount)
        managersTable.constant =  CGFloat(managersdata.count * 65)
        
        superTableHt.constant =  CGFloat(supersdata.count * 65)
        
        
    }
    func loadingDefaultUI()
    {
        tview.isHidden = true;
        adjustView()
        
        
        
        
        
        addGrayBorders([cView, uView, sView, scView, mview])
        ResenfBtn.layer.cornerRadius = 4.0;
        ResenfBtn.clipsToBounds = true;
        cancelBtn.layer.cornerRadius = 4.0
        cancelBtn.clipsToBounds = true;
         CompatibleStatusBar(self.view);
        callinformationData()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }

}



class NotificationDetailDatacellClass : UITableViewCell
{
    @IBOutlet weak var mview: UIView!
    @IBOutlet weak var titleFelds: UITextFeild!
    func loadingdefaultUI()
    {
        addGrayBorders([mview])
        
    }
    
}
