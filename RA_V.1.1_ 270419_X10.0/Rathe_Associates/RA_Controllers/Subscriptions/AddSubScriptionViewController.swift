//
//  AddSubScriptionViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import SwiftyJSON
import Reachability
import Alamofire
import MBProgressHUD


class AddSubScriptionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }

      let menuPicker = UIPickerView()
     var pickerDataList = Array<JSON>();

      var addBuildingHud = MBProgressHUD();
    let dateform = DateFormatter();
    var companieslistt = [JSON]();
    
    
    @IBOutlet weak var companyField: UITextFeild!
    @IBOutlet weak var subscriptionName: UITextFeild!
    @IBOutlet weak var subscriptionPrice: UITextFeild!
    @IBOutlet weak var subscriptionStatus: UITextFeild!
    @IBOutlet weak var termsOFSub: UITextFeild!
    @IBOutlet weak var expirtyDatFIeld: UITextFeild!
    @IBOutlet weak var notesData: UITextView!
    let datepicker = UIDatePicker();
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var subscriptionLevelView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var pView: UIView!
    @IBOutlet weak var tsView: UIView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var selectAllBtn: UIBotton!
    @IBOutlet weak var notificationBtn: UIBotton!
    @IBOutlet weak var buildingManagemetBtn: UIBotton!
    @IBOutlet weak var customInspectnFromBtn: UIBotton!
    @IBOutlet weak var equipmentTestFormsBtn: UIBotton!
    @IBOutlet weak var mechanicalRoomBtn: UIBotton!
    @IBOutlet weak var EquipmentManagementBtn: UIBotton!
    @IBOutlet weak var reportsBtn: UIBotton!
    @IBOutlet weak var userManagementBtn: UIBotton!
    @IBOutlet weak var compnayManagementBtn: UIBotton!
    @IBOutlet weak var syncBtn: UIBotton!
    @IBOutlet weak var expiryView: UIView!
    @IBOutlet weak var syncVw: UIView!
    
    var companyData = [JSON]();
    let substatus = [["companyName":"Public", "id":""],["companyName":"Private", "id":""]]
   let subscriptionData  = [["companyName":"Annual", "id":""],["companyName":"Monthly", "id":""]]
    let btndatas = ["1" : "notification", "2":"building_management", "3":"custom_inspection_sheet", "4":"equipment_test_management", "5":"mechnical_room_management", "6":"equipment_management", "7":"multiple_inspection_sheet", "8":"reports", "9":"company_settings", "10":"user_management", "11":"sync"]
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        pickerView.backgroundColor = UIColor.black;
        let attributed = NSAttributedString.init(string: pickerDataList[row]["companyName"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        
        return attributed;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.backgroundColor = UIColor.black;
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView.backgroundColor = UIColor.black;
        return pickerDataList.count
    }
    
    var selectedcomid = "";
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.backgroundColor = UIColor.black;
        if row < pickerDataList.count
        {
            if lemyvcar == 0
            {
              selectedcomid = pickerDataList[row]["id"].stringValue
                
               let com = pickerDataList[row]["companyName"].stringValue
                companyField.text = com;
                
            }
            else if  lemyvcar == 1
            {
                let com = pickerDataList[row]["companyName"].stringValue
                subscriptionStatus.text = com;
                
            }
            else if  lemyvcar == 2
            {
                let com = pickerDataList[row]["companyName"].stringValue
                termsOFSub.text = com;
                
            }
            
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    @IBAction func tappedCheckBox(_ sender: UIBotton) {
        
        
        sender.isSelected = !sender.isSelected;
      
        
    }
    
    
    
    
    
    
    
    
    @objc func subscriptionAbilitiesTapped(_ sender : UIBotton)
    {
        
        print(sender.isSelected)
        sender.isSelected = !sender.isSelected;
        
        
        print("got click")
        if sender.tag == 42
        {
             print("got u \(sender.IradioBtns.count)")
            for i in 0..<sender.IradioBtns.count
            {
                print("got buttons")
                let btn = sender.IradioBtns[i];
                if sender.isSelected
                {
                    btn.isSelected = true;
                }
                else{
                    print("its false;");
                    btn.isSelected = false;
                }
            }
            
        }
        else
        {
            for i in 0..<selectAllBtn.IradioBtns.count
            {
                print("got buttonstttttttttt")
                let btn = selectAllBtn.IradioBtns[i];
                if !btn.isSelected
                {
                    selectAllBtn.isSelected = false;
                    return
                }
                
            }
            selectAllBtn.isSelected = true;
           
        }
        
        
        
    }
    
    
    
    
    
    
    
    func callinformationData()
    {
        
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
                
                
            }
            
            //getofflineStateCompanyList();
            return;
        }
        
        
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi = "\(vUseraaddCompaniesAPI)\(userid)/\(usertype)"
        
        Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                isOfflineMode = false
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                
                let datainfo = buildinginfo["data"].arrayValue
                if datainfo.count > 0
                {
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        self.companieslistt = datainfo;
                        self.companyData = datainfo;
                        
                         self.addBuildingHud.hide(animated: true);
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.addBuildingHud.hide(animated: true);
                        
                    }
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("No companies are added"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
              
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.addBuildingHud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_) in
                        self.callinformationData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    var lemyvcar = -1
    
    @IBAction func setThedata(_ sender: UITextField) {
        
        if sender == companyField
        {lemyvcar = 0
            pickerDataList = companyData;
            
        }
        else if sender == subscriptionStatus
        {lemyvcar = 1
            pickerDataList = JSON(substatus).arrayValue
            
        }
        else if sender == termsOFSub
        {lemyvcar = 2
            pickerDataList = JSON(subscriptionData).arrayValue
            
        }
        menuPicker.reloadAllComponents();
        
        
        
    }
    
    
    @objc func dateSelected(_ sender : UIDatePicker)
    {
        let sdate = dateform.string(from: sender.date);
        expirtyDatFIeld.text = sdate;
        
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        let checkNetworks = Reachability()!;
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."
        
        
        let comname = companyField.text!;
        let subsname = subscriptionName.text!
        let pricetitle = subscriptionPrice.text!;
        let ptitle = subscriptionStatus.text!;
        let subscrptiontitle = termsOFSub.text!;
        let expdaae = expirtyDatFIeld.text!;
        var estatus = false;
        var emsg = "";
        if comname.isEmpty || selectedcomid.isEmpty
        {
            estatus = true;
            emsg = "Please select company";
            
        }
        else if subsname.isEmpty
        {
            estatus = true;
            emsg = "Please enter subscription level name";
            
        }
        else if pricetitle.isEmpty
        {
            estatus = true;
            emsg = "Please enter price";
        }
        else if ptitle.isEmpty
        {
            estatus = true;
            emsg = "Please select public";
            
        }
        else if subscrptiontitle.isEmpty
        {
            estatus = true;
            emsg = "Please select terms of subscription";
            
        }
        else if expdaae.isEmpty
        {
            estatus = true;
            emsg = "Please select expiry date";
        }
        
        
        
        
        if estatus
        {
            self.addBuildingHud.hide(animated: true);
            let alerts = UIAlertController.init(title: "Alert!", message: emsg, preferredStyle: .alert);
            alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
            self.present(alerts, animated: true, completion: nil);
            return ;
        }
        
        
        
        
        
        
        if checkNetworks.connection == .none
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
                
                
            }
            
            return;
        }
        
       
        
        var parmdata = Dictionary<String,Any>();
        
        parmdata["company"] = selectedcomid;
        parmdata["subscription_level"] = subsname
        parmdata["price"] = pricetitle;
        parmdata["ispublic"] = ptitle;
        parmdata["terms"] = subscrptiontitle;
        parmdata["edate"] = expdaae;
        
        for bttn in selectAllBtn.IradioBtns
        {
            if bttn.isSelected
            {
                let accessdata = String(bttn.tag)
               let isinside =  btndatas[accessdata]
                if isinside != nil
                {
                    parmdata[isinside!] = "yes"
                    
                }
                
            }
            
        }
        
        let notedata = notesData.text
        if notedata != nil
        {
            parmdata["notes"] = notesData.text!;
        }
        
        
        
        
       /* {"company":"1","subscription_level":"test21312","price":"1000","ispublic":"Private","terms":"annual","edate":"04-19-2021","notification":"yes","building_management":"yes","custom_inspection_sheet":"yes","equipment_test_management":"yes","mechnical_room_management":"yes","equipment_management":"yes","multiple_inspection_sheet":"yes","reports":"yes","company_settings":"yes","user_management":"yes","sync":"yes","notes":"sadadsad"}
            */
            let parms = ["sData" :  JSON(parmdata)];
            print(parms);
        print(vSubscriptionSaveAPI)
            Alamofire.request(vSubscriptionSaveAPI, method: .post, parameters: parms).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    print(resp.result.value)
                    let resultdata =  JSON(resp.result.value!);
                    let statuscode = resultdata["status"].stringValue;
                    if statuscode == "200"
                    {
                        isOfflineMode = false;
                        refreshdata = true;
                        
                        DispatchQueue.main.async {
                            self.addBuildingHud.hide(animated: true);
                            
                            let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully added subscription"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                
                                
                                
                                self.navigationController?.popViewController(animated: true);
                                
                                
                            }))
                            self.present(alert, animated: true, completion: nil);
                        }
                        
                        
                        
                        
                    }
                        
                        
                        // }
                    else{
                        DispatchQueue.main.async(execute: {
                            self.addBuildingHud.hide(animated: true);
                            let mes = resultdata["msg"].stringValue
                            
                            let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil);
                        })
                        
                        
                    }
                    
                    
                    
                    
                }
                else
                {
                    DispatchQueue.main.async(execute: {
                        self.addBuildingHud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            
                            
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                }
                
                
                
            }
            
        
        
        
    }
    
    //------Default Func----
    func  loadingDefaultUI()
    {
        
        
        companyField.inputView = menuPicker;
        termsOFSub.inputView  = menuPicker;
        subscriptionStatus.inputView  = menuPicker;
        menuPicker.delegate = self;
        menuPicker.dataSource = self;
        expirtyDatFIeld.inputView = datepicker;
        datepicker.addTarget(self, action: #selector(dateSelected(_:)), for: .valueChanged);
        selectAllBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        datepicker.datePickerMode = .date;
        
        
        dateform.dateFormat = "MM-dd-yyyy"
        
        notificationBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        buildingManagemetBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        customInspectnFromBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        equipmentTestFormsBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        mechanicalRoomBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        EquipmentManagementBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        reportsBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        userManagementBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        compnayManagementBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
         syncBtn.addTarget(self, action: #selector(subscriptionAbilitiesTapped(_:)), for: .touchUpInside)
        selectAllBtn.tag = 42
          selectAllBtn.IradioBtns = [notificationBtn,buildingManagemetBtn,customInspectnFromBtn, equipmentTestFormsBtn, mechanicalRoomBtn,  EquipmentManagementBtn, reportsBtn,  userManagementBtn, compnayManagementBtn,  syncBtn  ]
        
        saveBtn.layer.cornerRadius = 8.0
        saveBtn.clipsToBounds = true;
        cancelBtn.layer.cornerRadius = 8.0
        cancelBtn.clipsToBounds = true;
       CompatibleStatusBar(self.view);
        
        addGrayBorders([companyView, subscriptionLevelView, priceView, tsView, pView, notesView, expiryView])
        
        callinformationData();
        
        
        
        
    }
    
    
    
    
    
    
}
