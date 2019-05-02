//
//  SyncDataNewViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 29/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//
import Foundation
import UIKit
import Reachability
import SwiftyStoreKit
import StoreKit
import ScrollingFollowView
import SWRevealViewController
import Alamofire
import FMDB
import MBProgressHUD
import SwiftyJSON

class SyncDataNewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         isFromBackGround = false;
        isEmergencyStop = true;
        loadingDefaultUI();
    }
    
    func alertshow()
    {
        
        self.synchud.hide(animated: true);
        let alert = UIAlertController.init(title: translator("Alert"), message: translator("An internal problem occured, please try again"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
    func loadingDefaultUI()
    {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
        
        if self.revealViewController() != nil
        {
            menuBUtton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            
        }
        self.navigationController?.navigationBar.isHidden = true;
        CompatibleStatusBar(self.view);
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var synchud = MBProgressHUD();
    var syncBtn = UIButton();
    var  helpview = UITextView();
    @IBOutlet weak var menuBUtton: UIButton!
    var dropper = Timer();
    
    
    @IBAction func syncTapped(_ sender: UIButton) {
        isEmergencyStop = true;
        
          synchud = MBProgressHUD.showAdded(to: self.view, animated: true);
        synchud.label.text = "Fetching your local Data..."
        synchud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        synchud.bezelView.color = UIColor.white;
        
        dropper = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(checkacceptdata(_:)), userInfo: nil, repeats: true);
       
       
        
    }
    
    
    @objc func checkacceptdata(_ sender : Timer)
    {
    
        print("timera aran...");
        if sethteflow
        {
             dropper.invalidate();
            fetchingLocalDB();
          
        }
    
    }
    
    
    var addbuildingOfflinedata = Array<Dictionary<String, Any>>();
     var updatebuildingdta = Array<Dictionary<String, Any>>();
    var addmechroomtobuilddata = Array<Dictionary<String, Any>>();
     var addmanagerstoabuilddata = Array<Dictionary<String, Any>>();
    var addsupertobuildadata = Array<Dictionary<String, Any>>();
    var deletealldatass = Array<Dictionary<String, Any>>();
     var addequipmentapidata = Array<Dictionary<String, Any>>();
     var updateEquipmedata = Array<Dictionary<String, Any>>();
     var addcustomInspectiondata = Array<Dictionary<String, Any>>();
    var addEfficiencyTestAPIData = Array<Dictionary<String, Any>>();
     var customInsSaveApiData = Array<Dictionary<String, Any>>();
    var equipmentTestSaveASApiData = Array<Dictionary<String, Any>>();
    var mechdefaultInsApiData = Array<Dictionary<String, Any>>();
    
    
    var mechdefaultInSCount = 0
    var equipmetnSaveASCount = 0;
    var customInsSaveCout = 0;
    var addEfficiencydatacount = 0
    var addCustomInspectionCount = 0
    var updateEqqqcount = 0
    var addequipmetdatcount = 0
    var deletealldatacount = 0
    var addmnagerstobuildcount  = 0 ;
    var addbuildcount = 0;
    var updatebuildCount = 0;
    var addmechroomtobuildcount = 0;
    var addsuperbuildcount = 0;
    
    func fetchingLocalDB()
    {
        
        print("data fetching strted..");
        editorVendorId = 0
        localvendorId = 0;
        signInmechCounter = 0;
        inspectionGCounter = 0;
        efficiencyGCounter = 0;
        addmnagerstobuildcount  = 0 ;
        addsuperbuildcount = 0;
        
        LVCcount = 0
        EVCount = 0
        MSCount = 0
        InCount =  0
        EffCount = 0
        DOCount  = 0
        TCCount  = 0
        NCCount = 0
        addequipmetdatcount = 0
        addbuildcount = 0
        updatebuildCount = 0
        updateEqqqcount = 0
        addmechroomtobuildcount = 0
        deletealldatacount = 0
        addCustomInspectionCount = 0
        addEfficiencydatacount = 0
         customInsSaveCout = 0;
        equipmetnSaveASCount = 0;
         mechdefaultInSCount = 0
        
        addbuildingOfflinedata = Array<Dictionary<String, Any>>();
        addmechroomtobuilddata = Array<Dictionary<String, Any>>();
          updatebuildingdta = Array<Dictionary<String, Any>>();
           addmanagerstoabuilddata = Array<Dictionary<String, Any>>();
          addsupertobuildadata = Array<Dictionary<String, Any>>();
        deletealldatass = Array<Dictionary<String, Any>>();
          addequipmentapidata = Array<Dictionary<String, Any>>();
        updateEquipmedata = Array<Dictionary<String, Any>>();
          addcustomInspectiondata = Array<Dictionary<String, Any>>();
          addEfficiencyTestAPIData = Array<Dictionary<String, Any>>();
        customInsSaveApiData = Array<Dictionary<String, Any>>();
          equipmentTestSaveASApiData = Array<Dictionary<String, Any>>();
          mechdefaultInsApiData = Array<Dictionary<String, Any>>();
        
        
        
        
        
        
        
        
        
        
        
       
        
        
        
        localVendorData = Array<Dictionary<String, Any>>();
        editedVendorData = Array<Dictionary<String, Any>>();
        mechSignInData = Array<Dictionary<String, Any>>();
        inspectionGData = Array<Dictionary<String, Any>>();
        efficiencyGData = Array<Dictionary<String, Any>>();
        
        
        let defaultValues = UserDefaults.standard
        GSuserid = defaultValues.string(forKey: "userid")
        GSuserType = defaultValues.string(forKey: "userType")
        
        
        
        
        let mynetwork = Reachability()!
        if mynetwork.connection == .none
        {
                self.synchud.hide(animated: true);
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("No network connection please try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        let filePath = getPath(fileName: locale_DB);
        
        let RAdb = FMDatabase.init(path: filePath);
        guard RAdb.open() else {
            print("Unable to open database")
            return
        }
        do {
            
            let defaultValues = UserDefaults.standard
            let userid = defaultValues.string(forKey: "userid")
            
            
            
            //vendorList2---------------------------------------------------------------------------------------------------------------
            
            let rs = try RAdb.executeQuery("select * from vendorList2 where userid = ?", values: [userid!])
            while rs.next() {
                if let x = rs.string(forColumn: "vendorname"), let y = rs.string(forColumn: "jobstatus"), let z = rs.string(forColumn: "notes"), let j = rs.string(forColumn: "datesaved"), let l = rs.string(forColumn: "uniqueUserid") {
                    let v = rs.int(forColumn: "equipmentid");
                    
                    print("x = \(x); y = \(y); z = \(z) : j = \(j), L = \(l)")
                    print("Im updated......");
                    var mydict = Dictionary<String, Any>();
                    mydict["status"] = y;
                    mydict["notes"] = z;
                    mydict["daterep"] = j;
                    mydict["vname"] = x;
                    mydict["uid"] = l;
                    mydict["equiId"] = v;
                    print(mydict);
                    
                    localVendorData.append(mydict);
                }
            }
            
            
            
            //vendorList1 changedData-----------------------------------------------------------------------------------------------------------
            
            let qs = try RAdb.executeQuery("select * from vendorList1 where userid = ? and isChanged = ?", values: [userid!, "true"])
            
            while qs.next() {
                if let x = qs.string(forColumn: "vendorname"), let y = qs.string(forColumn: "jobstatus"), let z = qs.string(forColumn: "notes"), let j = qs.string(forColumn: "datesaved") {
                    let v = qs.int(forColumn: "equipmentid");
                    let l = qs.int(forColumn: "uniqueUserid");
                    
                    print("x = \(x); y = \(y); z = \(z) : j = \(j), L = \(l)")
                    print("Im updated......");
                    var mydict = Dictionary<String, Any>();
                    mydict["status"] = y;
                    mydict["notes"] = z;
                    
                    mydict["uid"] = l;
                    mydict["equiId"] = v;
                    print(mydict);
                    editedVendorData.append(mydict);
                }
            }
            
            // insert into signInLog(userid, mechId, userType, dateSignIn, uniqueUserid) values (?, ?, ?, ?, ?)
            
            let ss = try RAdb.executeQuery("select * from signInLog where userid = ? ", values: [userid!])
            
            while ss.next() {
                if let x = ss.string(forColumn: "userType"), let y = ss.string(forColumn: "uniqueUserid"), let z = ss.string(forColumn: "dateSignIn")  {
                    
                    let v = ss.int(forColumn: "mechId");
                    print(v)
                    
                    print("x = \(x); y = \(y); z = \(z)  ")
                    
                    var mydict = Dictionary<String, Any>();
                    mydict["uniqueId"] = y;
                    mydict["dateIn"] = z;
                    
                    mydict["mid"] = v;
                    
                    print(mydict);
                    mechSignInData.append(mydict);
                }
            }
            
            
            
            
            //************* indspectiondata ***
            
            
            let ins = try RAdb.executeQuery("select * from inspectionData where userid = ? ", values: [userid!])
            
            while ins.next() {
                if let x = ins.string(forColumn: "sdata"), let y = ins.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    inspectionGData.append(mydict);
                }
            }
            
            
            
            //************* efficiencydata ***
            
            
            let efs = try RAdb.executeQuery("select * from efficiencyData where userid = ? ", values: [userid!])
            
            while efs.next() {
                if let x = efs.string(forColumn: "sdata"), let y = efs.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    efficiencyGData.append(mydict);
                }
            }
            
            
            //************* addbuildingsfs ***
            
            
            let badata = try RAdb.executeQuery("select * from addbuilding where userid = ? ", values: [userid!])
            
            while badata.next() {
                if let x = badata.string(forColumn: "sdata"), let y = badata.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    addbuildingOfflinedata.append(mydict);
                }
            }
            
            
            
            //************* buildingdeletdata   ***
            
            
            let bddataa = try RAdb.executeQuery("select * from deletebuilding where userid = ? ", values: [userid!])
            
            while bddataa.next() {
                if let x = bddataa.string(forColumn: "sdata"), let y = bddataa.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    deletealldatass.append(mydict);
                }
            }
            
            
            //************* buildingmechroomdelete  ***
            
            
            let deletemechroom = try RAdb.executeQuery("select * from deletemechroom where userid = ? ", values: [userid!])
            
            while deletemechroom.next() {
                if let x = deletemechroom.string(forColumn: "sdata"), let y = deletemechroom.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            //************* buildingdocumentedelete  ***
            
            
            let deletebuilddoc = try RAdb.executeQuery("select * from deletedocument where userid = ? ", values: [userid!])
            
            while deletebuilddoc.next() {
                if let x = deletebuilddoc.string(forColumn: "sdata"), let y = deletebuilddoc.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            //************* buildingmeanagersadd  ***
            
            
            let buildingmanagersadd = try RAdb.executeQuery("select * from addmanagersbuilding where userid = ? ", values: [userid!])
            
            while buildingmanagersadd.next() {
                if let x = buildingmanagersadd.string(forColumn: "sdata"), let y = buildingmanagersadd.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                   
                    print(mydict);
                    addmanagerstoabuilddata.append(mydict);
                }
            }
            
            
            
            //************* buildingsuperadd  ***
            
            
            let buildingsuperdata = try RAdb.executeQuery("select * from addsupersbuilding where userid = ? ", values: [userid!])
            
            while buildingsuperdata.next() {
                if let x = buildingsuperdata.string(forColumn: "sdata"), let y = buildingsuperdata.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    addsupertobuildadata.append(mydict);
                }
            }
            
            
            
            
            
            //************* buildingmechadd ***
            
            
            let buildingsavemech = try RAdb.executeQuery("select * from savemechroom where userid = ? ", values: [userid!])
            
            while buildingsavemech.next() {
                if let x = buildingsavemech.string(forColumn: "sdata"), let y = buildingsavemech.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    addmechroomtobuilddata.append(mydict);
                }
            }
            
            //************* buildingmechadd ***
            
            
            let buildingdeletesupewrmanager = try RAdb.executeQuery("select * from deletebuildigsupermanager where userid = ? ", values: [userid!])
            
            while buildingdeletesupewrmanager.next() {
                if let x = buildingdeletesupewrmanager.string(forColumn: "sdata"), let y = buildingdeletesupewrmanager.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
           
            //************* updatebuilding ***
            
            
            let buildingupadataer = try RAdb.executeQuery("select * from updatebuilding where userid = ? ", values: [userid!])
            
            while buildingupadataer.next() {
                if let x = buildingupadataer.string(forColumn: "sdata"), let y = buildingupadataer.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    
                    updatebuildingdta.append(mydict);
                }
            }
            
            
            
            
            //************* addCustomform copy ***
            
            
            let addcustominspections = try RAdb.executeQuery("select * from addcustominspection where userid = ? ", values: [userid!])
            
            while addcustominspections.next() {
                if let x = addcustominspections.string(forColumn: "sdata"), let y = addcustominspections.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                   
                    print(mydict);
                    addcustomInspectiondata.append(mydict);
                }
            }
            
            
            
            
            
            
            //************* addCustomform saeas ***
            
            
            let custominspectionsavas = try RAdb.executeQuery("select * from custominspectionsaveas where userid = ? ", values: [userid!])
            
            while custominspectionsavas.next() {
                if let x = custominspectionsavas.string(forColumn: "sdata"), let y = custominspectionsavas.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                   
                    print(mydict);
                    customInsSaveApiData.append(mydict);
                }
            }
            
            
            //************* custominspection delete ***
            
            
            let custominspectiondelete = try RAdb.executeQuery("select * from deletecustominspection where userid = ? ", values: [userid!])
            
            while custominspectiondelete.next() {
                if let x = custominspectiondelete.string(forColumn: "sdata"), let y = custominspectiondelete.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            
            //************* addefffeetest   ***
            
            
            let addefficeincytest = try RAdb.executeQuery("select * from addefficiencytest where userid = ? ", values: [userid!])
            
            while addefficeincytest.next() {
                if let x = addefficeincytest.string(forColumn: "sdata"), let y = addefficeincytest.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    addEfficiencyTestAPIData.append(mydict);
                }
            }
            
            
            
            
            //************* efftest delete ***
            
            
            let deleteefficiency = try RAdb.executeQuery("select * from deleteeffiecienty where userid = ? ", values: [userid!])
            
            while deleteefficiency.next() {
                if let x = deleteefficiency.string(forColumn: "sdata"), let y = deleteefficiency.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            //************* efftest update sa ***
            
            
            let updateefficiecy  = try RAdb.executeQuery("select * from saveaseffieciencytest where userid = ? ", values: [userid!])
            
            while updateefficiecy.next() {
                if let x = updateefficiecy.string(forColumn: "sdata"), let y = updateefficiecy.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    equipmentTestSaveASApiData.append(mydict);
                }
            }
            
            
            
            //************* creat mechroom update ***
            
            
            let savemechroomer  = try RAdb.executeQuery("select * from savemechroom where userid = ? ", values: [userid!])
            
            while savemechroomer.next() {
                if let x = savemechroomer.string(forColumn: "sdata"), let y = savemechroomer.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            //************* delete mechroom   ***
            
            
            let dmroom  = try RAdb.executeQuery("select * from deletemechroom where userid = ? ", values: [userid!])
            
            while dmroom.next() {
                if let x = dmroom.string(forColumn: "sdata"), let y = dmroom.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            
            
            
            //*************   mechroom  update ***
            
            
            let updatedmroom  = try RAdb.executeQuery("select * from mechupdate where userid = ? ", values: [userid!])
            
            while updatedmroom.next() {
                if let x = updatedmroom.string(forColumn: "sdata"), let y = updatedmroom.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            
            
            
            
            //*************   mechroomsuperdelete  update ***
            
            
            let mechroomsuperdelete  = try RAdb.executeQuery("select * from mechsuperdelete where userid = ? ", values: [userid!])
            
            while mechroomsuperdelete.next() {
                if let x = mechroomsuperdelete.string(forColumn: "sdata"), let y = mechroomsuperdelete.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            
            //*************   mechroomequipment delete ***
            
            
            let mechequipdelete  = try RAdb.executeQuery("select * from mechequipmentdelete where userid = ? ", values: [userid!])
            
            while mechequipdelete.next() {
                if let x = mechequipdelete.string(forColumn: "sdata"), let y = mechequipdelete.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            
            //*************   mechdefaultinsopect ***
            
            
            let mechdefgaultdap  = try RAdb.executeQuery("select * from changedefaultinspection where userid = ? ", values: [userid!])
            
            while mechdefgaultdap.next() {
                if let x = mechdefgaultdap.string(forColumn: "sdata"), let y = mechdefgaultdap.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    mechdefaultInsApiData.append(mydict);
                }
            }
            
            
            
            //*************   addequipment  ***
           
            let addequpt  = try RAdb.executeQuery("select * from addequipment where userid = ? ", values: [userid!])
            
            while addequpt.next() {
                if let x = addequpt.string(forColumn: "sdata"), let y = addequpt.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    
                    print(mydict);
                    addequipmentapidata.append(mydict);
                }
            }
            
            
            
            
            //*************   deleteEquipmet  ***
            
            
            let deleteequipm  = try RAdb.executeQuery("select * from deleteequipment where userid = ? ", values: [userid!])
            
            while deleteequipm.next() {
                if let x = deleteequipm.string(forColumn: "sdata"), let y = deleteequipm.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            //*************   updateequip  ***
            
            
            let updateequppj  = try RAdb.executeQuery("select * from updateequipment where userid = ? ", values: [userid!])
            
            while updateequppj.next() {
                if let x = updateequppj.string(forColumn: "sdata"), let y = updateequppj.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                   
                    print(mydict);
                    updateEquipmedata.append(mydict);
                }
            }
            
            
            
            //*************   adduserss  ***
            
            
            let adduserdd  = try RAdb.executeQuery("select * from adduser where userid = ? ", values: [userid!])
            
            while adduserdd.next() {
                if let x = adduserdd.string(forColumn: "sdata"), let y = adduserdd.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            //*************   deleteuseress  ***
            
            
            let deleteusers  = try RAdb.executeQuery("select * from deleteuser where userid = ? ", values: [userid!])
            
            while deleteusers.next() {
                if let x = deleteusers.string(forColumn: "sdata"), let y = deleteusers.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            
            //*************   updateuserss  ***
            
            
            let updateuser  = try RAdb.executeQuery("select * from updateuser where userid = ? ", values: [userid!])
            
            while updateuser.next() {
                if let x = updateuser.string(forColumn: "sdata"), let y = updateuser.string(forColumn: "uniqueUserid")  {
                    
                    
                    
                    print("x = \(x), y = \(y) ");
                    
                    var mydict = Dictionary<String, Any>();
                    
                    
                    mydict["sdata"] = x;
                    mydict["uid"] = y;
                    
                    var buildingdeleteData = Array<Dictionary<String, Any>>();
                    print(mydict);
                    buildingdeleteData.append(mydict);
                }
            }
            
            
            deleteusers.close();
            
            adduserdd.close();
            
            updateequppj.close();
            
            deleteequipm.close();
            
            addequpt.close();
            
            mechdefgaultdap.close();
            
            mechequipdelete.close();
            
            mechroomsuperdelete.close();
            
            updatedmroom.close();
            
            dmroom.close();
            
            savemechroomer.close();
            
            updateefficiecy.close();
            
            deleteefficiency.close();
            
            addefficeincytest.close();
            
            custominspectiondelete.close();
            
            custominspectionsavas.close();
            
            addcustominspections.close();
            
            buildingupadataer.close();
            
            buildingdeletesupewrmanager.close();
            
            buildingsavemech.close();
            
            buildingsuperdata.close();
            
            buildingmanagersadd.close();
            
            deletebuilddoc.close();
            
            deletemechroom.close();
            
            bddataa.close();
            
            badata.close();
            
            
            
            
            
            updateuser.close();
            badata.close();
            qs.close();
            rs.close();
            ss.close();
            ins.close();
            efs.close();
            print(localVendorData);
        } catch {
            print("failed: \(error.localizedDescription)")
            return;
        }
        
        
        RAdb.close();
        
        
        
        
        LVCcount = localVendorData.count
        EVCount = editedVendorData.count
        MSCount = mechSignInData.count
        InCount =  inspectionGData.count
        EffCount = efficiencyGData.count
        
        
        print("the data updated count")
        print("vendar count \(localVendorData.count)");
        print("edited vendor Data \(editedVendorData.count)");
        print("mechsign in data \(mechSignInData.count)");
        print("inspectiondata count \(inspectionGData.count)");
        print("efficiency data count \(efficiencyGData.count)");
        
        print("addbuilding data count \(addbuildingOfflinedata.count)");
        
        print("addmanagerstobuild data count \(addmanagerstoabuilddata.count)");
        
        print("addsupertobuild data count \(addsupertobuildadata.count)");
         print("updatebuilding data count \(updatebuildingdta.count)");
        
        print("addequipmentdata data count \(addequipmentapidata.count)");
         print("updateequipmet data count \(updateEquipmedata.count)");
        print("addcustominspection data count \(addcustomInspectiondata.count)");
        print("addEfficiencytest data count \(addEfficiencyTestAPIData.count)");
        print("custominspectionsaveas data count \(customInsSaveApiData.count)");
        print("equipmetnTestSaveasA data count \(equipmentTestSaveASApiData.count)");
        print("mechdefaultins data count \(mechdefaultInsApiData.count)");
        
        
        
        
        //----VendorList2 loadingto server-------------------------------------------------------------------------------------
        
        
        
        
      
        
        
    self.loadingVendorDataToServerLoop1();
     
        
    }
    
    
    
    
    func loadingVendorDataToServerLoop1()
    {
        
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        let userType = defaultValues.string(forKey: "userType")
        
        if localVendorData.count > 0 && localvendorId < localVendorData.count
        {
            
            let equipIDE_mdiat = Int(localVendorData[localvendorId]["equiId"] as! Int32)
            let jobstatus_mdiat = localVendorData[localvendorId]["status"] as! String
            let notes_mdiat = localVendorData[localvendorId]["notes"] as! String
            let vname_mdiat = localVendorData[localvendorId]["vname"] as! String
            
            
            let parameters: Parameters=[
                "equipment_id": equipIDE_mdiat,
                "jobstatus": jobstatus_mdiat,
                "notes": notes_mdiat,
                "vendor_name": vname_mdiat,
                "user_id": userid!,
                "user_type" : userType!
                
            ]
            
            Alamofire.request(saveVendorAPI , method: .post, parameters: parameters).responseJSON { (resp) in
                
                
                if resp.result.value != nil
                {
                    
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        
                        do {
                            
                            try RAdb.executeUpdate("Delete from vendorList2 where userid = ? and equipmentid = ? and vendorname = ? and  notes = ?", values: [userid!, equipIDE_mdiat, vname_mdiat, notes_mdiat]);
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        
                        RAdb.close();
                        localvendorId =  localvendorId + 1;
                        
                        self.loadingVendorDataToServerLoop1();
                        
                        
                        
                    }
                    else{
                        
                        
                        self.alertshow()
                     
                        
                    }
                    
                }
                else
                {
                    
                     self.alertshow()
                    
                }
                
                
                
            }
            
        }
        else
        {
            localVendorData = Array<Dictionary<String, Any>>();
            
            localvendorId = 0;
            
            print("editvendordatacalled")
            
            
            
            
            updateEditindOnlineVendorDatatoServerLoop2();
        }
        
    }
    
    
    
    
    func updateEditindOnlineVendorDatatoServerLoop2()
    {
        
        
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        let userType = defaultValues.string(forKey: "userType")
        
        
        if editedVendorData.count > 0 && editorVendorId < editedVendorData.count
        {
            
            
            let vendor_mediat = editedVendorData[editorVendorId]["uid"] as! Int32
            let jobstatus_mdiat = editedVendorData[editorVendorId]["status"] as! String
            let notes_mdiat = editedVendorData[editorVendorId]["notes"] as! String
            
            
            
            let parameters: Parameters=[
                
                "vendor_id": vendor_mediat,
                "jobstatus": jobstatus_mdiat,
                "notes": notes_mdiat,
                "user_type" : userType!
                
            ]
            
            
            
            
            Alamofire.request(upadateVendorAPI , method: .post, parameters: parameters).responseJSON { (resp) in
                
                
                if resp.result.value != nil
                {
                    isOfflineMode = false
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                        
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            
                            try RAdb.executeUpdate("Delete from vendorList1 where userid = ? and isChanged = ? and uniqueUserid = ?", values: [userid!, "true", vendor_mediat])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        
                        editorVendorId = editorVendorId + 1;
                        self.updateEditindOnlineVendorDatatoServerLoop2();
                        
                        
                    }
                    else{
                        
                        
                        self.alertshow();
                    }
                    
                    
                    
                    
                }
                else
                {
                     self.alertshow();
                }
                
                
            }
        }
        else
        {
            
            editedVendorData = Array<Dictionary<String, Any>>();
            editorVendorId = 0;
            
            print("sign in loop called");
            moveSignInDataLoop3();
            
            
            
        }
        
        
    }
    
    
    
    func moveSignInDataLoop3()
    {
        
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        let userType = defaultValues.string(forKey: "userType")
        
        
        if mechSignInData.count > 0 && signInmechCounter < mechSignInData.count
        {
            
            let mechId_mediat  =  mechSignInData[signInmechCounter]["mid"] as! Int32
            let mechUnique_meidat   = mechSignInData[signInmechCounter]["uniqueId"] as! String
            
            
            
            
            let parameters: Parameters = [
                "user_id": userid!,
                "mech_id": mechId_mediat,
                "user_type" : userType!
            ]
            
            
            print(parameters)
            
            Alamofire.request(mechanicalroomSignInApi , method: .post, parameters: parameters).responseJSON { (resp) in
                print("first api called");
                
                
                print(resp);
                if resp.result.value != nil
                {
                    isOfflineMode = false
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                        let eId = resultdata["signinid"] as! Int
                        
                        
                        let parameterss: Parameters = [
                            "signin_id": eId,
                            "user_type" : userType!
                            
                            
                        ]
                        print(parameters);
                        
                        Alamofire.request(signOutFromMechRoomAPI, method: .post, parameters: parameterss).responseJSON { (resp) in
                            
                            print("second api called");
                            if resp.result.value != nil
                            {
                                print(resp.result.value)
                                
                                
                                let resultdata =  resp.result.value! as! NSDictionary
                                let statuscode = resultdata["status"] as! Int
                                if statuscode == 200
                                {
                                    
                                    
                                    let filePath = getPath(fileName: locale_DB);
                                    let RAdb = FMDatabase.init(path: filePath);
                                    guard RAdb.open() else {
                                        print("Unable to open database")
                                        return
                                    }
                                    
                                    do {
                                        
                                        try RAdb.executeUpdate("Delete from signInLog where userid = ? and  uniqueUserid = ?", values: [userid!,  mechUnique_meidat])
                                        
                                        
                                        
                                    } catch {
                                        print("failed: \(error.localizedDescription)")
                                        
                                    }
                                    RAdb.close();
                                    
                                    
                                    signInmechCounter = signInmechCounter + 1;
                                    
                                    self.moveSignInDataLoop3();
                                    
                                    
                                    
                                    
                                }
                                else
                                {
                                    self.alertshow();
                                    
                                    
                                }
                                
                            }
                                
                            else
                            {
                                self.alertshow();
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                    }      }
                    
                    
                else
                {
                    
                    
                 self.alertshow();
                    
                }
            
                
            }
            
        }
        else
        {
            
            mechSignInData = Array<Dictionary<String, Any>>();
            signInmechCounter = 0;
            
            print("inspectionDatacalled")
            
            
            
            updateInspectionDatatoServerLoop4();
            
            
            
            
            
        }
        
        
    }
    
    
   
    func updateInspectionDatatoServerLoop4()
    {
        
        if inspectionGData.count > 0 && inspectionGCounter < inspectionGData.count
        {
            
            let jstr = inspectionGData[inspectionGCounter]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("global upload attachment called");
            
            let isdefaultIns = dictData!["atftype"]
            storedpathdata = Array<Dictionary<String, String>>();
            storeupdatedatacounter = 0;
            
            if isdefaultIns != nil
            {
                
                let itypedata = dictData!["atftype"] as! Dictionary<String, String>;
                let imagepathData  = dictData!["atfvalue"] as! Dictionary<String, Any>;
                
                for (key, value) in itypedata
                {
                    
                    if value == "9"
                    {
                        print(key);
                        
                        for (tom, jerry) in imagepathData
                        {
                            if tom == key
                            {
                                
                                var midict = Dictionary<String, String>()
                                let defaultPath = jerry as! String
                                
                                
                                
                                
                                if defaultPath != ""
                                {
                                    if defaultPath.contains("/")
                                    {
                                        
                                        midict[tom] = defaultPath
                                        storedpathdata.append(midict);
                                    }
                                    else{
                                        print("already stored");
                                        print(defaultPath);
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        
                        
                    }
                    
                }
            }
            
            GuploadingAttachmentToServer(dictData!);
            
          
            
        }
        else
        {
            
            inspectionGData = Array<Dictionary<String, Any>>();
            inspectionGCounter = 0;
            
            print("OfflineEfficiency called")
            self.updateEfficiencyDatatoServerLoop5();
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func GuploadingAttachmentToServer(  _ apiparameters : Dictionary<String, Any>  )
    {
        
        
        
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        let userType = defaultValues.string(forKey: "userType")
        
        
        
        if storeupdatedatacounter < storedpathdata.count
        {
            let filepathRow = storedpathdata[storeupdatedatacounter];
            var meidaotrtitle = "";
            var okey = ""
            for (key, value) in filepathRow
            {
                
                meidaotrtitle = value;
                okey = key
                
                
            }
            
            
            print(meidaotrtitle);
            
            
            
            let dtaim = fileManag.contents(atPath: meidaotrtitle);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                return;
            }
            
            // "application/pdf"
            let localulrimgPath = URL.init(fileURLWithPath: meidaotrtitle)
            //let sname = localulrimgPath.lastPathComponent;
            let uid = localulrimgPath.pathExtension;
            
            print(uid);
            
            
            
            
            
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: "test", mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "firstName");
                
                
                
                
            }, to: imageUploadAPI , method: .post ) { (resp) in
                
                // imageUploadAPI
                //http://192.168.1.37/upload.php
                
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if let resp = response.result.value {
                            
                            
                            print(response.result);
                            
                            print(response.result.value)
                            
                            let midiatr = JSON(resp);
                            
                            let respStatus = midiatr["scode"].intValue;
                            print(respStatus)
                            if respStatus == 200
                            {
                                var mydata = apiparameters;
                                let  path = midiatr["filePath"].stringValue
                                
                                var imagepathData  = mydata["atfvalue"] as! Dictionary<String, Any>;
                                
                                for (v, l) in imagepathData
                                {
                                    print(l);
                                    if okey == v
                                    {
                                        imagepathData[v] = path;
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                mydata["atfvalue"] = imagepathData
                                
                                storeupdatedatacounter = storeupdatedatacounter + 1;
                                
                                
                                self.GuploadingAttachmentToServer(mydata);
                                
                                
                            }
                            else
                            {
                                
                                inspectionGCounter = inspectionGCounter + 1;
                                self.updateInspectionDatatoServerLoop4();
                                
                                print("got error");
                                
                                
                            }
                            
                        }
                            
                        else
                        {
                            inspectionGCounter = inspectionGCounter + 1;
                            self.updateInspectionDatatoServerLoop4();
                            print("got error");
                            
                        }
                        
                        
                    }
                    
                case .failure(let encodingError):
                    
                    inspectionGCounter = inspectionGCounter + 1;
                    self.updateInspectionDatatoServerLoop4();
                    print("got error");
                    
                }
                
                
            }
            
            
            
            
        }
        else
        {
            
            
            
            
            let apiJparams = JSON.init(apiparameters);
            print(apiJparams);
            
            
            
            let parameters: Parameters=[
                
                "insepectionData": apiJparams
                
            ]
            
            
            
            
            
            let unique_meida = inspectionGData[inspectionGCounter]["uid"] as! String
            
            
            
            
            Alamofire.request(saveInspectionFormAPI, method: .post, parameters: parameters).responseJSON { (resp) in
                
                
                if resp.result.value != nil
                {
                    isOfflineMode = false
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    print(resultdata);
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                        
                        
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            
                            try RAdb.executeUpdate("Delete from inspectionData where userid = ? and uniqueUserid = ?", values: [userid!, unique_meida])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("insepction sheet saved successfulley");
                        inspectionGCounter = inspectionGCounter + 1;
                        self.updateInspectionDatatoServerLoop4();
                        
                        
                    }
                    else{
                        self.alertshow();
                    }
                    
                    
                    
                    
                }
                else
                {
                    self.alertshow();
                    
                }
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    
    func GuploadingEfficiencyAttachmentToServer(  _ apiparameters : Dictionary<String, Any>  )
    {
        
        
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        
        
        
        if storeupdatedatacounter < storedpathdata.count
        {
            let filepathRow = storedpathdata[storeupdatedatacounter];
            var meidaotrtitle = "";
            var okey = ""
            for (key, value) in filepathRow
            {
                
                meidaotrtitle = value;
                okey = key
                
                
            }
            
            
            print(meidaotrtitle);
            
            
            
            let dtaim = fileManag.contents(atPath: meidaotrtitle);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                return;
            }
            
            // "application/pdf"
            let localulrimgPath = URL.init(fileURLWithPath: meidaotrtitle)
            //let sname = localulrimgPath.lastPathComponent;
            let uid = localulrimgPath.pathExtension;
            
            print(uid);
            
            
            
            
            
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: "test", mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "firstName");
                
                
                
                
            }, to: imageUploadAPI , method: .post ) { (resp) in
                
                // imageUploadAPI
                //http://192.168.1.37/upload.php
                
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if let resp = response.result.value {
                            
                            
                            print(response.result);
                            
                            print(response.result.value)
                            
                            let midiatr = JSON(resp);
                            
                            let respStatus = midiatr["scode"].intValue;
                            print(respStatus)
                            if respStatus == 200
                            {
                                var mydata = apiparameters;
                                let  path = midiatr["filePath"].stringValue
                                
                                var imagepathData  = mydata["atfvalue"] as! Dictionary<String, String>;
                                
                                for (v, l) in imagepathData
                                {
                                    print(l);
                                    if okey == v
                                    {
                                        imagepathData[v] = path;
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                mydata["atfvalue"] = imagepathData
                                
                                storeupdatedatacounter = storeupdatedatacounter + 1;
                                
                                self.GuploadingEfficiencyAttachmentToServer(mydata)
                                
                                
                                
                            }
                            else
                            {
                                
                                efficiencyGCounter = efficiencyGCounter + 1;
                                self.updateEfficiencyDatatoServerLoop5()
                                
                                
                                print("got error");
                                
                                
                            }
                            
                        }
                            
                        else
                        {
                            efficiencyGCounter = efficiencyGCounter + 1;
                            self.updateEfficiencyDatatoServerLoop5()
                            print("got error");
                            
                        }
                        
                        
                    }
                    
                case .failure(let encodingError):
                    
                    efficiencyGCounter = efficiencyGCounter + 1;
                    self.updateEfficiencyDatatoServerLoop5()
                    print("got error");
                    
                }
                
                
            }
            
            
            
            
        }
        else
        {
            
            
            
            let apiJparams = JSON.init(apiparameters);
            print(apiJparams);
            
            
            
            let parameters: Parameters = [
                
                "eqipmentsData": apiJparams
                
            ]
            
            
            
            let effieci_media = efficiencyGData[efficiencyGCounter]["uid"] as! String
            
            
            
            Alamofire.request(saveEfficiencyAPI, method: .post, parameters: parameters).responseJSON { (resp) in
                
                
                
                if resp.result.value != nil
                {
                    isOfflineMode = false
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                        
                        
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            
                            try RAdb.executeUpdate("Delete from efficiencyData where userid = ? and uniqueUserid = ?", values: [userid!, effieci_media])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("efficiency sheet saved successfulley");
                        efficiencyGCounter = efficiencyGCounter + 1;
                        self.updateEfficiencyDatatoServerLoop5();
                        
                        
                    }
                    else{
                        self.alertshow();
                        
                    }
                    
                    
                    
                    
                }
                else
                {
                    self.alertshow();
                }
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    func updateEfficiencyDatatoServerLoop5()
    {
        
        
        if efficiencyGData.count > 0 && efficiencyGCounter < efficiencyGData.count
        {
            
            let jstr = efficiencyGData[efficiencyGCounter]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            
            
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("global upload attachment called");
            
            let itypedata = dictData!["atftype"] as! Dictionary<String, String>;
            let imagepathData  = dictData!["atfvalue"] as! Dictionary<String, Any>;
            storedpathdata = Array<Dictionary<String, String>>();
            storeupdatedatacounter = 0;
            for (key, value) in itypedata
            {
                
                if value == "9"
                {
                    print(key);
                    
                    for (tom, jerry) in imagepathData
                    {
                        if tom == key
                        {
                            var midict = Dictionary<String, String>()
                            let defaultPath = jerry as! String
                            if defaultPath != ""
                            {
                                if defaultPath.contains("/")
                                {
                                    
                                    midict[tom] = defaultPath
                                    storedpathdata.append(midict);
                                }
                                else{
                                    print("already stored");
                                    print(defaultPath);
                                }
                                
                            }
                            
                            
                        }
                    }
                    
                    
                    
                }
                
            }
            
            
            
            
            self.GuploadingEfficiencyAttachmentToServer(dictData!)
            
            
            
            
            
            
            
            
            
            
        }
        else
        {
            
            efficiencyGData = Array<Dictionary<String, Any>>();
            efficiencyGCounter = 0;
            
            
            
            
            self.gettheattachemetntbilding();
            
            
            
        }
        
        
    }
    
    
    
    
    var addbuilodingimageneedtouploaddata = [JSON]()
    var addbuildingimagecount  = 0;
    
    func gettheattachemetntbilding()
    {
        

        if addbuildingOfflinedata.count > 0 && addbuildcount < addbuildingOfflinedata.count
        {
            addbuilodingimageneedtouploaddata = [JSON]()
                addbuildingimagecount  = 0;
            
            let jstr = addbuildingOfflinedata[addbuildcount]["sdata"] as! String

            var dictData  : Dictionary<String, Any>? = nil
           print(jstr)

            print("converting jsonstrting into dictionary");

            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }

       

            print("global upload attachment called");

            var mydatajsonbuiild = JSON(dictData!)
            
            addbuilodingimageneedtouploaddata = mydatajsonbuiild["documents"].arrayValue;
            
            movebuildimgtoserver()



        }
        else
        {

           // inspectionGData = Array<Dictionary<String, Any>>();
            //inspectionGCounter = 0;

            AddmechroomtoBuilding()
            //self.updateEfficiencyDatatoServerLoop5();



        }

        
    }
    

    
    
    
    
    func movebuildimgtoserver()
    {
        if addbuilodingimageneedtouploaddata.count > 0 && addbuildingimagecount < addbuilodingimageneedtouploaddata.count
        {
            
            var imagepath = addbuilodingimageneedtouploaddata[addbuildingimagecount]["path"].stringValue
            print(imagepath);
            let dtaim = fileManag.contents(atPath: imagepath);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                DispatchQueue.main.async {
                    self.alertshow();
                }
                
                return;
            }
            
            
            let localulrimgPath = URL.init(fileURLWithPath: imagepath)
            
            
            let uid =  localulrimgPath.pathExtension;
            print(uid);
            var uidname = "bid"
            
            let userid = UserDefaults.standard
            let user_id =  userid.string(forKey: "userid")
            
            print(uid);
            print(user_id);
            
            var uploadApiforimg = vbuildingfileupload;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
            print(uploadApiforimg);
            print(uid);
            print(uidname);
            print("loading to server....");
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: uidname, mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "fileName");
                
                
                
                
            }, to: uploadApiforimg , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if  response.result.value != nil && response.result.isSuccess{
                            
                            let resp = response.result.value;
                            print(response.result);
                            
                            print(response.result.value)
                            
                            
                            let midiatr = JSON(resp);
                            
                            
                            
                            if uid == "mp4"
                            {
                                let  path = midiatr["filePath"].stringValue
                                
                                
                            self.addbuilodingimageneedtouploaddata[self.addbuildingimagecount]["path"].stringValue = path
                                self.addbuildingimagecount = self.addbuildingimagecount + 1;
                                
                                
                                self.movebuildimgtoserver();
                                
                            }
                            else
                            {
                                
                                let respStatus = midiatr["scode"].intValue;
                                print(respStatus)
                                if respStatus == 200
                                {
                                    
                                    
                                    let  path = midiatr["filePath"].stringValue
                                    
                                    self.addbuilodingimageneedtouploaddata[self.addbuildingimagecount]["path"].stringValue = path
                                    self.addbuildingimagecount = self.addbuildingimagecount + 1;
                                    
                                    
                                    self.movebuildimgtoserver();
                                    
                                }
                                else
                                {
                                    let  msg = midiatr["message"].stringValue
                                    
                                    print("Error exist here");
                                    
                                    DispatchQueue.main.async {
                                        self.alertshow();
                                        
                                    }
                             
                                }
                                
                            }
                            
                            
                        }
                            
                        else
                        {
                            DispatchQueue.main.async {
                                self.alertshow();
                            }
                            
                            
                        }
                   
                    }
                    
                 
                case .failure(let encodingError):
                    
                    print("eroror \(encodingError)");
                    
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
        }
        else
        {
            
            let jstr = addbuildingOfflinedata[addbuildcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            dictData!["documents"] = addbuilodingimageneedtouploaddata
            
            let gjid = addbuildingOfflinedata[addbuildcount]["uid"] as! String
            let mygi = JSON(dictData!);
            print(mygi);
            movebuildingtoserver(mygi, gjid);
            
            
            
            
        }
        
        
    }
    
    
    
    
    func movebuildingtoserver(_ cjson : JSON, _ jid : String)
    {
        
        let parms = ["buildingdata" : cjson ];
        print(parms);
        Alamofire.request(vsavebuildingApi, method: .post, parameters: parms).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from addbuilding where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        
                        
                        self.addbuildcount = self.addbuildcount + 1;
                        self.gettheattachemetntbilding()
                        
                    }
                    
                }
                    
                    
                    // }
                else{
                    DispatchQueue.main.async(execute: {
                        self.alertshow();
                    })
                    
                }
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                     self.alertshow();
                })
                 }  }
        
    }
    
    
    
    
    
    
    
    func AddmechroomtoBuilding()
    {
        
        
        
        if addmechroomtobuilddata.count > 0 && addmechroomtobuildcount < addmechroomtobuilddata.count
        {
            
            let jstr = addmechroomtobuilddata[addmechroomtobuildcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            let jid =   addmechroomtobuilddata[addmechroomtobuildcount]["uid"] as! String
            
            let parameters = [
                "mechdata":  JSON(dictData!)
            ]
            print(parameters);
            print("global upload attachment called");
            
                print(vmechanicalSaveApi)
            
            
          
            Alamofire.request(vmechanicalSaveApi, method: .post, parameters : parameters).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from savemechroom where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        self.addmechroomtobuildcount = self.addmechroomtobuildcount + 1;
                        self.AddmechroomtoBuilding();
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                 
                }
                
                
            }
            
            
        }
        else
        {
            
            addbuildmanagertobuilding()
            
            
            
        }
        
        
        
    }
    
    
    func addbuildmanagertobuilding()
    {
        
        if addmanagerstoabuilddata.count > 0 && addmnagerstobuildcount < addmanagerstoabuilddata.count
        {
            
            
            let jstr = addmanagerstoabuilddata[addmnagerstobuildcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary in build managers");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            let jid =   addmanagerstoabuilddata[addmnagerstobuildcount]["uid"] as! String
            
            
            
            print("global upload attachment called");
            
            print(vbuildingAddmanager)
            
            
            
            Alamofire.request(vbuildingAddmanager, method: .post, parameters : dictData!).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from addmanagersbuilding where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        self.addmnagerstobuildcount = self.addmnagerstobuildcount + 1;
                        self.addbuildmanagertobuilding()
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            addsupertobuilding()
            print("I'm offline heerweajflkajf");
            
            
            
            
            
        }
        
        
        
    }
    
    
    func addsupertobuilding()
    {
        
        
        if addsupertobuildadata.count > 0 && addsuperbuildcount < addsupertobuildadata.count
        {
            
            
            let jstr = addsupertobuildadata[addsuperbuildcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary in build managers");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            let jid =   addsupertobuildadata[addsuperbuildcount]["uid"] as! String
            
            
            
            print("global upload attachment called");
            
            print(vbuildingAddSuper)
            
            
            
            Alamofire.request(vbuildingAddSuper, method: .post, parameters : dictData!).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from addsupersbuilding where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        self.addsuperbuildcount = self.addsuperbuildcount + 1;
                        self.addsupertobuilding();
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
           
            DeleteAlldatatoserver()
            
            
        }
        
        
        
    }
    
    
    
    
    
    
   
    
    func DeleteAlldatatoserver()
    {
        
        
        if deletealldatass.count > 0 && deletealldatacount < deletealldatass.count
        {
            
            
            let jstr = deletealldatass[deletealldatacount]["sdata"] as! String
             print(jstr)
            
            print("converting jsonstrting into dictionary in build managers");
            
           
            
            let jid =   deletealldatass[deletealldatacount]["uid"] as! String
            
            
            
            print("global upload attachment called");
            
            print(jstr)
            
            
            
            Alamofire.request(jstr, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from deletebuilding where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        self.deletealldatacount = self.deletealldatacount + 1;
                        self.DeleteAlldatatoserver();
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            self.gettheattachemetupdatebuilding();
           
            
        }
        
        
        
    }
    
    
    
    
    //----------------
    var updatebuildinguploadimage = [JSON]()
    var updatebuildingimagecount  = 0;
    
    
    func gettheattachemetupdatebuilding()
    {
        
        
        if updatebuildingdta.count > 0 && updatebuildCount < updatebuildingdta.count
        {
            updatebuildinguploadimage = [JSON]()
            updatebuildingimagecount  = 0;
            
            let jstr = updatebuildingdta[updatebuildCount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("global upload attachment called");
            
            var mydatajsonbuiild = JSON(dictData!)
            
            updatebuildinguploadimage = mydatajsonbuiild["documents"].arrayValue;
            
            movebuildimgupdatetoserver()
            
            
            
        }
        else
        {
            
            // inspectionGData = Array<Dictionary<String, Any>>();
            //inspectionGCounter = 0;
            self.addequipmentdatacalled()
            
            //self.updateEfficiencyDatatoServerLoop5();
            
            
            
        }
        
        
    }
    
   
    
    
    
    
    func movebuildimgupdatetoserver()
    {
        if updatebuildinguploadimage.count > 0 && updatebuildingimagecount < updatebuildinguploadimage.count
        {
           
            
            var imagepath = updatebuildinguploadimage[updatebuildingimagecount]["path"].stringValue
            print(imagepath);
            let dtaim = fileManag.contents(atPath: imagepath);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                DispatchQueue.main.async {
                    self.alertshow();
                }
                
                return;
            }
            
            
            let localulrimgPath = URL.init(fileURLWithPath: imagepath)
            
            
            let uid =  localulrimgPath.pathExtension;
            print(uid);
            var uidname = "bid"
            
            let userid = UserDefaults.standard
            let user_id =  userid.string(forKey: "userid")
            
            print(uid);
            print(user_id);
            
            var uploadApiforimg = vbuildingfileupload;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
            print(uploadApiforimg);
            print(uid);
            print(uidname);
            print("loading to server....");
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: uidname, mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "fileName");
                
                
                
                
            }, to: uploadApiforimg , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if  response.result.value != nil && response.result.isSuccess{
                            
                            let resp = response.result.value;
                            print(response.result);
                            
                            print(response.result.value)
                            
                            
                            let midiatr = JSON(resp);
                            
                            
                            
                            if uid == "mp4"
                            {
                                let  path = midiatr["filePath"].stringValue
                                
                               
                                
                                self.updatebuildinguploadimage[self.updatebuildingimagecount]["path"].stringValue = path
                                self.updatebuildingimagecount = self.updatebuildingimagecount + 1;
                                
                                
                                self.movebuildimgupdatetoserver()
                                
                            }
                            else
                            {
                                
                                let respStatus = midiatr["scode"].intValue;
                                print(respStatus)
                                if respStatus == 200
                                {
                                    
                                    
                                    let  path = midiatr["filePath"].stringValue
                                    
                                    self.updatebuildinguploadimage[self.updatebuildingimagecount]["path"].stringValue = path
                                    self.updatebuildingimagecount = self.updatebuildingimagecount + 1;
                                    
                                    
                                    self.movebuildimgupdatetoserver()
                                    
                                }
                                else
                                {
                                    let  msg = midiatr["message"].stringValue
                                    
                                    print("Error exist here");
                                    
                                    DispatchQueue.main.async {
                                        self.alertshow();
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                            
                        else
                        {
                            DispatchQueue.main.async {
                                self.alertshow();
                            }
                            
                            
                        }
                        
                    }
                    
                    
                case .failure(let encodingError):
                    
                    print("eroror \(encodingError)");
                    
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
        }
        else
        {
            
            
            
            
            let jstr = updatebuildingdta[updatebuildCount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            dictData!["documents"] = updatebuildinguploadimage
            
            let gjid = updatebuildingdta[updatebuildCount]["uid"] as! String
            let mygi = JSON(dictData!);
            print(mygi);
            movebuildingupdatetoserver(mygi, gjid);
            
     
            
            
        }
        
        
    }
    
    
    
    
    func movebuildingupdatetoserver(_ cjson : JSON, _ jid : String)
    {
        
        let parms = ["buildingdata" : cjson ];
        print(parms);
        Alamofire.request(vbuildingupdateApi, method: .post, parameters: parms).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from updatebuilding where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        
                        self.updatebuildCount = self.updatebuildCount + 1;
                        self.gettheattachemetupdatebuilding()
                        
                    }
                    
                }
                    
                    
                    // }
                else{
                    DispatchQueue.main.async(execute: {
                        self.alertshow();
                    })
                    
                }
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.alertshow();
                })
            }  }
        
    }
    
    
    
    
    //----------------
    var addequipmetndataimages = [JSON]()
    var iamgeaddequipmetntimagedatacount  = 0;
    
    
    
    func addequipmentdatacalled()
    {
        
        
        if addequipmentapidata.count > 0 && addequipmetdatcount < addequipmentapidata.count
        {
            addequipmetndataimages = [JSON]()
            iamgeaddequipmetntimagedatacount  = 0;
            
            let jstr = addequipmentapidata[addequipmetdatcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("global upload attachment called");
            
            var mydatajsonbuiild = JSON(dictData!)
            
            addequipmetndataimages = mydatajsonbuiild["documents"].arrayValue;
            
            addequipmentimagtoserer()
            
            
            
        }
        else
        {
            
            // inspectionGData = Array<Dictionary<String, Any>>();
            //inspectionGCounter = 0;
            
            updateEquipmentDatotocaller()
            //self.updateEfficiencyDatatoServerLoop5();
            
            
            
        }
        
        
    }
    
    
    
    
    
    func addequipmentimagtoserer()
    {
        if addequipmetndataimages.count > 0 && iamgeaddequipmetntimagedatacount < addequipmetndataimages.count
        {
            
            
            var imagepath = addequipmetndataimages[iamgeaddequipmetntimagedatacount]["path"].stringValue
            print(imagepath);
            let dtaim = fileManag.contents(atPath: imagepath);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                DispatchQueue.main.async {
                    self.alertshow();
                }
                
                return;
            }
            
            
            let localulrimgPath = URL.init(fileURLWithPath: imagepath)
            
            
            let uid =  localulrimgPath.pathExtension;
            print(uid);
            var uidname = "bid"
            
            let userid = UserDefaults.standard
            let user_id =  userid.string(forKey: "userid")
            
            print(uid);
            print(user_id);
            
            var uploadApiforimg = vbuildingfileupload;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
            print(uploadApiforimg);
            print(uid);
            print(uidname);
            print("loading to server....");
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: uidname, mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "fileName");
                
                
                
                
            }, to: uploadApiforimg , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if  response.result.value != nil && response.result.isSuccess{
                            
                            let resp = response.result.value;
                            print(response.result);
                            
                            print(response.result.value)
                            
                            
                            let midiatr = JSON(resp);
                            
                            
                            
                            if uid == "mp4"
                            {
                                let  path = midiatr["filePath"].stringValue
                                
                               
                                
                                
                                self.addequipmetndataimages[self.iamgeaddequipmetntimagedatacount]["path"].stringValue = path
                                self.iamgeaddequipmetntimagedatacount = self.iamgeaddequipmetntimagedatacount + 1;
                                
                                
                                self.addequipmentimagtoserer()
                                
                            }
                            else
                            {
                                
                                let respStatus = midiatr["scode"].intValue;
                                print(respStatus)
                                if respStatus == 200
                                {
                                    
                                    
                                    let  path = midiatr["filePath"].stringValue
                                    self.addequipmetndataimages[self.iamgeaddequipmetntimagedatacount]["path"].stringValue = path
                                    self.iamgeaddequipmetntimagedatacount = self.iamgeaddequipmetntimagedatacount + 1;
                                    
                                    self.addequipmentimagtoserer()
                                    
                                }
                                else
                                {
                                    let  msg = midiatr["message"].stringValue
                                    
                                    print("Error exist here");
                                    
                                    DispatchQueue.main.async {
                                        self.alertshow();
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                            
                        else
                        {
                            DispatchQueue.main.async {
                                self.alertshow();
                            }
                            
                            
                        }
                        
                    }
                    
                    
                case .failure(let encodingError):
                    
                    print("eroror \(encodingError)");
                    
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
        }
        else
        {
            
          
            
            
            let jstr = addequipmentapidata[addequipmetdatcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            dictData!["documents"] = addequipmetndataimages;
            
            let gjid = addequipmentapidata[addequipmetdatcount]["uid"] as! String
            let mygi = JSON(dictData!);
            print(mygi);
            movingaddequipmentdataotserver(mygi, gjid);
            
            
            
            
        }
        
        
    }
    
    
    
    
    func movingaddequipmentdataotserver(_ cjson : JSON, _ jid : String)
    {
        
        let parms = ["eqpdata" : cjson ];
        print(parms);
        Alamofire.request(vEquipmentCreatesaveApi, method: .post, parameters: parms).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                
                
                    
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from deleteequipment where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        
                        
                        
                        self.addequipmetdatcount = self.addequipmetdatcount + 1;
                        self.addequipmentdatacalled();
                        
                    }
                    
                 
                    
                    
                
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.alertshow();
                })
            }  }
        
    }
    
    
    
    //----------------
    var updateequipmentimagedata = [JSON]()
    var imageupdtaeequipmentcount  = 0;
    
