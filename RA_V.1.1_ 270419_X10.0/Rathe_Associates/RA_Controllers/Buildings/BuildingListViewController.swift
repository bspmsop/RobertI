//
//  BuildingListViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability


class BuildingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
         loadingDefaultUI();
        
        
    }
   
    
    
     var hud = MBProgressHUD();
     var lastContentOffset: CGFloat = 0
     var headTitleName = ""
     var fdata =   Array<JSON>()
     var dataDemo =   Array<JSON>()
    
    
    @IBOutlet weak var addbuildingHt: NSLayoutConstraint!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var buildingTable: UITableView!
   
    @IBOutlet weak var menuImg: UIImageView!
    
   
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func buildingSearching(_ sender: UITextField) {
       
        
        
        if sender.text != ""
        {
            dataDemo = [];
            for i in 0..<fdata.count
            {
               let buildData =  fdata[i]
                var buildTitle = buildData["title"].stringValue;
                var buildTitle2 = buildData["title2"].stringValue;
                buildTitle = buildTitle.lowercased();
                buildTitle2 = buildTitle2.lowercased();
                if buildTitle.contains(sender.text!.lowercased()) || buildTitle2.contains(sender.text!.lowercased())
                {
                    dataDemo.append(fdata[i]);
                   
                }
                
                
            }
             self.buildingTable.reloadData();
            
            
        }
        else{
            
            dataDemo = fdata;
            self.buildingTable.reloadData();
            
        }
        
        
        
        
    }
    
    
    
    
  
    @IBAction func addBuildingTapped(_ sender: Any) {
        
          let usertype = cachem.string(forKey: "userType")!;
        
        
        if usertype == "2"
        {
            let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
            return;
            
        }
        
         searchField.endEditing(true);
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddBuildingViewController") as! AddBuildingViewController
        self.navigationController?.pushViewController(vController, animated: true);

        
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
        return  dataDemo.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingList") as! BuildingCellClass
         let dict = dataDemo[indexPath.row];
        cell.address1.text =  dict["title"].stringValue;
        cell.address2.text = dict["title2"].stringValue;
        
        
        
        return cell;
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchField.endEditing(true);
         vselectedbuildingId =  dataDemo[indexPath.row]["id"].stringValue;
         let vController = self.storyboard?.instantiateViewController(withIdentifier: "BuildingDetailViewController") as! BuildingDetailViewController;
         self.navigationController?.pushViewController(vController, animated:  true);
         
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func getOfflineBuildingData()
    {
        
        
        if isOfflineMode
        {
            let localData = cachem.string(forKey: "offlinedata");
            let localJSON = JSON.init(parseJSON: localData!);
            let buildingsData = localJSON["buildings"].arrayObject
            
            
            let anyData = buildingsData!
           
            
            DispatchQueue.main.async {
                self.buildingTable.reloadData();
                self.hud.hide(animated: true);
            }
            
            
        }
        else
        {
            
            
            let localData = cachem.string(forKey: "offlinedata");
            let localJSON = JSON.init(parseJSON: localData!)
            let alert = UIAlertController.init(title: translator("Network Alert"), message: translator("No network connection would you like to use offline data"), preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                
                
                let buildingsData = localJSON["buildings"].arrayObject
                isOfflineMode = true;
                let anyData = buildingsData!
               
                self.fdata = self.dataDemo
                print(self.fdata.count);
                
                DispatchQueue.main.async {
                    self.buildingTable.reloadData();
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
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
            }
            
            return;
        }
        
        
        
        
        
        
        
        
       let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
           
        
        let Buildingapi = "\(vbuildingList)\(userid)/\(usertype)"
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
                    self.fdata = resultdata["response"].arrayValue
                    self.dataDemo = self.fdata;
                    DispatchQueue.main.async {
                        self.buildingTable.reloadData();
                         self.buildingTable.isHidden = false;
                        self.hud.hide(animated: true);
                    }
                    
                   
                    
                    
                    
                }
                   
                else{
                    
                    DispatchQueue.main.async(execute: {
                         self.hud.hide(animated: true);
                    })
                     
                   
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: "Unknown error occured", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_ ) in
                        
                         self.callingBuildingData();
                        
                        
                    }))
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil));
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    
                }
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_ ) in
                    
                    self.callingBuildingData();
                    
                    
                }))
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil))
                
                
                self.present(alert, animated: true, completion: nil);
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    func loadingDefaultUI(){
        
        buildingTable.isHidden = true;
        
        
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer());
        }
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
       
        
         callingBuildingData();
         CompatibleStatusBar(self.view);
        
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
      
        
        
        
    }
   

}







class BuildingCellClass : UITableViewCell
{
    
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    
    
    
    
    
    
}

