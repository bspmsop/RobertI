//
//  AddRepairViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import  Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
import FMDB


class AddRepairViewController: UIViewController, UIScrollViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        notes.text = "";
       loadingDefaultUI()
        
    }

    
    
    
    
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var _jobSttusField: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var vName: UITextField!
    
    
    var isfromVone = false;
    var mechId = -1
    var equipmenId = -1
    var equipmentName = "";
    
    let menuPicker = UIPickerView()
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        
         self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    let pickerData  = ["Inspection Required", "In progress", "Waiting on parts", "Repair Scheduled", "Complete", "On Hold/Cancelled"];
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 ;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row < pickerData.count
        {
        _jobSttusField.text = pickerData[row];
        }
    }
    
    
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        
         self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if _jobSttusField.text != "" &&  notes.text != "" && vName.text != ""
        {
            
        
        
            
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
             let userType = cachem.string(forKey: "userType")!
        
        let parameters: Parameters=[
            "equipment_id": equipmenId,
            "jobstatus": _jobSttusField.text!,
            "notes": notes.text!,
            "vendor_name": vName.text!,
             "user_id": userid!,
             "user_type" : userType
            
        ]
        
            print(parameters);
        
            
            
           
            if netReach.connection == .none
            {
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("No netork connection wouild you like to save in local"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_ ) in
                    
                    self.saveDatainLocalDB()
                }))
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            
            
            
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
            print(saveVendorAPI);
        Alamofire.request( saveVendorAPI , method: .post, parameters: parameters).responseJSON { (resp) in
            
            hud.hide(animated: true);
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                     isOfflineMode = false
                     self.notes.text = "";
                    self.vName.text  = "";
                    self._jobSttusField.text = "";
                    
                    let alert = UIAlertController.init(title: translator("Success"), message: translator("Successfully added a vendor"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        self.navigationController?.popViewController(animated: true);
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                else{
                    
                    let mes = resultdata["message"] as! String
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
            }
            else
            {
                print(resp);
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out Wouild you like to save in local database"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_ ) in
                    
                    self.saveDatainLocalDB()
                }))
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                
//
//                let alert = UIAlertController.init(title: "Failed", message: "Please check your network connection!!!", preferredStyle: .alert);
//                alert.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: nil))
//                self.present(alert, animated: true, completion: nil);
                
                
            }
            
            
            
            
            
            
            
            
        }
            
            
        
        }
        else{
            
            let alert = UIAlertController.init(title:translator("Failed"), message: translator("Please enter all the fields"), preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil);
            
        }
        
        
        
        
        
    }
    
    
 
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        pickerView.backgroundColor = UIColor.black;
        let title =  pickerData[row];
        
        let astring = NSAttributedString.init(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]);
        return astring;
        
    }
    
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reach = note.object as! Reachability
        
       if reach.connection == .none
       {
//        let alert = UIAlertController.init(title: "Alert!", message: "Please connect your network", preferredStyle: .alert);
//        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
//        self.present(alert, animated: true, completion: nil);
//
        
        
       }
        
    }
    
     //create table vendorList(userid varchar(50), equipmentid Integer, jobstatus varchar(50),notes text, vendorname varchar(50), usertype varchar(50), datesaved varchar(20) );
    
    func saveDatainLocalDB()
    {
        
        
        let filePath = getPath(fileName: locale_DB);
        let RAdb = FMDatabase.init(path: filePath);
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
       
        guard RAdb.open() else {
            print("Unable to open database")
            return
        }
        print("data base is opened");
        
        
        do {
            let userType = cachem.string(forKey: "userType")!
            let datewForm = DateFormatter()
            datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let tdate = datewForm.string(from: Date());
             let uniqueCode = userid! + tdate
            try RAdb.executeUpdate("insert into vendorList2(userid, equipmentid, jobstatus, notes, vendorname, usertype, datesaved, uniqueUserid, equipmentName) values (?, ?, ?,?,?,?, ?, ?, ?)", values: [userid!, equipmenId, _jobSttusField.text!, notes.text!, vName.text!, userType, tdate, uniqueCode, equipmentName ])
            
           
            
            let rs = try RAdb.executeQuery("select * from vendorList2 where userid = ?", values: [userid!])
            while rs.next() {
                if let x = rs.string(forColumn: "vendorname"), let y = rs.string(forColumn: "jobstatus"), let z = rs.string(forColumn: "notes"), let j = rs.string(forColumn: "datesaved"), let jh = rs.string(forColumn: "uniqueUserid") {
                    print("x = \(x); y = \(y); z = \(z) : j = \(j); jh =\(jh)")
                }
            }
            rs.close();
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        RAdb.close()
        
        let alert = UIAlertController.init(title: translator("Success"), message: translator("Successfully added a vendor to local Database"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
        
        
        
    }
    
    
    
    
    
    
    
    
    //----Default Func -----
    
    @IBOutlet weak var repairSummaryLabel: UILabel!
    @IBOutlet weak var repairDetals: UILabel!
    @IBOutlet weak var notesHere: UILabel!
    @IBOutlet weak var headerLab: UILabel!
    
    
    func loadingDefaultLang()
    {
        
        notesHere.text = translator("Enter repair notes here");
        repairDetals.text = translator("Repair Details").uppercased();
        _jobSttusField.placeholder = translator("Job Status");
        vName.placeholder = translator("Vendor Name");
        repairSummaryLabel.text = translator("Vendor repair summary").uppercased();
        saveBtn.setTitle(translator("Save and Close"), for: .normal);
        cancelBtn.setTitle(translator("Cancel"), for: .normal);
        headerLab.text = translator("Vendor Repair");
        
        
        
        
    }
    @IBOutlet weak var greenHt: NSLayoutConstraint!
    @IBOutlet weak var redHt: NSLayoutConstraint!
    
    func loadingDefaultUI()
    {
        
        if isfromVone
        {
            
            headerLab.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0);
            repairSummaryLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             repairDetals.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            vName.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            _jobSttusField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            notesHere.font  = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            notes.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            greenHt.constant = 44.0
            redHt.constant = 44.0
            
        }
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
         loadingDefaultLang()
        cancelBtn.layer.cornerRadius = 5.0;
        cancelBtn.clipsToBounds = true;
        saveBtn.layer.cornerRadius = 5.0;
        saveBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
        menuPicker.backgroundColor = UIColor.black;
        menuPicker.setValue(UIColor.white, forKey: "textColor")
        menuPicker.delegate = self;
        menuPicker.dataSource = self;
        menuPicker.reloadAllComponents();
        _jobSttusField.inputView = menuPicker;
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: netReach)
        do{
            try netReach.startNotifier()
        }catch{
            print("could not start reachability notifier")
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