//    updateEquipmedata = Array<Dictionary<String, Any>>();
//    updateEqqqcount = 0
    
    
    func updateEquipmentDatotocaller()
    {
       
        if updateEquipmedata.count > 0 && updateEqqqcount < updateEquipmedata.count
        {
            updateequipmentimagedata = [JSON]()
            imageupdtaeequipmentcount  = 0;
            
            let jstr = updateEquipmedata[updateEqqqcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("global upload attachment called");
            
            var mydatajsonbuiild = JSON(dictData!)
            
            updateequipmentimagedata = mydatajsonbuiild["documents"].arrayValue;
            
            updtaeEquimpnetimagetotServer()
            
            
            
        }
        else
        {
            
            // inspectionGData = Array<Dictionary<String, Any>>();
            //inspectionGCounter = 0;
            
           self.custominspectionUPloadtoServer()
            //self.updateEfficiencyDatatoServerLoop5();
            
            
            
        }
        
        
    }
    
    
    
    
    
    func updtaeEquimpnetimagetotServer()
    {
        if updateequipmentimagedata.count > 0 && imageupdtaeequipmentcount < updateequipmentimagedata.count
        {
            
            
            var imagepath = updateequipmentimagedata[imageupdtaeequipmentcount]["path"].stringValue
            print(imagepath);
            let dtaim = fileManag.contents(atPath: imagepath);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                DispatchQueue.main.async {
                    self.alertshow();
                }
                
                return;
            }
            
            
            let localulrimgPath = URL.init(fileURLWithPath: imagepath)
            
            
            let uid =  localulrimgPath.pathExtension;
            print(uid);
            var uidname = "bid"
            
            let userid = UserDefaults.standard
            let user_id =  userid.string(forKey: "userid")
            
            print(uid);
            print(user_id);
            
            var uploadApiforimg = vbuildingfileupload;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
            print(uploadApiforimg);
            print(uid);
            print(uidname);
            print("loading to server....");
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: uidname, mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "fileName");
                
                
                
                
            }, to: uploadApiforimg , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if  response.result.value != nil && response.result.isSuccess{
                            
                            let resp = response.result.value;
                            print(response.result);
                            
                            print(response.result.value)
                            
                            
                            let midiatr = JSON(resp);
                            
                            
                            
                            if uid == "mp4"
                            {
                                let  path = midiatr["filePath"].stringValue
                                
                               
                                
                                self.updateequipmentimagedata[self.imageupdtaeequipmentcount]["path"].stringValue = path
                                self.imageupdtaeequipmentcount = self.imageupdtaeequipmentcount + 1;
                                
                                
                                self.updtaeEquimpnetimagetotServer();
                                
                            }
                            else
                            {
                                
                                let respStatus = midiatr["scode"].intValue;
                                print(respStatus)
                                if respStatus == 200
                                {
                                    
                                    
                                    let  path = midiatr["filePath"].stringValue
                                    self.updateequipmentimagedata[self.imageupdtaeequipmentcount]["path"].stringValue = path
                                    self.imageupdtaeequipmentcount = self.imageupdtaeequipmentcount + 1;
                                    
                                    
                                    self.updtaeEquimpnetimagetotServer();
                                    
                                }
                                else
                                {
                                    let  msg = midiatr["message"].stringValue
                                    
                                    print("Error exist here");
                                    
                                    DispatchQueue.main.async {
                                        self.alertshow();
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                            
                        else
                        {
                            DispatchQueue.main.async {
                                self.alertshow();
                            }
                            
                            
                        }
                        
                    }
                    
                    
                case .failure(let encodingError):
                    
                    print("eroror \(encodingError)");
                    
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
            
            
            
            
        }
        else
        {
            
           
            
            let jstr = updateEquipmedata[updateEqqqcount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            dictData!["documents"] = updateequipmentimagedata;
            
            let gjid = updateEquipmedata[updateEqqqcount]["uid"] as! String
            let mygi = JSON(dictData!);
            print(mygi);
            movingaddequipmentdataotserver(mygi, gjid);
            
            
            
            
        }
        
        
    }
    
    
    
    
    func movingupdateEquipmenttoServer(_ cjson : JSON, _ jid : String)
    {
        
        let parms = ["eqpdata" : cjson ];
        print(parms);
        Alamofire.request(vEquipmentUpdateDataApi, method: .post, parameters: parms).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                
                
                
                DispatchQueue.main.async {
                    let filePath = getPath(fileName: locale_DB);
                    let RAdb = FMDatabase.init(path: filePath);
                    guard RAdb.open() else {
                        print("Unable to open database")
                        return
                    }
                    
                    do {
                        let userid = cachem.string(forKey: "userid")!
                        try RAdb.executeUpdate("Delete from updateequipment where userid = ? and uniqueUserid = ?", values: [userid, jid])
                        
                        
                        
                    } catch {
                        print("failed: \(error.localizedDescription)")
                        
                    }
                    RAdb.close();
                    
                    print("addbuilding sheet saved successfulley");
                    
                    
                    
                    
                    
                    self.updateEqqqcount = self.updateEqqqcount + 1;
                    self.updateEquipmentDatotocaller();
                    
                }
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.alertshow();
                })
            }  }
        
    }
    
    
    
    
    
    
    
    func custominspectionUPloadtoServer()
    {
        
        
        if addcustomInspectiondata.count > 0 && addCustomInspectionCount < addcustomInspectiondata.count
        {
            
            
            let jstr = addcustomInspectiondata[addCustomInspectionCount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            var mydatajsonbuiild = JSON(dictData!)
            print("converting jsonstrting into dictionary in build managers");
            
            
            
            let jid =   addcustomInspectiondata[addCustomInspectionCount]["uid"] as! String
            
            
            let params = ["cinsdata": mydatajsonbuiild]
            print("global upload attachment called");
            
            print(jstr)
            
            
            Alamofire.request(vAddCustomInspectionSaveapi, method: .post, parameters: params).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 1
                    {
                     
                    DispatchQueue.main.async {
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            let userid = cachem.string(forKey: "userid")!
                            try RAdb.executeUpdate("Delete from addcustominspection where userid = ? and uniqueUserid = ?", values: [userid, jid])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        print("addbuilding sheet saved successfulley");
                        
                        self.addCustomInspectionCount = self.addCustomInspectionCount + 1;
                        self.custominspectionUPloadtoServer();
                        
                        
                    }
                }else{
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            self.addEfficiencytestformtoServer();
            
            
        }
        
        
        
    }
    
    
    
    
    func addEfficiencytestformtoServer()
    {
        
        
        if addEfficiencyTestAPIData.count > 0 && addEfficiencydatacount < addEfficiencyTestAPIData.count
        {
            
            
            let jstr = addEfficiencyTestAPIData[addEfficiencydatacount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            var mydatajsonbuiild = JSON(dictData!)
            print("converting jsonstrting into dictionary in build managers");
            
            
            
            let jid =   addEfficiencyTestAPIData[addEfficiencydatacount]["uid"] as! String
            
            
            let params = ["eqpdata": mydatajsonbuiild]
            print("global upload attachment called");
            
            print(jstr)
            
            
            Alamofire.request(vEfficiencyTestSaveAPI, method: .post, parameters: params).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 1
                    {
                        
                        DispatchQueue.main.async {
                            let filePath = getPath(fileName: locale_DB);
                            let RAdb = FMDatabase.init(path: filePath);
                            guard RAdb.open() else {
                                print("Unable to open database")
                                return
                            }
                            
                            do {
                                let userid = cachem.string(forKey: "userid")!
                                try RAdb.executeUpdate("Delete from addefficiencytest where userid = ? and uniqueUserid = ?", values: [userid, jid])
                                
                                
                                
                            } catch {
                                print("failed: \(error.localizedDescription)")
                                
                            }
                            RAdb.close();
                            
                            print("addbuilding sheet saved successfulley");
                              self.addEfficiencydatacount = self.addEfficiencydatacount + 1;
                            self.addEfficiencytestformtoServer();
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            
                            self.alertshow();
                            
                            
                        }
                        
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            self.cusotminspectionSaveasMovtoServer()
            
            
        }
        
        
        
    }
    
    
    
   
 
    func cusotminspectionSaveasMovtoServer()
    {
        
        
        if customInsSaveApiData.count > 0 && customInsSaveCout < customInsSaveApiData.count
        {
            
            
            let jstr = customInsSaveApiData[customInsSaveCout]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("converting jsonstrting into dictionary in build managers");
            
            
            
            let jid =   customInsSaveApiData[customInsSaveCout]["uid"] as! String
            
            
            
            print(jstr)
            
            
            Alamofire.request(vCustomInspectionSaveAsAPI, method: .post, parameters: dictData!).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    
                    let resultdata =  JSON(resp.result.value!)
                    let statuscode = resultdata["status"].stringValue
                    if statuscode == "200"
                    {
                        
                        DispatchQueue.main.async {
                            let filePath = getPath(fileName: locale_DB);
                            let RAdb = FMDatabase.init(path: filePath);
                            guard RAdb.open() else {
                                print("Unable to open database")
                                return
                            }
                            
                            do {
                                let userid = cachem.string(forKey: "userid")!
                                try RAdb.executeUpdate("Delete from custominspectionsaveas where userid = ? and uniqueUserid = ?", values: [userid, jid])
                                
                                
                                
                            } catch {
                                print("failed: \(error.localizedDescription)")
                                
                            }
                            RAdb.close();
                            
                            print("addbuilding sheet saved successfulley");
                            self.customInsSaveCout = self.customInsSaveCout + 1;
                            self.cusotminspectionSaveasMovtoServer()
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            
                            self.alertshow();
                            
                            
                        }
                        
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            self.EfficientyTestSaveAsApicall()
            
            
        }
        
        
        
    }
    
    
    
    
    
    func EfficientyTestSaveAsApicall()
    {
        
        
        if equipmentTestSaveASApiData.count > 0 && equipmetnSaveASCount < equipmentTestSaveASApiData.count
        {
            
            
            let jstr = equipmentTestSaveASApiData[equipmetnSaveASCount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("converting jsonstrting into dictionary in build managers");
            
            
            
            let jid =   equipmentTestSaveASApiData[equipmetnSaveASCount]["uid"] as! String
            
            
            
            print(jstr)
            
            
            Alamofire.request(vEfficiencyTestSaveasAPI, method: .post, parameters: dictData!).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    
                    let resultdata =  JSON(resp.result.value!)
                    let statuscode = resultdata["status"].stringValue
                    if statuscode == "200"
                    {
                        
                        DispatchQueue.main.async {
                            let filePath = getPath(fileName: locale_DB);
                            let RAdb = FMDatabase.init(path: filePath);
                            guard RAdb.open() else {
                                print("Unable to open database")
                                return
                            }
                            
                            do {
                                let userid = cachem.string(forKey: "userid")!
                                try RAdb.executeUpdate("Delete from saveaseffieciencytest where userid = ? and uniqueUserid = ?", values: [userid, jid])
                                
                                
                                
                            } catch {
                                print("failed: \(error.localizedDescription)")
                                
                            }
                            RAdb.close();
                            
                            print("addbuilding sheet saved successfulley");
                            self.equipmetnSaveASCount = self.equipmetnSaveASCount + 1;
                            self.EfficientyTestSaveAsApicall()
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            
                            self.alertshow();
                            
                            
                        }
                        
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            mechdefaulteinsData()
           
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func mechdefaulteinsData()
    {
        
        
        if mechdefaultInsApiData.count > 0 && mechdefaultInSCount < mechdefaultInsApiData.count
        {
            
            
            let jstr = mechdefaultInsApiData[mechdefaultInSCount]["sdata"] as! String
            
            var dictData  : Dictionary<String, Any>? = nil
            print(jstr)
            
            print("converting jsonstrting into dictionary");
            
            if let data = jstr.data(using: .utf8) {
                do {
                    dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    print(dictData);
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
            
            print("converting jsonstrting into dictionary in build managers");
            
            
            
            let jid =   mechdefaultInsApiData[mechdefaultInSCount]["uid"] as! String
            
            
            let paramss = ["cidata" : JSON(dictData!) ]
            print(jstr)
            
            
            Alamofire.request(vmechanicalupdateinsApi, method: .post, parameters: paramss).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    
                    let resultdata =  JSON(resp.result.value!)
                    
                        DispatchQueue.main.async {
                            let filePath = getPath(fileName: locale_DB);
                            let RAdb = FMDatabase.init(path: filePath);
                            guard RAdb.open() else {
                                print("Unable to open database")
                                return
                            }
                            
                            do {
                                let userid = cachem.string(forKey: "userid")!
                                try RAdb.executeUpdate("Delete from changedefaultinspection where userid = ? and uniqueUserid = ?", values: [userid, jid])
                                
                                
                                
                            } catch {
                                print("failed: \(error.localizedDescription)")
                                
                            }
                            RAdb.close();
                            
                            print("addbuilding sheet saved successfulley");
                            self.mechdefaultInSCount = self.mechdefaultInSCount + 1;
                            self.mechdefaulteinsData()
                            
                            
                        }
                     
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.alertshow();
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        else
        {
            
            print("im offlinedddddd");
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    

}
