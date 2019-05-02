//
//  MechanicalRoomDashboardViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 22/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
import FMDB

var DocumetLibaraymechId = ""

class MechanicalRoomDashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var mid = -1
    var mechTitle: String!
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]()
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var inspectionBtn: UIButton!
    @IBOutlet weak var addressOne: UILabel!
    @IBOutlet weak var addressTwo: UILabel!
    @IBOutlet weak var Equipment: UILabel!
    @IBOutlet var EquipmentTableHeight: NSLayoutConstraint!
    @IBOutlet weak var boilerInspectionDropDownBtn: UIButton!
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var headerTile: UILabel!
    @IBOutlet weak var usersBackView: UIView!
    var signId = -1
    var OsignId = "";
    @IBOutlet weak var scrollerHeight: NSLayoutConstraint!
    @IBOutlet weak var inspectionViewR: UIView!
    var mylocalDataId = "";
    
    
    
    
    
    
    
   
    
    override func viewDidLoad() {
       super.viewDidLoad()
        let userType = cachem.string(forKey: "userType")!
         DocumetLibaraymechId = "\(documentAPI)/\(mid)/\(userType)"
       
       loadingDefaultUI()
       apiData()
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        usersBackView.backgroundColor = UIColor.clear;
    }
    
    
    func getDataFromLocalDB()
    {
        
       // mechanicalRoomID
       // GbuildIdentifier
       // inspectionIDG
        
        
        let localData = cachem.string(forKey: "offlinedata");
        let localJSON = JSON.init(parseJSON: localData!)
        
        
        let buildingsData = localJSON["buildings"].arrayObject
        
        let anyData = buildingsData!
        for i in 0..<anyData.count
        {
            let builer = anyData[i] as! Dictionary<String, Any>;
            let builerIDE = builer["id"] as! Int;
            if GbuildIdentifier == builerIDE
            {
                
                let mymechData =  builer["mechanicals"] as! Array<Any>
                
                for j in 0..<mymechData.count
                {
                    
                    let mechroomData = mymechData[j] as! Dictionary<String, Any>;
                    let mechRoomId = mechroomData["id"] as! Int;
                    
                    if mechanicalRoomID == mechRoomId
                    {
                        
                        self.scroller.isHidden = false;
                        
                        let jmechData = JSON.init(mechroomData);
                        
                        let address1 = jmechData["address1"].stringValue
                        
                        let newString = jmechData["address2"].stringValue
                        
                        self.addressOne.text = address1
                        
                        self.addressTwo.text = newString
                        self.inspectionId = jmechData["inspection"]["insid"].intValue
                        inspectionIDG = jmechData["insid"].intValue
                        print(jmechData["inspection"]["insname"].stringValue)
                        if jmechData["inspection"]["insname"].stringValue == ""
                        {
                            self.boilerInspectionDropDownBtn.setTitle("Default Inspection Form", for: .normal)
                        }
                        else{
                        self.boilerInspectionDropDownBtn.setTitle(jmechData["inspection"]["insname"].stringValue, for: .normal)
                        }
                        if let resData = jmechData["equipments"].arrayObject {
                            self.arrRes = resData as! [[String:AnyObject]]
                            if   self.arrRes.count > 0
                            {
                                
                                self.EquipmentTableHeight.constant = CGFloat(self.arrRes.count * 40);
                                self.scrollerHeight.constant = CGFloat(390 + (self.arrRes.count * 40))
                            }
                            else{
                                self.EquipmentTableHeight.constant =  160
                                self.scrollerHeight.constant = 550
                            }
                        }
                        if self.arrRes.count > 0 {
                            self.tblJSON.separatorStyle = .singleLine;
                            self.tblJSON.reloadData()
                            
                        }
                        
                        
                        
                        break;
                    }
                   
                    
                }
                
                
                
              
                
                
                break;
            }
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
   
    func apiData() {
         scroller.isHidden = true;

        
        let netReach = Reachability()!


        if netReach.connection == .none
        {
          
            if isOfflineMode
            {
                
               getDataFromLocalDB()
                
                
                return;
            }
            else
                
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.getDataFromLocalDB()
                    
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                return
                
                
                
                
            }
        }
        
        
        



        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        
        
        let userType = cachem.string(forKey: "userType")!
        
        
         
        Alamofire.request("\(mechanicalRoomDashboardAPI)/\(mid)/\(userType)").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                isOfflineMode = false
                print(responseData.result.value);
                self.scroller.isHidden = false;
                print(responseData.result.value)
                let mediator = JSON(responseData.result.value!)
                let swiftyJsonVar = mediator["response"]
                
                
                
                
                let address1 = swiftyJsonVar["address1"].stringValue
                
                let newString = swiftyJsonVar["address2"].stringValue
                
               // self.addressOne.text = address1
                
               // self.addressTwo.text = newString
                self.inspectionId = swiftyJsonVar["insid"].intValue
                inspectionIDG = swiftyJsonVar["insid"].intValue
               let inspectioName = swiftyJsonVar["insname"].stringValue
                var myaddress1any = Dictionary<String, Any>();
                var myaddress2any = Dictionary<String, Any>();
                var myaddress3any = Dictionary<String, Any>();
                myaddress1any["title"] = address1
                myaddress2any["title"] = newString
                myaddress3any["title"] = inspectioName
                
                var mediatordict = Array<Any>();
                mediatordict =   self.arrRes;
                mediatordict.append(myaddress1any);
                mediatordict.append(myaddress2any);
                mediatordict.append(myaddress3any);
                self.tblJSON.separatorStyle = .singleLine;
                self.tblJSON.reloadData()
                self.addressOne.text = Apitranslator(address1, GconvertMechDashData)
                self.addressTwo.text = Apitranslator(newString, GconvertMechDashData)
                if swiftyJsonVar["insname"].stringValue == ""
                {
                    self.boilerInspectionDropDownBtn.setTitle(translator("Default Inspection Form"), for: .normal)
                }
                else{
                    self.boilerInspectionDropDownBtn.setTitle(Apitranslator(inspectioName, GconvertMechDashData) , for: .normal)
                }
                
                
                
                
                if let resData = swiftyJsonVar["equipments"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    if   self.arrRes.count > 0
                    {
                        
                        
                       
                        
                        convertIntoDict("title", mediatordict, ", . ", handler: { (_, mydict ) in
                            GconvertMechDashData = Dictionary<String, String>();
                            GconvertMechDashData = mydict;
                            self.tblJSON.separatorStyle = .singleLine;
                            self.tblJSON.reloadData()
                            self.addressOne.text = Apitranslator(address1, GconvertMechDashData)
                            self.addressTwo.text = Apitranslator(newString, GconvertMechDashData)
                            if swiftyJsonVar["insname"].stringValue == ""
                            {
                               self.boilerInspectionDropDownBtn.setTitle(translator("Default Inspection Form"), for: .normal)
                            }
                            else{
                                self.boilerInspectionDropDownBtn.setTitle(Apitranslator(inspectioName, GconvertMechDashData) , for: .normal)
                            }
                            
                            hud.hide(animated: true);
                        })
                        
                        
                        
                        
                        hud.hide(animated: true);
                        self.EquipmentTableHeight.constant = CGFloat(self.arrRes.count * 40);
                        self.scrollerHeight.constant = CGFloat(390 + (self.arrRes.count * 40))
                    }
                    else{
                        hud.hide(animated: true);
                        self.EquipmentTableHeight.constant =  160
                        self.scrollerHeight.constant = 550
                    }
                }
                if self.arrRes.count > 0 {
                    hud.hide(animated: true);
                    self.tblJSON.separatorStyle = .singleLine;
                    self.tblJSON.reloadData()
                    
                }
                 else
                {
                    
                     hud.hide(animated: true);
                    
                    
                }
                
            }
            else
            {
                //                let alert = UIAlertController.init(title: "Failed", message: "Your request has been timed out!. Please try again.", preferredStyle: .alert);
                //                alert.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: nil))
                //                alert.addAction(UIAlertAction.init(title: "Try Again!", style: .default, handler: { (_) in
                //                    self.apiData()
                //                }))
                //                self.present(alert, animated: true, completion: nil);
                
                 hud.hide(animated: true);
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out Would you like to use offline data"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.getDataFromLocalDB()
                    
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                
                hud.hide(animated: true);
            }
        }
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        var numOfSections: Int = 0
        if arrRes.count > 0
        {
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = translator("No data available")
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle = .none;
        }
        return numOfSections
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrRes.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "eqpCell") as! SuperDashboardEquipmentCellClass
        var dict = arrRes[indexPath.row]
        //print(dict)
        let titleData = dict["title"] as! String
        cell.title.text = Apitranslator(titleData, GconvertMechDashData)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var dict = arrRes[indexPath.row]
        
        let eqpTitle =  dict["title"] as! String
        let eqpModel = dict["model"] as? String
        let eqpSerial = dict["serial"] as? String
        
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EquipmentViewController") as! EquipmentViewController
       
        let equipmentId = dict["id"] as? Int
       
        print(equipmentId);
        
        if equipmentId == nil
        {
            controller.equId =  -1;
            GequipmentId = -1
        }
        else
        {
            controller.equId = equipmentId!
            GequipmentId = equipmentId!
            
        }
        
         controller.mechId = mid
        controller.eqipTitle = Apitranslator(eqpTitle, GconvertMechDashData);
        controller.eqipModel =  eqpModel
        controller.eqipSerial = eqpSerial
        controller.mechanicalTitle = headTitle;
        controller.effId = dict["effid"] as! Int
        print(controller.effId);
        let efficiencyname = dict["effname"] as? String
        if efficiencyname != nil
        {
            controller.efficiencyTitle = efficiencyname!
            
        }
        
         self.navigationController?.pushViewController(controller, animated: true)
        
        
        
    }
    
    
    @IBAction func getMechanicalDocuments(_ sender: Any) {
        let userType = cachem.string(forKey: "userType")!
        DocumetLibaraymechId = "\(documentAPI)/\(mid)/\(userType)"
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        let mcontroller = storyboard.instantiateViewController(withIdentifier: "NewDocumentLibraryViewController") as! NewDocumentLibraryViewController
       
        
        let nav = UINavigationController.init(rootViewController: mcontroller)
          GlobalNav2   = nav
        
        self.present(nav, animated: false, completion: nil);
       
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  40
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true;
        
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let items = arrRes[sourceIndexPath.row];
        arrRes.remove(at: sourceIndexPath.row);
        arrRes.insert(items, at: destinationIndexPath.row);
        
        
        
        let netReachc = Reachability()!
        
        
        if netReachc.connection != .none
        {
            callorderchangeApi();
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        
        
        return .none;
    }
    
    
    
    
    func callorderchangeApi()
    {
        
        
        
        
        
        
    }
    
    
    
    
    
    func offlineSigOut()
    {
        
        
        
        //create table signInLog(userid varchar(50), mechId Integer, userType varchar(50), dateSignIn archer(20) );
        let filePath = getPath(fileName: locale_DB);
        let RAdb = FMDatabase.init(path: filePath);
        
        
        
        guard RAdb.open() else {
            print("Unable to open database")
            return
        }
        print("data base is opened");
        
        
        do {
            
            let datewForm = DateFormatter()
            datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let tdate = datewForm.string(from: Date());
            
            
            
            try RAdb.executeUpdate("insert into signInLog(signInId, dateSignOut) values (?, ?)", values: [signId, tdate])
            
            
            
            
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        RAdb.close()
        
        
        let alert = UIAlertController.init(title: translator("Success"), message: translator("User Signout Mechanical Room"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil);
            GlobalNav = nil
            GlobalNav2 = nil
            
            GlobalTimer.sharedTimer.stopTimer();
            
        }))
        self.present(alert, animated: true, completion: nil);

        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    @IBAction func signOut(_ sender: Any)
    {
        if signId == -1
        {
           
            let alert = UIAlertController.init(title: translator("Success"), message: translator("User Signout Mechanical Room"), preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                self.dismiss(animated: true, completion: nil);
                GlobalNav = nil
                GlobalNav2 = nil
                
                GlobalTimer.sharedTimer.stopTimer();
                
            }))
            self.present(alert, animated: true, completion: nil);

            
            
            
        }
        else
        {
           
            
            
            
            let netReach = Reachability()!
            
            
            if netReach.connection == .none
            {
                
                if isOfflineMode
                {
                    
                     self.offlineSigOut()
                    
                    
                    return;
                }
                else
                    
                {
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        self.offlineSigOut()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    return
                    
                    
                    
                    
                }
            }
            
            
            

            
            
            
            
            
            
            
            
        
        let userType = cachem.string(forKey: "userType")!
        
        let parameters: Parameters = [
            "signin_id": signId,
            "user_type" : userType
            
            
        ]
        print(parameters);
        
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        Alamofire.request(signOutFromMechRoomAPI, method: .post, parameters: parameters).responseJSON { (resp) in
            
            hud.hide(animated: true);
            if resp.result.value != nil
            {
                print(resp.result.value)
                 isOfflineMode = false
                
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    let message = resultdata["message"] as! String
                    let alert = UIAlertController.init(title: translator("Success"), message: translator("User Signout Mechanical Room"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil);
                        GlobalNav = nil
                        GlobalNav2 = nil
                        
                        GlobalTimer.sharedTimer.stopTimer();
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                else{
                    
                    let mes = resultdata["message"] as! String
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
            }
            else
            {
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out Would you like to use offline data"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.offlineSigOut()
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                
//                let alert = UIAlertController.init(title: "Failed", message: "Please check your network connection!!!", preferredStyle: .alert);
//                alert.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: nil))
//                self.present(alert, animated: true, completion: nil);
                
                
            }
            
            
        }} 


    }


        
        
        
    @IBAction func scanTapped(_ sender: Any) {
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "ScanQRCodeReaderViewController") as! ScanQRCodeReaderViewController
        
       for i in 0..<arrRes.count
       {
        let id = arrRes[i]["id"] as! Int
        vController.equipment_ids.append(id);
        
        
        }
         vController.headTitle = headTitle
        vController.arrRes = arrRes
        self.navigationController?.pushViewController(vController, animated: false);
    }
    


    
    
    
    var inspectionId = -1
    @IBAction func performInspectionSheetTapped(_ sender: UIButton) {
        
        
        
       
        if inspectionId == 0 ||  inspectionId == -1
        {
            
            let vConttroller = self.storyboard?.instantiateViewController(withIdentifier: "SuperDefaultInspectionViewController") as! SuperDefaultInspectionViewController
            
             self.navigationController?.pushViewController(vConttroller, animated: true )
        }
        else
        {
            let vConttroller = self.storyboard?.instantiateViewController(withIdentifier: "AddInspectionSheetViewController") as! AddInspectionSheetViewController
            vConttroller.IspectionId = inspectionId
            self.navigationController?.pushViewController(vConttroller, animated: true )
        }
        
        
        
       
    }
    @IBAction func usersTapped(_ sender: UIButton) {
        
        usersBackView.backgroundColor = UIColor.init(red: 124/255, green: 125/255, blue: 126/255, alpha: 1.0)
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        let mcontroller = storyboard.instantiateViewController(withIdentifier: "VendorRepairListViewController") as! VendorRepairListViewController
        mcontroller.headerTile = headTitle;
        
        let nav = UINavigationController.init(rootViewController: mcontroller)
        GlobalNav2   = nav
        
        self.present(nav, animated: false, completion: nil);
        
        
        
    }
    
    
    var headTitle = ""
    
    
    
    func loadingDefaultLang()
    {
        Equipment.text = translator("Equipment");
        
        scanBtn.setTitle(translator("Scan Equipment"), for: .normal);
        inspectionBtn.setTitle(translator("Perform Inspection"), for: .normal);
        signOutBtn.setTitle(translator("Sign out").uppercased(), for: .normal);
        
        
    }
    
    
    
    
    func loadingDefaultUI()
    {
        inspectionViewR.layer.cornerRadius = 5.0
        scanBtn.layer.cornerRadius = 5.0
        
        signOutBtn.layer.cornerRadius = 5.0
        tblJSON.isEditing = true;
        tblJSON.allowsSelectionDuringEditing = true;
        
        CompatibleStatusBar(self.view);
        self.navigationController?.navigationBar.isHidden = true;
         self.headerTile.text = headTitle
         GroomTitle = headTitle;
        DocumentHeader = headTitle
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
      loadingDefaultLang()
        
        
    }
    
    override var shouldAutorotate: Bool{
        return false;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
    {  return .portrait
    }
}




class SuperDashboardEquipmentCellClass : UITableViewCell
{
    
    @IBOutlet weak var title: UILabel!
    
    
    
}
