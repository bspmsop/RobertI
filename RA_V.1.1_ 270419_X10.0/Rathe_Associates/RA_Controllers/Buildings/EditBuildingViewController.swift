//
//  EditBuildingViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 18/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import MobileCoreServices
import SwiftyJSON
import Reachability
import MBProgressHUD
import PEPhotoCropEditor
import Alamofire

class EditBuildingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, PECropViewControllerDelegate   {

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        loadingDefaultUI();
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
       
    }
    
    var BuildDetils = ["cname": "","Property Code" : "", "Address" : "",  "Address2" : "",  "City" : "", "State" : "", "Zip" : "", "cluster" : "", "location":"", "apartments" : "", "notes":"", "statecode":""];
    var companiesList = Array<JSON>();
    var managersList = Array<JSON>();
    var supersList = Array<JSON>();
    var statesLists = Array<JSON>();
    var isfrommechupdate = false;
    var isfromSection = -1;
    var remainingsupermanagersdata = Array<JSON>();
    
    var selectedmechrooms = Array<JSON>();
     var selectedmanagers = Array<JSON>();
    var selectedsupers = Array<JSON>();
    var buildingDjData = JSON();
     var hud = MBProgressHUD();
    
    var pickerDataList = Array<JSON>();
    let menuDropDown = UIPickerView();
    var generalDropDownField = UITextFeild();
    var addBuildingHud = MBProgressHUD();
    var selectedcompnay = "-1";
    var selectedcompnaytiutle = "";
    var textAreaId = IndexPath.init(row: 0, section: 0);
    let menuPicker = UIPickerView()
    var pickedImage = UIImageView()
    var demoChooseBtn = UIBotton();
    var choosefileCounter = IndexPath.init(row: 0, section: 0);
    
    
      var mechanialRoomList = [""];
    
    
    
    var mechanicalRoomData = [["name":"New York, NY 10027"]];
    
    var BuildigSuperDta = [["name":"New York, NY 10027"]];
    var BuildingManagersData = [["name":"New York, NY 10027"]];
    var attachedmentData =  [["title":"", "path" : ""]];
    var testingTabData = ["Michal", "John", "David", "Markel","Michal", "John", "David", "Markel", "Michal", "John", "David", "Markel", "Michal", "John", "David", "Markel", "Michal", "John", "David", "Markel", "Michal", "John", "David", "Markel", "Michal", "John", "David", "Markel"]
     var lastContentOffset: CGFloat = 0
     var selectedBrowseRow = 0
    var buildingEidtData = JSON();
    
    @IBOutlet weak var editBuildingTable: UITableView!
    
    
    
    
    @IBAction func doclibrarybtntapped(_ sender: UIButton) {
        
        
      let vController =   self.storyboard?.instantiateViewController(withIdentifier: "BuildingDocumentViewController") as! BuildingDocumentViewController
        vController.BuildingAddress = self.buildingDjData["address1"].stringValue;
        
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        pickerView.backgroundColor = UIColor.black;
        let attributed = NSAttributedString.init(string: pickerDataList[row]["name"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.backgroundColor = UIColor.black;
        if row < pickerDataList.count
        {
            
            generalDropDownField.text = pickerDataList[row]["name"].stringValue;
            
            
            switch generalDropDownField.texet.section
            {
            case 0:
               
                
                BuildDetils["State"] = pickerDataList[row]["name"].stringValue;
                BuildDetils["statecode"] = pickerDataList[row]["id"].stringValue;
                
              
                
            case 2:
                
                selectedmanagers[generalDropDownField.texet.row] = pickerDataList[row];
                
            case 3:
                selectedsupers[generalDropDownField.texet.row] = pickerDataList[row];
                
            case 4:
                BuildingManagersData[generalDropDownField.texet.row]["name"] =  pickerDataList[row]["name"].stringValue;
                BuildingManagersData[generalDropDownField.texet.row]["id"] =  pickerDataList[row]["id"].stringValue;
                
                
            default:
                print("Im default");
                
            }
            
            
            
            
            
            
        }
        
        
    }
    
    
    
    
    
    
    @objc func gettingTableViewFieldText(_ sender : UITextFeild)
    {
        print("Im called");
        
        
        
        switch sender.texet.section {
            
        
        case 0:
            
           
              if sender.texet.row == 1
            {
                BuildDetils["Property Code"] = sender.text;
            }
            else if sender.texet.row == 2
            {
                BuildDetils["Address"] = sender.text;
            }
            else if sender.texet.row == 3
            {
                BuildDetils["Address2"] = sender.text;
            }
            else if sender.texet.row == 4
            {
                 BuildDetils["City"] = sender.text;
                
                
                
            }
            else if sender.texet.row == 5
            {
                pickerDataList = statesLists;
                
                menuDropDown.reloadAllComponents();
                generalDropDownField = sender;
                
                
            }
              else if sender.texet.row == 6
              {
                
                BuildDetils["Zip"] = sender.text;
              }
                
            else{
                print("default")
                
            }
            
            
            
            
            
            break;
        case 2:
            
            var mymanagersdata = [JSON]();
            for i in 0..<managersList.count
            {
                let superslistid = managersList[i]["id"].stringValue
                var ismatched = false;
                for l in 0..<selectedmanagers.count
                {
                    
                    let buildingsuperdtaid = selectedmanagers[l]["id"].stringValue;
                    if superslistid == buildingsuperdtaid
                    {
                        ismatched = true;
                        
                    }
                    
                }
                if !ismatched
                {
                    mymanagersdata.append( managersList[i])
                    
                }
                
                
            }
            pickerDataList = mymanagersdata;
            
            menuDropDown.reloadAllComponents();
            generalDropDownField = sender;
            
            
            
            
            break;
        case 3:
            var mymanagersdata = [JSON]();
            for i in 0..<supersList.count
            {
                let superslistid = supersList[i]["id"].stringValue
                var ismatched = false;
                for l in 0..<selectedsupers.count
                {
                    
                    let buildingsuperdtaid = selectedsupers[l]["id"].stringValue;
                    if superslistid == buildingsuperdtaid
                    {
                        ismatched = true;
                        
                    }
                    
                }
                if !ismatched
                {
                    mymanagersdata.append( supersList[i])
                    
                }
                
                
            }
            pickerDataList = mymanagersdata;
            
            menuDropDown.reloadAllComponents();
            generalDropDownField = sender;
            
            
            
            break;
        case 4:
            
            attachedmentData[sender.texet.row]["title"] = sender.text;
            
            break;
            
       
        case 5:
            
            if sender.texet.row == 0
            {
                BuildDetils["cluster"] = sender.text;
            }
            else if sender.texet.row == 1
            {
                BuildDetils["location"] = sender.text;
            }
            else if sender.texet.row == 2
            {
                BuildDetils["apartments"] = sender.text;
            }
            else if sender.texet.row == 3
            {
                BuildDetils["notes"] = sender.text;
            }
            else{
                print("default")
                
            }
            
            
            
            break;
            
            
            
            
            
        default:
            
            break;
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
      let popTabl = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 18] as! popupTableViewClass;
    
    @objc func addMechanicalRoom(_ sender : UIBotton)
    {
        
        
        
        switch sender.hasTag
        {
            
        case 1:
            
            mechanialRoomList.append("");
            // mechanicalRoomData.append(["name":""]);
            
            
        case 2:
            
            BuildigSuperDta.append(["name":"", "id":""]);
            
            
            
        case 3:
            
            BuildingManagersData.append(["name":"", "id":""]);
            
            
            
        case 4:
            
            attachedmentData.append(["title":"", "path" : ""]);
            
        default:
            print("I'm done");
            
        }
        
        
        let addText = NSAttributedString.init(string: "ADD", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.underlineColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0),  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue  ])
        UIView.animate(withDuration: 0.05, animations: {
            sender.backgroundColor = .clear;
            sender.setAttributedTitle(addText, for: .normal);
            
        }) { (_) in
            self.editBuildingTable.reloadData();
            print("reloaded data")
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    @objc func removeRoow(_ sender : UIBotton)
    {
        
        switch sender.hasTag
        {
            
        case 1:
            
            mechanialRoomList.remove(at: sender.tag);
            
            
            
        case 2:
            
            BuildigSuperDta.remove(at: sender.tag);
            
            
            
            
        case 3:
            
            BuildingManagersData.remove(at: sender.tag);
            
            
        case 4:
            
            attachedmentData.remove(at: sender.tag);
            
            
        default:
            print("I'm done");
            
        }
        
        
        
        
        let deleteText = NSAttributedString.init(string: "Delete", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.underlineColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0) , NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue ])
        
        UIView.animate(withDuration: 0.05, animations: {
            sender.backgroundColor = .clear;
            sender.setAttributedTitle(deleteText, for: .normal);
            
        }) { (_) in
            
            self.editBuildingTable.reloadData();
            
            
        }
        
        
        
        
        
    }
    
    var imageuploadercount  = 0
    var imageneedtouploaddata = Array<Dictionary<String, String>>();
    
    func checkvalidattionofdata() -> Dictionary<String,String>
    {
        
        var isvalid = ["isvalid":"1", "msg":""];
        let pcode = BuildDetils["Property Code"];
        let address = BuildDetils["Address"];
        let city = BuildDetils["City"];
        let state = BuildDetils["State"];
        let zipp = BuildDetils["Zip"];
        let satecode = BuildDetils["statecode"]
        
        var imagestatus = true;
        var imessage = "";
        imageuploadercount = 0;
        imageneedtouploaddata = Array<Dictionary<String, String>>();
        for i in 0..<attachedmentData.count
        {
            let imagetitle = attachedmentData[i]["title"]
            let imagepath = attachedmentData[i]["path"]
            if  !imagetitle!.isEmpty && !imagepath!.isEmpty
            {
                imageneedtouploaddata.append(attachedmentData[i])
                imagestatus = true;
                
            }
            else if imagetitle!.isEmpty && imagepath!.isEmpty
            {
                imagestatus = true;
            }
            else
            {
                if imagetitle!.isEmpty
                {
                    imessage = "Please enter document title"
                }
                else
                {
                    imessage = "Please choose file for \(imagetitle!)"
                }
                imagestatus = false;
                
            }
            
            
        }
        
        
        
        
        
         if address!.isEmpty
        {
            isvalid = ["isvalid":"0", "msg":"Please enter address"];
            return isvalid;
            
        }
        else if city!.isEmpty
        {
            isvalid = ["isvalid":"0", "msg":"Please enter city"];
            return isvalid;
            
        }
        else if state!.isEmpty || satecode!.isEmpty
        {
            isvalid = ["isvalid":"0", "msg":"Please enter state"];
            return isvalid;
            
        }
        else if zipp!.isEmpty
        {
            isvalid = ["isvalid":"0", "msg":"Please enter zip code"];
            return isvalid;
            
        }
        else if  !isvalidzipcode(zipcode: zipp!)
        {
            isvalid = ["isvalid":"0", "msg":"Please enter valid zip code"];
            return isvalid;
        }
        else if !imagestatus
        {
            
            isvalid = ["isvalid":"0", "msg": imessage];
            return isvalid;
            
        }
            
        else
        { return isvalid;
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func uploadimagetoserver()
    {
        
        
        
        if imageneedtouploaddata.count > 0 && imageneedtouploaddata.count > imageuploadercount
        {
            let imagepath = imageneedtouploaddata[imageuploadercount]["path"]!
            let dtaim = fileManag.contents(atPath: imagepath);
            
            if dtaim != nil
            {
                print("converted inot data")
            }
            else
            {
                print("got conversion error");
                DispatchQueue.main.async {
                     self.addBuildingHud.hide(animated: true);
                }
               
                return;
            }
            
            
            let localulrimgPath = URL.init(fileURLWithPath: imagepath)
            
            
            let uid = localulrimgPath.pathExtension;
            var uidname = "bid"
            
            print(uid);
            
            
            let userid = UserDefaults.standard
            let user_id =  userid.string(forKey: "userid")
            
            print(uid);
            print(user_id);
            
            print("loading to server....");
            var uploadApiforimg = vbuildingfileupload;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
            
            
            
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: uidname, mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "fileName");
                
                
                
                
            }, to: uploadApiforimg , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if  response.result.value != nil && response.result.isSuccess {
                            
                            let resp = response.result.value;
                            
                            
                            print(response.result.value)
                            
                            let midiatr = JSON(resp);
                            
                            if uid == "mp4"
                            {
                                let  path = midiatr["filePath"].stringValue
                                
                                self.imageneedtouploaddata[self.imageuploadercount]["path"] = path
                                self.imageuploadercount = self.imageuploadercount + 1;
                                
                                
                                self.uploadimagetoserver()
                                
                            }
                            else
                            {
                                
                             
                            let respStatus = midiatr["scode"].intValue;
                            print(respStatus)
                            
                            if respStatus == 200
                            {
                                
                                
                                let  path = midiatr["filePath"].stringValue
                                
                                self.imageneedtouploaddata[self.imageuploadercount]["path"] = path
                                self.imageuploadercount = self.imageuploadercount + 1;
                                
                                
                                self.uploadimagetoserver()
                                
                            }
                            else
                            {
                                let  msg = midiatr["message"].stringValue
                                
                                print("Error exist here");
                                
                                
                                
                                DispatchQueue.main.async {
                                    self.addBuildingHud.hide(animated: true);
                                    let alert = UIAlertController.init(title: translator("Failed"), message: msg, preferredStyle: .alert);
                                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                    self.present(alert, animated: true, completion: nil);
                                }
                               
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                        }
                            
                            
                            
                        }
                            
                        else
                        {
                            DispatchQueue.main.async {
                                self.addBuildingHud.hide(animated: true);
                                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unable to save attached file to the server please try again"), preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                            }
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                case .failure(let encodingError):
                    
                    print("eroror \(encodingError)");
                    
                    DispatchQueue.main.async {
                        self.addBuildingHud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unable to save attached file to the server please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
        }
        else
        {
            
            let parms = ["buildingdata" : createJSON()];
            print(parms);
            print(vbuildingupdateApi);
            Alamofire.request(vbuildingupdateApi, method: .post, parameters: parms).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    
                    print(resp.result.value)
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        isOfflineMode = false
                        
                        
                        DispatchQueue.main.async {
                            self.addBuildingHud.hide(animated: true);
                            let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Building successfully updated"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                
                                
                                
                                self.navigationController?.popViewController(animated: true);
                                
                                
                            }))
                            self.present(alert, animated: true, completion: nil);
                        }
                        
                       
                       
                        
                    }
                        
                        
                        // }
                    else{
                        DispatchQueue.main.async {
                            self.addBuildingHud.hide(animated: true);
                            let mes = resultdata["message"] as? String
                            
                            let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil);
                        }
                        
                        
                    }
                    
                    
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        self.addBuildingHud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            
                            
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                    }
                    
                    
                    
                    
                }
                
                
                
            }
            
        }
    }
    
    func createJSON() -> JSON
    {
        var datajson = JSON();
        
        var dtadict = Dictionary<String, Any>();
        let pcode = BuildDetils["Property Code"];
        let address = BuildDetils["Address"];
        let address2 = BuildDetils["Address2"];
        let city = BuildDetils["City"];
        
        let zipp = BuildDetils["Zip"];
        let satecode = BuildDetils["statecode"]
        let clust = BuildDetils["cluster"];
        let loc = BuildDetils["location"];
        let apratm = BuildDetils["apartments"];
        let notes = BuildDetils["notes"];
        let userid = cachem.string(forKey: "userid")!
        
        
        dtadict["userid"] = userid;
        dtadict["companyid"] = selectedcompnay;
        dtadict["stateid"] = satecode
        dtadict["propertycode"] = pcode;
        dtadict["address"] = address;
        dtadict["address2"] = address2;
        dtadict["city"] = city;
        dtadict["zip"] = zipp;
        dtadict["cluster"] = clust;
        dtadict["location"] = loc;
        dtadict["apartment"] = apratm;
        dtadict["notes"] = notes;
        dtadict["bid"] = vselectedbuildingId;
        
        
        
        
        dtadict["documents"] = imageneedtouploaddata;
        
        var buildingsuperids = Array<String>();
        var buildingmanagersids = Array<String>();
        var buildingmechanicallas = Array<String>();
        
        
        
        
        
        
        
        for i in 0..<selectedmechrooms.count
        {
            let mechdata = selectedmechrooms[i]["mid"].stringValue
            if !mechdata.isEmpty
            {
                buildingmechanicallas.append(mechdata);
                
            }
            
            
            
        }
        dtadict["mechanicals"] = buildingmechanicallas;
        for i in 0..<selectedsupers.count
        {
            let superid = selectedsupers[i]["id"].stringValue
            if !superid.isEmpty
            {
                buildingsuperids.append(superid);
                
            }
            
            
            
        }
        dtadict["supers"] = buildingsuperids;
        
        for i in 0..<selectedmanagers.count
        {
            let mid = selectedmanagers[i]["id"].stringValue
            if !mid.isEmpty
            {
                buildingmanagersids.append(mid);
                
            }
            
            
            
        }
        dtadict["supers"] = buildingsuperids;
        dtadict["managers"] = buildingmanagersids;
        
        
        
        
        datajson = JSON(dtadict);
        
        
        
        
        
        
        
        
        return datajson;
    }
    
    @objc  func SaveAndCloseBtnTapped(_ sender : UIButton)
    {
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        let checkNetworks = Reachability()!;
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Updating..."
        
        
        let resultdata =  checkvalidattionofdata()
        let validationdata = resultdata["isvalid"]!;
        let validationmsg = resultdata["msg"]!;
        if(validationdata == "0")
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alert = UIAlertController.init(title: "Alert!", message: validationmsg, preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil);
            }
            
            return;
        }
        
        
        if checkNetworks.connection == .none
        {
            
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =   self.createJSON() ;
                    let jdata =  deleteapidata.description
                    
                    let savestatsu =   saetolocaldatabase(jdata, "updatebuilding");
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
        
        
       
        
        
        
        
        uploadimagetoserver()
        
        
    }
    
    
    
    
    
    
    
    func isvalidzipcode(zipcode: String) -> Bool {
        
        
        let emailRegEx = "(^[0-9]{5}(-[0-9]{4})?$)"
        
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let bool = pinPredicate.evaluate(with: zipcode) as Bool
        
        return bool
        
        
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let myimage = info[UIImagePickerControllerLivePhoto] as? UIImage
        if myimage != nil
        {
            
            picker.dismiss(animated: true) {
                let alert = UIAlertController.init(title: "Alert", message: "Cannot upload Live Photos.", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil);
                
            }
            
        }
        else{
            
            let selectedImg = info[UIImagePickerControllerOriginalImage] as? UIImage
            if selectedImg != nil
            {
                
                
                
                
                
                
                let pecropper = PECropViewController.init();
                pecropper.image = selectedImg!
                pecropper.delegate = self;
                
                
                picker.dismiss(animated: false) {
                    let nav = UINavigationController.init(rootViewController: pecropper);
                    self.present(nav, animated: false, completion: nil);
                }
                
                
            }
            else
            {
                
                picker.dismiss(animated: true) {
                    let alert = UIAlertController.init(title: "Alert", message: "Please select valid image", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    func cropViewController(_ controller: PECropViewController!, didFinishCroppingImage croppedImage: UIImage!) {
        print("cropped")
        
        
        
        let ImgeData = UIImagePNGRepresentation(croppedImage);
        
        if ImgeData != nil
        {
            // testdata = ImgeData!
            
            
            
            
            
            let tdate = Date();
            let dateformer = DateFormatter();
            dateformer.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateStr = dateformer.string(from: tdate);
            var imageName = "buildinglibrary" + dateStr  + ".png";
            imageName = imageName.replacingOccurrences(of: " ", with: "_");
            let specificPath = getPath(fileName: imageName)
            let specificURL = getPathURL(fileName: imageName)
            
            let isExist = fileManag.fileExists(atPath: specificPath);
            if !isExist
            {
                
                
                fileManag.createFile(atPath: specificPath, contents: ImgeData!, attributes: nil);
                
                print("image  created");
                
                
                do {
                    let resources = try specificURL.resourceValues(forKeys:[.fileSizeKey])
                    let fileSize = resources.fileSize!
                    print ("\(fileSize)")
                    
                    
                    if fileSize > 16777216
                    {
                        controller.dismiss(animated: true) {
                            let alert = UIAlertController.init(title: translator("Failed"), message: translator("File size is too large"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            return ;
                        }
                        
                    }
                    
                    if fileSize <= 0
                    {
                        controller.dismiss(animated: true) {
                            let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unsupported file formate"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            return ;
                        }
                        
                        
                    }
                }
                catch{
                    controller.dismiss(animated: true) {
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unsupported file formate"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        return ;
                    }
                }
                
                
                
                 DispatchQueue.main.async {
                 controller.dismiss(animated: true, completion: nil);
                self.demoChooseBtn.setTitle(specificPath, for: .normal)
                self.attachedmentData[self.choosefileCounter.row]["path"] = specificPath;
                }
                
                
                
                
            }
            else
            {
                controller.dismiss(animated: true) {
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please select valid image"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                }
            }
            
            
            
            
        }
        else
        {
            
            controller.dismiss(animated: true) {
                
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please select valid image"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    func cropViewControllerDidCancel(_ controller: PECropViewController!) {
        print("cancel");
        controller.dismiss(animated: true, completion: nil);
    }
    
    
    
    
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL = url as URL
        print("import result : \(myURL)")
        
        let tdate = Date();
        let dateformer = DateFormatter();
        dateformer.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateformer.string(from: tdate);
        
        let file_Path = "buildinglibrary" +  dateStr + myURL.lastPathComponent;
        
        var savedfilePath = getPath(fileName: file_Path);
        savedfilePath = savedfilePath.replacingOccurrences(of: " ", with: "_");
        print(savedfilePath);
        
        let isExist = fileManag.fileExists(atPath: savedfilePath);
        if !isExist
        {
            
            
            do{
                
                
                try fileManag.copyItem(atPath: myURL.path, toPath: savedfilePath );
                
                print("file copied");
                
                
                
                do {
                    let resources = try myURL.resourceValues(forKeys:[.fileSizeKey])
                    let fileSize = resources.fileSize!
                    print ("\(fileSize)")
                    
                    
                    if fileSize > 16777216
                    {
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("File size is too large"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        return ;
                    }
                    
                    if fileSize <= 0
                    {
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unsupported file formate"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        return ;
                        
                    }
                    
                    
                    
                } catch {
                    print("Error: \(error)")
                }
                
                
                
                
            }
            catch
            {
                print("Unable to copy the  file");
            }
            
            
        }
        else
        {
            print("image exists");
        }
        
        
        
        
        
        
        DispatchQueue.main.async {
            self.demoChooseBtn.setTitle(savedfilePath, for: .normal)
            
            self.attachedmentData[self.choosefileCounter.row]["path"] = savedfilePath;
        }
        
        
        
        
        
        
        
        
        
        
        print("picked")
    }
    
    
    
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        
        present(documentPicker, animated: true, completion: nil)
        
        
    }
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil);
        
    }
    @objc func openGallary(_ sender : UIBotton)
    {
        self.view.endEditing(true);
        demoChooseBtn = sender;
        self.choosefileCounter = sender.setTitlein;
        
        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Choose below"), preferredStyle: .actionSheet);
        alert.addAction(UIAlertAction.init(title: translator("Take a photo"), style: .default, handler: { (_ ) in
            
            print("Take photo");
            let imagpicker = UIImagePickerController();
            imagpicker.delegate = self;
            
            imagpicker.sourceType = .camera
            imagpicker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
            
            imagpicker.allowsEditing = false;
            imagpicker.navigationBar.barTintColor = UIColor.black;
            imagpicker.navigationBar.tintColor = UIColor.white;
            imagpicker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white];
            
            
            self.present(imagpicker, animated: true, completion: nil);
            
            
        }))
        alert.addAction(UIAlertAction.init(title: translator("Gallery"), style: .default, handler: { (_ ) in
            
            print("choose gallary");
            let imagpicker = UIImagePickerController();
            imagpicker.delegate = self;
            
            imagpicker.sourceType = .photoLibrary;
            imagpicker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
            
            imagpicker.allowsEditing = false;
            imagpicker.navigationBar.barTintColor = UIColor.black;
            imagpicker.navigationBar.tintColor = UIColor.white;
            imagpicker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white];
            
            
            self.present(imagpicker, animated: true, completion: nil);
            
            
        }))
        alert.addAction(UIAlertAction.init(title: translator("More"), style: .destructive, handler: { (_ ) in
            print("more..");
            
            let importMenu = UIDocumentMenuViewController(documentTypes: ["kUTTypePDF", "public.image", "public.audio", "public.movie", "public.text", "public.item", "public.content", "public.source-code"], in: .import)
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            self.present(importMenu, animated: true, completion: nil)
            
            
            
        }))
        
        alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil);
        
        
        
        
        
        
    }
    
    @objc func addAnotherRow(_ sender : UIBotton)
    {
        switch sender.tag {
        
        case 1:
            var myjson  = JSON();
            myjson["te"] = "test";
            self.selectedmechrooms.append(myjson)
            
            
        case 2:
            
            BuildingManagersData.append(["name": testingTabData[sender.hasTag] ])
            
            
        case 3:
            
            BuildigSuperDta.append(["name": testingTabData[sender.hasTag]])
            
            
        case 4:
            attachedmentData.append(["name": testingTabData[sender.hasTag]])
            
            
        default:
            print("I'm default");
            
        }
        
        
        
        
        
        editBuildingTable.reloadData();
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    @objc func deleteSectionRow(_ sender : UIBotton)
    {
        switch sender.setTitlein.section {
            
        case 1:
            
            mechanicalRoomData.remove(at: sender.setTitlein.row)
            
            
        case 2:
            
            BuildingManagersData.remove(at: sender.setTitlein.row)
            
            
        case 3:
            
            BuildigSuperDta.remove(at: sender.setTitlein.row)
            
            
        case 4:
            attachedmentData.remove(at: sender.setTitlein.row)
            
            
        default:
            print("I'm default");
            
        }
        DispatchQueue.main.async {
             sender.myimageVw.image = UIImage.init(named: "test");
        }
       
        UIView.animate(withDuration: 1.0, animations: {
            
        }) { (_) in
            
              self.editBuildingTable.reloadData();
            
        }
        
        
      
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
       if tableView != editBuildingTable
       {
        
       
        DispatchQueue.main.async {
              self.popTabl.miniLoader.isHidden = false;
            self.hidePopView(UIButton());
            let uid = self.remainingsupermanagersdata[indexPath.row]["id"].stringValue;
            let namer = self.remainingsupermanagersdata[indexPath.row]["name"].stringValue;
            
             self.addusers(uid, namer,  self.popTabl.dropDownTable.tag)
           
        }
       
        
        
        
        
        
        
       
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
    

    
    
    
    @objc func addMechancialRoomPopupSubmitted(_ sender : UIBotton)
    {
        self.view.endEditing(true);
        
        if popTabl.roomNameField.text == ""
        {
            popTabl.wariningLab.text = "Please enter required field";
            
            
        }
        else
        {
            
            DispatchQueue.main.async {
                self.popTabl.miniLoader.isHidden = false;
                self.hidePopView(sender);
                self.addmechroomhere(self.popTabl.roomNameField.text!)
            }
            
            
        
        }
        
    
    }
    
    
    func addmechroomhere(_ mechroomname : String)
    {
        
        if !vselectedbuildingId.isEmpty && !mechroomname.isEmpty
        {
            
            
            
            
            hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            
            let userid = cachem.string(forKey: "userid")!
            let usertype = cachem.string(forKey: "userType")!;
            var paramjson = Dictionary<String, String>();
            paramjson["user_id"] = userid;
            paramjson["title"] = mechroomname;
            paramjson["building_id"] = vselectedbuildingId;
            
            
            let parameters = [
                "mechdata":  JSON(paramjson)
            ]
            print(parameters);
            
            
            let checkNetwork = Reachability()!;
            
            
            if checkNetwork.connection == .none
            {
                DispatchQueue.main.async {
                    self.hud.hide(animated: true);
                    let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                    alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                    alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                        
                        let deleteapidata =  JSON(paramjson).description
                        let jdata =  deleteapidata
                        
                        let savestatsu =   saetolocaldatabase(jdata, "savemechroom");
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
                
                // getOfflineBuildingData()
                return;
            }
            
            
           
            print(vmechanicalSaveApi)
            Alamofire.request(vmechanicalSaveApi, method: .post, parameters : parameters).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Success!"), message: translator("Mechanical Room added to the building."), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            DispatchQueue.main.async {
                                self.isfrommechupdate = true;
                                
                                self.loadingDefaultUI();
                                
                            }
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
            
            
        }
        else
        {
            let alert = UIAlertController.init(title: "Alert!", message: "Please select required fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil);
            
            
        }
        
        
        
        
        
        
        
    }
 
    
    
    
    
    @objc func deletemechrooms(_ sender : UIBotton)
    {
        
        if Gmenu.count > 4
        {
            let isfull =  Gmenu[4]["isfull"]!
            let isnodelte = Gmenu[4]["isnodelete"]!
            
             let isbred =  Gmenu[1]["isread"]!
            let isbnodelete =  Gmenu[1]["isnodelete"]!
            
            
            if isbred == "1" || isnodelte == "1" || isbnodelete == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                return;
                
            }
            else if isfull == "1"
            {
                
            }
              
            else
            {
               
                
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                return;
            }
            
            
        }
        
        
        let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.notes)", preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil));
        alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_ ) in
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            
            
            
            let checkNetwork = Reachability()!;
            
            
            if checkNetwork.connection == .none
            {
                DispatchQueue.main.async {
                    self.hud.hide(animated: true);
                    let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                    alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                    alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                        
                        let deleteapidata = "\(vmechanicalDeleteApi)\(sender.jobstatus)"
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
                // getOfflineBuildingData()
                return;
            }
            
            
            
            
            
            let buildingdetailapi = "\(vmechanicalDeleteApi)\(sender.jobstatus)"
            
            print(buildingdetailapi);
            
            Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    if resp.result.isSuccess
                    {
                        isOfflineMode = false
                        DispatchQueue.main.async {
                            
                            self.hud.hide(animated: true);
                            let alerrt = UIAlertController.init(title: "Success!", message: "Mechanical Room deleted successfully", preferredStyle: .alert);
                            alerrt.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                                self.isfrommechupdate = true;
                                
                                self.loadingDefaultUI();
                                
                                
                            }));
                            self.present(alerrt, animated: true, completion: nil);
                            
                            
                        }
                       
                        
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            self.hud.hide(animated: true);
                            let alert = UIAlertController.init(title: translator("Failed!"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                isOfflineMode = true;
                                
                                //  self.getOfflineBuildingData()
                                
                                
                            }))
                            
                            
                            self.present(alert, animated: true, completion: nil);
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            //  self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
        
       
        
        
    }
    
    
    
    @objc func addusers(_ uuid : String, _ uname : String, _ issuper : Int)
    {
        print(uuid);
        print(uname);
        print(issuper);
        
            hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        var paramjson = Dictionary<String, String>();
        paramjson["user_id"] = uuid;
        
        paramjson["building_id"] = vselectedbuildingId;
        
        
        var adduserapi = "";
        if issuper == 2
        {
            adduserapi =  vbuildingAddmanager
        }
        else{
            adduserapi = vbuildingAddSuper
            
        }
        
        let parameters = [
            "bid":  vselectedbuildingId,
            "uid":  uuid
            
        ]
        print(parameters);
        
            
            let checkNetwork = Reachability()!;
            
            
            if checkNetwork.connection == .none
            {
                DispatchQueue.main.async {
                    self.hud.hide(animated: true);
                    let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                    alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                    alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                        
                        let deleteapidata =  JSON(parameters).description
                        let jdata =  deleteapidata
                        var myttt = ""
                        if issuper == 2
                        {
                            myttt =  "addmanagersbuilding"
                        }
                        else{
                            myttt = "addsupersbuilding"
                            
                        }
                        let savestatsu =   saetolocaldatabase(jdata, myttt);
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
                
                // getOfflineBuildingData()
                return;
            }
            
            
        
            print(adduserapi)
            Alamofire.request(adduserapi, method: .post, parameters : parameters).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Success!"), message: translator("\(uname) added successfully"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            self.isfromSection = issuper
                            DispatchQueue.main.async {
                                
                                
                                self.loadingDefaultUI();
                                
                            }
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
            
            
         
        
        
        
        
        
        
        
    }
    
    
    
    
    
    @objc func deleteManagerSuper(_ sender : UIBotton)
    {
        
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
             let isbnodelete =  Gmenu[1]["isnodelete"]!
            if isread == "1" || isbnodelete == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        
        let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.notes)", preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil));
        alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_ ) in
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            self.hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.hud.bezelView.color = UIColor.white;
            self.hud.label.text = "Loading..."
            var buildingdetailapi =  "";
            
            if sender.setTitlein.section == 2
            {
                buildingdetailapi = "\(vbuildingDeleteManager)\(sender.jobstatus)/\(vselectedbuildingId)"
            }
            else
            {
                buildingdetailapi = "\(vbuildingDeleteSuper)\(sender.jobstatus)/\(vselectedbuildingId)"
            }
            
            
            
            let checkNetwork = Reachability()!;
            
            
            if checkNetwork.connection == .none
            {
                DispatchQueue.main.async {
                    self.hud.hide(animated: true);
                    let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                    alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                    alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                        
                        let deleteapidata =  buildingdetailapi
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
                // getOfflineBuildingData()
                return;
            }
            
           
            
          
            
            print(buildingdetailapi);
            
            Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil
                {
                    if resp.result.isSuccess
                    {
                        isOfflineMode = false
                         self.isfromSection = sender.setTitlein.section
                        DispatchQueue.main.async {
                            
                            self.hud.hide(animated: true);
                            let alerrt = UIAlertController.init(title: "Success!", message: "\(sender.notes) deleted successfully", preferredStyle: .alert);
                            alerrt.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_ ) in
                                
                                
                                self.loadingDefaultUI();
                                
                                
                            }));
                            self.present(alerrt, animated: true, completion: nil);
                            
                            
                        }
                        
                        
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            self.hud.hide(animated: true);
                            let alert = UIAlertController.init(title: translator("Failed!"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                isOfflineMode = true;
                                
                                //  self.getOfflineBuildingData()
                                
                                
                            }))
                            
                            
                            self.present(alert, animated: true, completion: nil);
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("An internal error occured, please try again."), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            isOfflineMode = true;
                            
                            //  self.getOfflineBuildingData()
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    @objc func addDocumentlibraryview(_ sender : UIBotton)
    {
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        attachedmentData.append(["title":"", "path" : ""])
        
       self.editBuildingTable.reloadSections( IndexSet.init(integer: 4), with: .fade)
    }
    
    
    
    
    @objc func showPopUp(_ sender : UIBotton)
    {
       
        
            self.popTabl.dropDownTable.tag = sender.tag;
            popTabl.loadingDefaultUI();
            self.popTabl.wariningLab.text = "";
        
            self.popTabl.roomNameField.text  = "";
        
        
            self.popTabl.submitBtn.tag = sender.tag;
        
            self.popTabl.submitBtn.addTarget(self, action: #selector(addMechancialRoomPopupSubmitted(_:)), for: .touchUpInside)
            popTabl.frame = CGRect.init(x: 0, y: self.view.frame.height + 42, width: self.view.frame.width, height: self.view.frame.height)
            
            
            
        
            
            
            self.popTabl.closeBtn.addTarget(self, action: #selector(hidePopView(_:)), for: .touchUpInside)
            self.popTabl.cancelBtn.addTarget(self, action: #selector(hidePopView(_:)), for: .touchUpInside)
            
        if sender.tag == 1
        {
            if Gmenu.count > 4
            {
                let isfull =  Gmenu[4]["isfull"]!
                let isnodelte = Gmenu[4]["isnodelete"]!
                
                let isbred =  Gmenu[1]["isread"]!
                
                
                if isbred == "1"
                {
                    let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                    return;
                    
                }
                else if isfull == "1" || isnodelte == "1"
                {
                    
                }
                    
                else
                {
                    
                    
                    let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                    return;
                }
                
                
            }
            
            
            
            self.popTabl.headertitle.text = "Please Enter Mechanical Room";
            
            self.popTabl.mechanicalRoomViw.isHidden = false;
        }
        else if sender.tag == 2
        {
            
            if Gmenu.count > 1
            {
                let isread =  Gmenu[1]["isread"]!
                
                if isread == "1"
                {
                    let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                    
                    return;
                }
                
                
            }
            
            self.popTabl.headertitle.text = "Select Building Managers";
            self.popTabl.mechanicalRoomViw.isHidden = true;
            self.popTabl.dropDownTable.isHidden = false;
            self.popTabl.dropDownTable.delegate = self;
            self.popTabl.dropDownTable.dataSource = self;
            var mymanagersdata = [JSON]();
            for i in 0..<managersList.count
            {
                let superslistid = managersList[i]["id"].stringValue
                var ismatched = false;
                for l in 0..<selectedmanagers.count
                {
                    
                    let buildingsuperdtaid = selectedmanagers[l]["id"].stringValue;
                    if superslistid == buildingsuperdtaid
                    {
                        ismatched = true;
                        
                    }
                    
                }
                if !ismatched
                {
                    mymanagersdata.append( managersList[i])
                    
                }
                
                
            }
            remainingsupermanagersdata = mymanagersdata;
            
            
            self.popTabl.dropDownTable.reloadData();
        }
        else if sender.tag == 3
        {
            if Gmenu.count > 1
            {
                let isread =  Gmenu[1]["isread"]!
                
                if isread == "1"
                {
                    let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                    
                    return;
                }
                
                
            }
            self.popTabl.headertitle.text = "Select Building Supers";
            self.popTabl.dropDownTable.isHidden = false;
            self.popTabl.mechanicalRoomViw.isHidden = true;
            self.popTabl.dropDownTable.delegate = self;
            self.popTabl.dropDownTable.dataSource = self;
            
            var mymanagersdata = [JSON]();
            for i in 0..<supersList.count
            {
                let superslistid = supersList[i]["id"].stringValue
                var ismatched = false;
                for l in 0..<selectedsupers.count
                {
                    
                    let buildingsuperdtaid = selectedsupers[l]["id"].stringValue;
                    if superslistid == buildingsuperdtaid
                    {
                        ismatched = true;
                        
                    }
                    
                }
                if !ismatched
                {
                    mymanagersdata.append( supersList[i])
                    
                }
                
                
            }
            remainingsupermanagersdata = mymanagersdata;
            
            self.popTabl.dropDownTable.reloadData();
       }
        else
        {
            
            
        }
         self.view.addSubview(popTabl);
        UIView.animate(withDuration: 0.5, animations: {
            self.popTabl.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }) { (isAnimated) in
            
            
            
        }
        
    }
    
    
    
    func remaingusersdata(_ section : Int, _ tjson : Array<JSON>, _ searchJSOn : Array<JSON>) -> Array<JSON>
    {
        let myjson = Array<JSON>()
        
       for i in 0..<tjson.count
       {
        
            for l in 0..<searchJSOn.count
            {
                
                
                
                
                
            }
        
        
        
        
        }
        
        
        return myjson
        
        
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == self.popTabl.dropDownTable
        {
            if remainingsupermanagersdata.count > 0
            {
                let viewer = UIView();
                viewer.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height)
                viewer.backgroundColor = UIColor.white;
                 tableView.backgroundView  = viewer
                return 1;
            }
            else{
                let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height - 50))
                noDataLabel.text          = translator("No data available");
                noDataLabel.textColor     = UIColor.lightGray;
                noDataLabel.textAlignment = .center
                tableView.backgroundView  = noDataLabel
                return 0
            }
            
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.popTabl.dropDownTable
        {
            
                return remainingsupermanagersdata.count
            
        }
        
        if section == 0
        {
            
            return  7
            
            
            
        }
        else if section == 1
        {
            if selectedmechrooms.count > 0
            {
                 return selectedmechrooms.count;
            }
            return 1;
            
            
            
           
        }
        else if section == 2
        {
            if selectedmanagers.count > 0
            {
                return selectedmanagers.count
            }
            return 1;
            
            
           
        }
        else if section == 3
        {
            if selectedsupers.count > 0
            {
                 return selectedsupers.count
            }
            return 1;
           
        }
        else if section == 4
        {
            
            return attachedmentData.count
        }
        else if section == 5
        {
            
            return 4;
            
        } else if section == 6
        {
            
            return 2;
        }
        else
        {
            return 0
            
        }
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == self.popTabl.dropDownTable
        {
            return 0;
        }
        if section == 1 || section == 2 || section == 3 || section == 4
        {
            return 35
        }
        else
        {
        
            return 0;
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        
        
        
        let headV = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 23] as! headerViewForEditBuildingCellClass;
        headV.addBtn.tag = section;
        headV.topborder.isHidden = true;
      
        headV.addBtn.myparentVw = headV.addVw;
        switch section {
            
            
              case 1:
               
                 headV.addBtn.addTarget(self, action: #selector(showPopUp(_:)), for: .touchUpInside);
                headV.headTitle.text = "Mechanical Rooms:"
              case 2:
                
                 headV.addBtn.addTarget(self, action: #selector(showPopUp(_:)), for: .touchUpInside);
                 
                headV.headTitle.text = "Building Manager:"
              case 3:
                
                 headV.addBtn.addTarget(self, action: #selector(showPopUp(_:)), for: .touchUpInside);
                 
                headV.headTitle.text = "Building Super:"
              case 4:
                
                 headV.addBtn.addTarget(self, action: #selector(addDocumentlibraryview(_:)), for: .touchUpInside);
                headV.headTitle.text = "Drawings/documents:"
        default:
            
            print("I'm default");
            
        }
        
        
        return headV
        
        
        
    }
    
    @objc func removemanager(_ sender : UIBotton)
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
        
        
        if sender.setTitlein.section == 2
        {
            let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.notes)", preferredStyle: .alert)
             alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil));
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_ ) in
                
                self.selectedmanagers.remove(at: sender.setTitlein.row);
                self.editBuildingTable.reloadData();
                
            }))
           
            self.present(alert, animated: true, completion: nil);
            
            
            
        }
        else if sender.setTitlein.section == 3
        {
            let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete \(sender.notes)", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil));
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_ ) in
                
                self.selectedsupers.remove(at: sender.setTitlein.row);
                self.editBuildingTable.reloadData();
                
            }))
            
            self.present(alert, animated: true, completion: nil);
            
            
        }
        else if sender.setTitlein.section == 4
        {
            
            let alert = UIAlertController.init(title: "Alert!", message: "Are you sure want to delete the document", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "No", style: .default, handler: nil));
            alert.addAction(UIAlertAction.init(title: "Yes", style: .destructive, handler: { (_ ) in
                
                self.attachedmentData.remove(at: sender.setTitlein.row);
                self.editBuildingTable.reloadSections(IndexSet.init(integer: 4), with: .fade);
                
            }))
            
            self.present(alert, animated: true, completion: nil);
            
            
                
          
            
        }
        else
        {
            
            
        }
        
        
    }
    
    @objc func gotoMechroomDetail(_ sender : UIBotton)
    {
        
        
        if Gmenu.count > 4
        {
            let isfull =  Gmenu[4]["isfull"]!
            let isnope =  Gmenu[4]["isnodelete"]!
            let isbred = Gmenu[1]["isread"]!
            
            if isbred == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                return;
            }
            if isfull == "1" ||  isnope == "1"
            {
                
            }
            else
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                return;
            }
            
            
        }
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "DetailCBMechanicalRoomViewController") as! DetailCBMechanicalRoomViewController;
        vselectedmechanicalId = sender.jobstatus;
        vselectedmechtitrle =  sender.notes
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.popTabl.dropDownTable
        {
            let cell = UITableViewCell()
            cell.textLabel?.text = remainingsupermanagersdata[indexPath.row]["name"].stringValue;
            cell.textLabel?.textAlignment = .center
            return cell;
            
            
        }
        
        
        if indexPath.section == 0
        {
            switch indexPath.row
            {
            case 0:
                let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 22] as! BuildingEditUsualCellClass;
                cell.lpadinng.constant  = 25
                cell.headerTitle.text = "Company:";
                cell.headerField.text = BuildDetils["cname"]
                if isinactiveuser
                {
                    cell.headerField.isUserInteractionEnabled = false;
                }
                cell.headerField.placeholder = "Select company"
                cell.headerField.isUserInteractionEnabled = false;
                cell.headerField.textColor = UIColor.lightGray;
                 cell.topborder.isHidden = true;
                return cell;
            case 1:
                
                let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 21] as! AddBuildingInitialCellClass
                cell.headert.text = "Property Code:"
                cell.bottomline.isHidden = true;
                cell.companyfld.text = BuildDetils["Property Code"]
                if isinactiveuser
                {
                    cell.companyfld.isUserInteractionEnabled = false;
                }
                cell.companyfld.placeholder = "Enter property code"
                cell.companyfld.texet = indexPath;
                cell.companyfld.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                  cell.dropdownArrow.isHidden = true;
                cell.loadUI();
                return cell;
                
            case 2:
                let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 22] as! BuildingEditUsualCellClass;
                 cell.lpadinng.constant  = 25
                cell.headerTitle.text = "Address:";
                cell.headerField.text = BuildDetils["Address"]
                if isinactiveuser
                {
                    cell.headerField.isUserInteractionEnabled = false;
                }
                 cell.headerField.placeholder = "Enter address"
                cell.headerField.texet = indexPath;
                cell.headerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                  cell.topborder.isHidden = true;
                return cell;
            case 3:
                let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 22] as! BuildingEditUsualCellClass;
                cell.headerTitle.text = "Address 2:";
                cell.headerField.texet = indexPath;
                if isinactiveuser
                {
                    cell.headerField.isUserInteractionEnabled = false;
                }
                cell.headerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                cell.headerField.placeholder = "Enter address2"
                cell.headerField.text = BuildDetils["Address2"]
                 cell.lpadinng.constant  = 25
                cell.topborder.isHidden = true;
                return cell;
            case 4:
                let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 22] as! BuildingEditUsualCellClass;
                cell.headerTitle.text = "City:";
                 cell.headerField.placeholder = "Enter city"
                if isinactiveuser
                {
                    cell.headerField.isUserInteractionEnabled = false;
                }
                cell.headerField.texet = indexPath;
                cell.headerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                  cell.headerField.text = BuildDetils["City"]
                 cell.lpadinng.constant  = 25
                cell.topborder.isHidden = true;
                return cell;
            case 5:
                let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 22] as! BuildingEditUsualCellClass;
                cell.headerTitle.text = "State:";
                cell.headerField.placeholder = "Select state"
                if isinactiveuser
                {
                    cell.headerField.isUserInteractionEnabled = false;
                }
                cell.headerField.texet = indexPath;
                cell.headerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin);
                
                cell.headerField.inputView = menuDropDown
                
                cell.headerField.text = BuildDetils["State"]
                 cell.lpadinng.constant  = 25
                cell.topborder.isHidden = true;
                return cell;
            case 6:
                let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 22] as! BuildingEditUsualCellClass;
                cell.headerTitle.text = "Zip:";
                 cell.headerField.placeholder = "Enter zipcode"
                if isinactiveuser
                {
                    cell.headerField.isUserInteractionEnabled = false;
                }
                cell.headerField.texet = indexPath;
                cell.headerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                
                cell.headerField.text = BuildDetils["Zip"]
                 cell.lpadinng.constant  = 25
                cell.topborder.isHidden = true;
                return cell;
            default:
                let cell = UITableViewCell()
                return cell;
                
            }
           
            
            
            
            
        }
        else if indexPath.section == 1
        {
            if selectedmechrooms.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "editbuilddeletecell") as! EditBuildingdeleteCellClass
                cell.mechroomdeletebtn.jobstatus = self.selectedmechrooms[indexPath.row]["mid"].stringValue;
                cell.mechroomdeletebtn.notes = self.selectedmechrooms[indexPath.row]["name"].stringValue;
                cell.mechroombtn.jobstatus = self.selectedmechrooms[indexPath.row]["mid"].stringValue;
                  cell.mechroomdeletebtn.addTarget(self, action: #selector(deletemechrooms(_:)), for: .touchUpInside);
                
                cell.mechroombtn.setTitle(self.selectedmechrooms[indexPath.row]["name"].stringValue, for: .normal)
                 cell.mechroombtn.notes = self.selectedmechrooms[indexPath.row]["name"].stringValue;
                cell.mechroombtn.addTarget(self, action: #selector(gotoMechroomDetail(_:)), for: .touchUpInside)
                cell.loadingdefaultUI();
                
                
                return cell;
                
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 50);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                return emptycell;
                
                
            }
            
            
            
            
        }
        else if indexPath.section == 2
        {
            
            if selectedmanagers.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteUserBuildingSupercell") as! DeleteBuildinguSerCelLClass
                cell.buildigusertitlefd.texet = indexPath;
                
                cell.buildigusertitlefd.text = selectedmanagers[indexPath.row]["name"].stringValue;
                cell.buildinguserDeletBtn.jobstatus = selectedmanagers[indexPath.row]["id"].stringValue;
                 cell.buildigusertitlefd.inputView = menuDropDown
                cell.buildigusertitlefd.isUserInteractionEnabled = false;
                
                cell.buildinguserDeletBtn.setTitlein = indexPath;
                cell.buildinguserDeletBtn.notes = selectedmanagers[indexPath.row]["name"].stringValue;
               
                cell.buildinguserDeletBtn.addTarget(self, action: #selector(deleteManagerSuper(_:)), for: .touchUpInside)
                cell.buildigusertitlefd.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin);
                cell.loadingdefaultUI();
                
                
                
                return cell;
                
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 50);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                return emptycell;
                
                
            }
            
           
            
            
            
            
            
        }
        else if indexPath.section == 3
        {
            if selectedsupers.count > 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteUserBuildingSupercell") as! DeleteBuildinguSerCelLClass
                 cell.buildigusertitlefd.texet = indexPath;
                cell.buildigusertitlefd.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin);
                cell.buildigusertitlefd.inputView = menuDropDown
                 cell.buildinguserDeletBtn.jobstatus = selectedsupers[indexPath.row]["id"].stringValue;
                 cell.buildigusertitlefd.isUserInteractionEnabled = false;
                cell.buildigusertitlefd.text = selectedsupers[indexPath.row]["name"].stringValue;
                cell.loadingdefaultUI();
                cell.buildinguserDeletBtn.setTitlein = indexPath;
                  cell.buildinguserDeletBtn.notes = selectedsupers[indexPath.row]["name"].stringValue;
                cell.buildinguserDeletBtn.addTarget(self, action: #selector(deleteManagerSuper(_:)), for: .touchUpInside)
                
                
                return cell;
                
                
            }
            else
            {
                let emptycell = UITableViewCell()
                let emptylab = UILabel();
                emptycell.addSubview(emptylab);
                emptylab.frame = CGRect.init(x: 0, y: 0, width: emptycell.frame.width, height: 50);
                emptylab.text = "No data available";
                emptylab.font =  UIFont.systemFont(ofSize: 14)
                emptylab.textColor = UIColor.lightGray;
                emptylab.textAlignment = .center;
                return emptycell;
                
                
            }
            
            
        }
        else if indexPath.section == 4
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 28] as! chooseFileWithBorderCell
            cell.chooseFile.setTitlein = indexPath;
            cell.title.text = attachedmentData[indexPath.row]["title"]
            cell.title.texet = indexPath;
             cell.chooseFile.setTitle(attachedmentData[indexPath.row]["path"], for: .normal);
            
            cell.deleteBtn.setTitlein = indexPath;
            if isinactiveuser
            {
                cell.chooseFile.isUserInteractionEnabled = false;
                 cell.title.isUserInteractionEnabled = false;
            }
            
            if attachedmentData[indexPath.row]["path"] == ""
            {
                cell.chooseFile.setTitle("Choose File", for: .normal);
            }
            cell.deleteBtn.addTarget(self, action: #selector(removemanager(_:)), for: .touchUpInside)
            cell.title.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
           
            cell.chooseFile.addTarget(self, action: #selector(openGallary(_:)), for: .touchUpInside)
            cell.loadUI();
            return cell;
            
            
        }
        else if indexPath.section == 5
        {
            
           
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 21] as! AddBuildingInitialCellClass
           
            cell.bottomline.isHidden = true;
           
             cell.companyfld.texet = indexPath;
            cell.dropdownArrow.isHidden = true;
            cell.loadUI();
            cell.companyfld.texet = indexPath;
            cell.companyfld.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
            if isinactiveuser
            {
                cell.companyfld.isUserInteractionEnabled = false;
                
            }
            
            switch indexPath.row
            {
            case 0:
                
                 cell.headert.text = "Cluster:"
                   cell.companyfld.text = BuildDetils["cluster"];
               
                
            case 1:
                cell.headert.text = "Location:"
                cell.companyfld.text = BuildDetils["location"];
                
                
            case 2:
                cell.headert.text = "# of Apartments:"
                cell.companyfld.keyboardType = .numberPad;
                cell.companyfld.text = BuildDetils["apartments"];
                
            case 3:
                
                cell.headert.text = "Notes:"
                cell.companyfld.text = BuildDetils["notes"];
                
            default:
                print("I'm default");
                
                
                
            }
            
            return cell;
            
        }
        else if indexPath.section == 6
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 3] as! InspectionsubmitBtncellClass
            cell.loadingDefaultUI();
            cell.saveBtn.layer.cornerRadius = 5.0
            cell.contentView.backgroundColor = .clear;
            cell.backgroundColor = .clear;
            cell.hoBtn.constant = 44.0
            if indexPath.row == 1
            {
                 cell.topPadding.constant = 15;
                cell.saveBtn.backgroundColor = UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0)
                cell.saveBtn.setTitle("Cancel", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside);
                
            }
            else
            {
               
                cell.saveBtn.backgroundColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                cell.saveBtn.setTitle("Update Building", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(SaveAndCloseBtnTapped(_:)), for: .touchUpInside);
                
            }
            return cell
            
            
        }
        else
        {
            let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 15] as! EditBuildingUsualCellClass;
            return cell;
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == self.popTabl.dropDownTable
        {
            return 50;
        }
        
        
        
        
        if indexPath.section == 6
        {
            if indexPath.row == 0
            {
                return 70;
            }
            else{
                return 110
            }
        }
        
        if (indexPath.section == 1)
        {
            return 65;
            
        }
        if   (indexPath.section == 2) || (indexPath.section == 3)
        {
            return 50;
        }
        if (indexPath.section == 0)
        {
            
            let userid = cachem.string(forKey: "userType")!;
            if userid != "0"
            {
                if indexPath.row == 0
                {
                    return 0;
                }
                
            }
            if indexPath.row == 1
            {
                return 75
            }
            return 60;
            
        }
        if indexPath.section  == 5
        {
            return 75;
        }
        if indexPath.section  == 4
        {
            return 110
        }
        
        return 50;
        
        
        
        
        
        
        
    }
    
   
    
 
    
    
    
    var isScrollingDown = true;
    
   
    
    
    
  func callingBuildingDetailData()
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
            let alert = UIAlertController.init(title: "Network Alert!", message: "Please check network connection and try again", preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil);
        }
        // getOfflineBuildingData()
        return;
    }
    
    
     let userid = cachem.string(forKey: "userid")!
    let usertype = cachem.string(forKey: "userType")!;
    
    let buildingdetailapi = "\(vbuildingEditdetailApi)\(userid)/\(usertype)/\(vselectedbuildingId)"
    
    print(buildingdetailapi);
    
    Alamofire.request(buildingdetailapi, method: .get).responseJSON { (resp) in
        
        print(resp);
        print(resp.result);
        
        if resp.result.value != nil && resp.result.isSuccess
        {
            
            print(resp.result.value!)
            let buildinginfo =  JSON(resp.result.value!)
            
              self.buildingDjData = buildinginfo["buildingInfo"];
            
            if self.isfrommechupdate
            {
                self.selectedmechrooms = self.buildingDjData["mechanicals"].arrayValue;
            }
                else if self.isfromSection == 2
            {
                self.selectedmechrooms = self.buildingDjData["mechanicals"].arrayValue;
                 self.managersList = self.buildingDjData["managers"].arrayValue;
                 self.selectedmanagers = self.buildingDjData["bmanagers"].arrayValue;
            }
            else if self.isfromSection == 3
            {
                 self.selectedmechrooms = self.buildingDjData["mechanicals"].arrayValue;
                self.selectedsupers = self.buildingDjData["bsupers"].arrayValue;
                 self.supersList = self.buildingDjData["supers"].arrayValue;
            }
            else
            {
                self.BuildDetils["cname"] = self.buildingDjData["cname"].stringValue;
                self.BuildDetils["Property Code"] = self.buildingDjData["pcode"].stringValue;
                self.BuildDetils["Address"] = self.buildingDjData["address1"].stringValue;
                self.BuildDetils["Address2"] = self.buildingDjData["address2"].stringValue;
                self.BuildDetils["City"] = self.buildingDjData["city"].stringValue;
                self.BuildDetils["State"] = self.buildingDjData["statename"].stringValue;
                self.BuildDetils["statecode"] = self.buildingDjData["statecode"].stringValue;
                
                self.BuildDetils["Zip"] = self.buildingDjData["zip"].stringValue;
                self.BuildDetils["cluster"] = self.buildingDjData["cluster"].stringValue;
                self.BuildDetils["location"] = self.buildingDjData["location"].stringValue;
                self.BuildDetils["apartments"] = self.buildingDjData["apt"].stringValue;
                self.BuildDetils["notes"] = self.buildingDjData["notes"].stringValue;
                
                self.managersList = self.buildingDjData["managers"].arrayValue;
                self.supersList = self.buildingDjData["supers"].arrayValue;
                self.statesLists = self.buildingDjData["states"].arrayValue;
                
                self.selectedmechrooms = self.buildingDjData["mechanicals"].arrayValue;
                self.selectedmanagers = self.buildingDjData["bmanagers"].arrayValue;
                self.selectedsupers = self.buildingDjData["bsupers"].arrayValue;
                
            }
            
            self.isfrommechupdate = false;
            self.isfromSection = -1;
            
            isOfflineMode = false
            
            DispatchQueue.main.async {
                self.editBuildingTable.isHidden = false;
                
                self.hud.hide(animated: true);
            }
            
             self.editBuildingTable.reloadData();
            
            
            
            
            
            
            
        }
        else
        {
            DispatchQueue.main.async {
                
                self.hud.hide(animated: true);
                
            }
            
            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                isOfflineMode = true;
                
                //  self.getOfflineBuildingData()
                
                
            }))
            
            alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                
            }))
            self.present(alert, animated: true, completion: nil);
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    }
   
    
    
    
    
 
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //------Default Func -----
    
    var isinactiveuser = false;
    func loadingDefaultUI()
    {
        
        if Gmenu.count > 1
        {
            let isread =  Gmenu[1]["isread"]!
            
            if isread == "1"
            {
                isinactiveuser = true;
                
                
            }
            
       }
        menuDropDown.backgroundColor = UIColor.black;
        menuDropDown.delegate = self;
        menuDropDown.dataSource = self;
        editBuildingTable.isHidden = true;
        callingBuildingDetailData();
        
        
        CompatibleStatusBar(self.view);
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
    }
    
    
    
}


