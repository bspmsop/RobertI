//
//  NotificationViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 09/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//


import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Reachability
 
class NotificationViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        loadingDefaultUI();
    }
   
     
    var fdata =   Array<JSON>()
    var dataDemo =   Array<JSON>()
    var hud = MBProgressHUD();
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationTable: UITableView!
    
    
    
    
    
    @IBAction func addNotification(_ sender: UIButton) {
        
        if Gmenu.count > 7
        {
            let isread =  Gmenu[7]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddNotificationViewController") as! AddNotificationViewController
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
    }
    
    
   
    @IBAction func searchingNotification(_ sender: UITextField) {
        
        
        
        if sender.text != ""
        {
            dataDemo = [];
            for i in 0..<fdata.count
            {
                let buildData =  fdata[i]
                
                
                var buildTitle = buildData["company"].stringValue;
                var buildTitle2 = buildData["message"].stringValue;
                var buildTitle3 = buildData["user_type"].stringValue;
                buildTitle = buildTitle.lowercased();
                buildTitle2 = buildTitle2.lowercased();
                buildTitle3 = buildTitle2.lowercased();
                
                if buildTitle.contains(sender.text!.lowercased()) || buildTitle2.contains(sender.text!.lowercased()) || buildTitle3.contains(sender.text!.lowercased())
                {
                    dataDemo.append(fdata[i]);
                    
                }
                
                
            }
            self.notificationTable.reloadData();
            
            
        }
        else{
            
            dataDemo = fdata;
            self.notificationTable.reloadData();
            
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customlist") as! NotificationCellerClass
        
        cell.title.text = dataDemo[indexPath.row]["company"].stringValue;
        cell.subtitle.text = dataDemo[indexPath.row]["message"].stringValue;
        cell.subsubtitle.text = dataDemo[indexPath.row]["user_type"].stringValue;
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85;
        
        
    }
    
    
    
   
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "NotificationDetailViewController") as! NotificationDetailViewController
       vController.sNotification_id =  dataDemo[indexPath.row]["id"].stringValue;
        
        self.navigationController?.pushViewController(vController, animated: true);
    }
    
    
    
   
    
    func callingnotificationLIst()
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
        
        
        
        
        
        
        
        
//        let userid = cachem.string(forKey: "userid")!
//
//        let usertype = cachem.string(forKey: "userType")!;
        
        
        
        Alamofire.request(vNotificationListAPI, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
               
                
                if  resp.result.isSuccess
                {
                    
                    
                    isOfflineMode = false
                    self.fdata = resultdata["data"].arrayValue
                    self.dataDemo = self.fdata;
                    DispatchQueue.main.async {
                        self.notificationTable.reloadData();
                        self.notificationTable.isHidden = false;
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
                        
                        self.callingnotificationLIst();
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
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
        
        
        
        
        
       CompatibleStatusBar(self.view);
        notificationTable.isHidden = true;
        callingnotificationLIst();
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
        
    }

    
    
    
    
    
    
    
    

}


class NotificationCellerClass : UITableViewCell
{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var subsubtitle: UILabel!
    
    
    
    
}
