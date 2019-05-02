//
//  SubscriptionDetailViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 26/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//


import UIKit
import ScrollingFollowView
import SwiftyJSON
import Reachability
import Alamofire
import MBProgressHUD

class SubscriptionDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadidngDefaultUI()
    }
    let btndatas = ["1" : "notification", "2":"building_management", "3":"custom_inspection_sheet", "4":"equipment_test_management", "5":"mechnical_room_management", "6":"equipment_management", "7":"multiple_inspection_sheet", "8":"reports", "9":"company_settings", "10":"user_management", "11":"sync"]
    
    @IBOutlet weak var oview: UIView!
    
    
    
    @IBOutlet weak var notesTextVw: UITextView!
    @IBOutlet weak var overallht: NSLayoutConstraint!
    var addBuildingHud = MBProgressHUD();
    @IBOutlet weak var scrollerHt: NSLayoutConstraint!
    var hud = MBProgressHUD();
    let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    var sSubscriptionID = ""
    @IBOutlet weak var comName: UILabel!
    @IBOutlet weak var subscriptionLevel: UILabel!
    @IBOutlet weak var publicLab: UILabel!
    @IBOutlet weak var pricelab: UILabel!
    @IBOutlet weak var termsLab: UILabel!
    
    @IBOutlet var btnsdata: [UIBotton]!
    
    
    
    
    
    @IBOutlet weak var expiryDatLab: UILabel!
    var mydata = [JSON]();
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        
 
 
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditSubscriptionViewController") as! EditSubscriptionViewController
        vController.sSubscriptionID = sSubscriptionID
        self.navigationController?.pushViewController(vController, animated: true);
        
        
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
        
 
       
       
        
        
       
     alertview.deleteBtn.addTarget(self, action: #selector(deletebuilding(_:)), for: .touchUpInside);
        alertview.cancelBtn.layer.cornerRadius = 4.0
        alertview.deleteBtn.layer.cornerRadius = 4.0
        alertview.frame = self.view.frame;
        self.view.addSubview(alertview);
        alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.descText.text = "You are about to delete  subscription."
        
        
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true);
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
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil);
            }
            
            // getOfflineBuildingData()
            return;
        }
        
        
         
        
        
        let buildingdetailapi = "\(vSubscriptionDeleteAPI)\(sSubscriptionID)"
        print(buildingdetailapi)
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                let respondata = JSON(resp.result.value!)
                if resp.result.isSuccess
                {
                    
                    let statuss = respondata["status"].stringValue
                    let wmsg = respondata["msg"].stringValue
                    if statuss == "200"
                    {
                        isOfflineMode = false
                        
                        let alerrt = UIAlertController.init(title: "Success!", message: "Subscription deleted successfully", preferredStyle: .alert);
                        alerrt.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                            
                            self.navigationController?.popViewController(animated: true);
                            
                            
                        }));
                        self.present(alerrt, animated: true, completion: nil);
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            self.hud.hide(animated: true);
                            let alert = UIAlertController.init(title: translator("Failed!"), message: translator(wmsg), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Try Again"), style: .default, handler: { (_) in
                                self.deletebuilding(sender)
                                //  self.getOfflineBuildingData()
                                
                                
                            }))
                            
                            alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                                
                            }))
                            self.present(alert, animated: true, completion: nil);
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed!"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Try Again"), style: .default, handler: { (_) in
                            self.deletebuilding(sender)
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
    
    
    @IBAction func tappedCheckBox(_ sender: UIBotton) {
        
        
        
        
        sender.isSelected = !sender.isSelected
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        
        let companylists = "\(vSubscriptionDetailAPI)\(sSubscriptionID)";
        
        print(companylists)
        Alamofire.request(companylists, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value)
                let resultdata =  JSON(resp.result.value!);
                
                  self.mydata = resultdata["data"].arrayValue
                if self.mydata.count > 0
                {
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                        self.oview.isHidden = false;
                        self.comName.text = self.mydata[0]["cname"].stringValue;
                        self.subscriptionLevel.text = self.mydata[0]["level"].stringValue;
                        self.pricelab.text = self.mydata[0]["price"].stringValue;
                        self.publicLab.text = self.mydata[0]["public"].stringValue;
                        self.termsLab.text = self.mydata[0]["subscription"].stringValue;
                        self.expiryDatLab.text = self.mydata[0]["sdate"].stringValue;
                        self.notesTextVw.text = self.mydata[0]["notes"].stringValue;
                        
                        for btnt in self.btnsdata
                        {
                            let mybtnid = String(btnt.tag)
                            print(mybtnid);
                            let titledata  = self.btndatas[mybtnid]
                            if titledata != nil
                            {
                                print("not nil its titledata \(titledata!)");
                                let sper  = self.mydata[0][titledata!].stringValue;
                                if sper == "yes"
                                {
                                    btnt.isSelected = true;
                                    
                                }
                               
                            }
                           
                        }
                      
                        self.addBuildingHud.hide(animated: true);
                    }
                    
                    
                    
                }
                else
                {
                    
                    DispatchQueue.main.async {
                        
                        self.addBuildingHud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("No data to display"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_) in
                            self.callinformationData()
                            
                            
                        }))
                        alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: { (_) in
                            
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                        
                    }
                    
                    
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
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil));
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    func loadidngDefaultUI()
    {
        oview.isHidden = true;
        for bbn in btnsdata
        {
            bbn.isSelected = false;
            
        }
        callinformationData()
        CompatibleStatusBar(self.view);
        
        
       /*
        notesTextVw.sizeToFit();
        notesTextVw.isScrollEnabled = false;
        scrollerHt.constant = 920 + notesTextVw.frame.height + (0.2 * notesTextVw.frame.height)
        overallht.constant = 950 + notesTextVw.frame.height + (0.5 * notesTextVw.frame.height)
        
        print((0.2 * notesTextVw.frame.height));
        
        print((notesTextVw.frame.height));
        */
        
    }
}
