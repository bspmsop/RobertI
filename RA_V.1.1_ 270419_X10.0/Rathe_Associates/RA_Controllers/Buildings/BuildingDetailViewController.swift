//
//  BuildingDetailViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 06/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import SwiftHEXColors
import SwiftyJSON
import Alamofire
import MBProgressHUD
import Reachability

class BuildingDetailViewController:  UIViewController , UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        loadingDefaultUI();
    }
    
    
    @IBOutlet weak var swapingtopConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var swapingView: ScrollingFollowView!
     var hud = MBProgressHUD();
    @IBOutlet weak var buildingheader: UILabel!
    
    
     var buildingDetailData = Dictionary<String, Any>();
     var buildingDjData = JSON();
    var buildingMechdata = [JSON]();
       var buildingSupersdata = [JSON]();
       var buildingManagersdata = [JSON]();
    
    
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
   
    
   
    let iMechRoom = Array<String>();
   
    let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    
    
    
    @objc func openmechroom(_ sender : UIBotton)
    {
        if Gmenu.count > 4
        {
            let isread =  Gmenu[4]["isread"]!
            let isdelete =  Gmenu[4]["isnodelete"]!
             let isfullaccess =  Gmenu[4]["isfull"]!
            let bisred = Gmenu[1]["isread"]!
            if bisred == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            if isread == "1" ||  isdelete == "1" || isfullaccess == "1"
            {
               
            }
            else
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "DetailCBMechanicalRoomViewController") as! DetailCBMechanicalRoomViewController;
        vselectedmechanicalId = sender.jobstatus;
        vselectedmechtitrle =  sender.notes
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
    }
    
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    
    
    @IBAction func deleteBtTapped(_ sender: UIButton) {
        
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
             let isdelete =  Gmenu[1]["isnodelete"]!
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
        alertview.descText.text = "You are about to delete a building with all mechanical rooms, equipments and assigned users.";
        self.view.addSubview(alertview);
        alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
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
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata = "\(vbuildingDeleteApi)\(vselectedbuildingId)"
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
        
        
      
        
        
        let buildingdetailapi = "\(vbuildingDeleteApi)\(vselectedbuildingId)"
        print(buildingdetailapi)
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                if resp.result.isSuccess
                {
                     isOfflineMode = false
                    
                    let alerrt = UIAlertController.init(title: "Success!", message: "Building deleted successfully", preferredStyle: .alert);
                    alerrt.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                        
                        self.navigationController?.popViewController(animated: true);
                        
                        
                    }));
                    self.present(alerrt, animated: true, completion: nil);
                    
                    
                    
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
    
    
    
    
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditBuildingViewController") as! EditBuildingViewController
        
        vController.buildingEidtData = buildingDjData;
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
          return 8;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
        case 0:
            
            return 2;
            
        case 1:
            if buildingMechdata.count > 0
            {
                return buildingMechdata.count;
            }
            else{
                return 1;
            }
            
        case 2:
            
            if buildingManagersdata.count > 0
            {
                return buildingManagersdata.count;
            }
            else{
                return 1;
            }
            
            
        case 3:
            
            if buildingSupersdata.count > 0
            {
                return buildingSupersdata.count;
            }
            else{
                return 1;
            }
            
         
            
        case 4:
            
             return 1
        case 5:
            return 1;
        case 6:
            return 1;
            
        case 7:
            
            return 1;
        case 8:
            
            return 1;
        case 9:
            
            return 1;
         
            
        default:
            return 0;
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 21] as! AddBuildingInitialCellClass
            cell.backViewHt.constant = 35;
            cell.imgwidth.constant = 0
            cell.backViw.backgroundColor = UIColor.white;
            if indexPath.row == 0
            {
                cell.headert.text = "Company:"
                //cell.companyfld.font = UIFont.systemFont(ofSize: 14)
                cell.companyfld.text =  buildingDjData["cname"].stringValue;
                
            }
            else{
                //cell.companyfld.font = UIFont.systemFont(ofSize: 14);
                cell.headert.text = "Property Code:";
                
                cell.companyfld.text =  buildingDjData["pcode"].stringValue;
            }
           
            
            return cell;
            
           
        case 1:
            
            
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 3] as! InspectionsubmitBtncellClass
            cell.loadingDefaultUI();
            
            cell.leftPadding.constant = 15;
            cell.rightPadding.constant = 15;
            
            cell.hoBtn.constant = 44
            cell.saveBtn.layer.cornerRadius = 5.0
             cell.topPadding.constant = 5
             cell.saveBtn.backgroundColor = UIColor.init(red: 0/255, green: 144/255, blue: 250/255, alpha: 1.0)
             cell.contentView.backgroundColor = UIColor.white;
          
            
            
            
            
            if buildingMechdata.count > 0
            {
                let mechtitile = buildingMechdata[indexPath.row]["title"].stringValue;
                cell.saveBtn.jobstatus = buildingMechdata[indexPath.row]["mid"].stringValue;
                cell.saveBtn.notes = buildingMechdata[indexPath.row]["title"].stringValue;
                cell.saveBtn.setTitle( mechtitile, for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(openmechroom(_:)), for: .touchUpInside);
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
            
            
            
            
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell4") as! BuildingDetailRowTitle
           
            if buildingManagersdata.count > 0
            {
                let mechtitile = buildingManagersdata[indexPath.row]["fullname"].stringValue;
                cell.rowTitle.text = mechtitile;
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
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell4") as! BuildingDetailRowTitle
            
            if buildingSupersdata.count > 0
            {
                let mechtitile = buildingSupersdata[indexPath.row]["fullname"].stringValue;
                cell.rowTitle.text = mechtitile;
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
            
           
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell4") as! BuildingDetailRowTitle
            cell.rowTitle.text =  buildingDjData["cluster"].stringValue;
            return cell;
            
        case 5:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell4") as! BuildingDetailRowTitle
            cell.rowTitle.text =  buildingDjData["location"].stringValue;
            return cell;
        case 6:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell4") as! BuildingDetailRowTitle
            cell.rowTitle.text =  buildingDjData["apt"].stringValue;
            
            return cell;
            
        case 7:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buildCell4") as! BuildingDetailRowTitle
           cell.rowTitle.numberOfLines = 100;
            
            cell.rowTitle.text =  buildingDjData["notes"].stringValue;
            
            return cell;
           
        default:
            
            let cell = UITableViewCell();
            return cell;
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            
            
            let headerv  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 27] as! buildingHeadCellClass
            headerv.address1.text = buildingDjData["address1"].stringValue
             headerv.address2.text = buildingDjData["address2"].stringValue
            
            return headerv;
            
            
            
            
        case 1:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            headerView.verytoplabel.isHidden = true;
            headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
            headerView.headtitle.text =  "Mehanical Rooms:"
            
            
            
            return headerView;
            
        case 2:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            let viewewr = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 3))
            viewewr.backgroundColor = UIColor.black;
            headerView.addSubview(viewewr);
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
             headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.headtitle.text =  "Building Managers:"
            
            
            return headerView;
        case 3:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            let viewewr = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 3))
            viewewr.backgroundColor = UIColor.black;
            headerView.addSubview(viewewr);
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
             headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.headtitle.text =  "Building Supers:"
            
            
            return headerView;
        case 4:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            let viewewr = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 3))
            viewewr.backgroundColor = UIColor.black;
            headerView.addSubview(viewewr);
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
             headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.headtitle.text =  "Cluster:"
            
            
            return headerView;
        case 5:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            let viewewr = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 3))
            viewewr.backgroundColor = UIColor.black;
            headerView.addSubview(viewewr);
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
             headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.headtitle.text =  "Location:"
            
            
            return headerView;
        case 6:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            let viewewr = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 3))
            viewewr.backgroundColor = UIColor.black;
            headerView.addSubview(viewewr);
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
             headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.headtitle.text =  "# of Apartments:"
            
            
            return headerView;
        case 7:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            let viewewr = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 3))
            viewewr.backgroundColor = UIColor.black;
            headerView.addSubview(viewewr);
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
             headerView.headtitle.textColor = UIColor.init(hexString: "00BBE6")
            headerView.headtitle.text =  "Notes:"
            
            
            return headerView;
        
            
            
        default:
            let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
            
            headerView.uppercons.constant  = 3;
            headerView.upperviwht.constant = 0
            headerView.headtitle.text =  "Building Managers:"
            
            
            return headerView;
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0
            {
                let usertype = cachem.string(forKey: "userType")!;
                if usertype != "0"
                {
                    return 0;
                }
               
                
            }
            
            
            return 70;
            
        case 1:
            if buildingMechdata.count < 1
            {
                return 50;
            }
            return 58
            
        case 2:
            if buildingManagersdata.count < 1
            {
                return 50;
            }
            return 30;
        case 3:
            if buildingSupersdata.count < 1
            {
                return 50;
            }
            return 30;
        case 4:
            return 30;
        case 5:
            return 30;
        case 6:
            return 30;
        case 7:
            let notedata =  buildingDjData["notes"].stringValue;
            if notedata.isEmpty
            {
                return 30;
            }
            else
            {
            return UITableViewAutomaticDimension;
            }
            
            
        default:
            return 0;
        }
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            
            return 70;
            
        case 1:
            return 25
            
        case 2:
             return 25
        case 3:
             return 25
        case 4:
             return 25
        case 5:
            return 25
        case 6:
            return 25
        case 7:
            return 25
        case 8:
            return 25
        case 9:
             return 25
            
            
        default:
            return 0;
        }
    }
    
    
    
    
    
    
    func getOfflineBuildingData()
    {
        
        
        if isOfflineMode
        {
            let localData = cachem.string(forKey: "offlinedata");
            let localJSON = JSON.init(parseJSON: localData!);
            let allbuilding = localJSON["buildings"].arrayObject
            
            for i in 0..<allbuilding!.count
            {
                let build1 = allbuilding![i] as! Dictionary<String, Any>
                 let build2 = build1["id"] as! Int
                
//                if build2 == vselectedbuildingId
//                {
//
//                    buildingDetailData = build1;
//
//                    DispatchQueue.main.async {
//                        self.detailTable.reloadData();
//                        self.hud.hide(animated: true);
//                    }
//
//                    return;
//
//                }
                
                
                
                
                
            }
            
           
            
            DispatchQueue.main.async {
                self.detailTable.reloadData();
                self.hud.hide(animated: true);
            }
            
            
        }
        else
        {
            
            
            let localData = cachem.string(forKey: "offlinedata");
            let localJSON = JSON.init(parseJSON: localData!)
            let alert = UIAlertController.init(title: translator("Network Alert"), message: translator("No network connection would you like to use offline data"), preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                
                
                let allbuilding = localJSON["buildings"].arrayObject
                isOfflineMode = true;
                for i in 0..<allbuilding!.count
                {
                    let build1 = allbuilding![i] as! Dictionary<String, Any>
                    let build2 = build1["id"] as! Int
                    
//                    if build2 ==  vselectedbuildingId
//                    {
//
//                        self.buildingDetailData = build1;
//                        DispatchQueue.main.async {
//                            self.detailTable.reloadData();
//                            self.hud.hide(animated: true);
//                        }
//
//                        return;
//
//                    }
//
                    
                    
                    
                    
                }
                
                
                
                DispatchQueue.main.async {
                    self.detailTable.reloadData();
                    self.hud.hide(animated: true);
                }
                
                
                
            }))
            
            alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                }
                
            }))
            self.present(alert, animated: true, completion: nil);
            return
        }
        
        
        
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
            
        
            //let userid = cachem.string(forKey: "userid")!
             let usertype = cachem.string(forKey: "userType")!;
        
            let buildingdetailapi = "\(vbuildingDetailData)\(vselectedbuildingId)/\(usertype)"
            print(buildingdetailapi)
            Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    print(resp.result.value!)
                     let buildinginfo =  JSON(resp.result.value!)
                    self.buildingDjData = buildinginfo["buildingInfo"];
                    self.buildingMechdata = self.buildingDjData["mechanicals"].arrayValue
                    self.buildingSupersdata = self.buildingDjData["supers"].arrayValue
                    self.buildingManagersdata = self.buildingDjData["managers"].arrayValue
                    self.buildingheader.text =  self.buildingDjData["address1"].stringValue;
                    
                    
                    
                    
                    
                        isOfflineMode = false
                    
                        DispatchQueue.main.async {
                            self.detailTable.reloadData();
                             self.detailTable.isHidden = false;
                            self.hud.hide(animated: true);
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
    
    
    
    
    
    
    
    
    //----- Default Func ----
    
    func loadingDefaultUI(){
        detailTable.isHidden = true;
        self.navigationController?.navigationBar.isHidden = true;
        detailTable.reloadData();
         callingBuildingDetail();
        
       CompatibleStatusBar(self.view);
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
    
    
    
    
    
    
    
    
    
    
    
}








//----------- Building Cell calasses ------------------------------









class buildingCell : UITableViewCell
{
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    
    
    
}


class buildingDetailcell : UITableViewCell
{
    
    
    
    @IBOutlet weak var detailTitle: UILabel!
    
    
    
    
}

class BuildingDetailheaderTitle : UITableViewCell
{
    @IBOutlet weak var headerLabel: UILabel!
    
    
    
    
}


class BuildingDetailRowTitle : UITableViewCell
{
    @IBOutlet weak var rowTitle: UILabel!
    
    
    
    
}
