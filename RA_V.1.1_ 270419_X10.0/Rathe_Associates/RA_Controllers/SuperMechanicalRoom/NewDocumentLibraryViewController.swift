//
//  NewDocumentLibraryViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 17/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability

var DocumentHeader = "";
class NewDocumentLibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    var mdid : String!
    var filePath : String?
    var isAllMechDoc = false;
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
     var demodata = [[String:AnyObject]]() 
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var userbackVeiw: UIView!
    var isfromvone = false;
    var isdeletedoc = true;
    
     let scrollerIdicators = UIImageView.init()
    override func viewDidAppear(_ animated: Bool) {
        
        print(tblJSON.contentSize.height);
        
        scrollerIdicators.image = UIImage.init(named: "downscroll.png");
        scrollerIdicators.frame = CGRect.init(x: self.view.frame.width - 20, y: 155, width: 20, height: 30);
        scrollerIdicators.contentMode = .scaleAspectFit;
        self.view.addSubview(scrollerIdicators);
        
        
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        userbackVeiw.backgroundColor = UIColor.clear
        
    }
    var lastContentOffset: CGFloat = 0
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
   
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("im top");
        
        let scrollheight = tblJSON.frame.size.height;
        let contentHieht = tblJSON.contentSize.height;
        let scrollOffset = tblJSON.contentOffset.y;
        print(scrollheight)
        print(contentHieht);
         print(scrollOffset);
        var spacinghight : CGFloat = 0
        
        
        
       
 print((scrollOffset/((contentHieht - scrollheight)))*scrollheight)
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            
            if scrollOffset < 75
            {
                
                
                return;
            }
            print("moving up")
             spacinghight = -35
            
            
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            
            
            
            
            spacinghight = 0
             print("moving down")
        } else {
            
        }
        
        
        let scrollerposition = (scrollOffset/((contentHieht - scrollheight) ))*scrollheight + spacinghight
        
        scrollerIdicators.frame = CGRect.init(x: self.view.frame.width - 20, y: 155 + scrollerposition , width: 20, height: 30);
        
        
        if (scrollOffset == 0)
        {
            scrollerIdicators.image = UIImage.init(named: "downscroll.png");
            print("reached top")
            
        }
        else if (scrollOffset + scrollheight == contentHieht)
        {
            scrollerIdicators.image = UIImage.init(named: "upssscroll.png");
            print("reached bottom")
            
        }
        else
        {
            
            
            
        }
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDefaultUI()
        print(mdid);
        
        tblJSON.isHidden = true;
        scrollerIdicators.isHidden = true;
        headTitle.text = DocumentHeader;
        self.navigationController?.navigationBar.isHidden = true;
        CompatibleStatusBar(self.view);
        tblJSON.flashScrollIndicators();
        
        let netReach = Reachability()!
        
        if netReach.connection == .none
        {
            
            
            if isfromvone
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network connection, please try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler:  nil))
                 self.present(alert, animated: true, completion: nil);
                return
                
                
            }
            if isOfflineMode
            {
                
                self.getOfflineData()
                
                
                return;
            }
            else
                
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.getOfflineData()
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                return
                
                
                
                
            }
        }
        
        
        
        
        
        
        
        if DocumetLibaraymechId != ""
        {
            
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        
            
            print(DocumetLibaraymechId);
        Alamofire.request(DocumetLibaraymechId).responseJSON { (responseData) -> Void in
            hud.hide(animated: true);
             self.tblJSON.isHidden = false;
            
            if((responseData.result.value) != nil) {
                 print(responseData.result.value);
                 isOfflineMode = false
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["response"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    
                    
                      self.demodata = self.arrRes
                    self.tblJSON.reloadData()
                    
                    self.tblJSON.isHidden = false;
                    hud.hide(animated: true);
                    
                    if self.tblJSON.contentSize.height <= self.tblJSON.frame.size.height
                    {
                        
                     self.scrollerIdicators.isHidden = true;
                    }
                    else
                    {
                         self.scrollerIdicators.isHidden = false;
                        
                    }
                }
            }
            else
            {
                hud.hide(animated: true);
                if self.isfromvone
                {
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network connection, please try again", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler:  nil))
                    self.present(alert, animated: true, completion: nil);
                    return
                    
                    
                }

                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, would you like to use offline data"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.getOfflineData()
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);



            }
        }
        }
       
        
        
    }
    
    @IBAction func userTapped(_ sender: Any) {
        userbackVeiw.backgroundColor = UIColor.init(red: 124/255, green: 125/255, blue: 126/255, alpha: 1.0)
        let vContrroller = self.storyboard?.instantiateViewController(withIdentifier: "VendorRepairListViewController") as! VendorRepairListViewController
        vContrroller.isfromvone = self.isfromvone;
        self.navigationController?.pushViewController(vContrroller, animated: false);
    }
    
    
    
    
    
    func getOfflineData()
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
                            
                            let equipData = mechroomData["equipments"] as! Array<Any>
                            
                            
                            for k in 0..<equipData.count
                            {
                                let indequipdata = equipData[k] as! Dictionary<String, Any>
                                let documentsData = indequipdata["drawings"] as! [[String : AnyObject]]
                                
                                
                                
                                        self.arrRes = documentsData
                                
                                    if self.arrRes.count > 0 {
                                        
                                        
                                        self.demodata = self.arrRes
                                        self.tblJSON.reloadData()
                                        
                                        self.tblJSON.isHidden = false;
                                        
                                        
                                        if self.tblJSON.contentSize.height <= self.tblJSON.frame.size.height
                                        {
                                            
                                            self.scrollerIdicators.isHidden = true;
                                        }
                                        else
                                        {
                                            self.scrollerIdicators.isHidden = false;
                                            
                                        }
                                    }
                                
                                
                                
                              
                                
                                
                            }
                            
                            
                            
                            break;
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    break;
                }
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
    @objc func deleteDocTapped(_ sender : UIBotton)
    {
        if !isdeletedoc
        {
            let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
            self.present(alert, animated: true, completion: nil);
            
            return;
            
        }
        let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.notes)", preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: nil));
        alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_) in
            
            var dict = self.arrRes[sender.tag]
            let did = String(dict["draw_id"] as! Int);
            
            self.deletelibrary(did);
            
            
        }))
        self.present(alert, animated: true, completion: nil);
        
        
        
    }
    
    func deletelibrary(_ docid : String)
    {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        hud.label.text = "Loading..."
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vDocdelteApi)\(docid)"
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            //getOfflineBuildingData()
            DispatchQueue.main.async {
                 hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =    Buildingapi
                    let jdata =  deleteapidata
                    
                    let savestatsu =   saetolocaldatabase(jdata, "deletedocument");
                    if savestatsu
                    {
                        let alert = UIAlertController.init(title: "Success", message: "Successfully saved to local database", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                            self.navigationController?.popViewController(animated: true);
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
                    
                    hud.hide(animated: true);
                    
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
                    
                     hud.hide(animated: true);
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
        
        var dict = arrRes[sender.tag]
        
       let filePather = dict["file_path"] as! String;
        
        
        
        let vContrroller = self.storyboard?.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController;
        vContrroller.filePathURL = filePather
        
        self.navigationController?.pushViewController(vContrroller, animated: false);
        
        
        
        
        
        
        
        
    }
    
    @IBAction func searchDocumet(_ sender: UITextField) {
     
    
    if sender.text != ""
    {
    arrRes = [];
    
    for i in 0..<demodata.count
    {
    
    let dict = demodata[i]
        var estr = dict["file_name"] as? String;
    estr = estr?.lowercased();
    if (estr?.contains(sender.text!.lowercased()))!
    {
    arrRes.append(demodata[i]);
    }
    }
    }
    else
    {
    arrRes = demodata
    }
    tblJSON.reloadData();
        if self.tblJSON.contentSize.height <= self.tblJSON.frame.size.height
        {
            
            self.scrollerIdicators.isHidden = true;
        }
        else
        {
            self.scrollerIdicators.isHidden = false;
            
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrRes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newdocumetlibrary") as! DocumentCellsTableViewCell
        var dict = arrRes[indexPath.row]
        cell.documentTitle?.text = dict["file_name"] as? String
        cell.delteDocBtn.notes = dict["file_name"] as! String
        let dname = dict["file_short_name"] as? String
        filePath = dict["file_path"] as? String;
        cell.documentName.tag = indexPath.row;
        
        cell.documentName.addTarget(self, action: #selector(fileClicked(_:)), for: .touchUpInside)
        cell.documentName.setTitle(dname, for: .normal)
        cell.delteDocBtn.tag = indexPath.row;
        cell.documentDate?.text = dict["draw_date"] as? String
        
        
        if isfromvone
        {
            cell.documentDate.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            cell.documentName.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             cell.documentTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
              cell.delteDocBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
              cell.btnwt.constant = 25;
            cell.delteDocBtn.addTarget(self, action: #selector(deleteDocTapped(_:)), for: .touchUpInside)
            
        }
        else{
            cell.btnwt.constant = 0;
            
            
            }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if arrRes.count > 0
        {
            numOfSections = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:tableView.bounds.size.height))
            noDataLabel.text          =  translator("No data available")
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: false) {
              GlobalNav2   = nil
            
        }
        
    }
    
    
    
    
    
    @IBAction func documentView(_ sender: Any) {
        if(filePath != nil)
        {
            let vContrroller = self.storyboard?.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController;
        vContrroller.filePathURL = filePath
            //self.navigationController?.pushViewController(vContrroller, animated: false);
        }
        else
        {
            let alert = UIAlertController(title: translator("Alert"), message: translator("No documents"), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: translator("Ok"), style: UIAlertActionStyle.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
            
            return
        }
    }
    
    
    
    
    
    
    
    
    
    //*********Default Func**********
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var searchDocField: UITextField!
    
    
    
    func loadingDefaultUI()
    {
        headerLabel.text = translator("Document Library");
        searchDocField.placeholder = translator("Search documents");
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        print(mdid);
        headTitle.text = DocumentHeader;
        if isfromvone
        {
            headerLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
             headTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
            searchDocField.font  = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        }
        
        tblJSON.isHidden = true;
        scrollerIdicators.isHidden = true;
        
        self.navigationController?.navigationBar.isHidden = true;
        CompatibleStatusBar(self.view);
        tblJSON.flashScrollIndicators();
        
        let netReach = Reachability()!
        
        if netReach.connection == .none
        {
            if isfromvone
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network connection, please try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler:  nil))
                self.present(alert, animated: true, completion: nil);
                return
                
                
            }
            
            if isOfflineMode
            {
                
                self.getOfflineData()
                
                
                return;
            }
            else
                
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.getOfflineData()
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                return
                
                
                
                
            }
        }
        
        
        
        
        
        
        
        if DocumetLibaraymechId != ""
        {
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            
            
            print(DocumetLibaraymechId);
            Alamofire.request(DocumetLibaraymechId).responseJSON { (responseData) -> Void in
                hud.hide(animated: true);
                self.tblJSON.isHidden = false;
                
                if((responseData.result.value) != nil) {
                    print(responseData.result.value);
                    isOfflineMode = false
                    
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    if let resData = swiftyJsonVar["response"].arrayObject {
                        self.arrRes = resData as! [[String:AnyObject]]
                    }
                    if self.arrRes.count > 0 {
                        
                        
                        self.demodata = self.arrRes
                        self.tblJSON.reloadData()
                        
                        self.tblJSON.isHidden = false;
                        hud.hide(animated: true);
                        
                        if self.tblJSON.contentSize.height <= self.tblJSON.frame.size.height
                        {
                            
                            self.scrollerIdicators.isHidden = true;
                        }
                        else
                        {
                            self.scrollerIdicators.isHidden = false;
                            
                        }
                    }
                }
                else
                {
                    hud.hide(animated: true);
                    
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, would you like to use offline data"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        self.getOfflineData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                    
                    
                }
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
