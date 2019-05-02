//
//  EditAssetEquipmentViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 13/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
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


class EditAssetEquipmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, PECropViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }
   
    @IBOutlet weak var editEquipmentTable: UITableView!
    
    
    var equipmenttestformlist = Array<JSON>();
    var mechanciarlroomslist = Array<JSON>();
    
    
    var companiesList = Array<JSON>();
    var managersList = Array<JSON>();
    
    var supersList = Array<JSON>();
    var mechanialRoomList = [""];
    var companiesdataresp = JSON();
    var statesLists = Array<JSON>();
    var attachedmentData =  [["title":"", "path" : ""]];
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
    var BuildDetils = ["Equiname" : "", "Model" : "",  "Serial" : "",  "Mechanicalroom" : "", "mid" : "", "testform" : "", "testid" : "", "eiid" : ""];
    var hud = MBProgressHUD();
    var equipmentID = "";
    
    
    var choosefileData = [["name":""]];
    var fileChoosenData = Array<Dictionary<String, Any>>();

   
   
    
   
    
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true);
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
        
        if row < pickerDataList.count
        {
            
            generalDropDownField.text = pickerDataList[row]["name"].stringValue;
            
            
            switch generalDropDownField.texet.section
            {
            case 0:
                if generalDropDownField.texet.row == 3
                {
                    
                    BuildDetils["Mechanicalroom"] = pickerDataList[row]["name"].stringValue;
                    BuildDetils["mid"] = pickerDataList[row]["id"].stringValue;
                    
                }
                
                
                
                
            case 2:
                
                
                BuildDetils["testform"] = pickerDataList[row]["name"].stringValue;
                BuildDetils["testid"] = pickerDataList[row]["id"].stringValue;
                
                
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
            
            switch sender.texet.row
            {
            case 0:
                BuildDetils["Equiname"] =  sender.text;
                break;
                
            case 1:
                BuildDetils["Model"] =  sender.text;
                break;
                
            case 2:
                BuildDetils["Serial"] =  sender.text;
                break;
                
            case 3:
                generalDropDownField = sender
                pickerDataList = mechanciarlroomslist;
                menuDropDown.reloadAllComponents();
                print(pickerDataList)
                
                
                break;
            default:
                break;
                
                
            }
            
            break;
        case 1:
            
            
            
            attachedmentData[sender.texet.row]["title"] = sender.text;
            
            
            
            break;
        case 2:
            generalDropDownField = sender
            pickerDataList = equipmenttestformlist;
            menuDropDown.reloadAllComponents();
            
            break;
            
            
        default:
            
            break;
        }
        
        
        
        
        
    }
    
    
    
    @objc func addAttachment(_ sender : UIBotton)
    {
        let addText = NSAttributedString.init(string: "ADD", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.underlineColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0),  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue  ])
        UIView.animate(withDuration: 0.05, animations: {
            sender.backgroundColor = .clear;
            sender.setAttributedTitle(addText, for: .normal);
            self.attachedmentData.append(["title":"", "path" : ""])
        }) { (_) in
            self.editEquipmentTable.reloadData();
            print("reloaded data")
            
        }
        
        
    }
    
    
    @objc func deleteAttachment(_ sender : UIBotton)
    {
        
        let deleteText = NSAttributedString.init(string: "Delete", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray, NSAttributedStringKey.underlineColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0) , NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue ])
        
        UIView.animate(withDuration: 0.05, animations: {
            sender.backgroundColor = .clear;
            sender.setAttributedTitle(deleteText, for: .normal);
           self.attachedmentData.remove(at: sender.tag)
            
        }) { (_) in
            
           self.editEquipmentTable.reloadData();
            
            
        }
         
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 4;
        }
        else if section == 1
        {
            
            return attachedmentData.count
        }
        else if section == 2
        {
            
            return 1;
        }
        else
        {
            return 2;
            
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textfileder = indexPath;
        if indexPath.section == 0
        {
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            
            cell.innerField.texet = textfileder
            cell.loadingDefaultUI();
            
            cell.upperSpace.constant = 5.0;
            // cell.titleLabe.textColor = UIColor.init(hexString: "00A7CF")
            cell.topbarLabel.isHidden = true;
            cell.actIn.isHidden = true;
            cell.addBtn.isHidden = true;
            cell.dropImg.isHidden = true;
            cell.innerField.texet = indexPath;
            if Gmenu.count > 5
            {
                let isread =  Gmenu[5]["isread"]!
                
                if isread == "1"
                {
                    cell.innerField.isUserInteractionEnabled = false;
                }
                
                
            }
            switch indexPath.row
            {
            case 0:
                
                
                cell.titleLabe.text = "Equipment Name :"
                cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                cell.innerField.text = BuildDetils["Equiname"];
                
                
            case 1:
                cell.titleLabe.text = "Model :"
                cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                cell.innerField.text = BuildDetils["Model"];
                
                
            case 2:
                cell.titleLabe.text = "Serial # :"
                cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
                cell.innerField.text = BuildDetils["Serial"];
                
                
            case 3:
                cell.dropImg.isHidden = false;
                cell.titleLabe.text = "Mechanical Room :"
                pickerDataList = mechanciarlroomslist;
                cell.innerField.inputView = menuDropDown;
                cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin);
                cell.innerField.text = BuildDetils["Mechanicalroom"];
                
            default:
                
                print("its default")
                
                
                
            }
            return cell
            
        }
        else if  indexPath.section == 1
        {
            
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            
            cell.innerField.texet = textfileder
            cell.loadingDefaultUI();
            cell.choobtnHt.constant  = 44.0
            cell.upperSpace.constant = 5.0;
            //cell.titleLabe.textColor = UIColor.init(hexString: "00A7CF")
            cell.topbarLabel.isHidden = true;
            cell.dropImg.isHidden = true;
            cell.innerField.texet = indexPath;
            cell.titleLabe.text = "Documents :"
            cell.innerField.text =  attachedmentData[indexPath.row]["title"];
            let choosefilepath = attachedmentData[indexPath.row]["path"];
            cell.chooseFileBtn.setTitle(choosefilepath, for: .normal);
            if choosefilepath!.isEmpty
            {
                cell.chooseFileBtn.setTitle("Choose File  No file choosen", for: .normal);
            }
            cell.chooseFileBtn.addTarget(self, action: #selector(openGallary(_:)), for: .touchUpInside)
            cell.chooseFileBtn.setTitlein = indexPath;
            
            cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
            if Gmenu.count > 5
            {
                let isread =  Gmenu[5]["isread"]!
                
                if isread == "1"
                {
                    cell.chooseFileBtn.isUserInteractionEnabled = false;
                    cell.innerField.isUserInteractionEnabled = false;
                    
                   
                }
                
                
            }
            cell.addBtn.tag = indexPath.row;
            if indexPath.row == attachedmentData.count - 1
            {
                let atext = NSAttributedString.init(string: "ADD", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(red: 29/255, green: 196/255, blue: 5/255, alpha: 1.0), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.styleSingle.rawValue])
                cell.addBtn.setAttributedTitle(atext, for: .normal)
                cell.addBtn.addTarget(self, action: #selector(addAttachment(_:)), for: .touchUpInside);
                cell.actIn.color = UIColor.init(red: 29/255, green: 196/255, blue: 5/255, alpha: 1.0)
                
            }
            else
            {
                let atext = NSAttributedString.init(string: "Delete", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0), NSAttributedString.Key.underlineStyle : NSUnderlineStyle.styleSingle.rawValue])
                cell.addBtn.setAttributedTitle(atext, for: .normal)
                cell.addBtn.addTarget(self, action: #selector(deleteAttachment(_:)), for: .touchUpInside);
                cell.actIn.color = UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0);
                
            }
            cell.loadingDefaultUI();
            return cell;
            
        }
        else if  indexPath.section == 2
        {
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            
            cell.innerField.texet = textfileder
            cell.loadingDefaultUI();
            
            cell.upperSpace.constant = 5.0;
            // cell.titleLabe.textColor = UIColor.init(hexString: "00A7CF")
            cell.topbarLabel.isHidden = true;
            if Gmenu.count > 5
            {
                let isread =  Gmenu[5]["isread"]!
                
                if isread == "1"
                {
                    cell.innerField.isUserInteractionEnabled = false;
                }
                
            }
            
            cell.addBtn.isHidden = true;
            cell.actIn.isHidden = true;
            cell.titleLabe.text = "Set Equipment Test Form :"
            cell.innerField.text = BuildDetils["testform"]
            cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin);
            cell.innerField.texet = indexPath;
            
            pickerDataList = equipmenttestformlist;
            cell.innerField.inputView = menuDropDown;
            
            return cell;
        }
        else if  indexPath.section == 3
        {
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 3] as! InspectionsubmitBtncellClass
            cell.loadingDefaultUI();
            cell.contentView.backgroundColor = .clear;
            cell.hoBtn.constant = 45.0
            cell.backgroundColor = .clear;
            if indexPath.row == 1
            {
                cell.topPadding.constant = 10;
                cell.saveBtn.backgroundColor = UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0)
                cell.saveBtn.setTitle("Cancel", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside);
                
            }
            else
            {
                cell.topPadding.constant =  35;
                cell.saveBtn.backgroundColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                cell.saveBtn.setTitle("Update Equipment", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(SaveAndCloseBtnTapped(_:)), for: .touchUpInside);
                
                
                
                
            }
            return cell
            
        }
        else
        {
            let defaultCell = UITableViewCell()
            return defaultCell;
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 85.0
            
        }
        else if indexPath.section == 1
        {
            
            return 150;
        }
        else if indexPath.section == 2
        {
            
            return 90.0;
        }
            
        else
        {
            if indexPath.row == 0
            {
                return 90
            }
            else
            {
                return 150;
            }
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 85.0
            
        }
        else if indexPath.section == 1
        {
            
            return 150;
        }
        else if indexPath.section == 2
        {
            
            return 90.0;
        }
            
        else
        {
            if indexPath.row == 0
            {
                return 90
            }
            else
            {
                return 150;
            }
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    var imageuploadercount  = 0
    var imageneedtouploaddata = Array<Dictionary<String, String>>();
    
    func checkvalidattionofdata() -> Dictionary<String,String>
    {
        var isvalid = ["isvalid":"1", "msg":""];
        
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
                
                
            }
            else if imagetitle!.isEmpty && imagepath!.isEmpty
            {
                
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
                
                
                return ["isvalid":"0", "msg":imessage];
                
            }
            
            
        }
        
        
        
        
        
        
        
        
        
        let equpme = BuildDetils["Equiname"];
        // let mole = BuildDetils["Model"];
        // let seri = BuildDetils["Serial"];
        let mechnamed = BuildDetils["Mechanicalroom"];
        let testform = BuildDetils["testform"];
        
        
        
        
        
        
        if equpme!.isEmpty
        {
            isvalid = ["isvalid":"0", "msg":"Please enter equipment name"];
            return isvalid;
            
        }
       
        else if mechnamed!.isEmpty
        {
            isvalid = ["isvalid":"0", "msg":"Please select mechanical room"];
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
            
            
            let uid =  localulrimgPath.pathExtension;
            print(uid);
            var uidname = "bid"
            
            
            let userid = UserDefaults.standard
            let user_id =  userid.string(forKey: "userid")
            
            print(uid);
            print(user_id);
            var uploadApiforimg = vEquipmentUploadimageApi;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
            print(uploadApiforimg);
            print("loading to server....");
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "file", fileName: uidname, mimeType: "application");
                
                multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "fileName");
                
                
                
                
            }, to: uploadApiforimg , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        if  response.result.value != nil && response.result.isSuccess{
                            
                            let resp = response.result.value;
                            print(response.result);
                            
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
                                
                                
                                DispatchQueue.main.async(execute: {
                                    self.addBuildingHud.hide(animated: true);
                                    let alert = UIAlertController.init(title: translator("Failed"), message: msg, preferredStyle: .alert);
                                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                    self.present(alert, animated: true, completion: nil);
                                })
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                        }
                            
                            
                            
                        }
                            
                        else
                        {
                            DispatchQueue.main.async(execute: {
                                self.addBuildingHud.hide(animated: true);
                                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unable to save attached file to the server please try again"), preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                            })
                           
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                case .failure(let encodingError):
                    
                    print("eroror \(encodingError)");
                    
                    DispatchQueue.main.async(execute: {
                        self.addBuildingHud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unable to save attached file to the server please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        
                    })
                   
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
        }
        else
        {
            
            let parms = ["eqpdata" : createJSON()];
            print(parms);
            print(vEquipmentUpdateDataApi)
            Alamofire.request(vEquipmentUpdateDataApi, method: .post, parameters: parms).responseJSON { (resp) in
                
                print(resp);
                print(resp.result);
                
                if resp.result.value != nil && resp.result.isSuccess
                {
                    
                    DispatchQueue.main.async(execute: {
                        self.addBuildingHud.hide(animated: true);
                        
                        
                        let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Equipment updated successfully"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            
                            self.navigationController?.popViewController(animated: true);
                            
                            
                        }))
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                    
                    
                    
                    
                }
                else
                {
                    DispatchQueue.main.async(execute: {
                        self.addBuildingHud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                            
                            
                            
                        }))
                        
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                   
                    
                    
                }
                
                
                
            }
            
        }
    }
    
    func createJSON() -> JSON
    {
        var datajson = JSON();
        
        
        
        var dtadict = Dictionary<String, Any>();
        
        let equipmname = BuildDetils["Equiname"];
        let model = BuildDetils["Model"];
        let serial = BuildDetils["Serial"];
        let midd = BuildDetils["mid"];
        
        let equiptestformid = BuildDetils["testid"];
        
        let userid = cachem.string(forKey: "userid")!
        let equipid = BuildDetils["eiid"];
        
        
        
        
        
        
        
        dtadict["userid"] = userid;
        dtadict["eqpname"] = equipmname;
        dtadict["model"] = model
        dtadict["serial"] = serial;
        dtadict["mid"] = midd;
        dtadict["eqptform"] = equiptestformid;
        dtadict["eid"] = equipid;
        
        
        
        
        dtadict["documents"] = imageneedtouploaddata;
        
        
        
        
        datajson = JSON(dtadict);
        
        
        
        
        
        
        
        
        return datajson;
    }
    
    @objc  func SaveAndCloseBtnTapped(_ sender : UIButton)
    {
        
        if Gmenu.count > 5
        {
            let isread =  Gmenu[5]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        
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
        
        let checkNetworks = Reachability()!;
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."
        
        if checkNetworks.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection, would you like to save in local database.", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "cancel", style: .destructive, handler: nil));
                alerts.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    
                    let deleteapidata =    self.createJSON()
                    let jdata =  deleteapidata.description
                    
                    let savestatsu =   saetolocaldatabase(jdata, "updateequipment");
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
    
    
    
    func getequipmentrelationData()
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
                
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check your network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil)
            }
            
            return;
        }
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vEquipmentEditDetailDataApi)\(userid)/\(usertype)/\(equipmentID)"
        print(Buildingapi);
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                
                
                
                isOfflineMode = false
                let fdata = resultdata["eqpinfo"]
                self.equipmenttestformlist = fdata["eqps"].arrayValue;
                self.mechanciarlroomslist = fdata["mechs"].arrayValue;
                
                
                
               self.BuildDetils["testform"] =  fdata["effname"].stringValue;
                self.BuildDetils["testid"] =  fdata["eupid"].stringValue;
                    
                
                
                
                   self.BuildDetils["Equiname"] = fdata["title"].stringValue;
                self.BuildDetils["Model"] = fdata["model"].stringValue;
                self.BuildDetils["Serial"] = fdata["serial"].stringValue;
                self.BuildDetils["Mechanicalroom"] = fdata["mtitle"].stringValue;
                self.BuildDetils["mid"] = fdata["mid"].stringValue;
                self.BuildDetils["eiid"] = fdata["id"].stringValue;

 
                
                
                DispatchQueue.main.async {
                    self.editEquipmentTable.reloadData();
                    self.editEquipmentTable.isHidden = false;
                    self.hud.hide(animated: true);
                }
                
                
                
                
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again."), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        
                        self.getequipmentrelationData();
                        
                        // self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
              
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    //----- Default Func ----
    
    func loadingDefaultUI(){
        
        getequipmentrelationData();
        
        menuDropDown.backgroundColor = UIColor.black;
        menuDropDown.delegate = self;
        menuDropDown.dataSource = self;
        
        self.editEquipmentTable.isHidden = true;
        
       CompatibleStatusBar(self.view);
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
        
        
        
    }
    
    
    
    
    
    

}
