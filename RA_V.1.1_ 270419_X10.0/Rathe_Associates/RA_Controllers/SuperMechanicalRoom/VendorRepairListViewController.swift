//
//  VendorRepairListViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 17/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import  Alamofire
import SwiftyJSON
import FMDB
import MBProgressHUD
import Reachability

class VendorRepairListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
        
    }
    
    
    @IBOutlet weak var heightOfCancelSaveView: NSLayoutConstraint!
    @IBOutlet weak var vendorTable: UITableView!
    var selectdSection  = -1;
    var isofflineMode = false;
    @IBOutlet weak var saveBtn: UIBotton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var hederRoomTitle: UILabel!
    var headerTile = "";
    var isfromvone = false;
    
    var EditingDropDown : UITextField? = nil
    @IBOutlet weak var searchField: UITextField!
    
    
    
    
    let menuPicker = UIPickerView()
    
    var vendorData = Array<Dictionary<String, Any>>();
    var demodata = Array<Dictionary<String, Any>>();
    var mediatorData = Array<Dictionary<String, Any>>();
    
    
    
    
    @IBAction func jobstatusEditingBegin(_ sender: UITextField) {
        EditingDropDown = sender;
    }
    

    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: false) {
            GlobalNav2   = nil
            
            
        }
        
    }
    
    
    
    @IBAction func documentTapped(_ sender: Any) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "NewDocumentLibraryViewController") as! NewDocumentLibraryViewController
        vController.isfromvone = isfromvone;
        self.navigationController?.pushViewController(vController, animated: false);
        
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
        saveBtn.jobstatus =   pickerData[row]
        
        demodata[selectdSection]["status"] = pickerData[row]
      if EditingDropDown != nil
      {
        EditingDropDown!.text =  pickerData[row]
        }
        
        }
        
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
        print("slection tookdata")
        
        saveBtn.notes =   textView.text!
        
        demodata[selectdSection]["notes"] = textView.text;
        
        
        
        
    }
    
    
    
    
    @IBAction func vendorSearch(_ sender: UITextField) {
        searchVendr(sender.text!)
        
       
    }
    
    
    func searchVendr(_ title : String)
    {
        
        
        if mediatorData.count != 0
        {
            
            demodata = mediatorData
            mediatorData = Array<Dictionary<String, Any>>();
            
        }
        
        
        
        selectdSection = -1
        heightOfCancelSaveView.constant =  0.0
        
        
        
        
        
        if title != ""
        {
            demodata = [];
            
            for i in 0..<vendorData.count
            {
                print("printing vendordtat")
                print(vendorData);
                
                let dict = vendorData[i]
                var estr = dict["erepaired"] as? String;
                var sestr = dict["status"] as? String;
                print(estr);
                estr = estr?.lowercased();
                sestr = sestr?.lowercased();
                if (estr?.contains(title.lowercased()))! || (sestr?.contains(title.lowercased()))!
                {
                    demodata.append(vendorData[i]);
                }
            }
        }
        else
        {
            demodata = vendorData
        }
        vendorTable.reloadData();
    }
    
    
        
        
    
    
        
        
        
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var numOfSections: Int = 0
        if demodata.count > 0
        {
            numOfSections            =   demodata.count;
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = translator("No data available");
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == selectdSection
        {
            return 2;
        }
        
        return 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(demodata[indexPath.section]);
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "jobstatuscell") as! SuperVendorRepairStatusCell
            cell.jobstatusField.inputView = menuPicker;
            cell.jobstatusField.placeholder = translator("Job Status");
            cell.jobstatusField.text = demodata[indexPath.section]["status"] as? String;
           let notes = demodata[indexPath.section]["notes"] as! String;
            cell.repairNotesField.text =   notes ;
            cell.adjustLabe.text =   "\n \n" +  notes;
            cell.repairNotesField.delegate = self;
            cell.historyLabel.text = translator("Repair History").uppercased();
            
            if isfromvone
            {
                
               cell.jobstatusField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
               cell.repairNotesField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                cell.adjustLabe.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
                 cell.historyLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
                
            }
            return cell;
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "repairHistorycell") as! SuperVendorRepairHistoryCell
            let notes = demodata[indexPath.section]["notes"] as! String;
            cell.dateNtime.text = demodata[indexPath.section]["daterep"] as? String;
            cell.repairNotes.text = Apitranslator(notes, GconvertVendorList);
            if isfromvone
            { 
                cell.dateNtime.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
               cell.repairNotes.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
               
            }
            
            return cell;
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "repairHistorycell") as! SuperVendorRepairHistoryCell
            return cell;
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 76;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 76;
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension;
    }
    
    func tableView(_ tableView : UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            
            return UITableViewAutomaticDimension;
        
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headwerView = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 1] as! SuperVendorRepairHeaderCell;
        headwerView.selectBtn.addTarget(self, action: #selector(headerTapped(_:)), for: .touchUpInside);
        headwerView.selectBtn.tag = section;
        headwerView.dateNTime.text = demodata[section]["daterep"] as? String;
        let headerTitle = demodata[section]["erepaired"] as! String;
        headwerView.headerTitle.text = Apitranslator(headerTitle, GconvertVendorList);
         let stats = demodata[section]["status"] as? String;
         headwerView.repairStatus.text = stats
        
        if isfromvone
        {
            
            headwerView.repairStatus.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            headwerView.dateNTime.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
           headwerView.headerTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            
            
            
        }
        
        if selectdSection == section
        {
            headwerView.arrowImg.image =  UIImage.init(named: "uparrow.png")
        }
        else
        {
            headwerView.arrowImg.image =  UIImage.init(named: "downnarrow.png")
            
        }
        
        
        switch stats {
        case "Repair Scheduled":
            
           
            headwerView.vendorPic.image = UIImage.init(named: "vendor_repair");
             headwerView.repairStatus.textColor = UIColor.init(red: 81/255, green: 123/255, blue: 159/255, alpha: 1.0);
             headwerView.dateNTime.textColor = UIColor.init(red: 81/255, green: 123/255, blue: 159/255, alpha: 1.0);
        case "Complete":
           
            headwerView.vendorPic.image = UIImage.init(named: "vendor_repair_1");
            headwerView.repairStatus.textColor = UIColor.black;
            headwerView.dateNTime.textColor = UIColor.black;
        case "Inspection Required":
            
            headwerView.vendorPic.image = UIImage.init(named: "redv.png");
            headwerView.repairStatus.textColor = UIColor.init(red: 231/255, green: 27/255, blue: 29/255, alpha: 1.0);
             headwerView.dateNTime.textColor = UIColor.init(red: 231/255, green: 27/255, blue: 29/255, alpha: 1.0);
            
        case "In progress":
            
            
            headwerView.vendorPic.image = UIImage.init(named: "greenv.png");
            headwerView.repairStatus.textColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0);
            headwerView.dateNTime.textColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0);
            
        case "Waiting on parts":
            
            
            headwerView.vendorPic.image = UIImage.init(named: "yellow.png");
            headwerView.repairStatus.textColor = UIColor.init(red: 216/255, green: 198/255, blue: 44/255, alpha: 1.0);
            headwerView.dateNTime.textColor = UIColor.init(red: 216/255, green: 198/255, blue: 44/255, alpha: 1.0);
            
         
            
        case "On Hold/Cancelled":
            
            
            headwerView.vendorPic.image = UIImage.init(named: "gray.png");
            headwerView.repairStatus.textColor = UIColor.init(red: 123/255, green: 129/255, blue: 129/255, alpha: 1.0);
            headwerView.dateNTime.textColor = UIColor.init(red: 123/255, green: 129/255, blue: 129/255, alpha: 1.0);
            
            
            
        default:
            print("I'm default")
        }
        return headwerView;
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return CGFloat.leastNormalMagnitude;
    }
    
    
    @IBAction func cancelTapped(_ sender: UIButton) {
       
        self.view.endEditing(true);
        
        if mediatorData.count != 0
        {
            
            demodata = mediatorData
            mediatorData = Array<Dictionary<String, Any>>();
            
        }
        
        
        selectdSection = -1
        heightOfCancelSaveView.constant =  0.0
        saveBtn.setTitleColor(UIColor.clear, for: .normal);
        cancelBtn.setTitleColor(UIColor.clear, for: .normal);
        
        UIView.animate(withDuration: 0.6, animations: {
            
             self.view.layoutIfNeeded()
            
        }) { (isanimated) in
            
            self.vendorTable.reloadData();
            
        }
        
        
    }
    
    
    
    
 @objc   func headerTapped(_ sender : UIBotton)
    {
        self.view.endEditing(true);
        
        searchField.resignFirstResponder();
        if mediatorData.count != 0
        {
            
            demodata = mediatorData
            mediatorData = Array<Dictionary<String, Any>>();
            
        }
       
        
        if sender.tag == selectdSection
        {
            
            saveBtn.setTitleColor(UIColor.clear, for: .normal);
            cancelBtn.setTitleColor(UIColor.clear, for: .normal);
            heightOfCancelSaveView.constant =  0.0
            
            selectdSection = -1
            
            UIView.animate(withDuration: 0.6, animations: {
                
                self.view.layoutIfNeeded()
                
            }) { (isanimated) in
                
                self.vendorTable.reloadData();
                
            }
            
        
        }
        else
        {
            
            
            mediatorData = demodata;
            
            
                selectdSection = sender.tag;
            print(selectdSection);
                heightOfCancelSaveView.constant =  60.0
            saveBtn.setTitleColor(UIColor.white, for: .normal);
            cancelBtn.setTitleColor(UIColor.white, for: .normal);
            saveBtn.jobstatus =   demodata[selectdSection]["status"] as! String
            
            saveBtn.notes =    demodata[selectdSection]["notes"] as! String
            
            let islive = demodata[selectdSection]["isFromlive"] as! Bool
            
            
            if islive
            {
            saveBtn.vendorId =  demodata[selectdSection]["id"] as! Int32;
                saveBtn.uniqueId = "";
            }
            else
            {
                
                 saveBtn.uniqueId =  demodata[selectdSection]["id"] as! String;
                saveBtn.vendorId = -1;
            }
            
                
                
            UIView.animate(withDuration: 0.6, animations: {
                
                self.view.layoutIfNeeded()
                
            }) { (isanimated) in
                
                self.vendorTable.reloadData();
                
            }
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func saveBtnTapped(_ sender: UIBotton) {
        
        self.view.endEditing(true);
        
        if sender.notes != "" &&  sender.jobstatus != ""
        {
            let userType = cachem.string(forKey: "userType")!
            let datewForm = DateFormatter()
            datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let tdate = datewForm.string(from: Date());
            let parameters: Parameters=[
                "vendor_id": sender.vendorId,
                "jobstatus": sender.jobstatus,
                "notes": sender.notes,
                "user_type" : userType
            ]
           
            
            hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            
            
            
            
            if sender.vendorId == -1
            {
                
              
                
                print(sender.uniqueId);
                updateTheLocalDB(sender.jobstatus, sender.notes,  tdate, sender.uniqueId);
                return;
                
            }
            else
            {
                let networkConnecter = Reachability()!;
                
                
                
                
                if networkConnecter.connection == .none
                {
                    
                    
                    
                    let alrt = UIAlertController.init(title: translator("Alert"), message: translator("No network connection would you like to save changes in local databse"), preferredStyle: .alert);
                    alrt.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_ ) in
                        
                        
                        let datewForm = DateFormatter()
                        datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let tdate = datewForm.string(from: Date());
                        
                        self.updateOfflineData(sender.vendorId, sender.jobstatus, sender.notes, tdate);
                        
                        
                    }))
                    alrt.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: nil));
                    self.present(alrt, animated: true, completion: nil);
                    
                    
                   
                    
                    
                    
                    
                    
                    return
                }
                
                
                
            }
            
            
            
            print(parameters)
             print(upadateVendorAPI)
            Alamofire.request(upadateVendorAPI, method: .post, parameters: parameters).responseJSON { (resp) in
                
                self.hud.hide(animated: true);
                if resp.result.value != nil
                {
                     isOfflineMode = false
                    print(resp.result.value)
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                         //self.updateOfflineData(sender.vendorId, sender.jobstatus, sender.notes, tdate);
                        
                        
                        let message = resultdata["message"] as! String
                        let alert = UIAlertController.init(title: translator("Success"), message: translator("Vendor information updated successfully"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            self.selectdSection = -1
                            self.mediatorData = Array<Dictionary<String, Any>>();
                            
                            self.loadingDefaultUI();
                            
                            
                            
                            
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
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: translator("Please check your network connection and try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }
        else{
            
            let alert = UIAlertController.init(title: translator("Failed"), message: translator("Please enter all the fields"), preferredStyle: .alert);
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
    
    
    
    
    
    func getLocalData()
    {
        
        self.dismiss(animated: true, completion: nil);
        selectdSection = -1
        let localData = cachem.string(forKey: "offlinedata");
        let localJSON = JSON.init(parseJSON: localData!)
        
        print("printing offlinedata");
        print(localJSON);
        
        
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
                        
                        
                        let sampleData = mechroomData["vendors"]  as! Array<Dictionary<String, Any>>;
                        
                         self.saveOnlineDataToLocalDB(sampleData)
                        
                        
                        break;
                    }
                    
                    
                }
                
                
                
                
                
                
                break;
            }
        }
        
        
        
        
        
    }
    
    
    
    
    var hud = MBProgressHUD();
    var editVData = Array<Dictionary<String, Any>>();
    var rowId = 0;
    
    
    //-------Default Func -*----------
    
    @IBOutlet weak var headerLabel: UILabel!
    
    func loadingDefaultLang()
    {
        
        headerLabel.text = translator("Vendor Repairs");
        searchField.placeholder = translator("Search equipment or repair status");
        cancelBtn.setTitle(translator("Cancel").uppercased(), for: .normal);
        saveBtn.setTitle(translator("Save").uppercased(), for: .normal);
        
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
    
    func loadingDefaultUI()
    {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        loadingDefaultLang()
        vendorTable.isHidden = true;
        heightOfCancelSaveView.constant =  0.0
        self.navigationController?.navigationBar.isHidden = true;
        saveBtn.setTitleColor(UIColor.clear, for: .normal);
        cancelBtn.setTitleColor(UIColor.clear, for: .normal);
        CompatibleStatusBar(self.view);
        menuPicker.delegate = self
        menuPicker.dataSource = self
        menuPicker.reloadAllComponents();
        menuPicker.backgroundColor = UIColor.black;
        hederRoomTitle.text = GroomTitle;
        
        
        if isfromvone
        {
            
            hederRoomTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            headerLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0);
            searchField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            cancelBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            saveBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
        }
        
        
        
        let netReacher = Reachability()!;
        
        if netReacher.connection == .none
        {
            
            if isfromvone
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network connection, please try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
                
               
                self.present(alert, animated: true, completion: nil);
                return
                
            }
            
            
            
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
        
        
        
        
        
        
          hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        
        if isfromvone
        {
        
            defaultURLCalling()
            
            return;
        }
        
        
        
        
        
        
        
        let filePath = getPath(fileName: locale_DB);
        
        let RAdb = FMDatabase.init(path: filePath);
        guard RAdb.open() else {
            print("Unable to open database")
            return
        }
        do {
            
            let defaultValues = UserDefaults.standard
            let userid = defaultValues.string(forKey: "userid")
            
            
            
            
            
            
            
            
            //vendorList1 changedData-----------------------------------------------------------------------------------------------------------
            
            let qs = try RAdb.executeQuery("select * from vendorList1 where userid = ? and isChanged = ?", values: [userid!, "true"])
            
            while qs.next() {
                if let x = qs.string(forColumn: "vendorname"), let y = qs.string(forColumn: "jobstatus"), let z = qs.string(forColumn: "notes"), let j = qs.string(forColumn: "datesaved") {
                    let v = qs.int(forColumn: "equipmentid");
                    let l = qs.int(forColumn: "uniqueUserid");
                    
                    print("x = \(x); y = \(y); z = \(z) : j = \(j), L = \(l)")
                    print("Im updated......");
                    var mydict = Dictionary<String, Any>();
                    mydict["status"] = y;
                    mydict["notes"] = z;
                    
                    mydict["uid"] = l;
                    mydict["equiId"] = v;
                    print(mydict);
                    editVData.append(mydict);
                }
            }
            
            
            
            qs.close();
             
            print(localVendorData);
        } catch {
            print("failed: \(error.localizedDescription)")
            return;
        }
        
        
        RAdb.close();
        
        
        
        
        
        if editVData.count > 0
        {
            
            print("calling editdata");
            updateEditindOnlineVendorDatatoServerLoop2(self);
            
            
            
            
            
            
        }
        else
        {
            print("default url clallingg");
            defaultURLCalling()
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
       
        
        
        
        
    }
    
    
    
    
    
    func defaultURLCalling()
    {
        
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        
        let userType = cachem.string(forKey: "userType")!
        print("\(vaendorListingAPI)/\(mechanicalRoomID)/\(userid!)/\(userType)")
        
        Alamofire.request("\(vaendorListingAPI)/\(mechanicalRoomID)/\(userid!)/\(userType)").responseJSON { (responseData) in
            
            print(responseData);
            self.vendorTable.isHidden = false;
            
            if((responseData.result.value) != nil)
            {
                
                isOfflineMode = false
                let myresponse = responseData.result.value! as! NSDictionary
                
                
                
                let sampleData = myresponse["response"]  as! Array<Dictionary<String, Any>>;
                
                //demodata[indexPath.section]["notes"]
                GDoubleconvertIntoDict(["erepaired", "notes"], sampleData,  ", . ", 0, handler: { (_ , mydict) in
                    
                
                    GconvertVendorList = Dictionary<String, String>();
                    GconvertVendorList = mydict;
                    
                    self.saveOnlineDataToLocalDB(sampleData)
                })
                
                
                
                
                
            }
            else
            {
                
                self.hud.hide(animated: true);
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please check your network connection and try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    func updateEditindOnlineVendorDatatoServerLoop2(_ selfi : UIViewController)
    {
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        let userType = defaultValues.string(forKey: "userType")
        
        
        if editVData.count > 0 && rowId < editVData.count
        {
            
            
            
            let parameters: Parameters=[
                
                "vendor_id": editVData[rowId]["uid"] as! Int32,
                "jobstatus": editVData[rowId]["status"] as! String,
                "notes": editVData[rowId]["notes"] as! String,
                "user_type" : userType!
                
            ]
            
            
            
            
            Alamofire.request(upadateVendorAPI , method: .post, parameters: parameters).responseJSON { (resp) in
                
                
                if resp.result.value != nil
                {
                    isOfflineMode = false
                    
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        
                        
                        let filePath = getPath(fileName: locale_DB);
                        let RAdb = FMDatabase.init(path: filePath);
                        guard RAdb.open() else {
                            print("Unable to open database")
                            return
                        }
                        
                        do {
                            
                            try RAdb.executeUpdate("Delete from vendorList1 where userid = ? and isChanged = ? and uniqueUserid = ?", values: [userid!, "true", self.editVData[self.rowId]["uid"] as! Int32])
                            
                            
                            
                        } catch {
                            print("failed: \(error.localizedDescription)")
                            
                        }
                        RAdb.close();
                        
                        
                        self.rowId = self.rowId + 1;
                        self.updateEditindOnlineVendorDatatoServerLoop2(selfi);
                        
                        
                    }
                    else{
                        
                           self.editVData = Array<Dictionary<String, Any>>();
                        self.rowId = 0
                            self.hud.hide(animated: true);
                            let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            selfi.present(alert, animated: true, completion: nil);
                        
                        
                    }
                    
                    
                    
                    
                }
                else
                {
                    self.editVData = Array<Dictionary<String, Any>>();
                    self.rowId = 0
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        selfi.present(alert, animated: true, completion: nil);
                    
                }
                
                
            }
        }
        else
        {
            
            editVData = Array<Dictionary<String, Any>>();
            rowId = 0;
            
             defaultURLCalling()
            
            
            
            
        }
        
        
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    

     var myvendorData = Array<Dictionary<String, Any>>();
    
    
    
    func saveOnlineDataToLocalDB(_ sender : Array<Dictionary<String, Any>>)
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
            
            
            
                try RAdb.executeUpdate("Delete from vendorList1 where userid = ?", values: [userid!])
                
            
            
            
            
            
            for i in 0..<sender.count
            {
               let statusfield =  sender[i]["status"] as! String;
                
                let userType = cachem.string(forKey: "userType")!
                let sdate = sender[i]["daterep"] as! String;
               let rnotes = sender[i]["notes"] as! String;
               let erepair =  sender[i]["erepaired"] as! String;
               let repairId = sender[i]["id"] as! Int;
                
                let islivechanged = sender[i]["isliveChanged"] as? Bool;
                
                let datewForm = DateFormatter()
                datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let tdate = datewForm.string(from: Date());
                let uniqueCode = userid! + tdate;
                
                
                if islivechanged != nil
                {
                    
                    try RAdb.executeUpdate("insert into vendorList1(userid, equipmentid, jobstatus, notes, vendorname, usertype, datesaved, uniqueUserid, isChanged) values (?, ?, ?,?,?,?, ?, ?, ?)", values: [userid!, GequipmentId, statusfield, rnotes, erepair, userType, sdate, repairId, "true" ])
                    
                }
                else
                {
                    
                    try RAdb.executeUpdate("insert into vendorList1(userid, equipmentid, jobstatus, notes, vendorname, usertype, datesaved, uniqueUserid, isChanged) values (?, ?, ?,?,?,?, ?, ?, ?)", values: [userid!, GequipmentId, statusfield, rnotes, erepair, userType, sdate, repairId, "false" ])
                }
                
              
                
              
                
                
            }
            
              myvendorData = Array<Dictionary<String, Any>>();
            
            let rs = try RAdb.executeQuery("select * from vendorList1 where userid = ?", values: [userid!])
            while rs.next() {
                if let x = rs.string(forColumn: "vendorname"), let y = rs.string(forColumn: "jobstatus"), let z = rs.string(forColumn: "notes"), let j = rs.string(forColumn: "datesaved")  {
                    print("x = \(x); y = \(y); z = \(z) : j = \(j)")
                    
                    let ide = rs.int(forColumn: "uniqueUserid");
                    var mediator = Dictionary<String, Any>();
                    mediator["daterep"] = j;
                    mediator["erepaired"] = x;
                    mediator["status"] = y;
                    mediator["notes"] = z;
                    mediator["id"] = ide;
                    mediator["isFromlive"] = true;
                    
                    
                    myvendorData.append(mediator);
                    
                    
                    
                    
                    
                }
            }
            rs.close();
            
            
            
            
            let netReacher = Reachability()!;
            
            if netReacher.connection == .none
            {
                
                
                let rs = try RAdb.executeQuery("select * from vendorList2 where userid = ?", values: [userid!])
                while rs.next() {
                    if let x = rs.string(forColumn: "equipmentName"), let y = rs.string(forColumn: "jobstatus"), let z = rs.string(forColumn: "notes"), let j = rs.string(forColumn: "datesaved"), let jh = rs.string(forColumn: "uniqueUserid") {
                        print("x = \(x); y = \(y); z = \(z) : j = \(j); jh =\(jh)")
                        
                        
                        var mediator = Dictionary<String, Any>();
                        mediator["daterep"] = j;
                        mediator["erepaired"] = x;
                        mediator["status"] = y;
                        mediator["notes"] = z;
                         mediator["id"] = jh;
                         mediator["isFromlive"] = false;
                        
                        myvendorData.append(mediator);
                        
                        
                        
                        
                        
                    }
                }
                rs.close();
                
              
                
                
                
            }
            
            
            
            
            
            
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        RAdb.close()
        
        
        
       
        
        
         self.demodata = self.myvendorData
           self.vendorData = self.myvendorData
        
        
        print(self.demodata);
        
        
        
        if self.searchField.text == ""
        {
            
            self.vendorTable.reloadData();
            print("vendortablereloaded")
        }
        else
        {
            self.searchVendr(self.searchField.text!)
        }
        self.vendorTable.isHidden = false;
        heightOfCancelSaveView.constant =  0.0
        hud.hide(animated: true)
        
        
    }
    
 
    
    
    
    
    


//------------------ Local DB connection---------------
 
    
    
    
    func updateTheLocalDB(_ jstatus : String, _ notes : String , _ savedDate : String, _ uid : String)
    {
        
        
        let filePath = getPath(fileName: locale_DB);
        let RAdb = FMDatabase.init(path: filePath);
        
        
        guard RAdb.open() else {
            print("Unable to open database")
            return
        }
        print("data base is opened");
        
        
        do {
           
            
            
           try RAdb.executeUpdate("update vendorList2 set jobstatus = ?, notes = ?, datesaved = ? where uniqueUserid = ?", values: [jstatus, notes, savedDate, uid])
            
            
            
        } catch {
            print("failed: \(error.localizedDescription)")
            print("unable to update data.....")
            return;
        }
        
        RAdb.close();
        self.selectdSection = -1
         self.mediatorData = Array<Dictionary<String, Any>>();
        getLocalData()
        
        
        
        
    }
    
    
    func updateOfflineData(_ vendorId : Int32, _ jstatus : String, _ notes: String, _ rdate : String)
    {
        
        
        
        
        
        let localData = cachem.string(forKey: "offlinedata");
        var localJSON = JSON.init(parseJSON: localData!)
        
        
        let buildingsData = localJSON["buildings"].arrayObject
        
        var anyData = buildingsData!
        for i in 0..<anyData.count
        {
            var builer = anyData[i] as! Dictionary<String, Any>;
            let builerIDE = builer["id"] as! Int;
            if GbuildIdentifier == builerIDE
            {
                
                var mymechData =  builer["mechanicals"] as! Array<Any>
                
                for j in 0..<mymechData.count
                {
                    
                    var mechroomData = mymechData[j] as! Dictionary<String, Any>;
                    let mechRoomId = mechroomData["id"] as! Int;
                    
                    if mechanicalRoomID == mechRoomId
                    {
                        
                        
                        var sampleData = mechroomData["vendors"]  as! Array<Dictionary<String, Any>>;
                        
                              for m in 0..<sampleData.count
                              {
                                
                                var vdata = sampleData[m]
                                let vid = vdata["id"] as! Int
                                if vid == vendorId
                                {
                                    
                                    vdata["status"] = jstatus;
                                    
                                    vdata["notes"] =  notes;
                                     vdata["isliveChanged"] =  true
                                    print("printitng notes");
                                    print(notes);
                                    
                                    sampleData[m] = vdata;
                                    mechroomData["vendors"] = sampleData
                                     mymechData[j] = mechroomData
                                    builer["mechanicals"] = mymechData;
                                    anyData[i]  = builer
                                    
                                    localJSON["buildings"].arrayObject = anyData;
                                    
                                    
                                   
                                    
                                    
                                     cachem.set(localJSON.description, forKey: "offlinedata")
                                    
                                    self.selectdSection = -1
                                    self.mediatorData = Array<Dictionary<String, Any>>();
                                    
                                    self.getLocalData()
                                   
                                    
                                    
                                    
                                    
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
    
    
  
    
    
    
    
}





class SuperVendorRepairStatusCell : UITableViewCell
{
    @IBOutlet weak var jobstatusField: UITextField!
    @IBOutlet weak var adjustLabe: UILabel!
    
    
    
    
    @IBOutlet weak var repairNotesField: UITextView!
    
    
    @IBOutlet weak var historyLabel: UILabel!
    
    
    
    
}


class SuperVendorRepairHistoryCell : UITableViewCell
{
    
    @IBOutlet weak var dateNtime: UILabel!
    
    @IBOutlet weak var repairNotes: UILabel!
    
    
    
    
    
    
}
