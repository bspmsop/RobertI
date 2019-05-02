//
//  EquipmetManagementViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Reachability
 
import KxMenu
class EquipmetManagementViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        loadingDefaultUI();
    }
    
   
    
    @IBOutlet weak var equipmentTable: UITableView!
    
    @IBOutlet weak var menuButton: UIButton!
    var fdata =   Array<JSON>()
    var dataDemo =   Array<JSON>()
        var hud = MBProgressHUD();
    
    
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        
        if Gmenu.count > 5
        {
            let isread =  Gmenu[5]["isread"]!
            
            if isread == "1"  
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddEquipmentViewController") as! AddEquipmentViewController
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
    }
    
    
    
    
    
    
    @IBAction func searchintapped(_ sender: UITextField) {
        
       
        
        if sender.text != ""
        {
            dataDemo = [];
            for i in 0..<fdata.count
            {
                let buildData =  fdata[i]
                var buildTitle = buildData["etitle"].stringValue;
                var buildTitle2 = buildData["address"].stringValue;
                var buildTitle3 = buildData["title"].stringValue;
                buildTitle = buildTitle.lowercased();
                buildTitle2 = buildTitle2.lowercased();
                  buildTitle3 = buildTitle2.lowercased();
                
                if buildTitle.contains(sender.text!.lowercased()) || buildTitle2.contains(sender.text!.lowercased()) || buildTitle3.contains(sender.text!.lowercased())
                {
                    dataDemo.append(fdata[i]);
                    
                }
                
                
            }
            self.equipmentTable.reloadData();
            
            
        }
        else{
            
            dataDemo = fdata;
            self.equipmentTable.reloadData();
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customlist") as! Equipmentlistingvcellclass
        
        cell.inititle.text = dataDemo[indexPath.row]["etitle"].stringValue;
        cell.address.text = dataDemo[indexPath.row]["address"].stringValue;
        cell.mechtitle.text = dataDemo[indexPath.row]["title"].stringValue;
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85;
        
        
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        vselectedEquipmentID = dataDemo[indexPath.row]["eid"].stringValue;
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EquipmentDetailViewController") as! EquipmentDetailViewController
        self.navigationController?.pushViewController(controller, animated: true);
        
        
        
    }
     
    
    func callEquipmentlistdata()
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
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil)
            }
           
            
           
           
            return;
        }
        
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vEquipmentListApi)\(userid)/\(usertype)"
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
                        self.equipmentTable.reloadData();
                        self.equipmentTable.isHidden = false;
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
                       
                        self.callEquipmentlistdata();
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
                
               
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    //---- Default Func ------
    func loadingDefaultUI()
    {
        
        if self.revealViewController() != nil
        {
           menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer());
        }
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
       
        equipmentTable.isHidden = true;
        
          CompatibleStatusBar(self.view);
        callEquipmentlistdata()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
    
    
    

}




class Equipmentlistingvcellclass : UITableViewCell
{
    
    @IBOutlet weak var inititle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mechtitle: UILabel!
    
    
    
    
    
}
