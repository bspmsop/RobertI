//
//  EquipmentViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 22/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import DXPopover
import MBProgressHUD
import Reachability

class EquipmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var equId = -1
    var mechId = -1
    var eqipTitle: String!
    var eqipModel: String?
    var eqipSerial: String?
    var mechanicalTitle = "";
    var effId = -1
    var efficiencyTitle = ""
    @IBOutlet var eqpName: UILabel!
    @IBOutlet var eqpModel: UILabel!
    @IBOutlet var eqpSerial: UILabel!
    @IBOutlet var eqpNavTitle: UILabel!
    @IBOutlet weak var scroller: UIScrollView!
    let dropdownTable = UITableView()
    let dropdownview = UIView()
    let dropdownsearchField = UITextField()
    @IBOutlet weak var equipmentTestForm: UIButton!
    var arrRes = [[String:AnyObject]]()
    var data =    [[String:AnyObject]]()
    @IBOutlet weak var selectDocBtn: UIButton!
    @IBOutlet weak var efficiencyHeight: NSLayoutConstraint!
    
    @IBOutlet weak var usersBackView: UIView!
    @IBOutlet weak var efficiencyViewr: UIView!
    @IBOutlet weak var documentImg: UIImageView!
    
    
    
    
    
    

    override func viewDidDisappear(_ animated: Bool) {
        dxdropdown.dismiss();
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        usersBackView.backgroundColor = UIColor.clear;
    }
    
    func getLocalData()
    {
        
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
                            
                             let equipmentIde = indequipdata["id"] as! Int
                          
                            if equipmentIde == GequipmentId
                                {
                                    
                                    
                                    self.arrRes = indequipdata["drawings"] as! [[String:AnyObject]]
                                    
                                    
                                    
                                    if self.arrRes.count > 0
                                    {
                                        
                                        self.selectDocBtn.setTitle("Select document", for: .normal);
                                        self.data =   self.arrRes
                                         self.docLibraryLab.text =  "(\(self.data.count)) Documents In Library";
                                        self.dropdownTable.reloadData()
                                        
                                    }
                                    else
                                    {
                                        self.selectDocBtn.setTitle("No documents", for: .normal);
                                         self.docLibraryLab.text =  "(0) Documents In Library ";
                                        
                                    }
                                    
                                    
                                    
                                    break;
                            }
                            
                            
                           
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                      
                            
                        
                        
                        
                        
                        
                        
                        break;
                    }
                    
                    
                }
                
                
                
                
                
                
                break;
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDefaultUI()
        self.eqpNavTitle.text = mechanicalTitle
        eqpName.text = eqipTitle
        eqpModel.text = eqipModel
        eqpSerial.text = eqipSerial
        
        if equId != -1
         {
            
            
            let netReach = Reachability()!
            
            if netReach.connection == .none
            {
                
                
                
                
                
                if isOfflineMode
                {
                    
                    
                    self.getLocalData()
                    
                    
                    
                    return;
                }
                else
                    
                {
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        self.getLocalData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    return
                    
                    
                    
                    
                }
            }
            
            
            
            
            
            
            let userType = cachem.string(forKey: "userType")!
             let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
             hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
             hud.bezelView.color = UIColor.white;
              
             Alamofire.request("\(equipmentDocAPI)/\(equId)/\(userType)").responseJSON { (responseData) -> Void in
                  
                 if((responseData.result.value) != nil)
                 {
                     isOfflineMode = false
                     print(responseData.result.value);
                     let swiftyJsonVar = JSON(responseData.result.value!)
                     if let resData = swiftyJsonVar["response"].arrayObject
                     {
                        
                        self.arrRes = resData as! [[String:AnyObject]]
                        var mediator1 = Dictionary<String, String>();
                        mediator1["file_name"] = self.efficiencyTitle
                        
                        var mediatordict = Array<Any>();
                        mediatordict =   self.arrRes;
                        mediatordict.append(mediator1)
                        convertIntoDict("file_name", mediatordict, ", . ", handler: { (_, mydict ) in
                            GconvertEquipData = Dictionary<String, String>();
                            GconvertEquipData = mydict;
                            
                            
                            if self.efficiencyTitle == ""
                            {
                                self.equipmentTestForm.setTitle(" ", for: .normal)
                            }
                            else{
                                self.equipmentTestForm.setTitle(Apitranslator(self.efficiencyTitle, GconvertEquipData) , for: .normal);
                            }
                            
                            self.dropdownTable.reloadData();
                            hud.hide(animated: true);
                        })
                        
                        hud.hide(animated: true);
                     }
                    
                    if self.arrRes.count > 0
                    {
                        self.selectDocBtn.setTitle(translator("Select document"), for: .normal);
                        self.data =   self.arrRes
                        self.docLibraryLab.text =  "(\(self.data.count)) Documents In Library ";
                        self.dropdownTable.reloadData()
                        print(self.data);
                        hud.hide(animated: true);
                    }
                    else
                    {
                        self.selectDocBtn.setTitle(translator("No documents"), for: .normal);
                        self.docLibraryLab.text =  "(0) Documents In Library ";
                        hud.hide(animated: true);
                    }
                    
                    
                    
                    
                 }
                else
                 {
                    
                    hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, would you like to use offline data"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        self.getLocalData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                    
                    
                }
                
            }
         }
  }
  @IBOutlet weak var cancelBtn: UIButton!
  @IBOutlet weak var efficiencyBtn: UIButton!
  @IBOutlet weak var vendorBtn: UIButton!
    
    
    
    
  @IBAction func backbtnTapped(_ sender: UIButton)
  {
    self.navigationController?.popViewController(animated: true);
  }
    
    
    @IBAction func performEfficiencyTapped(_ sender: UIButton) {
        print(effId);
        print("effecient data");
        if effId == -1 || effId == 0
        {
            
            
        }
        else
        {
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EfficentyTestViewController") as!  EfficentyTestViewController
        vController.efficiencyId = effId;
            vController.equipmentID = equId;
        self.navigationController?.pushViewController(vController, animated: true);
    }
    }
    
  @IBAction func vendorRepairTapped(_ sender: Any)
  {
    let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddRepairViewController") as! AddRepairViewController
    vController.mechId = mechId;
    vController.equipmenId = equId;
    vController.equipmentName = eqipTitle
     self.navigationController?.pushViewController(vController, animated: true);
  }
  @IBAction func usersTapped(_ sender: UIButton)
  {
    usersBackView.backgroundColor = UIColor.init(red: 124/255, green: 125/255, blue: 126/255, alpha: 1.0);
    let storyboard = UIStoryboard(name: "super", bundle: nil)
    let mcontroller = storyboard.instantiateViewController(withIdentifier: "VendorRepairListViewController") as! VendorRepairListViewController
    mcontroller.headerTile = mechanicalTitle;
    
    let nav = UINavigationController.init(rootViewController: mcontroller)
    GlobalNav2   = nav
    
    self.present(nav, animated: false, completion: nil);
    
  }
    
    let dxdropdown = DXPopover.init();
    
  @IBAction func selectDocumentDropdownTapped(_ sender: UIButton) {
    
     data = arrRes
    
    if data.count > 0
    {
        scroller.isScrollEnabled = false;
        dxdropdown.isHidden = false;
        print(self.view.frame.width);
        print(self.view.frame.width * 0.15 * 0.5)
        dxdropdown.show(at: CGPoint.init(x:  (self.view.frame.width *  0.1 * 0.5) +  23, y: 280), popoverPostion: .down, withContentView: dropdownview, in: self.scroller);
        
        dxdropdown.blackOverlay.backgroundColor = UIColor.clear;
        
        print("I'm tapped")
        
        
        dxdropdown.didDismissHandler =  {
            self.scroller.isScrollEnabled   = true;
            print("dismissed");
        };
        
        
        
         }
    else
    {
        
        
        
        
    }
    
    
    
    }
    
    
    
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
  }
    
  var documentPath : String? = ""
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        var dict = data[indexPath.row]
        let myfileName = dict["file_name"] as! String
        cell.textLabel?.text = Apitranslator(myfileName, GconvertEquipData);
    
        cell.textLabel?.textColor = UIColor.darkGray;
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if data.count > 0
        {
            numOfSections = 1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height:tableView.bounds.size.height - 40))
            noDataLabel.text          = translator("No data available")
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vContrroller = self.storyboard?.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController;
        
        var dict = data[indexPath.row]
        
        
        vContrroller.filePathURL = dict["file_path"] as? String
        
        dxdropdown.dismiss();
        self.navigationController?.pushViewController(vContrroller, animated: false);
    }
    
    
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    
    
    
    @objc func  searchtextfieldTapped(_ sender : UITextField)
    {
        
        if sender.text != ""
        {
            data = [];
            
            for i in 0..<arrRes.count
            {
                
                let dict = arrRes[i]
                var estr = dict["file_name"] as? String;
                estr = estr?.lowercased();
                if (estr?.contains(sender.text!.lowercased()))!
                {
                    data.append(arrRes[i]);
                }
            }
        }
        else
        {
            data = arrRes
        }
        dropdownTable.reloadData();
    }
    
    
    
    
    
    
    
    @IBOutlet weak var equipmetnLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var docLibraryLab: UILabel!
    
    
    
    
    
    //*************** Default Function *******************
    
    func loadingDefaultLang()
    {
        
        
        equipmetnLabel.text = translator("Equipment") + " :";
        modelLabel.text = translator("Model") + " :";
        serialLabel.text = translator("Serial") + " # :";
        docLibraryLab.text = translator("Document Library");
       // equiptestFormLabel.text = translator("Equipment Test Forms")
        vendorBtn.setTitle(translator("Vendor Repair"), for: .normal);
        efficiencyBtn.setTitle(translator("Perform Efficiency Test"), for: .normal);
        cancelBtn.setTitle(translator("Cancel"), for: .normal);
        selectDocBtn.setTitle(translator("Select document"), for: .normal);
        
    }
    
    
    
    
    
    
    
    
    func loadingDefaultUI()
    {
        
        loadingDefaultLang();
        
        if effId == -1 || effId == 0
        {
            
            efficiencyHeight.constant = 0;
            efficiencyBtn.isHidden = true;
            
            

            
        }
        else
        {
            efficiencyHeight.constant = 70;
            efficiencyBtn.isHidden = false;
            
            
        }
        
        
        dropdownTable.separatorStyle = .none;
        
        efficiencyViewr.layer.cornerRadius = 5.0;
        cancelBtn.layer.cornerRadius = 5.0;
        vendorBtn.layer.cornerRadius = 5.0;
        
        CompatibleStatusBar(self.view);
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        //self.scroller.addSubview(dropdownview);
      //  dropdownview.frame = CGRect.init(x: self.view.frame.width * 0.1 , y: 375, width: self.view.frame.width * 0.8 , height: 170);
         dropdownview.frame = CGRect.init(x: 0 , y: 0, width: self.view.frame.width * 0.9 , height: 170);
        
        
        
        //dropdownview.frame = CGRect.init(x: self.view.frame.width * 0.1 , y: 0, width: self.view.frame.width * 0.8 , height: 220);
        
        dropdownview.addSubview(dropdownTable);
        //dropdownview.addSubview(dropdownview);
        dropdownview.addSubview(dropdownsearchField);
        let searchImg = UIImageView()
        let border = UILabel();
        searchImg.image = UIImage.init(named: "search")
        dropdownsearchField.placeholder = translator("Search")
        dropdownview.addSubview(searchImg);
        dropdownview.addSubview(border);
        searchImg.frame = CGRect.init(x: 5, y: 0, width: 20, height: 40)
        searchImg.contentMode = .scaleAspectFit;
        dropdownsearchField.frame = CGRect.init(x: 30, y: 0, width: dropdownview.frame.width - 35, height: 40)
        dropdownsearchField.keyboardAppearance = .dark;
        dropdownsearchField.keyboardType = .default;
        dropdownsearchField.autocapitalizationType = .none;
        dropdownsearchField.clearButtonMode = .always;
        dropdownsearchField.addTarget(self, action: #selector(searchtextfieldTapped(_:)), for: .editingChanged);
        border.frame = CGRect.init(x: 0, y: 40, width: dropdownview.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray;
        dropdownview.layer.cornerRadius = 5.0;
        dropdownview.clipsToBounds = true;
        dropdownview.layer.borderColor =  UIColor.lightGray.cgColor;
        dropdownview.layer.borderWidth = 1.0
        dropdownview.backgroundColor = UIColor.white;
        dropdownTable.frame = CGRect.init(x: 5, y: 42, width: dropdownview.frame.width - 10, height: 125)
        dropdownTable.delegate = self
        dropdownTable.dataSource = self
        dropdownTable.reloadData();
    }
    @IBAction func getEqpDocs(_ sender: Any)
    {
        let mId = "\(equipmentDocAPI)/\(mechId)" as String
        let storyboard = UIStoryboard(name: "super", bundle: nil)
        let mcontroller = storyboard.instantiateViewController(withIdentifier: "NewDocumentLibraryViewController") as! NewDocumentLibraryViewController
         mcontroller.mdid = mId
        let nav = UINavigationController.init(rootViewController: mcontroller)
        GlobalNav2 = nav
        
        self.present(nav, animated: false, completion: nil);
        
        
        
        
        
        
       
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
