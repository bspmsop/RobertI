//
//  MechanicalRoomSignInViewController.swift
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

class MechanicalRoomSignInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    override func viewDidLoad() {
        super.viewDidLoad();
         timerStatus = false
         loadingDefaultUI();
    }
    
    @IBOutlet weak var menuButton: UIButton!
    
    
    @IBOutlet weak var listingTableView: UITableView!
    
    
    @IBOutlet weak var mechanicalroomHeadTitle: UILabel!
    
    var mechnetwork = Reachability()!
    var fdata =   Array<JSON>()
    var dataDemo =   Array<JSON>()
    var mechId = -1
 
 
    var buildId = -1
    var buildTitle = "";
    var uniqueCode = ""
    
    
    @IBAction func signInlogTapped(_ sender: UIButton) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "SignInLogViewController") as! SignInLogViewController
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    
    
    @IBAction func searchingtapped(_ sender: UITextField) {
     
        if sender.text != ""
        {
            dataDemo = [];
            for i in 0..<fdata.count
            {
                let buildData =  fdata[i]
                var buildTitle = buildData["mname"].stringValue;
                var buildTitle2 = buildData["address"].stringValue;
                buildTitle = buildTitle.lowercased();
                buildTitle2 = buildTitle2.lowercased();
                if buildTitle.contains(sender.text!.lowercased()) || buildTitle2.contains(sender.text!.lowercased())
                {
                    dataDemo.append(fdata[i]);
                    
                }
                
                
            }
            self.listingTableView.reloadData();
            
            
        }
        else{
            
            dataDemo = fdata;
            self.listingTableView.reloadData();
            
        }
        
        
        
        
    }
    
    @IBAction func searchUserTapped(_ sender: UITextField) {
//        if sender.text != ""
//        {
//            data = [];
//
//            for i in 0..<dataDemo.count
//            {
//
//               let dict = dataDemo[i ] as? Dictionary<String, Any>
//               var estr = dict?["title"] as? String;
//                estr = estr?.lowercased();
//                if (estr?.contains(sender.text!.lowercased()))!
//                {
//                    data.append(dataDemo[i]);
//                }
//            }
//        }
//        else
//        {
//            data = dataDemo
//        }
//        listingTableView.reloadData();
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingList") as! Cmechrommcellclass
        
         cell.title.text = dataDemo[indexPath.row]["mname"].stringValue;
        
        cell.address.text =  dataDemo[indexPath.row]["address"].stringValue;
        
        return cell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDemo.count  ;
    }
    
    var mtitle = "";
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dict = data[indexPath.row  ] as? Dictionary<String, Any>
//
//
//          let selectedmech = dict?["title"] as! String;
//
//        mechId = ((dict!["id"]) as! Int);
//        mechanicalRoomID = ((dict!["id"]) as! Int);
        GbuildIdentifier = dataDemo[indexPath.row]["cid"].intValue;
        mechanicalRoomID = dataDemo[indexPath.row]["mid"].intValue;
         mtitle = dataDemo[indexPath.row]["mname"].stringValue;
       mechId = dataDemo[indexPath.row]["mid"].intValue;
        mechSignin()
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if dataDemo.count > 0
        {
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = translator("No data available");
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82 ;
    }
    
    var resultData = Array<Any>();
    
    
    
    
    
    
   
    
      func mechSignin() {
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        
        //print(mtitle)
       
        if  mechId ==  -1
        {
            let alet = UIAlertController.init(title: translator("Alert"), message: translator("Please Select Mechanical Room"), preferredStyle: .alert);
            alet.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil))
            self.present(alet, animated: true, completion: nil);
        }
        else
        {
            
            let defaultValues = UserDefaults.standard
            let userid = defaultValues.string(forKey: "userid")
            let userType = cachem.string(forKey: "userType")!
            
            let parameters: Parameters = [
                "user_id": userid!,
                "mech_id": mechId,
                "user_type" : userType
            ]
            print(parameters);
            
            
            let networkSignal = Reachability()!
            
            
            
            if networkSignal.connection == .none
            {
                
                
                print(mechId);
                print("mechanicalId");
                
                if isOfflineMode
                {
                    let userType = cachem.string(forKey: "userType")!
                   savedataToLocaleDB(userid!, userType, mechId)
                    
                    
                    return;
                }
                else
                
                {
                    print("**************0");
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                         isOfflineMode = true;
                        self.savedataToLocaleDB(userid!, userType, self.mechId)
                        print(networkMsg);
                        
                        
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
            Alamofire.request( mechanicalroomSignInApi, method: .post, parameters: parameters).responseJSON { (resp) in
                
                hud.hide(animated: true);
                if resp.result.value != nil
                {
                    isOfflineMode = false
                    print(resp.result.value)
                    
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                        let message = resultdata["message"] as! String
                        let alert = UIAlertController.init(title: translator("Success"), message: translator("User Signin Mechanical Room"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                           
                            let controllers = storyboard.instantiateViewController(withIdentifier: "MechanicalRoomDashboardViewController") as! MechanicalRoomDashboardViewController
                            controllers.mid = self.mechId
                             controllers.headTitle = self.mtitle
                            
                             controllers.mechTitle = self.mtitle
                             controllers.signId  = resultdata["signinid"] as! Int
                            
                            let nav = UINavigationController.init(rootViewController: controllers);
                            GlobalNav = nav
                            GlobalNav2 = nil
                            timerStatus = true;
                            GlobalTimer.sharedTimer.startTimer();
                            self.present(nav, animated: false, completion: nil);
                            
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
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
                    
                    let alert = UIAlertController.init(title: translator("Alert!"), message: translator("Your request has been timed out Would you like to use offline data"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        self.savedataToLocaleDB(userid!, userType, self.mechId)
                        
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
            }}}
                
                
                
                
            
            
            
            
            
   
        
    func savedataToLocaleDB(_ uId : String, _ uType : String, _ mId: Int )
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
                
                  uniqueCode = uId + tdate
                
                try RAdb.executeUpdate("insert into signInLog(userid, mechId, userType, dateSignIn, uniqueUserid) values (?, ?, ?, ?, ?)", values: [uId, mId, uType, tdate , uniqueCode])
                
                print(mId);
                
               
                
            } catch {
                print("failed: \(error.localizedDescription)")
            }
            
            RAdb.close()
            
            let alert = UIAlertController.init(title: translator("Success"), message: translator("User Signin Mechanical Room"), preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                let controllers = self.storyboard?.instantiateViewController(withIdentifier: "MechanicalRoomDashboardViewController") as! MechanicalRoomDashboardViewController
                controllers.mid = self.mechId
                //controllers.headTitle = self.boilerRoomTextBox.text!
                
               // controllers.mechTitle = self.boilerRoomTextBox.text! as String
                controllers.mylocalDataId =  self.uniqueCode
               // controllers.signId  = resultdata["signinid"] as! Int
                controllers.OsignId = self.uniqueCode;
                let nav = UINavigationController.init(rootViewController: controllers);
                GlobalNav = nav
                GlobalNav2 = nil
                timerStatus = true;
                GlobalTimer.sharedTimer.startTimer();
                self.present(nav, animated: false, completion: nil);
            }))
            self.present(alert, animated: true, completion: nil);
            
            
            
            
            
            
            
            
            
            
            
    }
        
    
    
    
    @IBAction func backbtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    @IBOutlet weak var selectMechanicalRoomLab: UILabel!
    
    
    func loadLanguage()
    {
        
        
        
      //  selectMechanicalRoomLab.text = translator("SELECT MECHANICAL ROOM").uppercased();
        
        
        
    }
    
    
    func loadingDefaultUI()
    {
        
       
        
        
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer());
        }
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
       
        
        CompatibleStatusBar(self.view);
        
       
        
        if mechnetwork.connection == .none
        {
            if isOfflineMode
            {
                
                let localData = cachem.string(forKey: "offlinedata");
                let localJSON = JSON.init(parseJSON: localData!)
                
                
                let buildingsData = localJSON["buildings"].arrayObject
                
                let anyData = buildingsData!
                for i in 0..<anyData.count
                {
                    let builer = anyData[i] as! Dictionary<String, Any>;
                    let builerIDE = builer["id"] as! Int;
                    if buildId == builerIDE
                    {
                        
//                        let mymechData =  builer["mechanicals"] as! Array<Any>
//                        self.dataDemo = mymechData
//                        self.data = self.dataDemo;
                        self.listingTableView.reloadData();
                        
                        
                        break;
                    }
                }
                
                
                
                return
                
            }
            else
            {
                
                let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    let localData = cachem.string(forKey: "offlinedata");
                    let localJSON = JSON.init(parseJSON: localData!)
                    isOfflineMode = true;
                    
                    let buildingsData = localJSON["buildings"].arrayObject
                    
                    let anyData = buildingsData!
                    for i in 0..<anyData.count
                    {
                        let builer = anyData[i] as! Dictionary<String, Any>;
                        let builerIDE = builer["id"] as! Int;
                        if self.buildId == builerIDE
                        {
                            
//                            let mymechData =  builer["mechanicals"] as! Array<Any>
//                            self.dataDemo = mymechData
//                            self.data = self.dataDemo;
                            self.listingTableView.reloadData();
                            
                            
                            break;
                        }
                    }
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator( "Cancel" ), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                
                return
                
            }
            
         
        }
        
        
        
        
        
        
        
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
         let userType = cachem.string(forKey: "userType")!
        let userid = cachem.string(forKey: "userid")!
        Alamofire.request("\(vmechanicalListapi)\(userid)/\(userType)").responseJSON { (responseData) in
            if((responseData.result.value) != nil)
            {
                isOfflineMode = false;
                print(responseData.result.value)
                let testdata = JSON(responseData.result.value!)
                self.fdata = testdata["mechs"].arrayValue
                self.dataDemo = self.fdata;
                DispatchQueue.main.async {
                    self.listingTableView.reloadData();
                    self.listingTableView.isHidden = false;
                     hud.hide(animated: true);
                }
                
                
                
            }
            else
            {
                 hud.hide(animated: true);
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, would you like to use offline data"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    let localData = cachem.string(forKey: "offlinedata");
                    let localJSON = JSON.init(parseJSON: localData!)
                    isOfflineMode = true;
                    
                    let buildingsData = localJSON["buildings"].arrayObject
                    
                    let anyData = buildingsData!
                    for i in 0..<anyData.count
                    {
                        let builer = anyData[i] as! Dictionary<String, Any>;
                        let builerIDE = builer["id"] as! Int;
                        if self.buildId == builerIDE
                        {
                            
//                            let mymechData =  builer["mechanicals"] as! Array<Any>
//                            self.dataDemo = mymechData
//                            self.data = self.dataDemo;
                            self.listingTableView.reloadData();
                            
                            
                            break;
                        }
                    }
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator( "Cancel" ), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                
                
                
               
            }
        }
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






