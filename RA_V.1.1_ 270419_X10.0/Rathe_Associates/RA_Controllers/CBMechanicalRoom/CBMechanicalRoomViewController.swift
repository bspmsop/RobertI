//
//  CBMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 25/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Reachability

class CBMechanicalRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        loadingDefaultUI();
    }
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var mechanicalListTable: UITableView!
    @IBOutlet weak var searchMechRoom: UITextField!
    var headTitleName = ""
    var fdata =   Array<JSON>()
    var dataDemo =   Array<JSON>()
    
    
    var hud = MBProgressHUD();
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func searchingMechroom(_ sender: UITextField) {
        
        
        
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
            self.mechanicalListTable.reloadData();
            
            
        }
        else{
            
            dataDemo = fdata;
            self.mechanicalListTable.reloadData();
            
        }
        
        
        
        
    }
    
  
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if dataDemo.count > 0
        {
            numOfSections            =  1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = translator("No data available");
            noDataLabel.textColor     = UIColor.white
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataDemo.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingList") as! Cmechrommcellclass
 
        cell.title.text = dataDemo[indexPath.row]["mname"].stringValue;
        
        cell.address.text =  dataDemo[indexPath.row]["address"].stringValue;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "DetailCBMechanicalRoomViewController") as! DetailCBMechanicalRoomViewController;
        vselectedmechanicalId = dataDemo[indexPath.row]["mid"].stringValue;
        vselectedmechtitrle = dataDemo[indexPath.row]["mname"].stringValue;
        self.navigationController?.pushViewController(vController, animated: true);
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82;
    }
    
    
    @IBAction func addMechanicalroomTapped(_ sender: Any) {
        
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
        
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddCBMechanicalRoomViewController") as! AddCBMechanicalRoomViewController;
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func getOfflineBuildingData()
    {
        
//
//        if isOfflineMode
//        {
//            let localData = cachem.string(forKey: "offlinedata");
//            let localJSON = JSON.init(parseJSON: localData!);
//            let buildingsData = localJSON["buildings"].arrayObject
//            fdata = [Any]();
//            for i in  0..<buildingsData!.count
//            {
//
//                let ecachbuilding = buildingsData![i] as! Dictionary<String, Any>
//                let mchrooms = ecachbuilding["mechanicals"] as? Array<Any>
//                if mchrooms != nil
//                {
//                    fdata = fdata + mchrooms!;
//
//                }
//
//
//
//
//            }
//            dataDemo = fdata;
//
//
//
//
//            DispatchQueue.main.async {
//                self.mechanicalListTable.reloadData();
//                self.hud.hide(animated: true);
//            }
//
//
//        }
//        else
//        {
//
//
//            let localData = cachem.string(forKey: "offlinedata");
//            let localJSON = JSON.init(parseJSON: localData!)
//            let alert = UIAlertController.init(title: translator("Network Alert"), message: translator("No network connection would you like to use offline data"), preferredStyle: .alert);
//            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
//
//
//
//                let buildingsData = localJSON["buildings"].arrayObject
//                self.fdata = [Any]();
//                for i in  0..<buildingsData!.count
//                {
//
//                    let ecachbuilding = buildingsData![i] as! Dictionary<String, Any>
//                    let mchrooms = ecachbuilding["mechanicals"] as? Array<Any>
//                    if mchrooms != nil
//                    {
//                        self.fdata = self.fdata + mchrooms!;
//
//                    }
//
//
//
//
//                }
//                self.dataDemo = self.fdata;
//
//
//
//                DispatchQueue.main.async {
//                    self.mechanicalListTable.reloadData();
//                    self.hud.hide(animated: true);
//                }
//
//
//
//            }))
//
//            alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
//                DispatchQueue.main.async {
//
//                    self.hud.hide(animated: true);
//                }
//
//            }))
//            self.present(alert, animated: true, completion: nil);
//            return
//        }
//
//
        
    }
    
    func callingBuildingData()
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
        
        
        let Buildingapi = "\(vmechanicalListapi)\(userid)/\(usertype)"
        print(Buildingapi);
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                
                
                if  resp.result.isSuccess
                {
                    
                    isOfflineMode = false
                    self.fdata = resultdata["mechs"].arrayValue
                    self.dataDemo = self.fdata;
                    DispatchQueue.main.async {
                        self.mechanicalListTable.reloadData();
                        self.mechanicalListTable.isHidden = false;
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
                        
                        self.callingBuildingData();
                       
                        
                        
                    }))
                    alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    //----- Default Func ----
    
    func loadingDefaultUI(){
        
        if self.revealViewController() != nil
        {
           menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer());
        }
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
        
        mechanicalListTable.isHidden = true;
         callingBuildingData();
        
        CompatibleStatusBar(self.view);
        
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
        
        
    }
    
    
    

}







//------------------------- base cellss ------------
class Cmechrommcellclass : UITableViewCell
{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    
    
    
    
    
    
    
    
}
