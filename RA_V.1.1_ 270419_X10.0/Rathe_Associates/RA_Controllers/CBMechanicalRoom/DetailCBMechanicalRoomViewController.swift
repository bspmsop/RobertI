//
//  DetailCBMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 25/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability

class DetailCBMechanicalRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loadingDefaultUI();
        
    }
    
      var hud = MBProgressHUD();
    
   
    @IBOutlet weak var innervw: UIView!
    @IBOutlet weak var uppertitlehead: UILabel!
    @IBOutlet weak var tableViwHt: NSLayoutConstraint!
    @IBOutlet weak var superViewHt: NSLayoutConstraint!
    @IBOutlet weak var supersTable: UITableView!
    @IBOutlet weak var supertableht: NSLayoutConstraint!
    @IBOutlet weak var equipmentTable: UITableView!
    @IBOutlet weak var buildingManagersTable: UITableView!
    @IBOutlet weak var mangerstableht: NSLayoutConstraint!
    
    var mechequipmentdata = [JSON]();
    var mechsuperesdata = [JSON]();
    var mechmanagersdata = [JSON]();
    var mechanicaldetaildta = JSON();
    @IBOutlet weak var address1lab: UILabel!
    @IBOutlet weak var address2lab: UILabel!
    
     let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    
    
    
    
    
    @objc func openequipmentdetailsdata(_ sender : UIBotton)
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
        
        
        vselectedEquipmentID = sender.notes;
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EquipmentDetailViewController") as! EquipmentDetailViewController
        self.navigationController?.pushViewController(controller, animated: true);
        
      
        
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true);
    }
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        
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
        
        alertview.cancelBtn.layer.cornerRadius = 4.0
        alertview.deleteBtn.layer.cornerRadius = 4.0
        alertview.frame = self.view.frame;
        self.view.addSubview(alertview);
        alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.descText.text = "You are about to delete a mechanical room with all equipment and assigned users.";
        
        alertview.deleteBtn.addTarget(self, action: #selector(deletemechroom(_:)), for: .touchUpInside);
        
        
        
        
        
        
    }
    
    @objc func deletemechroom(_ sender : UIBotton)
    {
        
      
        
        alertview.removeFromSuperview();
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        let buildingdetailapi = "\(vmechanicalDeleteApi)\(vselectedmechanicalId)"
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =   buildingdetailapi
                    let jdata =  deleteapidata;
                    
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
        
        
        
        
        
        
        
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                if resp.result.isSuccess
                {
                    isOfflineMode = false
                    
                    let alerrt = UIAlertController.init(title: "Success!", message: "Mechanical Room deleted successfully", preferredStyle: .alert);
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          warningMessage = "You are about to delete a mechanical room with all equipment and assigned users."
    }
   
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == equipmentTable
        {
            if mechequipmentdata.count > 0
            {
                return mechequipmentdata.count;
            }
            return 1;
            
        }
        else if tableView == supersTable
        {
            if mechsuperesdata.count > 0
            {
                return mechsuperesdata.count
            }
            return 1;
            
        }
        else
        {
            if mechmanagersdata.count > 0
            {
            return mechmanagersdata.count
            }
            return 1;
            
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == equipmentTable
        {
        
            if mechequipmentdata.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "equipTitleCell") as! DetailEquipmentCellBtnClass
                cell.equipmentBtn.layer.cornerRadius = 5.0
                cell.equipmentBtn.notes = mechequipmentdata[indexPath.row]["id"].stringValue;
                cell.equipmentBtn.addTarget(self, action: #selector(openequipmentdetailsdata(_:)), for: .touchUpInside)
                cell.equipmentBtn.setTitle(mechequipmentdata[indexPath.row]["title"].stringValue, for: .normal);
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
        else if tableView == supersTable
        {
            if mechsuperesdata.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "supertitle") as! EquipmectTitleCellClass
                cell.title.text = mechsuperesdata[indexPath.row]["fullname"].stringValue
                
                return cell;
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 30);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                
                
                
                return emptycell;
            }
            
            
        }
        else
        {
            if mechmanagersdata.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "buildingmanagers") as! EquipmectTitleCellClass
                cell.title.text = mechmanagersdata[indexPath.row]["fullname"].stringValue
                return cell;
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 30);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                
                
                
                return emptycell;
            }
            
           
            
        }
        
        
        
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == equipmentTable
        {
            
            
            return 60;
        }
        else
        {
             return 30;
        }
        
    }
    
    
    
    
    
    func callingMechdetailData()
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
            return;
        }
        
        
        
        
        
        
        
        
        
        
        let Buildingapi = "\(vmechanicalDetailApi)\(vselectedmechanicalId)"
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
                   self.mechanicaldetaildta = resultdata["response"]
                    self.mechsuperesdata = self.mechanicaldetaildta["supers"].arrayValue
                     self.mechmanagersdata = self.mechanicaldetaildta["managers"].arrayValue
                    self.mechequipmentdata = self.mechanicaldetaildta["equipments"].arrayValue
                    
                    DispatchQueue.main.async {
                        
                        var supersdatacount = 1
                        var managersdatacount  = 1
                        var equipmentdatacountr = 1
                        if self.mechequipmentdata.count > 0
                        {
                            equipmentdatacountr = self.mechequipmentdata.count;
                        }
                        if self.mechsuperesdata.count > 0
                        {
                            supersdatacount = self.mechsuperesdata.count;
                        }
                        if self.mechmanagersdata.count > 0
                        {
                            managersdatacount = self.mechmanagersdata.count;
                        }
                        
                        
                        let totalcount =  supersdatacount + managersdatacount;
                        self.tableViwHt.constant = CGFloat(130 + equipmentdatacountr * 60)
                        self.superViewHt.constant = CGFloat(400 + (equipmentdatacountr * 60) + (totalcount * 30))
                        self.supertableht.constant = CGFloat(40 + supersdatacount * 30)
                        self.mangerstableht.constant = CGFloat(40 + managersdatacount * 30)
                        self.address1lab.text =  self.mechanicaldetaildta["address1"].stringValue;
                        self.address2lab.text = self.mechanicaldetaildta["address2"].stringValue;
                        self.buildingManagersTable.reloadData();
                        self.supersTable.reloadData();
                        self.equipmentTable.reloadData();
                      self.innervw.isHidden = false;
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
                        
                        self.callingMechdetailData()
                        // self.getOfflineBuildingData()
                        
                        
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
        innervw.isHidden = true;
        uppertitlehead.text = vselectedmechtitrle;
        
        callingMechdetailData();
        
         CompatibleStatusBar(self.view);
        
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
        
    }
    
}


class DetailEquipmentCellBtnClass : UITableViewCell
{
    
    @IBOutlet weak var equipmentBtn: UIBotton!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




class EquipmectTitleCellClass : UITableViewCell
{
    
    @IBOutlet weak var title: UILabel!
    
    
    
    
    
}
