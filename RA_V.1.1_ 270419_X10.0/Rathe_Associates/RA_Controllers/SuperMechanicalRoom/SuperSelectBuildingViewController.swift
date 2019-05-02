//
//  SuperSelectBuildingViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 14/11/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Reachability
class SuperSelectBuildingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()

      loadingDefaultUI()
    }
    @IBOutlet weak var selectBuildingBtn: UIButton!
    @IBOutlet weak var listingPopupView: UIView!
    @IBOutlet weak var listingTableView: UITableView!
    @IBOutlet weak var searchUser: UITextField!
    @IBOutlet weak var selectBuildingField: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var dropDownHeight: NSLayoutConstraint!
   
    var data =   Array<Any>()
    var dataDemo =   Array<Any>()
    
    var  mtitle = ""
    var mechId = -1
    
    
    
    
    override var shouldAutorotate: Bool
        {
        return false;
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
        {
        
        return .portrait;
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
        {
        return .portrait;
    }
    
    @IBAction func searchUserTapped(_ sender: UITextField) {
        
        
        
        if sender.text != ""
        {
            data = [];
             
            for i in 0..<dataDemo.count
            {
                
                let dict = dataDemo[i] as? Dictionary<String, Any>
                var estr = dict?["title"] as? String;
                estr = estr?.lowercased();
                if (estr?.contains(sender.text!.lowercased()))!
                {
                    data.append(dataDemo[i]);
                }
            }
        }
        else
        {
            data = dataDemo
        }
        listingTableView.reloadData();
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
          changeLanguage();
          
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectBuildingIden");
        let dict = data[indexPath.row] as? Dictionary<String, Any>
        let buildingTitle = dict?["title"] as! String;
        
        cell?.textLabel!.text = Apitranslator(buildingTitle, GconvertdApiData);
        return cell!;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count ;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = data[indexPath.row ] as? Dictionary<String, Any>
        
        let selectedBuild = dict?["title"] as! String;
        
        selectBuildingField.text =   Apitranslator(selectedBuild, GconvertdApiData);
        mechId = ((dict!["id"]) as! Int);
        mtitle =  Apitranslator(selectedBuild, GconvertdApiData);
        searchUser.resignFirstResponder()
         self.searchUser.font = UIFont.systemFont(ofSize: 0.0);
        
        
        
        dropDownHeight.constant = 0.0;
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (isanimated) in
            
            self.listingPopupView.isHidden =   true;
           
            
        }

        
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if data.count > 0
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
            
        }
        return numOfSections
    }
    
    
    
    @IBAction func BuildingListingTapped(_ sender: Any) {
        print("tapped")
        
        
        
            
        
            self.listingPopupView.isHidden =   false;
            self.dropDownHeight.constant = 220
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (isanimated) in
            
            self.searchUser.font = UIFont.systemFont(ofSize: 18.0);
            
        }
        
       
        
       
    }
    
    @IBAction func CancelBtnTappdd(_ sender: Any) {
        
        
            self.searchUser.font = UIFont.systemFont(ofSize: 0.0);
            self.dropDownHeight.constant = 0.0;
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (isanimated) in
            
             self.listingPopupView.isHidden =   true;
            self.searchUser.resignFirstResponder()
        
        
    }
    }
    
    
    
    
    @IBAction func seletedBuildingTapped(_ sender: Any) {
        
        
        
       
            if  self.mechId == -1
        {
            let alet = UIAlertController.init(title: translator("Alert"), message: translator("Please Select Building"), preferredStyle: .alert);
            alet.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil))
            self.present(alet, animated: true, completion: nil);
        }
        else
        {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "MechanicalRoomSignInViewController") as! MechanicalRoomSignInViewController
            controller.buildId = self.mechId
            GbuildIdentifier = self.mechId;
            controller.buildTitle = self.mtitle
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
         
        
    }
    

    
    @IBOutlet weak var blabel: UILabel!
    @IBOutlet weak var sbuildingLab: UILabel!
    
    
    
    
    
    func changeLanguage()
    {
        
        blabel.text = translator("Building");
        sbuildingLab.text = translator("SELECT BUILDING");
        selectBuildingField.placeholder =  translator("Select Building");
        selectBuildingBtn.setTitle(translator("SELECT BUILDING"), for: .normal);
       searchUser.placeholder = translator("Search");
        
    }
    
   
    
    
    
  
    func loadingDefaultUI()
    {
        
        isEmergencyStop = false;
        self.navigationController?.navigationBar.isHidden = true;
        selectBuildingBtn.layer.cornerRadius = 8.0;
        selectBuildingBtn.clipsToBounds = true
        searchUser.font = UIFont.systemFont(ofSize: 0.0);
        dropDownHeight.constant = 0.0;
        listingPopupView.isHidden = true;
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 130;
            
            self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!);
        }
        
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        
        
         let checkNetwork = Reachability()!;
      
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
       
        
        if checkNetwork.connection == .none
        {
            if isOfflineMode
            {
                let localData = cachem.string(forKey: "offlinedata");
                let localJSON = JSON.init(parseJSON: localData!);
                let buildingsData = localJSON["buildings"].arrayObject
                
                let anyData = buildingsData!
                self.dataDemo = anyData
                self.data = self.dataDemo
                self.listingTableView.reloadData();
                hud.hide(animated: true);
                 GlobalTimer.backgroundSyn.startSync(self);
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
                    self.dataDemo = anyData
                    self.data = self.dataDemo
                    print(self.data.count);
                    self.listingTableView.reloadData();
                     hud.hide(animated: true);
                     GlobalTimer.backgroundSyn.startSync(self);
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    hud.hide(animated: true);
                }))
                self.present(alert, animated: true, completion: nil);
                return
            }
        }
        else
        {
            
            print("network exists here");
        }
        
        
        
       let userType = cachem.string(forKey: "userType")!
        
        print("\(buildingListApi)/\(userid!)/\(userType)")
        Alamofire.request("\(buildingListApi)/\(userid!)/\(userType)").responseJSON { (responseData) in
            print(responseData);
            
           
            
            if((responseData.result.value) != nil)
            {
                isOfflineMode = false
                print(responseData.result.value)
                
                let testdata = responseData.result.value as! Dictionary<String, Any>
                let usualDta = testdata["response"] as! [Any]
                
                 self.dataDemo = testdata["response"] as! [Any]
                 self.data = self.dataDemo;
                
                
                convertIntoDict("title", usualDta,", . ", handler: { (_, mydata ) in
                    GconvertdApiData = Dictionary<String, String>();
                    GconvertdApiData = mydata;
                    self.listingTableView.reloadData();
                    hud.hide(animated: true);
                })
                
                
                
                
                
                 
                
                
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
                        self.dataDemo = anyData
                        self.data = self.dataDemo
                        
                        self.listingTableView.reloadData();
                        hud.hide(animated: true);
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        hud.hide(animated: true);
                    }))
                    self.present(alert, animated: true, completion: nil);
                        
                    
                
                
            
            }
            
            
                
                GlobalTimer.backgroundSyn.startSync(self);
                
            
            
        }
        
    }
        
//    override var shouldAutorotate: Bool{
//        return false;
//    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return .portrait
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation
//    {  return .portrait
//    }
//
    
    

    
    
    
    
    
}