class EditBuildingheadercell : UITableViewCell
{
    //EditBuildingheadercell
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var addViews: UIView!
    
    
}


class EditBuildingMiddeleCell : UITableViewCell
{
    @IBOutlet weak var underLine: UILabel!
    @IBOutlet weak var middleTitles: UILabel!
    //EditBuildingMiddeleCell
    
    
    
}
class EditBuildingBtnCell: UITableViewCell
{
    
    //EditBuildingBtnCell
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var upperBorder: UILabel!
    
    
    
    
    
    
    
}
class EditBuildingTextBox : UITableViewCell
{
    //EditBuildingTextBox
    
    @IBOutlet weak var textTitle: UITextField!
    
    
    
    
    
    
    
}


class EditBuildingdeleteCellClass : UITableViewCell
{
    
    @IBOutlet weak var mechroombtn: UIBotton!
    @IBOutlet weak var mechroomdeletebtn: UIBotton!
    
    func loadingdefaultUI()
    {
        mechroombtn.layer.cornerRadius = 5.0;
        
        
        
        
    }
    
    
    
}



class DeleteBuildinguSerCelLClass : UITableViewCell
{
    @IBOutlet weak var buildigusertitlefd: UITextFeild!
    @IBOutlet weak var buildinguserDeletBtn: UIBotton!
    @IBOutlet weak var backViw: UIView!
    
    func loadingdefaultUI()
    {
         addGrayBorders([backViw]);
        
    }
    
}
