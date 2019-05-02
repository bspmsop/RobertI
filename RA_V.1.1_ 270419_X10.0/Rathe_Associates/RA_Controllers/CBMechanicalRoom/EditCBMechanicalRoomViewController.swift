//
//  EditCBMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 26/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import ScrollingFollowView
import MBProgressHUD
import SwiftyJSON
import Reachability



class EditCBMechanicalRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingDefaultUI();
    }
    
    var selectedinsid = "-1"
    @IBOutlet weak var addess2: UILabel!
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var performInspectionvw: UIView!
    @IBOutlet weak var backviefw: UIView!
    
    
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var superstabht: NSLayoutConstraint!
    @IBOutlet weak var backViw: UIView!
    @IBOutlet weak var tableViewHt: NSLayoutConstraint!
    @IBOutlet weak var equiptable: UITableView!
    @IBOutlet weak var supersTable: UITableView!
    @IBOutlet weak var inspectionDropdown: UITextFeild!
    var hud = MBProgressHUD();
    @IBOutlet weak var overallHt: NSLayoutConstraint!
     var nrows = 5
    var equipmentdataJn = [JSON]();
    var supersdataJn = [JSON]();
     var allsuperdatajsn = [JSON]();
    var inspectionjn = [JSON]();
    var mechovberalldata = JSON();
    var pickerDataList = Array<JSON>();
     var pickersuperlistdata = Array<JSON>();
    let menuDropDown = UIPickerView();
    @IBOutlet weak var inspectionvw: UIView!
    @IBOutlet weak var inspectionht: NSLayoutConstraint!
    @IBOutlet weak var inspectiontitlebtn: UIButton!
    var inspectionId = -1;
    
    @IBOutlet weak var headertitle: UILabel!
     let popTabl = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 18] as! popupTableViewClass;
    
    @objc func hidePopView(_ sender : UIButton)
    {
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.popTabl.frame = CGRect.init(x: 0, y: self.view.frame.height + 42, width: self.view.frame.width, height: self.view.frame.height)
        }) { (isSuccess) in
            self.popTabl.backgroundColor = .clear;
            
        }
        
        
    }
    @IBAction func signoutTapped(_ sender: UIButton) {
        
        let alert = UIAlertController.init(title: "Success!", message: "User Signout Mechanical Room", preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
            
            self.navigationController?.popViewController(animated: false);
            
        }))
        self.present(alert, animated: true, completion: nil);
        
        
    }
    
    
    @IBAction func documentlibrarybtntapped(_ sender: UIButton) {
        
        let usertypee = cachem.string(forKey: "userType")!;
        
        DocumetLibaraymechId = "\(documentAPI)/\(vselectedmechanicalId)/\(usertypee)"
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        let mcontroller = storyboard.instantiateViewController(withIdentifier: "NewDocumentLibraryViewController") as! NewDocumentLibraryViewController
        mcontroller.isfromvone = true;
        let nav = UINavigationController.init(rootViewController: mcontroller)
        DocumentHeader = vselectedmechtitrle
        let mymechid = Int(vselectedmechanicalId)
        if mymechid != nil
        {
            mechanicalRoomID = mymechid!;
        }
        GroomTitle = vselectedmechtitrle;
        if Gmenu.count > 4
        {
            let isread =  Gmenu[4]["isread"]!
            let isdelete =  Gmenu[4]["isnodelete"]!
            if isread == "1" ||  isdelete == "1"
            {
                 mcontroller.isdeletedoc = false
            }
            
            
        }
          self.present(nav, animated: false, completion: nil);
        
        
    }
    
    @IBAction func vendorlistTapped(_ sender: UIButton) {
        let usertypee = cachem.string(forKey: "userType")!;
        
        DocumetLibaraymechId = "\(documentAPI)/\(vselectedmechanicalId)/\(usertypee)"
        let mymechid = Int(vselectedmechanicalId)
        if mymechid != nil
        {
             mechanicalRoomID = mymechid!;
        }
       
        DocumentHeader = vselectedmechtitrle
        //usersBackView.backgroundColor = UIColor.init(red: 124/255, green: 125/255, blue: 126/255, alpha: 1.0)
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        let mcontroller = storyboard.instantiateViewController(withIdentifier: "VendorRepairListViewController") as! VendorRepairListViewController
        //mcontroller.headerTile = headTitle;
         mcontroller.isfromvone = true;
        let nav = UINavigationController.init(rootViewController: mcontroller)
        
        GroomTitle = vselectedmechtitrle;
        self.present(nav, animated: false, completion: nil);
        
        
        
    }
    
    
    
    
    @IBAction func addSupertapped(_ sender: UIButton) {
        
        if Gmenu.count > 4
        {
            let isread =  Gmenu[4]["isread"]!
            
            if isread == "1"  
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditBuildingViewController") as! EditBuildingViewController
        
        vselectedbuildingId =  mechovberalldata["bid"].stringValue;
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        /*
        self.popTabl.dropDownTable.tag = sender.tag;
        popTabl.loadingDefaultUI();
        self.popTabl.wariningLab.text = "";
        self.popTabl.headertitle.text = "Please select super"
        self.popTabl.roomNameField.text  = "";
       
        self.view.addSubview(popTabl);
        self.popTabl.submitBtn.tag = sender.tag;
        
       
        popTabl.frame = CGRect.init(x: 0, y: self.view.frame.height + 42, width: self.view.frame.width, height: self.view.frame.height)
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.popTabl.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (isAnimated) in
            
            
            
        }
        
        
       self.popTabl.closeBtn.addTarget(self, action: #selector(hidePopView(_:)), for: .touchUpInside)
           self.popTabl.cancelBtn.addTarget(self, action: #selector(hidePopView(_:)), for: .touchUpInside)
        
            getsuperpickerlist();
            
            self.popTabl.mechanicalRoomViw.isHidden = true;
            self.popTabl.dropDownTable.delegate = self;
            self.popTabl.dropDownTable.dataSource = self;
            self.popTabl.dropDownTable.reloadData();
            
       */
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func addnewEquipmentTapped(_ sender: UIButton) {
        if Gmenu.count > 5
        {
            let isread =  Gmenu[4]["isread"]!
            let isfull =  Gmenu[5]["isfull"]!
            let isnodelte =  Gmenu[5]["isnodelete"]!
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
                
            }
            else if isfull == "1" || isnodelte == "1"
            {
                
            }
            else{
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
 
        }
        let vcontroller = self.storyboard?.instantiateViewController(withIdentifier: "AddEquipmentViewController") as! AddEquipmentViewController;
        vcontroller.gotmechid = vselectedmechanicalId;
        vcontroller.gotmechtitle = vselectedmechtitrle;
         
        self.navigationController?.pushViewController(vcontroller, animated: true);
        
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
        
        
    }
    @IBAction func performinspectiontapped(_ sender: UIButton) {
        
        if Gmenu.count > 4
        {
            let isread =  Gmenu[4]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        if inspectionId == 0 ||  inspectionId == -1
        {

            let vConttroller = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "SuperDefaultInspectionViewController") as! SuperDefaultInspectionViewController
            vConttroller.isfromvone = true;
            mechanicalRoomID =  Int(vselectedmechanicalId)!;
            self.navigationController?.pushViewController(vConttroller, animated: true )
        }
        else
        {
            let vConttroller = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "AddInspectionSheetViewController") as! AddInspectionSheetViewController
             vConttroller.isfromvone = true;
            vConttroller.IspectionId = inspectionId
            inspectionIDG = inspectionId
            mechanicalRoomID = Int(vselectedmechanicalId)!;
            
            self.navigationController?.pushViewController(vConttroller, animated: true )
        }
        
        
        
        
        
        
    }
    @IBAction func vendorrepairtapped(_ sender: UIButton) {
        
        let vController = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "AddRepairViewController") as! AddRepairViewController
            
        
       // vController.mechId = mechId;
       // vController.equipmenId = equId;
        //vController.equipmentName = eqipTitle
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    @IBAction func scanBtnTapped(_ sender: UIButton) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "CBMechanicalScanEquipViewController") as! CBMechanicalScanEquipViewController
         
        self.navigationController?.pushViewController(vController, animated: false);
        
        
    }
    
    @objc func superdelete(_ sender : UIBotton)
    {
        if Gmenu.count > 4
        {
            let isread =  Gmenu[4]["isread"]!
            let isdelete =  Gmenu[4]["isnodelete"]!
            if isread == "1" ||  isdelete == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let deletealert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.jobstatus)", preferredStyle: .alert);
        deletealert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil));
        deletealert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_) in
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            
            let userid = cachem.string(forKey: "userid")!
            
            let Buildingapi = "\(vmechanicalEditDeleteSuperApi)\(sender.notes)/\(vselectedmechanicalId)"
            
            let checkNetwork = Reachability()!;
            
            
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
                return;
            }
            
            
            
            
            
            
            
            
           
            print(Buildingapi);
            Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil && resp.result.isSuccess
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        print(resp.result.value)
                        var resultdata =  JSON(resp.result.value!);
                        let alert = UIAlertController.init(title: "Success!", message: "Successfully deleted \(sender.jobstatus)", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                            self.loadingDefaultUI();
                        }))
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            // self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }))
        self.present(deletealert, animated: true, completion: nil);
        
        
        
        
        
    }
    
    
    
    @objc func equipmentdeleteTapped(_ sender : UIBotton)
    {
        
        if Gmenu.count > 5
        {
            let isread =  Gmenu[4]["isread"]!
            let isfull =  Gmenu[5]["isfull"]!
            let isnodelte =  Gmenu[5]["isnodelete"]!
            if isread == "1" || isnodelte == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
                
            }
            else if isfull == "1"
            {
                
            }
            else{
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
        }
        
       
        let deletealert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.jobstatus)", preferredStyle: .alert);
        deletealert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil));
        deletealert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_) in
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true);
             self.hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
             self.hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
             let Buildingapi = "\(vmechanicalEditEquipmentDeleteApi)\(sender.notes)"
            
            
            let checkNetwork = Reachability()!;
            
            
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
                return;
            }
            
            
            
            
            
            
            
            
            
            
           
            Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil && resp.result.isSuccess
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        print(resp.result.value)
                        var resultdata =  JSON(resp.result.value!);
                        let alert = UIAlertController.init(title: "Success!", message: "Successfully deleted \(sender.jobstatus)", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                            self.loadingDefaultUI();
                        }))
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            // self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }))
        self.present(deletealert, animated: true, completion: nil);
        
        
        
       
        
    }
    
    
    
    
    @IBAction func changedefaultinsbtntapped(_ sender: UIButton) {
        
        if Gmenu.count > 4
        {
            let isread =  Gmenu[4]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        
        let pdict = ["inspection_id" : selectedinsid,
                     "mech_id": vselectedmechanicalId
            
        ]
        let parms = ["cidata" : JSON(pdict)];
        print(parms);
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =    JSON(pdict)
                    let jdata =  deleteapidata.description
                    
                    let savestatsu =   saetolocaldatabase(jdata, "changedefaultinspection");
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
        
        
        Alamofire.request(vmechanicalupdateinsApi, method: .post, parameters: parms).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value)
                let resultdata =  JSON(resp.result.value!);
                
                
                isOfflineMode = false
                
                
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController.init(title: "Success!", message: "Successfully updated default inspection form", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                        self.hud.hide(animated: true);
                        self.loadingDefaultUI();
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        // self.getofflineStateCompanyList();
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                }
                
               
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    
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
        
        if row < pickerDataList.count
        {
            
            
            inspectionDropdown.text = pickerDataList[row]["name"].stringValue;
            selectedinsid = pickerDataList[row]["id"].stringValue;
            
            
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == equiptable
        {
            
                        if equipmentdataJn.count > 0
                        {
                            return equipmentdataJn.count;
                        }
                        else{
                            return 1;
                        }
            
            
        }
         else if tableView == supersTable
        {
            
                    if supersdataJn.count > 0
                    {
                        return supersdataJn.count;
                    }
                    else{
                        return 1;
                    }
            
            
            
        }
        else if tableView == self.popTabl.dropDownTable
        {
            
            if pickersuperlistdata.count > 0
            {
                 return pickersuperlistdata.count;
            }
            else{
                return 1;
            }
            
           
            
            
            
        }
        else{
            
            return 0;
            
        }
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if tableView ==  self.popTabl.dropDownTable{
            
            if pickersuperlistdata.count > 0
            {
                DispatchQueue.main.async {
                    self.hidePopView(UIButton());
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
                            let alert = UIAlertController.init(title: "Network Alert!", message: "Please check network connection and try again", preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil);
                        }
                        
                        // getOfflineBuildingData()
                        return;
                    }
                    
                    
                    let userid = cachem.string(forKey: "userid")!
                    let usertype = cachem.string(forKey: "userType")!;
                    var paramjson = Dictionary<String, String>();
                    paramjson["user_id"] = userid;
                    paramjson["title"] = vselectedmechanicalId;
                    paramjson["building_id"] = vselectedbuildingId;
                    
                    
                    let parameters = [
                        "mechdata":  JSON(paramjson)
                    ]
                    print(parameters);
                    
                    
                    Alamofire.request(vmechanicalSaveApi, method: .post, parameters : parameters).responseJSON { (resp) in
                        
                        print(resp);
                        print(resp.result);
                        
                        if resp.result.value != nil
                        {
                            DispatchQueue.main.async {
                                
                                self.hud.hide(animated: true);
                                let alert = UIAlertController.init(title: translator("Success!"), message: translator("Successfully added super"), preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                    isOfflineMode = true;
                                    DispatchQueue.main.async {
                                        
                                        
                                        self.loadingDefaultUI();
                                        
                                    }
                                    
                                }))
                                
                                
                                self.present(alert, animated: true, completion: nil);
                                
                                
                            }
                            
                            
                        }
                        else
                        {
                            DispatchQueue.main.async {
                                
                                self.hud.hide(animated: true);
                                
                                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                    
                                    
                                    
                                }))
                                
                                
                                self.present(alert, animated: true, completion: nil);
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                
                
                
                
                
                
                
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
    @objc func gotoEquipmentDetail(_ sender : UIBotton)
    {
        
        if Gmenu.count > 5
        {
            let isread =  Gmenu[4]["isread"]!
            let isfull =  Gmenu[5]["isfull"]!
            let isnodelte =  Gmenu[5]["isnodelete"]!
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
                
            }
            else if isfull == "1" || isnodelte == "1"
            {
                
            }
            else{
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
        }
        
        vselectedEquipmentID = sender.jobstatus;
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EquipmentDetailViewController") as! EquipmentDetailViewController
        self.navigationController?.pushViewController(controller, animated: true);
        
       
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == equiptable
        {
            if equipmentdataJn.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "equipmentTable") as! equiptablesuperCellClass
                cell.headerBtn.layer.cornerRadius = 5.0
                cell.headerBtn.setTitlein = indexPath;
                cell.headerBtn.setTitle(equipmentdataJn[indexPath.row]["title"].stringValue, for: .normal);
                cell.deleteBtn.jobstatus = equipmentdataJn[indexPath.row]["title"].stringValue;
                cell.deleteBtn.notes = equipmentdataJn[indexPath.row]["id"].stringValue;
                cell.headerBtn.jobstatus = equipmentdataJn[indexPath.row]["id"].stringValue;
                cell.deleteBtn.addTarget(self, action: #selector(equipmentdeleteTapped(_:)), for: .touchUpInside);
                cell.headerBtn.addTarget(self, action: #selector(gotoEquipmentDetail(_:)), for: .touchUpInside);
                return cell;
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 50);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                
                
                
                return emptycell;
            }
            
          
          
            
        }
        else if tableView == supersTable{
            if supersdataJn.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "supersTable") as! equiptablesuperCellClass
                cell.headerBtn.layer.cornerRadius = 5.0
                cell.headerBtn.setTitle(supersdataJn[indexPath.row]["name"].stringValue, for: .normal);
                cell.deleteBtn.jobstatus = supersdataJn[indexPath.row]["name"].stringValue;
                cell.deleteBtn.notes = supersdataJn[indexPath.row]["id"].stringValue;
                cell.deleteBtn.addTarget(self, action: #selector(superdelete(_:)), for: .touchUpInside);
                
                
                return cell;
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 50);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                
                
                
                return emptycell;
            }
            
           
        }
        else if tableView ==  self.popTabl.dropDownTable{
            if pickersuperlistdata.count > 0
            {
                let cell = UITableViewCell();
                cell.textLabel?.text = pickersuperlistdata[indexPath.row]["name"].stringValue;
                cell.textLabel?.textAlignment = .center
                return cell;
                
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 80);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                
                
                
                return emptycell;
            }
            
            
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
    
    func callingEditMechroomData()
    {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            //getOfflineBuildingData()
            
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
        
       
        let Buildingapi = "\(vmechanicalEditData)\(userid)/\(usertype)/\(vselectedmechanicalId)"
        print(Buildingapi);
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                let scode = resultdata["scode"].stringValue;
                
                if  scode == "200"
                {
                    
                    isOfflineMode = false
                    self.mechovberalldata = resultdata["response"];
                    self.supersdataJn = self.mechovberalldata["bsupers"].arrayValue;
                     self.equipmentdataJn = self.mechovberalldata["equipments"].arrayValue;
                     self.inspectionjn = self.mechovberalldata["inspections"].arrayValue;
                     self.allsuperdatajsn = self.mechovberalldata["supers"].arrayValue;
                    self.address1.text = self.mechovberalldata["address1"].stringValue;
                        self.addess2.text = self.mechovberalldata["address2"].stringValue;
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        var supersrowscount  = 1;
                        var equipmentrowcount  = 1;
                        if  self.supersdataJn.count > 0
                        {
                         supersrowscount = self.supersdataJn.count
                        }
                        if  self.equipmentdataJn.count > 0
                        {
                            equipmentrowcount = self.equipmentdataJn.count
                        }
                        let trows = supersrowscount + equipmentrowcount;
                        if self.inspectionjn.count > 0
                        {
                            self.inspectionht.constant = 170
                            self.inspectionvw.isHidden = false;
                            self.inspectionDropdown.text = self.inspectionjn[0]["name"].stringValue
                            self.inspectiontitlebtn.setTitle(self.inspectionjn[0]["name"].stringValue, for: .normal)
                            self.selectedinsid = self.inspectionjn[0]["id"].stringValue
                            self.inspectionId = self.inspectionjn[0]["id"].intValue
                            self.overallHt.constant = CGFloat(650 + trows * 60)
                        }
                        else
                        {
                            self.inspectionht.constant = 0;
                            self.inspectiontitlebtn.setTitle("Default Inspection Form", for: .normal)
                            self.inspectionvw.isHidden = true;
                            self.overallHt.constant = CGFloat(500 + trows * 60)
                        }
                        self.pickerDataList = self.inspectionjn;
                        
                        if Gmenu.count > 4
                        {
                            let isread =  Gmenu[4]["isread"]!
                            
                            if isread == "1"
                            {
                                self.inspectionDropdown.isUserInteractionEnabled = false;
                            }
                        }
                        
                        
                        
                        
                        self.equiptable.reloadData();
                         self.supersTable.reloadData();
                        self.backviefw.isHidden = false;
                        self.superstabht.constant = CGFloat(40 + supersrowscount * 60)
                        self.tableViewHt.constant = CGFloat(155 + equipmentrowcount * 60)
                        
                    
                        self.menuDropDown.reloadAllComponents();
                        self.hud.hide(animated: true);
                    }
                    
                    
                    
                    
                    
                }
                    
                else{
                    
                    DispatchQueue.main.async(execute: {
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: "Unknown error occured, please try again.", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        self.callingEditMechroomData();
                        
                        // self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
               
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    func getsuperpickerlist()
    {
        pickersuperlistdata = [JSON]();
        for l in 0..<allsuperdatajsn.count{
            var ismatched = false;
            let id = allsuperdatajsn[l]["id"].stringValue;
            for i in 0..<supersdataJn.count
            {
                let selectedid = supersdataJn[i]["id"].stringValue;
                if selectedid == id
                {
                    ismatched = true;
                }
               
                
            }
            if !ismatched
            {
                pickersuperlistdata.append(allsuperdatajsn[l]);
            }
            
            
            
        }
        
        print("im form get picker list");
        print(pickersuperlistdata);
        
        
    }
    func loadingDefaultUI()
    {
        menuDropDown.backgroundColor = UIColor.black;
        menuDropDown.dataSource = self;
        menuDropDown.delegate = self;
        menuDropDown.reloadAllComponents();
        inspectionDropdown.inputView = menuDropDown;
        backviefw.isHidden = true;
        headertitle.text = vselectedmechtitrle;
        
        changeBtn.layer.cornerRadius = 3.0
        changeBtn.clipsToBounds = true;
        
        scanBtn.layer.cornerRadius = 5.0
        scanBtn.clipsToBounds = true;
        
        performInspectionvw.layer.cornerRadius = 5.0
        performInspectionvw.clipsToBounds = true;
        
        
        signOutBtn.layer.cornerRadius = 5.0
        signOutBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
        
        addGrayBorders([backViw]);
        
        callingEditMechroomData()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
}







class equiptablesuperCellClass : UITableViewCell
{
    
    
 
    
    @IBOutlet weak var headerBtn: UIBotton!
    
    @IBOutlet weak var deleteBtn: UIBotton!
    
    
}
