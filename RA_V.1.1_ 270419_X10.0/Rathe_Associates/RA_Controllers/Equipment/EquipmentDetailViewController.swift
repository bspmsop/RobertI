//
//  EquipmentDetailViewController.swift
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
import DXPopover
import MBProgressHUD
import Reachability


class EquipmentDetailViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource   {

    override func viewDidLoad() {
        super.viewDidLoad()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        loadingDefaultUI();
    }
    override func viewDidDisappear(_ animated: Bool) {
        dxdropdown.dismiss();
    }
    
    @IBOutlet weak var scroller: UIScrollView!
    
    var hud = MBProgressHUD();
    @IBOutlet weak var printQRBtn: UIButton!
    @IBOutlet weak var performefficiencyTest: UIView!
    @IBOutlet weak var vendorRepairBtn: UIButton!
    @IBOutlet weak var backvww: UIView!
    
    @IBOutlet weak var eqname: UILabel!
    @IBOutlet weak var mname: UILabel!
    @IBOutlet weak var sname: UILabel!
    @IBOutlet weak var doclibaraylab: UILabel!
    var equipdrawings = [JSON]();
    @IBOutlet weak var headertitle: UILabel!
    @IBOutlet weak var efficiencytitle: UIButton!
    let dropdownTable = UITableView()
    let dropdownview = UIView()
    let dropdownsearchField = UITextField()
      let dxdropdown = DXPopover.init();
    var docsarrayjson = [JSON]();
     var demodocs = [JSON]();
    var selfequipid = "";
    var selfefficiencyid = "";
    var buildingDjData = JSON();
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demodocs.count
    }
    @IBAction func edittapped(_ sender: UIButton) {
        
        
        
        if !selfequipid.isEmpty
        {
            let vacontroller = self.storyboard?.instantiateViewController(withIdentifier: "EditAssetEquipmentViewController") as! EditAssetEquipmentViewController
            vacontroller.equipmentID = selfequipid
            self.navigationController?.pushViewController(vacontroller, animated: true);
        }
       
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        var dict = demodocs[indexPath.row]
        let myfileName = dict["file_name"].stringValue;
        cell.textLabel?.text = myfileName;
        
        cell.textLabel?.textColor = UIColor.darkGray;
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if demodocs.count > 0
        {
            numOfSections = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:tableView.bounds.size.height - 40))
            noDataLabel.text          = translator("No data available")
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vContrroller = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController;
        
        
        vContrroller.filePathURL =  demodocs[indexPath.row]["file_path"].stringValue
        
        dxdropdown.dismiss();
        self.navigationController?.pushViewController(vContrroller, animated: false);
    }
    
    
    @IBAction func performefficencytapped(_ sender: UIButton) {
        
        if Gmenu.count > 5
        {
            let isread =  Gmenu[5]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let vController = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "EfficentyTestViewController") as!  EfficentyTestViewController
        vController.isfromvone = true;
        vController.efficiencyId = buildingDjData["eupid"].intValue;
         vController.equipmentID = buildingDjData["id"].intValue;
        self.navigationController?.pushViewController(vController, animated: true);
        
        
    }
    @IBAction func vendorreparirtapped(_ sender: UIButton) {
        
        if Gmenu.count > 5
        {
            let isread =  Gmenu[5]["isread"]!
            
            if isread == "1" 
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let vController = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "AddRepairViewController") as! AddRepairViewController
        vController.isfromVone = true;
        vController.mechId = buildingDjData["mid"].intValue;
        vController.equipmenId = buildingDjData["id"].intValue;
        vController.equipmentName = buildingDjData["title"].stringValue;
        
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    @IBAction func printqrlabelTapped(_ sender: UIButton) {
        
        
        let filePather = buildingDjData["qrcodeImage"].stringValue;
        let vContrroller =  UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        
        vContrroller.filePathURL = filePather
        
        self.navigationController?.pushViewController(vContrroller, animated: false);
        
        
        
        
    }
    @objc func  searchtextfieldTapped(_ sender : UITextField)
    {
        
        if sender.text != ""
        {
            demodocs = [JSON]();
            
            for i in 0..<docsarrayjson.count
            {
                
                var estr = docsarrayjson[i]["file_name"].stringValue;
                
                estr = estr.lowercased();
                if (estr.contains(sender.text!.lowercased()))
                {
                    demodocs.append(docsarrayjson[i]);
                }
            }
        }
        else
        {
            demodocs = docsarrayjson
        }
        dropdownTable.reloadData();
    }
    
    @IBAction func doclibraytapped(_ sender: UIButton) {
        
       demodocs = docsarrayjson
        
        if demodocs.count > 0
        {
            scroller.isScrollEnabled = false;
            dxdropdown.isHidden = false;
            print(self.view.frame.width);
            print(self.view.frame.width * 0.15 * 0.5)
            dxdropdown.show(at: CGPoint.init(x:  (self.view.frame.width *  0.1 * 0.5) +  23, y: 280), popoverPostion: .down, withContentView: dropdownview, in: self.scroller);
            
            dxdropdown.blackOverlay.backgroundColor = UIColor.clear;
            
            print("I'm tapped")
            
            
            dxdropdown.didDismissHandler =  {
                self.scroller.isScrollEnabled   = true;
                print("dismissed");
            };
            
            
            
        }
        else
        {
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    
    
    
    
    @IBAction func deletebtnTapped(_ sender: UIButton) {
        if Gmenu.count > 5
        {
            let isread =  Gmenu[5]["isread"]!
            let isdelete =  Gmenu[5]["isnodelete"]!
            if isread == "1" ||  isdelete == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        if !selfequipid.isEmpty
        {
            alertview.cancelBtn.layer.cornerRadius = 4.0
            alertview.deleteBtn.layer.cornerRadius = 4.0
            alertview.frame = self.view.frame;
            self.view.addSubview(alertview);
            alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
            alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
            alertview.descText.text = "You are about to delete \(eqname.text!) and all associated documents.";
            alertview.deleteBtn.addTarget(self, action: #selector(deletebuilding(_:)), for: .touchUpInside);
            
        }
        
       
        
    }
    @objc func deletebuilding(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        let Buildingapi = "\(vmechanicalEditEquipmentDeleteApi)\(selfequipid)"
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =   Buildingapi
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
        
        
        
        
        
        
        
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                if resp.result.isSuccess
                {
                    isOfflineMode = false
                    
                    let alerrt = UIAlertController.init(title: "Success!", message: "Equipment  deleted successfully", preferredStyle: .alert);
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
    
    
    
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
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
                
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check your network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil)
            }
            // getOfflineBuildingData()
            return;
        }
        
        
        //let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi = "\(vEquipmentDetaildataApi)\(vselectedEquipmentID)"
        
        print(buildingdetailapi);
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                  self.buildingDjData = buildinginfo["eqpinfo"];
                self.selfequipid = self.buildingDjData["id"].stringValue;
                print(self.selfequipid);
                let drawingscount = self.buildingDjData["dcount"].stringValue;
                self.doclibaraylab.text = "(\(drawingscount)) Documents In Library";
                self.eqname.text = self.buildingDjData["title"].stringValue;
                self.mname.text = self.buildingDjData["model"].stringValue;
                    self.sname.text = self.buildingDjData["serial"].stringValue;
                    self.headertitle.text = self.buildingDjData["mtitle"].stringValue;
                self.efficiencytitle.setTitle(self.buildingDjData["effname"].stringValue, for: .normal);
                self.docsarrayjson = self.buildingDjData["drawings"].arrayValue;
                self.selfefficiencyid = self.buildingDjData["eupid"].stringValue;
                
                
                
                self.demodocs = self.docsarrayjson;
                isOfflineMode = false
               
                
                DispatchQueue.main.async {
                    if self.selfefficiencyid.isEmpty
                    {
                        self.performefficiencyTest.isHidden = true;
                        
                    }
                    self.backvww.isHidden = false;
                    self.dropdownTable.reloadData()
 
                    self.hud.hide(animated: true);
                }
                
                
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        self.callingBuildingDetail();
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
               
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    func loadingDefaultUI()
    {
        backvww.isHidden = true;
        printQRBtn.layer.cornerRadius = 8.0;
        printQRBtn.clipsToBounds = true;
        
        performefficiencyTest.layer.cornerRadius = 8.0
        performefficiencyTest.clipsToBounds = true;
        
        vendorRepairBtn.layer.cornerRadius = 8.0
        vendorRepairBtn.clipsToBounds = true;
        dropdownview.frame = CGRect.init(x: 0 , y: 0, width: self.view.frame.width * 0.9 , height: 170);
        
        dropdownview.addSubview(dropdownTable);
       
        dropdownview.addSubview(dropdownsearchField);
        let searchImg = UIImageView()
        let border = UILabel();
        searchImg.image = UIImage.init(named: "search")
        dropdownsearchField.placeholder = translator("Search")
        dropdownview.addSubview(searchImg);
        dropdownview.addSubview(border);
        searchImg.frame = CGRect.init(x: 5, y: 0, width: 20, height: 40)
        searchImg.contentMode = .scaleAspectFit;
        dropdownsearchField.frame = CGRect.init(x: 30, y: 0, width: dropdownview.frame.width - 35, height: 40)
        dropdownsearchField.keyboardAppearance = .dark;
        dropdownsearchField.keyboardType = .default;
        dropdownsearchField.autocapitalizationType = .none;
        dropdownsearchField.clearButtonMode = .always;
        dropdownsearchField.addTarget(self, action: #selector(searchtextfieldTapped(_:)), for: .editingChanged);
        border.frame = CGRect.init(x: 0, y: 40, width: dropdownview.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray;
        dropdownview.layer.cornerRadius = 5.0;
        dropdownview.clipsToBounds = true;
        dropdownview.layer.borderColor =  UIColor.lightGray.cgColor;
        dropdownview.layer.borderWidth = 1.0
        dropdownview.backgroundColor = UIColor.white;
        dropdownTable.frame = CGRect.init(x: 5, y: 42, width: dropdownview.frame.width - 10, height: 125)
        dropdownTable.delegate = self
        dropdownTable.dataSource = self
        dropdownTable.reloadData();
        callingBuildingDetail();
        
        
    }
    
    
    
    
    
    

}
