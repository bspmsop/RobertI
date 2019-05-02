//
//  AddCBMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 25/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import SwiftHEXColors
import SwiftyJSON
import Alamofire
import MBProgressHUD
import Reachability

class AddCBMechanicalRoomViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
     loadingDefaultUI()
      AddCBMechanicalRoomViewController.newequipdata = nil
    }
    
    
    @IBOutlet weak var addNewEquipmentBtn: UIButton!
    @IBOutlet weak var createMechanicalRoomBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
     let menuDropDown = UIPickerView();
    var pickerDataList = Array<JSON>();
    @IBOutlet weak var secondNameViw: UIView!
    @IBOutlet weak var firstNmeViw: UIView!
    var hud = MBProgressHUD();
    var selectedbuildid = "";
    @IBOutlet weak var selectbuildbox: UITextFeild!
    @IBOutlet weak var mechancalroomname: UITextFeild!
    public static var newequipdata : JSON?;
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    @IBAction func addequipmetnTapped(_ sender: UIButton) {
        
        if Gmenu.count > 5
        {
            let isfull =  Gmenu[5]["isfull"]!
             let isnodelte =  Gmenu[5]["isnodelete"]!
            
            if isfull == "1" || isnodelte == "1"
            {
                
            }
            else{
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
           
            
            
        }
        
        let mroomtitle = mechancalroomname.text
        if mroomtitle != nil
        {
            let rromnaem = mroomtitle!
            if rromnaem.isEmpty
            {
                let alert = UIAlertController.init(title: "Alert!", message: "Please enter mechanical room name", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
               
                
            }
            else
            {
                let vcontroller = self.storyboard?.instantiateViewController(withIdentifier: "AddEquipmentViewController") as! AddEquipmentViewController;
                vcontroller.gotmechid = "-1";
                vcontroller.gotmechtitle = rromnaem;
                self.navigationController?.pushViewController(vcontroller, animated: true);
                
            }
           
        }
        else
        {
            
            let alert = UIAlertController.init(title: "Alert!", message: "Please enter mechanical room name", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
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
         pickerView.backgroundColor = UIColor.black;
        if row < pickerDataList.count{
           selectbuildbox.text = pickerDataList[row]["name"].stringValue;
        selectedbuildid =  pickerDataList[row]["id"].stringValue;
        }
    }
    
    
    @IBAction func createMechroom(_ sender: UIButton) {
        
        if !selectedbuildid.isEmpty && !mechancalroomname.text!.isEmpty
        {
            
            
            
            
            hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            
            
            
            let checkNetwork = Reachability()!;
            
            
            
            
            
            let userid = cachem.string(forKey: "userid")!
            let usertype = cachem.string(forKey: "userType")!;
            var paramjson = Dictionary<String, Any>();
            paramjson["user_id"] = userid;
            paramjson["title"] = mechancalroomname.text!;
                paramjson["building_id"] = selectedbuildid;
            
            if AddCBMechanicalRoomViewController.newequipdata != nil
            {
                let myjsondataeqp = AddCBMechanicalRoomViewController.newequipdata!
                paramjson["eqpname"] = myjsondataeqp["eqpname"]
                paramjson["model"] = myjsondataeqp["model"]
                paramjson["serial"] = myjsondataeqp["serial"]
                paramjson["eqptform"] = myjsondataeqp["eqptform"]
                paramjson["documents"] = myjsondataeqp["documents"]
                
            }
            
            
            let parameters = [
                "mechdata":  JSON(paramjson)
            ]
            print(parameters);
            
            
            if checkNetwork.connection == .none
            {
                DispatchQueue.main.async {
                    self.hud.hide(animated: true);
                    let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                    alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                    alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                        
                        let deleteapidata =     JSON(paramjson)
                        let jdata =  deleteapidata.description
                        
                        let savestatsu =   saetolocaldatabase(jdata, "savemechroom");
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
            
          
            Alamofire.request(vmechanicalSaveApi, method: .post, parameters : parameters).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    let alert = UIAlertController.init(title: translator("Success!"), message: translator("Mechanical Room added to the building."), preferredStyle: .alert);
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
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
            
            
        }
        else
        {
            let alert = UIAlertController.init(title: "Alert!", message: "Please select required fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil);
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    func callingBuildingList()
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
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler:   nil));
                self.present(alert, animated: true, completion: nil);
            }
            
            // getOfflineBuildingData()
            return;
        }
        
        
         let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi = "\(vmechanicalBuildinglistapi)\(userid)/\(usertype)"
        print(buildingdetailapi);
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                self.pickerDataList = buildinginfo["response"].arrayValue;
               
 
                
                
                isOfflineMode = false
                
                DispatchQueue.main.async {
                    
                      self.menuDropDown.backgroundColor = UIColor.black;
                     self.menuDropDown.reloadAllComponents();
                    self.hud.hide(animated: true);
                }
                
                
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        
                        self.callingBuildingList();
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
                
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    func  loadingDefaultUI()
    {
        
       
        
        addNewEquipmentBtn.layer.cornerRadius  = 5.0
        addNewEquipmentBtn.clipsToBounds = true;
          menuDropDown.backgroundColor = UIColor.black;
        menuDropDown.dataSource = self;
        menuDropDown.delegate = self;
         menuDropDown.reloadAllComponents();
      
        selectbuildbox.inputView = menuDropDown;
        createMechanicalRoomBtn.layer.cornerRadius  = 5.0
        createMechanicalRoomBtn.clipsToBounds = true;
        
        closeBtn.layer.cornerRadius  = 5.0
        closeBtn.clipsToBounds = true;
         CompatibleStatusBar(self.view);
        addGrayBorders([firstNmeViw, secondNameViw]);
        callingBuildingList()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
    

}
