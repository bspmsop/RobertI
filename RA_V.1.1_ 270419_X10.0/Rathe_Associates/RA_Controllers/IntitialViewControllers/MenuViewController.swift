//
//  MenuViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
       
       loadingDefaultUI()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if gisFromDashboard
        {
            loadingDefaultUI();
        }
    }
    
    var expandedrow = -1
  
    
   
   
   
  
   
    
   
    
    var temporarySelection: CGFloat = 0
    var selectedheader = -1;
    var isexpanded = false;
    var myview = UIView();
    var reportview = UIView();
    @IBOutlet weak var userview: UIView!
    
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var usertitle: UILabel!
    @IBOutlet weak var menuTable: UITableView!
    
    
    
    var undermenu = [Dictionary<String, String>]();
    
    
    
    
    
    
    
    var adminMenu = [["name": "Dashboard" , "id": "0", "img" : "dashboard"],
                     ["name": "Buildings" , "id": "1", "img" : "buildings"],
                     ["name": "Custom Inspectionsheets" , "id": "2", "img" : "userMangment"], ["name": "Equipment Test" , "id": "3", "img" : "mech"],
                     ["name": "Mechanical Rooms" , "id": "4", "img" : "buildings"],
                     ["name": "Equipment" , "id": "5", "img" : "reports"],
                     ["name": "Inspections" , "id": "6", "img" : "subscribe"],
                     ["name": "Notifications" , "id": "7", "img" : "reports"],
                     ["name": "Reports" , "id": "8", "img" : "mech", "imgr":"menuright", "imaged" : "menudown"],
                       ["name": "Companies" , "id": "9", "img" : "dashboard"],
                        ["name": "User Management" , "id": "10", "img" : "userMangment"],
                         ["name": "Subscriptions" , "id": "11", "img" : "subscribe"],
                          ["name": "SYNC" , "id": "12", "img" : "sync"],
                           ["name": "Logout" , "id": "13", "img" : "logout"] ];
    
   
    var  ratheadminMenu = [["name": "Dashboard" , "id": "0", "img" : "dashboard"],
                           ["name": "Buildings" , "id": "1", "img" : "buildings"],
                           ["name": "Custom Inspectionsheets" , "id": "2", "img" : "userMangment"], ["name": "Equipment Test" , "id": "3", "img" : "mech"],
                           ["name": "Mechanical Rooms" , "id": "4", "img" : "buildings"],
                           ["name": "Equipment" , "id": "5", "img" : "reports"],
                           ["name": "Inspections" , "id": "6", "img" : "subscribe"],
                           ["name": "Notifications" , "id": "7", "img" : "reports"],
                           ["name": "Reports" , "id": "8", "img" : "mech", "imgr":"menuright", "imaged" : "menudown"],
                           ["name": "Companies" , "id": "9", "img" : "dashboard"],
                           ["name": "User Management" , "id": "10", "img" : "userMangment"],
                           
                           ["name": "SYNC" , "id": "12", "img" : "sync"],
                           ["name": "Logout" , "id": "13", "img" : "logout"] ];
    
   
    var cormportatemanagerMenu = [["name": "Dashboard" , "id": "0", "img" : "dashboard"],
                                  ["name": "Buildings" , "id": "1", "img" : "buildings"],
                                  ["name": "Custom Inspectionsheets" , "id": "2", "img" : "userMangment"], ["name": "Equipment Test" , "id": "3", "img" : "mech"],
                                  ["name": "Mechanical Rooms" , "id": "4", "img" : "buildings"],
                                  ["name": "Equipment" , "id": "5", "img" : "reports"],
                                  ["name": "Inspections" , "id": "6", "img" : "subscribe"],
                                  
                                  ["name": "Reports" , "id": "8", "img" : "mech", "imgr":"menuright", "imaged" : "menudown"],
                                  ["name": "Companies" , "id": "9", "img" : "dashboard"],
                                  ["name": "User Management" , "id": "10", "img" : "userMangment"],
                                 
                                  ["name": "SYNC" , "id": "12", "img" : "sync"],
                                  ["name": "Logout" , "id": "13", "img" : "logout"] ];
    
    
    var buildingManagerMenu = [["name": "Dashboard" , "id": "0", "img" : "dashboard"],
                               ["name": "Buildings" , "id": "1", "img" : "buildings"],
                               ["name": "Custom Inspectionsheets" , "id": "2", "img" : "userMangment"], ["name": "Equipment Test" , "id": "3", "img" : "mech"],
                               ["name": "Mechanical Rooms" , "id": "4", "img" : "buildings"],
                               ["name": "Equipment" , "id": "5", "img" : "reports"],
                               ["name": "Inspections" , "id": "6", "img" : "subscribe"],
                               
                               ["name": "Reports" , "id": "8", "img" : "mech", "imgr":"menuright", "imaged" : "menudown"],
                               
                               ["name": "User Management" , "id": "10", "img" : "userMangment"],
                              
                               ["name": "SYNC" , "id": "12", "img" : "sync"],
                               ["name": "Logout" , "id": "13", "img" : "logout"] ];
    
    
    var  Pmenu = [JSON]();
    
    
    
    @objc func headerTapped(_ sender : UIBotton)
    {
        selectedheader = sender.tag;
        myview.backgroundColor = UIColor.clear;
       sender.myparentVw.backgroundColor  = UIColor.init(hexString: "005462");
        myview = sender.myparentVw;
        let id = Pmenu[sender.tag]["id"].stringValue;
        switch id
        {
        case "0":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                 isexpanded = !isexpanded
            }
            
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "DashbaordNav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
            
        case "1":
            
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "buildingNav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
            
        case "2":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "CustomInspectionNav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
            
        case "3":
            
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "equipmenttestnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
            
        case "4":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "signInMechanicalRoomNav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "5":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "EquipmentNav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "6":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "inspectionreportnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "7":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "notificationnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "8":
            expandedrow = sender.tag
            print(sender.tag);
                 isexpanded = !isexpanded
                 DispatchQueue.main.async {
                  self.menuTable.reloadSections( IndexSet.init(integer: sender.tag), with: .fade)
                   // self.menuTable.reloadData();
                    self.myview = self.reportview
                 }
            
            
            
             break;
            
        case "9":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let usertpe = cachem.string(forKey: "userType")!;
            
            if usertpe == "3"
            {
                let controler = self.storyboard?.instantiateViewController(withIdentifier: "CompanyDetailViewController") as! CompanyDetailViewController
                controler.isfromcorportat = true;
                let naver = UINavigationController.init(rootViewController: controler)
                
                self.revealViewController()?.pushFrontViewController(naver, animated: true);
                
            }
            else
            {
                let vController = self.storyboard?.instantiateViewController(withIdentifier: "companynavtest");
                self.revealViewController()?.pushFrontViewController(vController, animated: true);
                
            }
            
           
            break;
        case "10":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "usernavtest");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "11":
            
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "subscriptionnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "12":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "syncNav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "13":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            
            let stryo = UIStoryboard.init(name: "super", bundle: nil);
            let vController = stryo.instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
              let navii = UINavigationController.init(rootViewController: vController)
            self.revealViewController()?.pushFrontViewController(navii, animated: true);
            break;
            
            
            
            
            
            
        case "14":
            if isexpanded
            {
                if expandedrow > -1
                {
                    DispatchQueue.main.async {
                        self.menuTable.reloadSections( IndexSet.init(integer: self.expandedrow ), with: .fade)
                        // self.menuTable.reloadData();
                        self.myview = self.reportview
                    }
                }
                isexpanded = !isexpanded
            }
            
            let alert = UIAlertController.init(title: "Alert!", message: "Are yout sure want to logout form the app", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_ ) in
                
                self.logoutTapped(UIButton());
                
                
            }))
            alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
            
            break;
            
        default:
            break;
            
            
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func reportsTapped(_ sender: UIButton) {
        
        
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return Pmenu.count;
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isexpanded
        {
            let id = Pmenu[section]["id"].stringValue;

            if id == "8"
            {
//                var rowsintab = 0
//                if Pmenu[section]["id1"].stringValue == "1"
//                {
//                    rowsintab = rowsintab + 1
//                }
//                if Pmenu[section]["id2"].stringValue == "1"
//                {
//                    rowsintab = rowsintab + 1
//                }
//                if Pmenu[section]["id3"].stringValue == "1"
//                {
//                    rowsintab = rowsintab + 1
//                }
//                if Pmenu[section]["id4"].stringValue == "1"
//                {
//                    rowsintab = rowsintab + 1
//                }
//                if Pmenu[section]["id5"].stringValue == "1"
//                {
//                    rowsintab = rowsintab + 1
//                }

                 return undermenu.count;
            }
           
            
            
        }
        return 0;
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 29] as! menucellheaderCvlass
        cell.headTapper.tag = section;
        cell.headTapper.addTarget(self, action: #selector(headerTapped(_:)), for: .touchUpInside)
        cell.headTapper.myparentVw = cell.backgroundVw;
        cell.titlewt.constant = self.view.frame.width * 0.7 - 50
        if selectedheader == section
        {
            cell.backgroundVw.backgroundColor  = UIColor.init(hexString: "005462");
            
            
        }
        else{
            cell.backgroundVw.backgroundColor  = UIColor.clear;
        }
        
        cell.title.text = Pmenu[section]["name"].stringValue
        cell.frontimg.image = UIImage.init(named: Pmenu[section]["img"].stringValue);
        let id = Pmenu[section]["id"].stringValue
        if id == "8"
        {
            
                        cell.titlewt.constant = 80;
                        self.reportview = cell.backgroundVw;
                        if isexpanded
                        {
                             cell.rightimage.image = UIImage.init(named: Pmenu[section]["imaged"].stringValue);
                        }
                        else
                        {
            
                             cell.rightimage.image = UIImage.init(named: Pmenu[section]["imgr"].stringValue);
                        }
            
        }
        
        
        
//        switch section
//        {
//        case 0:
//            cell.title.text = "Dashboard";
//            cell.frontimg.image = UIImage.init(named: "dashboard");
//            break;
//
//        case 1:
//            cell.title.text = "Buildings";
//            cell.frontimg.image = UIImage.init(named: "buildings");
//            break;
//
//        case 2:
//            cell.title.text = "Custom Inspectionsheets";
//            cell.frontimg.image = UIImage.init(named: "userMangment");
//            break;
//
//        case 3:
//            cell.title.text = "Equipment Test";
//            cell.frontimg.image = UIImage.init(named: "mech");
//            break;
//
//        case 4:
//            cell.title.text = "Mechanical Rooms";
//            cell.frontimg.image = UIImage.init(named: "buildings");
//            break;
//        case 5:
//            cell.title.text = "Equipment";
//            cell.frontimg.image = UIImage.init(named: "reports");
//            break;
//        case 6:
//            cell.title.text = "Inspections";
//            cell.frontimg.image = UIImage.init(named: "subscribe");
//            break;
//        case 7:
//            cell.title.text = "Notifications";
//            cell.frontimg.image = UIImage.init(named: "reports");
//            break;
//        case 8:
//            cell.title.text = "Reports";
//            cell.titlewt.constant = 80;
//            self.reportview = cell.backgroundVw;
//            if isexpanded
//            {
//                 cell.rightimage.image = UIImage.init(named: "menudown");
//            }
//            else
//            {
//
//                 cell.rightimage.image = UIImage.init(named: "menuright");
//            }
//            cell.frontimg.image = UIImage.init(named: "mech");
//
//            break;
//        case 9:
//            cell.title.text = "Companies";
//            cell.frontimg.image = UIImage.init(named: "dashboard");
//            break;
//        case 10:
//            cell.title.text = "User Management";
//            cell.frontimg.image = UIImage.init(named: "userMangment");
//            break;
//        case 11:
//            cell.title.text = "Subscriptions";
//            cell.frontimg.image = UIImage.init(named: "subscribe");
//            break;
//        case 12:
//            cell.title.text = "SYNC";
//            cell.frontimg.image = UIImage.init(named: "sync");
//            break;
//        case 13:
//            cell.title.text = "Logout";
//            cell.frontimg.image = UIImage.init(named: "logout");
//            break;
//
//        default:
//             break;
//
//
//
//        }
//
        return cell;
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let unid = undermenu[indexPath.row]["id"];
        
        switch unid {
        case "0":
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "equipmenttestreportnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "1":
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "signinreportnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "2":
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "inspectionreportnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "3":
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "repairsandcostreportnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
        case "4":
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "auditreportnav");
            self.revealViewController()?.pushFrontViewController(vController, animated: true);
            break;
            
        default:
            break;
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 50;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcell") as! menusubcellclass
        
        cell.title.text = undermenu[indexPath.row]["name"];
        return cell;
    }
    
    
    
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        
        let cache = UserDefaults.standard;
         cache.set(false, forKey: logstatus)
        
        
        let fController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInNav")
        self.present(fController, animated: false, completion: nil);
        
    }
    
    
    
    

    
    
    
    //--------Default Function ----

    func loadingDefaultUI()
    {
        
        expandedrow = -1
        gisFromDashboard = false;
        useremail.text = cachem.string(forKey: "useremail");
        usertitle.text = cachem.string(forKey: "username");
        
        let usertpe = cachem.string(forKey: "userType")!;
        let useraccess = cachem.string(forKey: "useraccess")
        var accessFields = [String.SubSequence]();
      
        if useraccess != nil{
            
                accessFields = useraccess!.split(separator: ",")
            
        }
        
        print(accessFields)
        Pmenu = [JSON]();
         let jgMenu = JSON(Gmenu).arrayValue;
  
           for i in 0..<jgMenu.count
           {
            let menuid = jgMenu[i]["id"].stringValue;
            let ifullaces = jgMenu[i]["isfull"].stringValue;
             let isreadonly = jgMenu[i]["isread"].stringValue;
            let isnodele = jgMenu[i]["isnodelete"].stringValue;
            
            if ifullaces == "1" || isreadonly == "1" || isnodele == "1"
            {
                Pmenu.append(jgMenu[i])
            }
            
            if menuid == "8"
            {
                 let ido = jgMenu[i]["id1"].stringValue;
                 let idt =  jgMenu[i]["id2"].stringValue;
                 let idth =   jgMenu[i]["id3"].stringValue;
                 let idf =  jgMenu[i]["id4"].stringValue;
                 let idfi =  jgMenu[i]["id5"].stringValue;
                
                
                if ido == "1" || idt == "1" || idth == "1" || idf == "1" || idfi == "1"
                {
                    Pmenu.append(jgMenu[i])
                }
               // var submenus = [["name": "Equipment Test" , "id": "0", "status" : ""],["name": "Sign In Log" , "id": "1", "status" : ""],["name": "Inspection Reports" , "id": "2", "status" : ""],["name": "Repairs and Costs" , "id": "3", "status" : ""],["name": "Audit Reports" , "id": "4", "status" : ""]]
                
                undermenu = [Dictionary<String, String>]();
                
                
                if ido == "1"
                {
                    undermenu.append(["name": "Equipment Test" , "id": "0"])
                }
                if idt == "1"
                {
                    undermenu.append(["name": "Sign In Log" , "id": "1"])
                    
                }
                 if idth == "1"
                {
                     undermenu.append(["name": "Inspection Reports" , "id": "2"])
                }
                 if idf == "1"
                {
                     undermenu.append(["name": "Repairs and Costs" , "id": "3"])
                }
                if idfi == "1"
                {
                     undermenu.append(["name": "Audit Reports" , "id": "4"])
                }
                
                
                
            }
            
            
            
            
            
           }
        
        
        
        
        menuTable.reloadData();
        
        self.navigationController?.navigationBar.isHidden = true;
        
       CompatibleStatusBar(self.view);
    }
    
    
    
    
    
    

}



class menusubcellclass : UITableViewCell
{
    
    @IBOutlet weak var title: UILabel!
    
    
    
    
    
    
}

 
