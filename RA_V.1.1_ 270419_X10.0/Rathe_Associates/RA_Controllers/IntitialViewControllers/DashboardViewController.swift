//
//  DashboardViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 22/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gisFromDashboard = true;
        let tokenddata = cachem.string(forKey: "userdto")
        if tokenddata != nil
        {
            DispatchQueue.main.async {
                self.movetokentoserver(tokenddata!);
            }
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loadingDefaultUI();
        
    }
    
    
    
    var hud = MBProgressHUD();
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var totalviewHeight: NSLayoutConstraint!
    @IBOutlet weak var companyTitle: UILabel!
    @IBOutlet weak var comView: UIView!
    
    @IBOutlet weak var listHeight: NSLayoutConstraint!
    @IBOutlet weak var usersView: UIView!
    @IBOutlet weak var buildingsView: UIView!
    @IBOutlet weak var mechanicalroomsView: UIView!
    @IBOutlet weak var equipmentView: UIView!
    @IBOutlet weak var nmanagers: UILabel!
    @IBOutlet weak var nBuildings: UILabel!
    @IBOutlet weak var nRooms: UILabel!
    @IBOutlet weak var nEquipments: UILabel!
    @IBOutlet weak var backScoller: UIScrollView!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var buildingsBtn: UIButton!
    @IBOutlet weak var mechanicalroomBtn: UIButton!
    @IBOutlet weak var equipmentBtn: UIButton!
    @IBAction func userSscrentapped(_ sender: UIButton) {
        if sender.tag == 1
        {
            let builder = self.storyboard?.instantiateViewController(withIdentifier: "UserListingViewController") as! UserListingViewController;
            let nav = UINavigationController.init(rootViewController: builder);
            if self.revealViewController()  != nil
            {
                self.revealViewController()?.pushFrontViewController(nav, animated: true)
            }
            
        }
        else
        {
            let alert = UIAlertController.init(title: "Alert!", message: "User does not have access", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
        }
    }
    
    @IBAction func buildingTappeddd(_ sender: UIButton) {
        if sender.tag == 1
        {
            let builder = self.storyboard?.instantiateViewController(withIdentifier: "BuildingListViewController") as! BuildingListViewController;
            let nav = UINavigationController.init(rootViewController: builder);
            if self.revealViewController()  != nil
            {
                self.revealViewController()?.pushFrontViewController(nav, animated: true)
            }
        }
        else
        {
            let alert = UIAlertController.init(title: "Alert!", message: "User does not have access", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
        }
    }
    
    
    
    @IBAction func mechroomatappedd(_ sender: UIButton) {
        if sender.tag == 1
        {
            let builder = self.storyboard?.instantiateViewController(withIdentifier: "CBMechanicalRoomViewController") as! CBMechanicalRoomViewController;
            let nav = UINavigationController.init(rootViewController: builder);
            if self.revealViewController()  != nil
            {
                self.revealViewController()?.pushFrontViewController(nav, animated: true)
            }
            
        }
        else
        {
            let alert = UIAlertController.init(title: "Alert!", message: "User does not have access", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
        }
    }
    
    @IBAction func equipmentTapped(_ sender: UIButton) {
        if sender.tag == 1
        {
            print("im form equipment");
            let builder = self.storyboard?.instantiateViewController(withIdentifier: "EquipmetManagementViewController") as! EquipmetManagementViewController;
            let nav = UINavigationController.init(rootViewController: builder);
            if self.revealViewController()  != nil
            {
                self.revealViewController()?.pushFrontViewController(nav, animated: true)
            }
            
            
        }
        else
        {
            let alert = UIAlertController.init(title: "Alert!", message: "User does not have access", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
        }
    }
    
  
    
    
    func movetokentoserver(_ uidid : String)
    {
        
        var pjson = Dictionary<String, Any>();
        pjson["token"] = uidid;
        let vCustomInspectionSaveAsAPIss = registrationStatesAPI;
        print(vCustomInspectionSaveAsAPIss);
        Alamofire.request(vCustomInspectionSaveAsAPIss, method: .get, parameters: pjson).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            
        }
        
        
    }
    
    
    func callingDashboardData()
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
                
                let alert = UIAlertController.init(title: "Network Alert!", message: "No network connection would you like to use offline data", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    let dashboarddata = cachem.string(forKey: "dasher");
                    if dashboarddata != nil
                    {
                        
                        let fdata = JSON.init(parseJSON: dashboarddata!);
                        print("offline data \(fdata)");
                        print(fdata["bcount"].stringValue);
                        self.nBuildings.text = fdata["bcount"].stringValue
                        let rcn = fdata["rcount"].stringValue
                        self.nRooms.text = fdata["mcount"].stringValue
                        self.nEquipments.text = fdata["ecount"].stringValue
                        self.companyTitle.text = fdata["cname"].stringValue
                        let useracess = fdata["access"].stringValue
                        cachem.set(useracess, forKey: "useraccess")
                        
                        self.backScoller.isHidden = false;
                        if rcn.isEmpty
                        {
                            self.listHeight.constant = 0
                            self.comView.isHidden = true;
                        }
                        else{
                            self.nmanagers.text = rcn
                        }
                        self.loadingAccessData();
                        
                        
                    }
                    
                    
                    
                }));
                 alert.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                
                self.present(alert, animated: true, completion: nil)
            }
            
           
            return;
        }
        
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vDashboardDataApi)\(userid)/\(usertype)"
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value)
                var fdata =  JSON(resp.result.value!);
                
                    isOfflineMode = false
                self.callofflinejsonfile()
                    DispatchQueue.main.async {
                        let dashdata = fdata.description;
                        cachem.set(dashdata, forKey: "dasher")
                        self.nBuildings.text = fdata["bcount"].stringValue
                        let rcn = fdata["rcount"].stringValue
                        self.nRooms.text = fdata["mcount"].stringValue
                        self.nEquipments.text = fdata["ecount"].stringValue
                        self.companyTitle.text = fdata["cname"].stringValue
                        let useracess = fdata["access"].stringValue
                        cachem.set(useracess, forKey: "useraccess")
                        
                        self.backScoller.isHidden = false;
                        if rcn.isEmpty
                        {
                             self.listHeight.constant = 0
                            self.comView.isHidden = true;
                        }
                        else{
                             self.nmanagers.text = rcn
                        }
                        self.loadingAccessData();
                        self.hud.hide(animated: true);
                    }
                    
                    
                    
                    
                
                    
            
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        
                        self.callingDashboardData();
                        //self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
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
    
    
    func callofflinejsonfile()
    {
        
        
        
        
        
    }
    
    func loadingAccessData()
    {
        userBtn.tag = 0
        buildingsBtn.tag = 0
        equipmentBtn.tag = 0
        mechanicalroomBtn.tag = 0
        let useraccess = cachem.string(forKey: "useraccess")
        var accessFields = [String.SubSequence]();
        
        if useraccess != nil{
            
            accessFields = useraccess!.split(separator: ",")
            
        }
        Gmenu = [Dictionary<String, String>]();
        print(accessFields)
        
        let usertype = cachem.string(forKey: "userType")!;
        Gmenu = GPMenu;
        if usertype == "0"
        {
            userBtn.tag = 1
            buildingsBtn.tag = 1
            equipmentBtn.tag = 1
            mechanicalroomBtn.tag = 1
            Gmenu = GPAdmiMenu;
        }
            
        else{
            
            
            
            
            
            for i in 0..<accessFields.count
            {
                let acstr = accessFields[i]
                switch acstr
                {
                case "buildings_full":
                    Gmenu[1]["isfull"] = "1"
                     buildingsBtn.tag = 1
                    break;
                case "buildings_ndelete":
                    Gmenu[1]["isnodelete"] = "1"
                    buildingsBtn.tag = 1
                    break;
                case "buildings_ronly":
                    Gmenu[1]["isread"] = "1"
                    buildingsBtn.tag = 1
                    break;
                    
                case "custom_inspection_sheets_full":
                    Gmenu[2]["isfull"] = "1"
                    break;
                case "custom_inspection_sheets_ndelete":
                    Gmenu[2]["isnodelete"] = "1"
                    break;
                case "custom_inspection_sheets_ronly":
                    Gmenu[2]["isread"] = "1"
                    break;
                    
                case "equipment_test_full":
                    Gmenu[3]["isfull"] = "1"
                    break;
                case "equipment_test_ndelete":
                    Gmenu[3]["isnodelete"] = "1"
                    break;
                case "equipment_test_ronly":
                    Gmenu[3]["isread"] = "1"
                    break;
                    
                    
                case "mechanical_room_full":
                    mechanicalroomBtn.tag =  1
                    Gmenu[4]["isfull"] = "1"
                    break;
                case "mechanical_room_ndelete":
                    mechanicalroomBtn.tag =  1
                    Gmenu[4]["isnodelete"] = "1"
                    break;
                case "mechanical_room_ronly":
                    mechanicalroomBtn.tag =  1
                    Gmenu[4]["isread"] = "1"
                    break;
                    
                case "equipment_full":
                    equipmentBtn.tag = 1
                    Gmenu[5]["isfull"] = "1"
                    break;
                case "equipment_ndelete":
                    equipmentBtn.tag = 1
                    Gmenu[5]["isnodelete"] = "1"
                    break;
                case "equipment_ronly":
                    equipmentBtn.tag = 1
                    Gmenu[5]["isread"] = "1"
                    break;
                    
                case "inspections_full":
                    Gmenu[6]["isfull"] = "1"
                    break;
                case "inspections_ndelete":
                    Gmenu[6]["isnodelete"] = "1"
                    break;
                case "inspections_ronly":
                    Gmenu[6]["isread"] = "1"
                    break;
                    
                    
                case "sign_in_log_full":
                    Gmenu[8]["id2"] = "1"
                    break;
                case "sign_in_log_ndelete":
                    Gmenu[8]["id2"] = "1"
                    break;
                case "sign_in_log_ronly":
                    Gmenu[8]["id2"] = "1"
                    break;
                    
                case "inspection_reports_full":
                    Gmenu[8]["id3"] = "1"
                    break;
                case "inspection_reports_ndelete":
                    Gmenu[8]["id3"] = "1"
                    break;
                case "inspection_reports_ronly":
                    Gmenu[8]["id3"] = "1"
                    break;
                    
                case "etest_reports_full":
                    Gmenu[8]["id1"] = "1"
                    break;
                case "etest_reports_ndelete":
                    Gmenu[8]["id1"] = "1"
                    break;
                case "etest_reports_ronly":
                    Gmenu[8]["id1"] = "1"
                    break;
                    
                case "repairs_cost_reports_full":
                    Gmenu[8]["id4"] = "1"
                    break;
                case "repairs_cost_reports_ndelete":
                    Gmenu[8]["id4"] = "1"
                    break;
                case "repairs_cost_reports_ronly":
                    Gmenu[8]["id4"] = "1"
                    break;
                    
                case "audit_reports_full":
                    Gmenu[8]["id5"] = "1"
                    break;
                case "audit_reports_ndelete":
                    Gmenu[8]["id5"] = "1"
                    break;
                case "audit_reports_ronly":
                    Gmenu[8]["id5"] = "1"
                    break;
                    
                    
                case "company_settings_full":
                    Gmenu[9]["isfull"] = "1"
                    break;
                case "company_settings_ndelete":
                    Gmenu[9]["isnodelete"] = "1"
                    break;
                case "company_settings_ronly":
                    Gmenu[9]["isread"] = "1"
                    break;
                    
                case "user_management_full":
                    Gmenu[10]["isfull"] = "1"
                    userBtn.tag = 1
                    break;
                case "user_management_ndelete":
                    Gmenu[10]["isnodelete"] = "1"
                    userBtn.tag = 1
                    break;
                case "user_management_ronly":
                    userBtn.tag = 1
                    Gmenu[10]["isread"] = "1"
                    break;
                    
                
                   
                    
                    
                    
                    
                    
                default:
                    break;
                    
                    
                }
                
                
                
            }
            
        }
        
        
    }
    
    func loadingDefaultUI()
    {
       
        loadingAccessData()
        backScoller.isHidden = true;
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 130;
            self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer());
        }
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
       
       
      self.revealViewController()?.rearViewRevealWidth = self.view.frame.width * 0.7;
       CompatibleStatusBar(self.view);
       callingDashboardData();
        
         isFromBackGround = true;
          
       //  GlobalTimer.backgroundSyn.startSync(self);
        
        
        
    }
}
