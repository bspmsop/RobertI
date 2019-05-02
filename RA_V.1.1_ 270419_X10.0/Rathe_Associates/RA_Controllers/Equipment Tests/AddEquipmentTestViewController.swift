//
//  AddEquipmentTestViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 29/01/19.
//  Copyright © 2019 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import ScrollingFollowView
import MBProgressHUD
import SwiftyJSON
import Reachability
import FMDB
import MobileCoreServices
import PEPhotoCropEditor



class AddEquipmentTestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }
    
    @IBOutlet weak var addEquipmetTest: UITableView!
    
    let menuDropDown = UIPickerView();
    
     var generalPickerData = [JSON]();
    
   var companyListData = [JSON]();
      var mechanicalListData = [JSON]();
    
    var intervalListData = ["daily", "weekly", "monthly", "quarterly", "yearly","custom"];
     var cinshud = MBProgressHUD();
    var sectionData : Array<Dictionary<String, Any>> = [["head" : "", "order" : "1", "ncolumns" : "1", "fields": [["label":"", "order" : "1", "itype" : "1","typename": "Text box", "ioptions" : "", "required" : "1", "ivalids" : "2", "idefault" : ""]]]];
    
  var primaryData :  Dictionary<String, String> = ["company" : "",  "inspection_name": "", "comid":""  ];
    var sampleData = ["company", "C&C company", "# company"]
    var samplePrimaryfield = UITextFeild();
   var fieldTypes = ["Text Box","Select Box", "Check Box","Radio Button", "Text Area",  "Attachment" ];
     var fieldTypeDataVlaue = ["Text Box" : "1" ,"Select Box" : "2" , "Check Box" : "3" ,"Radio Button" : "4", "Text Area" : "5",  "Attachment" : "9" ];
    var pickerData = Array<String>();
    var orderNumData = [String]();
     let popTabl = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 18] as! popupTableViewClass;
    
    
    
    
    @objc func getTheData(_ sender : UITextFeild)
    {
        if sender.texet.section == 0
        {
            
            
            switch sender.texet.row
            {
            case 0:
                
                
                generalPickerData = companyListData;
                samplePrimaryfield = sender;
                menuDropDown.reloadAllComponents();
                
                break;
                
            case 1:
                primaryData["inspection_name"] = sender.text
                break;
                
            default :
                break;
                
            }
            
            
            
            
            
        }
        else
        {
            
            var fdata = self.sectionData[sender.texet.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
            
            if sender.tag == 1
            {
                
                
                
                
                fdata[sender.texet.row]["label"] = sender.text;
                self.sectionData[sender.texet.section - 1]["fields"] = fdata;
                
                
            }
            else if sender.tag == 2
            {
                
                fdata[sender.texet.row]["idefault"] = sender.text;
                self.sectionData[sender.texet.section - 1]["fields"] = fdata;
                
                
                
                
                
                
                
                
            }
            else if sender.tag == 3
            {
                
                samplePrimaryfield = sender;
                orderNumData = [String]();
                for i in 1..<fdata.count + 1
                {
                    orderNumData.append(String(i));
                }
                generalPickerData = JSON(orderNumData).arrayValue
                menuDropDown.reloadAllComponents();
                
            }
            else if sender.tag == 4
            {
                samplePrimaryfield = sender;
                generalPickerData = JSON(fieldTypes).arrayValue
                menuDropDown.reloadAllComponents();
                
                
            }
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        let mytext = textView as? UITextVw
        
        if mytext != nil
        {
            var fdata = self.sectionData[mytext!.setTitlein.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
            
            fdata[mytext!.setTitlein.row]["ioptions"] = textView.text;
            self.sectionData[mytext!.setTitlein.section - 1]["fields"] = fdata;
            print(textView.text);
            
            
        }
    }
    
    
    @objc func addMechancialRoomPopupSubmitted(_ sender : UIBotton)
    {
        self.view.endEditing(true);
        
        if popTabl.roomNameField.text == ""
        {
            popTabl.wariningLab.text = "Please enter required field";
            
            
        }
        else
        {
            
            
            self.popTabl.miniLoader.isHidden = false;
            self.hidePopView(sender);
            self.intervalListData.append(popTabl.roomNameField.text!)
            samplePrimaryfield.text = popTabl.roomNameField.text!
            primaryData["inspection_interval"] = popTabl.roomNameField.text!
            
            
            
            
        }
        
        
    }
    
    
    @objc func hidePopView(_ sender : UIButton)
    {
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.popTabl.frame = CGRect.init(x: 0, y: self.view.frame.height + 42, width: self.view.frame.width, height: self.view.frame.height)
        }) { (isSuccess) in
            self.popTabl.backgroundColor = .clear;
            
        }
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return generalPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row < generalPickerData.count
        {
            
            
            if samplePrimaryfield.texet.section == 0
            {
                
                switch samplePrimaryfield.texet.row
                {
                    case 0:
                        samplePrimaryfield.text = generalPickerData[row]["cname"].stringValue
                        primaryData["company"] = generalPickerData[row]["cname"].stringValue
                        primaryData["comid"] = generalPickerData[row]["cid"].stringValue
                    
                    default:
                        print("Im default");
                    
                }
                
            }
            else if samplePrimaryfield.texet.section == 100
            {
                samplePrimaryfield.text = generalPickerData[row].stringValue
                let myorder = generalPickerData[row].stringValue
                
                for l in 0..<sectionData.count
                {
                    let rorder = sectionData[l]["order"] as! String
                    
                    if myorder == rorder
                    {
                            sectionData[l]["order"] = sectionData[samplePrimaryfield.hastag]["order"]
                    }
                    
                    
                }
                
                
                sectionData[samplePrimaryfield.hastag]["order"] = generalPickerData[row].stringValue
                
            }
            else
            {
                 samplePrimaryfield.text = generalPickerData[row].stringValue
                var fdata = self.sectionData[samplePrimaryfield.texet.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
                
                if samplePrimaryfield.tag == 3
                {
                    
                    
                    let myorder = generalPickerData[row].stringValue
                    
                    for l in 0..<fdata.count
                    {
                        let rorder = fdata[l]["order"] as! String
                        
                        if myorder == rorder
                        { fdata[l]["order"] = fdata[samplePrimaryfield.texet.row]["order"]
                        }
                        
                        
                    }
                    
                    fdata[samplePrimaryfield.texet.row]["order"] = generalPickerData[row].stringValue
                    self.sectionData[samplePrimaryfield.texet.section - 1]["fields"] = fdata;
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    fdata[samplePrimaryfield.texet.row]["typename"] = generalPickerData[row].stringValue
                    fdata[samplePrimaryfield.texet.row]["itype"] = fieldTypeDataVlaue[generalPickerData[row].stringValue]
                    self.sectionData[samplePrimaryfield.texet.section - 1]["fields"] = fdata;
                    self.addEquipmetTest.reloadRows(at: [samplePrimaryfield.texet], with: .fade)
                    
                    
                }
                
                
            }
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count + 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0
        {
            return 2
        }
        else if section == sectionData.count + 1
        {
            
            return 3;
        }
        else if section > 0  && section < sectionData.count + 1
        {
            let fields = sectionData[section - 1]["fields"] as! Array<Dictionary<String, Any>>
            return fields.count;
        }
            
        else
        {
            return 0
        }
        
        
    }
    
    
    
    
    
    @objc func cancelBtnTapped(_ sender : UIBotton)
    {
        self.navigationController?.popViewController(animated: true);
        
        
    }
    
    @objc func getPrimaryData(_ sender : UITextFeild)
    {
        
        print("get selected")
        
        if sender.tag == 3
        {
            
            primaryData["inspection_name"] = sender.text;
            
        }
        else
        {
            print("sent to primary field");
            samplePrimaryfield = sender;
            menuDropDown.reloadAllComponents();
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        pickerView.backgroundColor = UIColor.black;
        
        if samplePrimaryfield.texet.section == 0
        {
            if samplePrimaryfield.texet.row == 0
            {
                let attributed = NSAttributedString.init(string: generalPickerData[row]["cname"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                
                return attributed;
            }
            else if samplePrimaryfield.texet.row == 1
            {
                let attributed = NSAttributedString.init(string: generalPickerData[row]["title"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                
                return attributed;
                
            }
            else
            {
                let attributed = NSAttributedString.init(string: generalPickerData[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                
                return attributed;
                
            }
            
            
            
        }
        else
        {
            let attributed = NSAttributedString.init(string: generalPickerData[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            
            return attributed;
        }
        
        
        
    }
    
    
    
    
    @objc func deleteSection(_ sender : UIBotton)
    {
        
        DispatchQueue.main.async {
            sender.actei.startAnimating();
            sender.isHidden = true;
            sender.backgroundColor = UIColor.clear
            self.sectionData.remove(at: sender.tag);
            UIView.animate(withDuration: 0.5, animations: {
                
            }) { (_ ) in
                
                
                for l in 0..<self.sectionData.count
                {
                    self.sectionData[l]["order"] = "\(l+1)"
                    
                }
                self.addEquipmetTest.reloadData();
                self.addEquipmetTest.scrollToRow(at: IndexPath.init(row: 0, section: sender.tag + 1), at: .top, animated: false);
                self.view.endEditing(true);
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    @objc func addSectionInTable(_ sender : UIBotton)
    {
        DispatchQueue.main.async {
            sender.actei.startAnimating();
            
            
            let orderstr = String(self.sectionData.count + 1)
            
            
            let sample : Dictionary<String, Any> =  ["head" : "", "order" : orderstr, "ncolumns" : "1", "fields": [["label":"", "order" : "1", "itype" : "1","typename": "Text box", "ioptions" : "", "required" : "1", "ivalids" : "2", "idefault" : ""]]]
            self.sectionData.append(sample);
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
        }) { (_ ) in
            
            DispatchQueue.main.async(execute: {
                self.addEquipmetTest.reloadData();
                self.addEquipmetTest.scrollToRow(at: IndexPath.init(row: 0, section: sender.tag + 2), at: .top, animated: false);
                self.view.endEditing(true);
            })
            
            
        }
        
        
        
        
    }
    @objc func addRowInTable(_ sender : UIBotton)
    {
        var fdata = self.sectionData[sender.setTitlein.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
        
        DispatchQueue.main.async {
            sender.actei.startAnimating();
            
            let rowOrder = String(fdata.count + 1)
            
            let mydata =   ["label" : "", "order" : rowOrder, "itype" : "1","typename": "Text box","ioptions" : "", "required" : "1", "ivalids" : "2", "idefault" : ""]
            fdata.append(mydata);
            self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
            
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
        }) { (_ ) in
            
            
            self.addEquipmetTest.reloadSections(IndexSet.init(integer: sender.setTitlein.section), with: .none);
            self.addEquipmetTest.scrollToRow(at: IndexPath.init(row: fdata.count - 1, section: sender.setTitlein.section), at: .none, animated: false);
            
            
        }
        
        
    }
    
    
    
    
    
    
    
   
    
    
   
    
   
    
    @objc func deleteRowInTable(_ sender : UIBotton)
    {
        
        
        
        
        DispatchQueue.main.async {
            sender.actei.startAnimating();
            sender.isHidden = true;
            
            var fdata = self.sectionData[sender.setTitlein.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
            
            fdata.remove(at: sender.setTitlein.row);
            
            for l in 0..<fdata.count
            {
                
                fdata[l]["order"] = "\(l+1)"
                
            }
            
            
            
            
            self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
            
            
            UIView.animate(withDuration: 0.5, animations: {
                
            }) { (_ ) in
                
                
                
                self.addEquipmetTest.reloadData()
                
                
                
                
            }
            
        }
        
        
        
    }
    
    
    
    @objc func cancelTapped(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true);
        
    }
    
    @objc func previewTapped(_ sender : UIBotton)
    {
        let validdict = checkvalidationData();
        let isvalid = validdict["isvalid"]
        let emsg = validdict["emsg"]
        if isvalid == "0"
        {
            let alert = UIAlertController.init(title: "Alert!", message: emsg, preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
            self.present(alert, animated: true, completion: nil);
            return;
            
        }
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "InitialPreviewController") as! InitialPreviewController;
        vController.loadedData = self.sectionData;
        vController.headertitleText =   primaryData["inspection_name"];
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
        
    }
    
    
    @objc func SaveAndCloseBtnTapped(_ sender : UIBotton)
    {
        
        let validdict = checkvalidationData();
        let isvalid = validdict["isvalid"]
        let emsg = validdict["emsg"]
        if isvalid == "0"
        {
            let alert = UIAlertController.init(title: "Alert!", message: emsg, preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
            self.present(alert, animated: true, completion: nil);
            return;
            
        }
        
        
        
        
        
        let checkNetworks = Reachability()!;
        cinshud = MBProgressHUD.showAdded(to: self.view, animated: true);
        cinshud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        cinshud.bezelView.color = UIColor.white;
        self.cinshud.label.text = "Loading..."
        
        if checkNetworks.connection == .none
        {
            DispatchQueue.main.async {
                self.cinshud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =   self.createJSOndata() ;
                    let jdata =  deleteapidata.description
                    
                    let savestatsu =   saetolocaldatabase(jdata, "addefficiencytest");
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
        
        
        let params = ["eqpdata" :  createJSOndata()] ;
        
        print(params);
        
        print(vEfficiencyTestSaveAPI);
        Alamofire.request(vEfficiencyTestSaveAPI, method: .post, parameters: params).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 1
                {
                    isOfflineMode = false;
                    refreshdata = true;
                    
                    DispatchQueue.main.async {
                        self.cinshud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully updated equipment test form"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            
                           self.navigationController?.popViewController(animated: true);
                            
                            
                        }))
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                }
                    
                    
                    // }
                else{
                    DispatchQueue.main.async(execute: {
                        self.cinshud.hide(animated: true);
                        let mes = resultdata["message"] as! String
                        
                        let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.cinshud.hide(animated: true);
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        
                        
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                })
                
            }
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    func createJSOndata() -> JSON
    {
        var dictjs = Dictionary<String, Any>();
        dictjs["id"]  = "0";
        var tmpdata = Dictionary<String,Any>();
        tmpdata["code"] = primaryData["comid"];
        tmpdata["name"] = primaryData["inspection_name"]!;
        dictjs["template"] = tmpdata;
         dictjs["uid"] =   cachem.string(forKey: "userid")!
         dictjs["section_delete"] = ""
        dictjs["field_delete"] = ""
         dictjs["field_all_sections"] = ""
         dictjs["critical_notification"] = "1"
        //critical_notification
        
        
        var fieldData = Dictionary<String,Any>();
        var fieldsIds = Array<Any>();
        var fielditype = Array<Any>();
        var fieldsectionids = Array<Any>();
        var fieldrequired = Array<Any>();
        var fieldivalidss = Array<Any>();
        var fieldsorts = Array<Any>();
        var fieldsidefaults = Array<Any>();
        var fieldsOptionss = Array<Any>();
        var labelarray = Array<Any>();
        
        
        
        var setioonheader = Dictionary<String,Any>();
        
        var setioontitles = Array<Any>();
        var setioonids = Array<Any>();
        var setionSno = Array<Any>();
        var sectionSort = Array<Any>();
        var sectioninputrows = Array<Any>();
        
        
        
        for l in 0..<sectionData.count
        {
            
            let dicter = sectionData[l]
            let sid = "S\(l+1)";
            setioontitles.append(dicter["head"]!)
            setioonids.append("0")
            setionSno.append(sid)
            sectionSort.append(dicter["order"]!)
            sectioninputrows.append(dicter["ncolumns"]!)
            
            
            
            
            
            
            
            let fieldsdata = dicter["fields"] as! [Dictionary<String, String>]
            
            for v in 0..<fieldsdata.count
            {
                
                let fdatar = fieldsdata[v]
                
                fieldsIds.append("0");
                labelarray.append(fdatar["label"]!);
                fielditype.append(fdatar["itype"]!);
                fieldsectionids.append(sid);
                
                
                let isrequiredfor = fdatar["required"]!
                if isrequiredfor == "1"
                {
                    fieldrequired.append("Y");
                    
                    
                }
                else
                {
                    fieldrequired.append("N");
                    
                    
                    
                }
                
                fieldivalidss.append(fdatar["ivalids"]!);
                fieldsorts.append(fdatar["order"]!);
                fieldsidefaults.append(fdatar["idefault"]!);
                
                fieldsOptionss.append(fdatar["ioptions"]!);
                
                
                
                
                
            }
            
        }
        
        
        setioonheader["title"] = setioontitles
        setioonheader["id"] = setioonids
        setioonheader["sno"] = setionSno
        setioonheader["sort"] = sectionSort
        setioonheader["inputs_per_row"] = sectioninputrows
        
        
        
        fieldData["fid"] = fieldsIds;
        fieldData["label"] = labelarray;
        fieldData["section_id"] = fieldsectionids;
        fieldData["required"] = fieldrequired;
        fieldData["ivalids"] = fieldivalidss;
        fieldData["sort"] = fieldsorts;
        fieldData["idefault"] = fieldsidefaults;
        fieldData["ioptions"] = fieldsOptionss;
        fieldData["itype"] = fielditype;
        
        
        dictjs["field"]  = fieldData
        dictjs["section"]  = setioonheader
        
        
        
        return JSON(dictjs);
        
        
        
        
       
//
//        var labelarray = Array<Dictionary<String,Any>>();
//        var typearray = Array<Dictionary<String,Any>>();
//        var sectionids = Array<Dictionary<String,Any>>();
//        var requiredArrays = Array<Dictionary<String,Any>>();
//        var ivalidsArrays = Array<Dictionary<String,Any>>();
//        var sortArrays = Array<Dictionary<String,Any>>();
//        var defaultarrays = Array<Dictionary<String,Any>>();
//        var ioptionsArrays = Array<Dictionary<String,Any>>();
//        var setioonheader = Array<Dictionary<String,Any>>();
//
//        var tid = 0
//        for l in 0..<sectionData.count
//        {
//            let dicter = sectionData[l]
//            let sid = "S\(l+1)";
//            //let sectionhead = dicter["head"] as! String
//
//            // [["head" : "", "order" : "1", "ncolumns" : "1", "fields": [["label":"", "order" : "1", "itype" : "1","typename": "Text box", "ioptions" : "", "required" : "1", "ivalids" : "2", "idefault" : ""]]]];
//            setioonheader.append(["value" : dicter["head"]!, "id": sid])
//            let fieldsdata = dicter["fields"] as! [Dictionary<String, String>]
//
//            for v in 0..<fieldsdata.count
//            {
//                tid = tid + 1;
//                let fdatar = fieldsdata[v]
//
//                labelarray.append(["value" : fdatar["label"]!, "id": tid])
//                typearray.append(["value" : fdatar["itype"]!, "id": tid])
//                requiredArrays.append(["value" : fdatar["required"]!, "id": tid])
//
//                ivalidsArrays.append(["value" : fdatar["ivalids"]!, "id": tid])
//                sortArrays.append(["value" : dicter["order"]!, "id": tid])
//                defaultarrays.append(["value" : fdatar["idefault"]!, "id": tid])
//                ioptionsArrays.append(["value" : fdatar["ioptions"]!, "id": tid])
//
//
//                sectionids.append(["value" : sid, "id": tid])
//
//
//
//            }
//
//        }
//
//
//
//
//
//        dictjs["label"]  = labelarray
//        dictjs["itype"]  = typearray
//        dictjs["section_id"]  = sectionids
//        dictjs["required"]  = requiredArrays
//        dictjs["ivalids"]  = ivalidsArrays
//        dictjs["sort"]  = sortArrays
//        dictjs["idefault"]  = defaultarrays
//        dictjs["ioptions"]  = ioptionsArrays
//        dictjs["seactiontitle"]  = setioonheader;
//
//
//        return JSON(dictjs);
        
    }
    
    
    
    func checkvalidationData() -> Dictionary<String, String>
    {
        var validationdict = ["isvalid" : "1", "emsg" : ""];
        
        let comid = primaryData["comid"]!;
        
        let insName = primaryData["inspection_name"]!;
        
        
       
        
        if comid.isEmpty
        {
            validationdict["isvalid"] = "0"
            validationdict["emsg"] = "Please select Company"
            
        }
         
        else if insName.isEmpty
        {
            validationdict["isvalid"] = "0"
            validationdict["emsg"] = "Please enter Equipment Test name"
            
            
        }
        
        else{
            
            
            for dicter in sectionData
            {
                
                let seorder = dicter["order"] as! String
                let sectionhead = dicter["head"] as! String
                if sectionhead.isEmpty
                {
                    validationdict["isvalid"] = "0"
                    validationdict["emsg"] = "Please enter the section title for order \(seorder)"
                    break;
                    
                }
                else{
                    let fieldsdata = dicter["fields"] as! [Dictionary<String, String>]
                    
                    for fdatar in fieldsdata
                    {
                        let subheader = fdatar["label"]!
                        let forder = fdatar["order"]!
                        if subheader.isEmpty
                        {
                            validationdict["isvalid"] = "0"
                            
                            validationdict["emsg"] = "Please enter field label for \(sectionhead) of order \(forder)"
                            break;
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        return validationdict;
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 25] as! CommonRoundTextFieldCellClass
            cell.innerTextField.texet = indexPath;
            cell.loadUI();
            cell.viewWidthCostr.constant = self.view.frame.width - 30
            cell.topLabel.isHidden = true;
             
            switch indexPath.row
            {
            case 0:
                cell.innerTextField.inputView = menuDropDown;
                
                cell.innerTextField.addTarget(self, action: #selector(getTheData(_:)), for: .editingDidBegin);
                cell.imgWth.constant = 25;
                
                cell.innerTextField.text = primaryData["company"]
                
                cell.titleLabel.text =  "Company* :"
                let uid = cachem.string(forKey: "userType")!
                if uid == "0" || uid == "4"
                {
                    cell.innerTextField.isUserInteractionEnabled = true;
                    cell.innerTextField.textColor = UIColor.darkGray;
                    
                }
                else
                {
                    cell.innerTextField.isUserInteractionEnabled = false;
                    cell.innerTextField.textColor = UIColor.lightGray;
                }
                
            case 1:
                
               
                cell.innerTextField.addTarget(self, action: #selector(getTheData(_:)), for: .editingChanged);
                cell.imgWth.constant = 0.0;
                
                cell.innerTextField.text = primaryData["inspection_name"]
                
                cell.titleLabel.text =    "Equipment Test Name* :"
                
                
             
                
                
                
            default:
                
                
                print("im default");
                
                
                
            }
            
            
            return cell;
            
            
            
        }
            
        else if  indexPath.section == sectionData.count + 1
        {
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 3] as! InspectionsubmitBtncellClass
            cell.loadingDefaultUI();
            cell.hoBtn.constant = 45;
            
            
            
            if indexPath.row == 0
            {
                cell.topBorder.constant = 2.0;
                cell.topPadding.constant = 20
                
                cell.saveBtn.backgroundColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                cell.saveBtn.setTitle("Create Test Form", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector( SaveAndCloseBtnTapped(_:)), for: .touchUpInside);
                
                
            }
            else if indexPath.row == 1
            {
                cell.topBorder.constant = 0.0
                cell.topPadding.constant = 20
                cell.saveBtn.backgroundColor = UIColor.init(red: 51/255, green: 130/255, blue: 179/255, alpha: 1.0)
                cell.saveBtn.setTitle("Preview Form", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(previewTapped(_:)), for: .touchUpInside);
                
                
            }
            else
            {
                cell.topPadding.constant = 20
                cell.topBorder.constant = 0.0
                cell.saveBtn.backgroundColor = UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0)
                cell.saveBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside);
                cell.saveBtn.setTitle("Cancel", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside);
                
                
                
            }
            return cell
            
        }
        else if  indexPath.section > 0  && indexPath.section < sectionData.count + 1
        {
            
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 26] as! inspectionCustomField
            
            cell.loadUI();
            
            
            cell.deleteActivitier.stopAnimating();
            let trows = sectionData[indexPath.section - 1]["fields"] as! Array<Dictionary<String, Any>>
            if indexPath.row == 0
            {
                if trows.count < 2
                {
                    cell.deleteCellBtn.isHidden = true;
                }
                
            }
            
            let itypeer = trows[indexPath.row]["itype"] as! String;
            cell.optionsVw.isHidden = true;
            cell.optionHt.constant = 0.0;
            if itypeer == "2" ||  itypeer == "3" || itypeer == "4"
            {
                cell.optionsVw.isHidden = false;
                cell.optionHt.constant = 128.0
                
            }
            
            
            cell.rowTitle.text = trows[indexPath.row]["label"] as? String;
            cell.fieldOrderFd.text = trows[indexPath.row]["order"] as? String;
            cell.validalphaBtn.setTitlein = indexPath;
            cell.deleteCellBtn.actei = cell.deleteActivitier;
            cell.addRowBtn.setTitlein = indexPath;
            cell.validNumBtn.setTitlein = indexPath;
            cell.addactivitier.stopAnimating();
            cell.validAnyBtn.setTitlein = indexPath;
            cell.validalphaBtn.tag  = 1;
            cell.deleteCellBtn.setTitlein = indexPath;
            cell.validNumBtn.tag = 2;
            cell.addRowBtn.addTarget(self, action: #selector(addRowInTable(_:)), for: .touchUpInside);
            cell.deleteCellBtn.addTarget(self, action: #selector(deleteRowInTable(_:)), for: .touchUpInside);
            cell.validAnyBtn.tag = 3;
            cell.validalphaBtn.addTarget(self, action: #selector(inputVlaidatiod(_:)), for: .touchUpInside);
            cell.validalphaBtn.IradioBtns = [cell.validNumBtn, cell.validAnyBtn];
            cell.validNumBtn.IradioBtns = [cell.validalphaBtn, cell.validAnyBtn];
            cell.addRowBtn.actei = cell.addactivitier;
            cell.validAnyBtn.IradioBtns = [cell.validalphaBtn, cell.validNumBtn]
            cell.validNumBtn.addTarget(self, action: #selector(inputVlaidatiod(_:)), for: .touchUpInside);
            cell.validAnyBtn.addTarget(self, action: #selector(inputVlaidatiod(_:)), for: .touchUpInside);
            
            cell.roeType.text = trows[indexPath.row]["typename"] as? String;
            cell.requiredyesBtn.setTitlein = indexPath;
            cell.requirednNoBtn.setTitlein = indexPath;
            cell.defaultVlve.text = trows[indexPath.row]["idefault"] as? String;
            cell.requiredyesBtn.IradioBtns = [cell.requirednNoBtn];
            cell.requirednNoBtn.IradioBtns = [cell.requiredyesBtn];
            cell.optionTextarea.text = trows[indexPath.row]["ioptions"] as? String;
            let isrequired = trows[indexPath.row]["required"] as! String;
            let isValidation = trows[indexPath.row]["ivalids"] as! String;
            cell.requiredyesBtn.addTarget(self, action: #selector(isRequiredTapped(_:)), for: .touchUpInside);
            cell.requirednNoBtn.addTarget(self, action: #selector(isRequiredTapped(_:)), for: .touchUpInside);
            cell.requirednNoBtn.tag = 1;
            cell.requiredyesBtn.tag = 2
            
            
            if isrequired == "0"
            {
                
                cell.requirednNoBtn.backgroundColor = UIColor.init(hexString: "4EC836")
                cell.requiredyesBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                
                
            }
            else
            {
                
                cell.requirednNoBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                cell.requiredyesBtn.backgroundColor =  UIColor.init(hexString: "4EC836")
                
            }
            
            
            switch isValidation
            {
            case "0":
                cell.validalphaBtn.backgroundColor = UIColor.init(hexString: "4EC836")
                cell.validNumBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                cell.validAnyBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                break;
            case "1":
                
                cell.validalphaBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                cell.validNumBtn.backgroundColor = UIColor.init(hexString: "4EC836")
                cell.validAnyBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                break;
            case "2":
                
                cell.validalphaBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                cell.validNumBtn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                cell.validAnyBtn.backgroundColor = UIColor.init(hexString: "4EC836")
                break;
            default:
                print("im default");
            }
            
            
            cell.defaultVlve.texet = indexPath;
            cell.rowTitle.addTarget(self, action: #selector(getTheData(_:)), for: .editingChanged)
            cell.rowTitle.texet = indexPath;
            cell.optionTextarea.setTitlein = indexPath;
            
            cell.optionTextarea.delegate = self;
            //            cell.addRowBtn.setTitlein = indexPath;
            cell.fieldOrderFd.texet = indexPath;
            cell.fieldOrderFd.tag = 2
            cell.roeType.texet = indexPath;
            cell.fieldOrderFd.addTarget(self, action: #selector(getTheData(_:)), for: .editingDidBegin);
            
            cell.defaultVlve.addTarget(self, action: #selector(getTheData(_:)), for: .editingChanged);
            cell.roeType.addTarget(self, action: #selector(getTheData(_:)), for: .editingDidBegin);
            cell.fieldOrderFd.inputView = menuDropDown;
            cell.roeType.inputView = menuDropDown;
            
            cell.rowTitle.tag = 1;
            cell.defaultVlve.tag = 2;
            cell.fieldOrderFd.tag = 3;
            cell.roeType.tag = 4
            
            
            
            
            
            
            return cell;
            
            
            
        }
        else
        {
            let cell = UITableViewCell();
            cell.contentView.backgroundColor = UIColor.blue;
            return cell;
            
            
        }
        
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0
        {
            
            
            if indexPath.row == 1
            {
                return 95;
            }
            
            return 80;
            
        }
        else  if indexPath.section > 0 && indexPath.section < sectionData.count + 1
        {
            
            let trows = sectionData[indexPath.section - 1]["fields"] as! Array<Dictionary<String,
                Any>>
            let itypeer = trows[indexPath.row]["itype"] as! String;
            
            if indexPath.row == 0
            {
                if trows.count < 2
                {
                    
                    if itypeer == "2" ||  itypeer == "3" || itypeer == "4"
                    {
                        return 630;
                    }
                    
                    return 510;
                }
                
            }
            
            if itypeer == "2" ||  itypeer == "3" || itypeer == "4"
            {
                return 670
            }
            return 550;
            
            
            
            
            
            
            
            
        }
        else  if indexPath.section == sectionData.count + 1
        {
            if indexPath.row == 2
            {
                return 120;
            }
            return 70;
            
            
        }
        
        
        
        
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0
        {
            
            
            if indexPath.row == 1
            {
                return 95;
            }
            
            return 80;
            
        }
        else  if indexPath.section > 0 && indexPath.section < sectionData.count + 1
        {
            
            let trows = sectionData[indexPath.section - 1]["fields"] as! Array<Dictionary<String,
                Any>>
            let itypeer = trows[indexPath.row]["itype"] as! String;
            
            if indexPath.row == 0
            {
                if trows.count < 2
                {
                    
                    if itypeer == "2" ||  itypeer == "3" || itypeer == "4"
                    {
                        return 630;
                    }
                    
                    return 510;
                }
                
            }
            
            if itypeer == "2" ||  itypeer == "3" || itypeer == "4"
            {
                return 670
            }
            return 550;
            
            
            
            
            
            
            
            
        }
        else  if indexPath.section == sectionData.count + 1
        {
            if indexPath.row == 2
            {
                return 120;
            }
            return 70;
            
            
        }
        
        
        
        
        return 50
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
        
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        if section == 0
        {
            return 0
        }
        else if section > 0 && section < sectionData.count + 1
        {
            if section == 1
            {
                
                
                if sectionData.count < 2
                {
                    return 295;
                }
                
                
                
                
                
                return 320
            }
            else{
                return 320
            }
            
            
            
        }
        else
        {
            return 0
        }
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        
        if section == 0
        {
            return 0
        }
        else if section > 0 && section < sectionData.count + 1
        {
            if section == 1
            {
                
                
                if sectionData.count < 2
                {
                    return 295;
                }
                
                
                
                
                
                return 320
            }
            else{
                return 320
            }
            
            
            
        }
        else
        {
            return 0
        }
        
        
        
        
        
        
    }
    
    @objc func getheaderTitle(_ sender : UITextFeild)
    {
        if sender.tag == 1
        {
            
            sectionData[sender.hastag]["head"]  = sender.text;
            
        }
        if sender.tag == 2
        {
            
            samplePrimaryfield = sender;
            orderNumData = [String]();
            for i in 1..<sectionData.count + 1
            {
                orderNumData.append(String(i));
            }
            generalPickerData = JSON(orderNumData).arrayValue
            menuDropDown.reloadAllComponents();
            
            
            
            
            
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        if section > 0 && section < sectionData.count + 1
        {
            
            
            let headV  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 12] as! CustomInspectionHeaderViewClass
            headV.loadUI();
            
            if section == 1
            {
                
                if sectionData.count < 2
                {
                    headV.deleteSectioNBtn.isEnabled = false;
                    headV.deleteSectioNBtn.isHidden = true;
                }
                
                
                
            }
            
            
            headV.deleteAct.stopAnimating();
            headV.addSectionBtn.tag = section - 1;
            headV.displayorderField.tag = 2;
            headV.deleteSectioNBtn.tag = section - 1;
            headV.addSectionBtn.addTarget(self, action: #selector(addSectionInTable(_:)), for: .touchUpInside)
            DispatchQueue.main.async {
                headV.loaderforadd.stopAnimating();
            }
            //            headV.addSectionBtn.tag = section - 1 ;
            headV.displayorderField.hastag = section - 1
            headV.deleteSectioNBtn.addTarget(self, action: #selector(deleteSection(_:)), for: .touchUpInside);
            headV.sectionTitleField.hastag = section - 1
            headV.displayorderField.text = sectionData[section - 1]["order"] as? String
            headV.addSectionBtn.actei = headV.loaderforadd;
            headV.displayorderField.texet = IndexPath.init(row: section - 1, section: 100 )
            
            headV.displayorderField.addTarget(self, action: #selector(getheaderTitle(_:)), for: .editingDidBegin);
            headV.sectionTitleField.tag = 1;
            headV.displayorderField.inputView = menuDropDown;
            headV.sectionTitleField.text = sectionData[section - 1]["head"] as? String;
            headV.btn1.IradioBtns = [headV.btn2, headV.btn3, headV.btn4];
            headV.btn1.tag = 1;
            headV.deleteSectioNBtn.actei = headV.deleteAct;
            headV.btn2.tag = 2;
            headV.btn3.tag = 3;
            headV.btn4.tag = 4;
            headV.btn1.hasTag = section - 1;
            headV.btn2.hasTag = section - 1;
            headV.btn3.hasTag = section - 1;
            headV.btn4.hasTag = section - 1;
            headV.btn2.IradioBtns = [headV.btn3, headV.btn4, headV.btn1];
            headV.btn3.IradioBtns = [headV.btn4, headV.btn1, headV.btn2];
            headV.btn4.IradioBtns = [headV.btn1, headV.btn2, headV.btn3];
            headV.btn1.addTarget(self, action: #selector(ncolumnsTapped(_:)), for: .touchUpInside)
            headV.btn2.addTarget(self, action: #selector(ncolumnsTapped(_:)), for: .touchUpInside)
            headV.btn3.addTarget(self, action: #selector(ncolumnsTapped(_:)), for: .touchUpInside)
            headV.btn4.addTarget(self, action: #selector(ncolumnsTapped(_:)), for: .touchUpInside)
            
            
            
            
            headV.sectionTitleField.addTarget(self, action: #selector(getheaderTitle(_:)), for: .editingChanged)
            let ncolumns = sectionData[section - 1]["ncolumns"] as! String
            
            switch ncolumns
            {
            case "1":
                
                headV.btn1.backgroundColor = UIColor.init(hexString: "4EC836");
                headV.btn2.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                headV.btn3.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                headV.btn4.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                
                break;
            case "2":
                headV.btn1.backgroundColor = UIColor.init(hexString: "F5F5F7")
                headV.btn2.backgroundColor = UIColor.init(hexString: "4EC836");
                headV.btn3.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                headV.btn4.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                
                break;
            case "3":
                
                headV.btn1.backgroundColor = UIColor.init(hexString: "F5F5F7")
                headV.btn2.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                headV.btn3.backgroundColor =  UIColor.init(hexString: "4EC836");
                headV.btn4.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                break;
            case "4":
                
                headV.btn1.backgroundColor = UIColor.init(hexString: "F5F5F7")
                headV.btn2.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                headV.btn3.backgroundColor =  UIColor.init(hexString: "F5F5F7")
                headV.btn4.backgroundColor = UIColor.init(hexString: "4EC836");
                break;
            default:
                print("im deault");
                break;
                
            }
            
            
            
            
            
            
            if section == sectionData.count
            {
                //                headV.bAct.color = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0);
                //                headV.addSectionBtn.setTitleColor(UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0), for: .normal);
                //                headV.addSectionBtn.setTitle("ADD SECTION", for: .normal)
                //                headV.addSectionBtn.addTarget(self, action: #selector(addSectionInTable(_:)), for: .touchUpInside);
                //
            }
            else
            {
                //                headV.bAct.color = UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0);
                //                headV.addSectionBtn.setTitleColor(UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0), for: .normal);
                //                headV.addSectionBtn.setTitle("DELETE", for: .normal)
                //                headV.addSectionBtn.addTarget(self, action: #selector(removesectionInTable(_:)), for: .touchUpInside);
                //
            }
            
            
            return headV;
            
            
        }
            
        else
        {
            let vw = UIView();
            vw.backgroundColor = UIColor.white;
            return vw;
            
        }
        
        
        
        
    }
    
    
    
    
    
    @objc func ncolumnsTapped(_ sender : UIBotton)
    {
        
        sender.backgroundColor =  UIColor.init(hexString: "4EC836");
        sectionData[sender.hasTag]["ncolumns"]  = String(sender.tag)
        
        
        
        
        for i in 0..<sender.IradioBtns.count
        {
            
            let btn = sender.IradioBtns[i]
            btn.backgroundColor = UIColor.init(hexString: "F5F5F7")
        }
        
        
        
        
        
        
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    @objc func isRequiredTapped(_ sender : UIBotton)
    {
        
        print("im clicked")
        
        
        var fdata = self.sectionData[sender.setTitlein.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
        let isrequired = fdata[sender.setTitlein.row]["required"] as! String
        
        if sender.tag == 1
        {
            print("im clicked no btn")
            switch isrequired
            {
                
            case "1":
                
                sender.backgroundColor =   UIColor.init(hexString: "4EC836")
                for i in 0..<sender.IradioBtns.count
                {
                    let btn = sender.IradioBtns[i];
                    btn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                }
                fdata[sender.setTitlein.row]["required"]  = "0"
                self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
                
                break;
                
                
                
            default :
                print("im default");
                break;
                
            }
            
            
            
        }
        else
        {
            print("im clicked yes btn")
            switch isrequired
            {
            case "0" :
                
                sender.backgroundColor =   UIColor.init(hexString: "4EC836")
                for i in 0..<sender.IradioBtns.count
                {
                    let btn = sender.IradioBtns[i];
                    btn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                }
                fdata[sender.setTitlein.row]["required"]  = "1"
                self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
                
                break;
                
                
                
                
            default :
                print("im default");
                break;
                
            }
            
        }
        
       
        
        
    }
    
    
    
    
    
    @objc func inputVlaidatiod(_ sender : UIBotton)
    {
        
        print("im clicked")
        
        
        var fdata = self.sectionData[sender.setTitlein.section - 1]["fields"] as! Array<Dictionary<String, Any>>;
        let isrequired = fdata[sender.setTitlein.row]["ivalids"] as! String
        
        if sender.tag == 1
        {
            print("im clicked no btn")
            switch isrequired
            {
                
            case "1", "2":
                
                sender.backgroundColor =   UIColor.init(hexString: "4EC836")
                for i in 0..<sender.IradioBtns.count
                {
                    let btn = sender.IradioBtns[i];
                    btn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                }
                fdata[sender.setTitlein.row]["ivalids"]  = "0"
                self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
                
                break;
                
                
                
            default :
                print("im default");
                break;
                
            }
            
            
            
        }
        else if sender.tag == 2
        {
            print("im clicked yes btn")
            switch isrequired
            {
            case "0", "2" :
                
                sender.backgroundColor =   UIColor.init(hexString: "4EC836")
                for i in 0..<sender.IradioBtns.count
                {
                    let btn = sender.IradioBtns[i];
                    btn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                }
                fdata[sender.setTitlein.row]["ivalids"]  = "1"
                self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
                
                break;
                
                
                
                
            default :
                print("im default");
                break;
                
            }
            
        }
        else
        {
            
            
            print("im clicked yes btn")
            switch isrequired
            {
            case "0", "1" :
                
                sender.backgroundColor =   UIColor.init(hexString: "4EC836")
                for i in 0..<sender.IradioBtns.count
                {
                    let btn = sender.IradioBtns[i];
                    btn.backgroundColor = UIColor.init(hexString: "F5F5F7")
                }
                fdata[sender.setTitlein.row]["ivalids"]  = "2"
                self.sectionData[sender.setTitlein.section - 1]["fields"] = fdata;
                
                break;
                
                
                
                
            default :
                print("im default");
                break;
                
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func calldefaultData()
    {
        
        cinshud = MBProgressHUD.showAdded(to: self.view, animated: true);
        cinshud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        cinshud.bezelView.color = UIColor.white;
        self.cinshud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            //getOfflineBuildingData()
            DispatchQueue.main.async {
                self.cinshud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
            }
            
            return;
        }
        
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vEfficiencyTestCreateDetailAPI)\(userid)/\(usertype)"
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                let scode = resultdata["companies"]
                
                if  scode != JSON.null
                {
                    
                    
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                        self.companyListData = resultdata["companies"].arrayValue
                        
                        
                        let uid =  cachem.string(forKey: "userType")!
                        
                        if uid == "1" || uid == "2" ||  uid == "3"
                        {
                            if self.companyListData.count > 0
                            {
                                self.primaryData["company"] = self.companyListData[0]["cname"].stringValue
                                self.primaryData["comid"] = self.companyListData[0]["cid"].stringValue;
                                
                            }
                            
                            
                        }
                        
                        
                        self.addEquipmetTest.reloadData();
                        self.addEquipmetTest.isHidden = false;
                        self.cinshud.hide(animated: true);
                    }
                    
                    
                    
                    
                    
                }
                    
                else{
                    
                    DispatchQueue.main.async(execute: {
                        self.cinshud.hide(animated: true);
                    })
                    
                    
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: "Unknown error occured", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_ ) in
                        
                        self.calldefaultData()
                        
                        
                    }))
                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil));
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.cinshud.hide(animated: true);
                    
                }
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_ ) in
                    
                    self.calldefaultData();
                    
                    
                }))
                alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil))
                
                
                self.present(alert, animated: true, completion: nil);
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    func loadingDefaultUI()
    {
        menuDropDown.backgroundColor = UIColor.black;
        menuDropDown.dataSource = self;
        menuDropDown.delegate = self;
        CompatibleStatusBar(self.view);
        addEquipmetTest.isHidden = true;
        calldefaultData()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
    
    
    
    
    
    
    
    
    
    
    
    

}
