//
//  BuildingDocumentViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 25/03/19.
//  Copyright © 2019 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability

class BuildingDocumentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }
    

    @IBOutlet weak var headertitle: UILabel!
    var buildingDocData = [JSON]();
     var buildingDocDataDemo = [JSON]();
    var BuildingAddress = "";
    @IBOutlet weak var docTable: UITableView!
      var hud = MBProgressHUD();
    
    
    @IBAction func SearchingDocs(_ sender: UITextField) {
        
        
        if sender.text != ""
        {
           buildingDocDataDemo = [JSON]();
            
            for i in 0..<buildingDocData.count
            {
                
                let dict = buildingDocData[i]
                var estr = dict["file_name"].stringValue;
                estr = estr.lowercased();
                if (estr.contains(sender.text!.lowercased()))
                {
                    buildingDocDataDemo.append(buildingDocData[i]);
                }
            }
        }
        else
        {
            buildingDocDataDemo = buildingDocData
        }
        docTable.reloadData();
        
    }
    
    @objc func deleteClicked(_ sender : UIBotton)
    {
        
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
            let isdelete =  Gmenu[1]["isnodelete"]!
            if isread == "1" ||  isdelete == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.notes)", preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil));
        alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_) in
            let did = self.buildingDocDataDemo[sender.tag]["draw_id"].stringValue;
            self.deletelibrary(did);
            
            
        }))
        self.present(alert, animated: true, completion: nil);
        
       
        
    }
    
    func deletelibrary(_ docid : String)
    {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vDocdelteApi)\(docid)"
        print(Buildingapi);
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            //getOfflineBuildingData()
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata = Buildingapi
                    let jdata =  deleteapidata
                    
                    let savestatsu =   saetolocaldatabase(jdata, "deletebuilding");
                    if savestatsu
                    {
                        let alert = UIAlertController.init(title: "Success", message: "Successfully saved to local database", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                            
                        }));
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else{
                        
                        let alert = UIAlertController.init(title: "Failed", message: "Failed to save to local database", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                }))
                self.present(alerts, animated: true, completion: nil);
            }
            
            return;
        }
        
        
        
        
        
        
        
        
        
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                
                var resultdata =  JSON(resp.result.value!);
               
                    
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title: "Success!", message: "Successfully deleted document", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                            self.loadingDefaultUI();
                            
                        }))
                         self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
               
             
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("ok"), style: .default, handler: { (_) in
                        
                        
                        
                    }))
                    
                     
                    self.present(alert, animated: true, completion: nil);
                }
                
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    @objc func fileClicked(_ sender : UIButton)
    {
        var dict = buildingDocDataDemo[sender.tag]
        
        let filePather = dict["file_path"].stringValue;
        
        
        
        let vContrroller =  UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        
        vContrroller.filePathURL = filePather
        
        self.navigationController?.pushViewController(vContrroller, animated: false);
        
        
        
    }
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingDocDataDemo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildDocCell") as! BuildingDocCellClass
        
            
        var dict = buildingDocDataDemo[indexPath.row]
        cell.documetTitle?.text = dict["file_name"].stringValue;
        let dname = dict["file_short_name"].stringValue;
        cell.deleteBtn.notes = dict["file_name"].stringValue;
       // filePath = dict["file_path"] as? String;
        cell.documentName.tag = indexPath.row;
        cell.deleteBtn.tag = indexPath.row;
       cell.documentName.addTarget(self, action: #selector(fileClicked(_:)), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deleteClicked(_:)), for: .touchUpInside);
        cell.documentName.setTitle(dname, for: .normal)
        cell.documentData?.text = dict["draw_date"].stringValue;
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if buildingDocDataDemo.count > 0
        {
            numOfSections = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:tableView.bounds.size.height))
            noDataLabel.text          =  translator("No data available")
            noDataLabel.textColor     = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections
    }
    
    
    func callBdocumentData()
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
                alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
            }
            
            return;
        }
        
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vbuildingDocsApi)\(vselectedbuildingId)"
         print(Buildingapi);
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                let scode = resultdata["status"].stringValue;
                
                if  scode == "200"
                {
                      self.buildingDocData = resultdata["response"].arrayValue
                      self.buildingDocDataDemo = resultdata["response"].arrayValue
                    
                    
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                        self.docTable.reloadData();
                        self.docTable.isHidden = false;
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
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try Again"), style: .default, handler: { (_) in
                       // isOfflineMode = true;
                        self.callBdocumentData();
                        //self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
                
               
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    func loadingDefaultUI()
    {
        headertitle.text =  BuildingAddress;
         self.docTable.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
       callBdocumentData()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
        
        
        
        
    }
    
    
    
    

}





class BuildingDocCellClass : UITableViewCell
{
    //buildDocCell
    
    @IBOutlet weak var documetTitle: UILabel!
    @IBOutlet weak var deleteBtn: UIBotton!
    @IBOutlet weak var documentName: UIButton!
    @IBOutlet weak var documentData: UILabel!
    
    
}
