//
//  AddBuildingViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
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


class AddBuildingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, PECropViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingDefaultUI()
    }
    
    
    var companiesList = Array<JSON>();
    var managersList = Array<JSON>();
    var supersList = Array<JSON>();
    var mechanialRoomList = [""];
    var companiesdataresp = JSON();
    var statesLists = Array<JSON>();
    var BuildDetils = ["Property Code" : "", "Address" : "",  "Address2" : "",  "City" : "", "State" : "", "Zip" : "", "cluster" : "", "location":"", "apartments" : "", "notes":"", "statecode":""];
    var mechanicalRoomData = [["name":""]];
    var BuildigSuperDta = [["name":"", "id" : ""]];
   
    var BuildingManagersData = [["name":"", "id":""]];
    
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
    
    @IBOutlet weak var addBuildingTable: UITableView!
    
    
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
              BuildigSuperDta = [["name":"", "id" : ""]];
              BuildingManagersData = [["name":"", "id":""]];
               selectedcompnaytiutle = pickerDataList[row]["name"].stringValue;
            self.managersList = pickerDataList[row]["managers"].arrayValue;
            self.supersList = pickerDataList[row]["supers"].arrayValue;
           selectedcompnay =  pickerDataList[row]["id"].stringValue;
            DispatchQueue.main.async {
                
                self.addBuildingTable.reloadData();
                
            }
            
        case 1:
           BuildDetils["State"] =  pickerDataList[row]["name"].stringValue;
            BuildDetils["statecode"] =  pickerDataList[row]["id"].stringValue;
            
        case 2:
            
            mechanicalRoomData[generalDropDownField.texet.row]["name"] =  pickerDataList[row]["name"].stringValue;
            
        case 3:
           BuildigSuperDta[generalDropDownField.texet.row]["name"] = pickerDataList[row]["name"].stringValue;
             BuildigSuperDta[generalDropDownField.texet.row]["id"] = pickerDataList[row]["id"].stringValue;
           
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
            
            pickerDataList = companiesList;
            menuDropDown.reloadAllComponents();
            generalDropDownField = sender;
            
            break;
        case 1:
            
           if sender.texet.row == 0
           {
            BuildDetils["Property Code"] = sender.text;
           }
           else if sender.texet.row == 1
           {
            BuildDetils["Address"] = sender.text;
           }
           else if sender.texet.row == 2
           {
            BuildDetils["Address2"] = sender.text;
           }
           else if sender.texet.row == 3
           {
            BuildDetils["City"] = sender.text;
           }
           else if sender.texet.row == 4
           {
            pickerDataList = statesLists;
            menuDropDown.reloadAllComponents();
            generalDropDownField = sender;
            
           }
           else if sender.texet.row == 5
           {
            BuildDetils["Zip"] = sender.text;
           }
            
           else{
            print("default")
            
           }
            
            
            
            
           
            break;
        case 2:
            
            
             mechanialRoomList[sender.tag] = sender.text!;
            
            
            
            break;
        case 3:
            if selectedcompnay == "-1"
            {
               sender.endEditing(true);
                let alertw = UIAlertController.init(title: "Alert!", message: "Please select company field", preferredStyle: .alert);
                alertw.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: { (_) in
                    
                    
                }))
                self.present(alertw, animated: true, completion: nil);
                
            }
            else
            {
                var mysuperdata = [JSON]();
                for i in 0..<supersList.count
                {
                    let superslistid = supersList[i]["id"].stringValue
                    var ismatched = false;
                    for l in 0..<BuildigSuperDta.count
                    {
                        
                        let buildingsuperdtaid = BuildigSuperDta[l]["id"];
                        if superslistid == buildingsuperdtaid
                        {
                            ismatched = true;
                            
                        }
                        
                    }
                    if !ismatched
                    {
                        mysuperdata.append( supersList[i])
                        
                    }
                    
                    
                }
                 pickerDataList = mysuperdata;
                menuDropDown.reloadAllComponents();
                generalDropDownField = sender;
            }
            
            
            break;
        case 4:
            if selectedcompnay == "-1"
            {
                 sender.endEditing(true);
                let alertw = UIAlertController.init(title: "Alert!", message: "Please select company field", preferredStyle: .alert);
                alertw.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: { (_) in
                    
                   
                }))
                self.present(alertw, animated: true, completion: nil);
                
            }
            else
            {
                var mymanagersdata = [JSON]();
                for i in 0..<managersList.count
                {
                    let superslistid = managersList[i]["id"].stringValue
                    var ismatched = false;
                    for l in 0..<BuildingManagersData.count
                    {
                        
                        let buildingsuperdtaid = BuildingManagersData[l]["id"];
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
            }
           
            
            
            
            
            break;
            
        case 5:
          
            attachedmentData[sender.texet.row]["title"] = sender.text
            
            break;
        case 6:
            
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
    
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 1
        }
        if section == 1
        {
            return 6
        }
        else if section == 2
        {
            
            return mechanialRoomList.count;
        }
        else if section == 3
        {
            
            return BuildigSuperDta.count;
        }
        else if section == 4
        {
            
            return BuildingManagersData.count;
        }
        else if section == 5
        {
            
            return attachedmentData.count;
        }
        else if section == 6
        {
            
            return 4;
        }
        else if section == 7
        {
            
            return 2;
        }
        else
        {
            return 1
            
        }
        
        
        
    }
    
    
   
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
            self.addBuildingTable.reloadData();
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
            
            self.addBuildingTable.reloadData();
            
            
        }
        
        
        
       
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textfileder = indexPath;
        
        if indexPath.section == 0
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 21] as! AddBuildingInitialCellClass
            cell.companyfld.text = "";
            cell.companyfld.texet = indexPath;
            cell.companyfld.placeholder = "Please select company";
            pickerDataList = companiesList
            cell.companyfld.tag = indexPath.row;
            
            cell.companyfld.inputView = menuDropDown;
            cell.companyfld.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin)
            let usertype = cachem.string(forKey: "userType")!;
            if(usertype == "0")
            {
                
                
                cell.companyfld.isUserInteractionEnabled = true;
                cell.companyfld.textColor = UIColor.darkGray;
                cell.companyfld.text = selectedcompnaytiutle;
                
                
                
                
            }
            else{
                if(companiesList.count > 0)
                {
                    let cdta = companiesList[0]["name"].stringValue;
                      cell.companyfld.text = cdta;
                    selectedcompnay = companiesList[0]["id"].stringValue;
                    
                    self.managersList = companiesList[0]["managers"].arrayValue;
                    self.supersList = companiesList[0]["supers"].arrayValue;
                    
                    
                    
                }
                
                cell.companyfld.isUserInteractionEnabled = false;
                 cell.companyfld.textColor = UIColor.lightGray;
                
                
            }
            cell.loadUI();
            return cell;
            
            
        }
        if indexPath.section == 1
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 25] as! CommonRoundTextFieldCellClass
            cell.innerTextField.texet = textfileder
            cell.loadUI();
            cell.viewWidthCostr.constant = self.view.frame.width - 30
            cell.topLabel.isHidden = true;
           
            
            switch indexPath.row
            {
            case 0:
                cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
                cell.viewWidthCostr.constant = self.view.frame.width * 0.7 - 30;
                cell.titleLabel.text =  "Property Code*:";
                cell.innerTextField.text = BuildDetils["Property Code"];
                cell.imgWth.constant = 0.0
                
                
                return cell
                
            case 1:
                cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
                cell.imgWth.constant = 0.0
                cell.innerTextField.text = BuildDetils["Address"]
                cell.titleLabel.text =    "Address*:"
                return cell
                
            case 2:
                cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
                cell.imgWth.constant = 0.0
                cell.innerTextField.text = BuildDetils["Address2"]
                cell.titleLabel.text =   "Address2:"
                return cell
                
            case 3:
                cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
                 cell.imgWth.constant = 0.0
                cell.innerTextField.text = BuildDetils["City"]
                cell.titleLabel.text =  "City*:"
                return cell
                
            case 4:
                cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin)
                cell.imgWth.constant = 25.0;
                cell.innerTextField.text = BuildDetils["State"]
                cell.viewWidthCostr.constant = self.view.frame.width * 0.7 - 30
                cell.titleLabel.text = "State*:"
                
                cell.innerTextField.inputView = menuDropDown;
                
                cell.dropImg.isHidden = false;
                return cell
                
            case 5:
                cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
                cell.imgWth.constant = 0.0
                cell.innerTextField.text = BuildDetils["Zip"]
                cell.viewWidthCostr.constant = self.view.frame.width * 0.7 - 30
                cell.titleLabel.text = "Zip*:"
                cell.innerTextField.keyboardType = .numbersAndPunctuation;
                return cell
                
            default:
                
                
                let defaultCell = UITableViewCell()
                return defaultCell;
                
                
            }
            
        }
        else if  indexPath.section == 2
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            cell.titleLabe.text = "Mechanical Room:";
            cell.imgwt.constant = 0;
            
            cell.addBtn.setTitlein = indexPath;
            
            cell.loadingDefaultUI();
            
            cell.addBtn.tag = indexPath.row;
            cell.addBtn.hasTag = 1;
            
            cell.innerField.tag = indexPath.row;
            cell.innerField.text = mechanialRoomList[indexPath.row];
           
            if Gmenu.count > 4
            {
                let isfull =  Gmenu[4]["isfull"]!
                let isnope =  Gmenu[4]["isnodelete"]!
                if isfull == "1" ||  isnope == "1"
                {
                   
                }
                else
                {
                    cell.backvw.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor;
                    cell.addBtn.isUserInteractionEnabled = false;
                    cell.innerField.isUserInteractionEnabled = false;
                }
                
                
            }
            
            cell.innerField.texet = indexPath;
        
            cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged);
            let deleteText = NSAttributedString.init(string: "Delete", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0) , NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue ])
            
            
            let addText = NSAttributedString.init(string: "ADD", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0),  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue  ])
            
            
            
            if indexPath.row == mechanialRoomList.count - 1
            {
                cell.addBtn.addTarget(self, action: #selector(addMechanicalRoom(_:)), for: .touchUpInside)
                DispatchQueue.main.async {
                     cell.actIn.color = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                    
                }
               
                cell.addBtn.setAttributedTitle(addText, for: .normal)
                
                
                
            }
            else
            {
                cell.addBtn.setAttributedTitle(deleteText, for: .normal)
                DispatchQueue.main.async {
                   cell.actIn.color = .red;
                }
                
                
                cell.addBtn.addTarget(self, action: #selector(removeRoow(_:)), for: .touchUpInside);
            }
            
            
            if indexPath.row  == 0
            {
                cell.topbarLabel.isHidden  = false;
            }
            else
            {
                cell.topbarLabel.isHidden  = true;
                
            }
            
            
            return cell;
            
        }
            
        else if  indexPath.section == 3
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            
            cell.titleLabe.text = "Building Super:";
            
            if selectedcompnay == "-1"
            {
                cell.innerField.inputView = UIView();
            }
            else
            {
                cell.innerField.inputView = menuDropDown;
            }
            
            cell.addBtn.setTitlein = indexPath
            cell.loadingDefaultUI();
            
            cell.addBtn.tag = indexPath.row;
            cell.addBtn.hasTag = 2
            cell.innerField.text = BuildigSuperDta[indexPath.row]["name"]
            cell.innerField.texet = indexPath;
            cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin)
            let deleteText = NSAttributedString.init(string: "Delete", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0) , NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue ])
            
            
            let addText = NSAttributedString.init(string: "ADD", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0),  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue  ])
            
            
            
            if indexPath.row == BuildigSuperDta.count - 1
            {
                cell.addBtn.addTarget(self, action: #selector(addMechanicalRoom(_:)), for: .touchUpInside)
                cell.addBtn.setAttributedTitle(addText, for: .normal)
                DispatchQueue.main.async {
                    cell.actIn.color = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                    
                }
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    cell.actIn.color = UIColor.red
                    
                }
                
                cell.addBtn.setAttributedTitle(deleteText, for: .normal)
                cell.addBtn.addTarget(self, action: #selector(removeRoow(_:)), for: .touchUpInside);
            }
            
            
            
            cell.topbarLabel.isHidden  = true;
            
            
            
            
            
            
            return cell;
            
        }
        else if  indexPath.section == 4
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            
            if selectedcompnay == "-1"
            {
                cell.innerField.inputView = UIView();
            }
            else
            {
                cell.innerField.inputView = menuDropDown;
            }
            
            cell.titleLabe.text = "Building Manager:";
            cell.addBtn.setTitlein = indexPath
            
            cell.loadingDefaultUI();
            cell.addBtn.tag = indexPath.row;
            cell.addBtn.hasTag = 3
            cell.innerField.text = BuildingManagersData[indexPath.row]["name"]
            cell.innerField.texet = indexPath;
            cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingDidBegin)
            
            let deleteText = NSAttributedString.init(string: "Delete", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0) , NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue ])
            
            
            let addText = NSAttributedString.init(string: "ADD", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0),  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue  ])
            
            
            
            if indexPath.row == BuildingManagersData.count - 1
            {
                
                
                
                DispatchQueue.main.async {
                    cell.actIn.color = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                    
                }
                
                
                cell.addBtn.addTarget(self, action: #selector(addMechanicalRoom(_:)), for: .touchUpInside)
                cell.addBtn.setAttributedTitle(addText, for: .normal)
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    cell.actIn.color = UIColor.red
                    
                }
                
                cell.addBtn.setAttributedTitle(deleteText, for: .normal)
                cell.addBtn.addTarget(self, action: #selector(removeRoow(_:)), for: .touchUpInside);
            }
            
            cell.topbarLabel.isHidden  = true;
            
            
            
            
            
            
            return cell;
            
        }
        else if  indexPath.section == 5
        {
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 20] as! commonAddDeleteCellClass
            
            cell.titleLabe.text = "Drawings/Documents:";
            cell.loadingDefaultUI();
            cell.dropImg.isHidden = true;
            cell.addBtn.setTitlein = indexPath
            
            
            
            
            cell.addBtn.tag = indexPath.row;
            cell.addBtn.hasTag = 4
            cell.innerField.text = attachedmentData[indexPath.row]["title"]
            cell.innerField.texet = indexPath;
            cell.innerField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
             cell.chooseFileBtn.setTitle(attachedmentData[indexPath.row]["path"], for: .normal);
            if attachedmentData[indexPath.row]["path"] == ""
            {
                cell.chooseFileBtn.setTitle("Choose File", for: .normal);
            }
             cell.chooseFileBtn.addTarget(self, action: #selector(openGallary(_:)), for: .touchUpInside);
            cell.chooseFileBtn.setTitlein = indexPath;
            
            let deleteText = NSAttributedString.init(string: "Delete", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 172/255, green: 0, blue: 2/255, alpha: 1.0) , NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue ])
            
            
            let addText = NSAttributedString.init(string: "ADD", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0), NSAttributedStringKey.underlineColor : UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0),  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue  ])
            
            
            
            if indexPath.row == attachedmentData.count - 1
            {
                DispatchQueue.main.async {
                    cell.actIn.color = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                    
                }
                
                cell.addBtn.addTarget(self, action: #selector(addMechanicalRoom(_:)), for: .touchUpInside)
                cell.addBtn.setAttributedTitle(addText, for: .normal)
                
            }
            else
            {
                DispatchQueue.main.async {
                    cell.actIn.color = UIColor.red
                    
                }
                
                cell.addBtn.setAttributedTitle(deleteText, for: .normal)
                cell.addBtn.addTarget(self, action: #selector(removeRoow(_:)), for: .touchUpInside);
            }
            
            
            if indexPath.row == 0
            {
                cell.topbarLabel.isHidden  = false;
                
            }
            else
            {
                cell.topbarLabel.isHidden  = true;
            }
            
            
            
            return cell;
            
        }
        else if  indexPath.section == 6
        {
            
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 25] as! CommonRoundTextFieldCellClass
            
            cell.innerTextField.texet = textfileder
            cell.innerTextField.texet = indexPath;
            cell.innerTextField.addTarget(self, action: #selector(gettingTableViewFieldText(_:)), for: .editingChanged)
            cell.imgWth.constant = 0.0;
            cell.loadUI();
            cell.viewWidthCostr.constant = self.view.frame.width - 30;
            
            if indexPath.row == 0
            {
                cell.topLabel.isHidden = false;
            }
            else
            {
                cell.topLabel.isHidden = true;
                
            }
           
            switch indexPath.row
            {
            case 0:
                
                cell.innerTextField.text = BuildDetils["cluster"]
                cell.titleLabel.text = "Cluster:"
                
                return cell
            case 1:
                 cell.innerTextField.text = BuildDetils["location"]
                cell.titleLabel.text =   "Location:"
                
                return cell
            case 2:
                cell.innerTextField.text = BuildDetils["apartments"]
                cell.titleLabel.text =   "# of Apartments:"
                cell.innerTextField.keyboardType = .numberPad;
                
                return cell
            case 3:
                cell.innerTextField.text = BuildDetils["notes"]
                cell.titleLabel.text =  "Notes:"
                
                let bottomline = UIView();
                cell.contentView.addSubview(bottomline);
                bottomline.frame = CGRect.init(x: 0, y: 93, width: self.view.frame.width, height: 2);
                bottomline.backgroundColor = UIColor.lightGray;
                
                
                return cell
            default:
                return cell
            }
            
            
            
        }
            
        else if  indexPath.section == 7
        {
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 3] as! InspectionsubmitBtncellClass
            cell.loadingDefaultUI();
            
            cell.contentView.backgroundColor = .clear;
            cell.backgroundColor = .clear;
            cell.hoBtn.constant = 44.0
            cell.saveBtn.layer.cornerRadius = 8.0
            if indexPath.row == 1
            {
                cell.topPadding.constant = 15
                cell.saveBtn.backgroundColor = UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0)
                cell.contentView.backgroundColor = UIColor.clear;
                cell.backgroundColor = UIColor.clear;
                cell.saveBtn.setTitle("Cancel", for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside);
                
            }
            else
            {
                cell.topPadding.constant = 25
                cell.contentView.backgroundColor = UIColor.clear;
                cell.backgroundColor = UIColor.clear;
                cell.saveBtn.backgroundColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                cell.saveBtn.setTitle("Create Building", for: .normal)
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
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0
        {
            
            return 85;
            
        }
        if indexPath.section == 1
        {
            
            return 80;
            
        }
        else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4
        {
            
            return 95
            
            
        }
        else if indexPath.section == 5
        {
            
            return 165;
        }
        else if indexPath.section == 6
        {
            
            if indexPath.row == 3
            {
                return 95;
            }
            return 85;
            
            
        }
        else
        {
            if indexPath.row == 0
            {
                return 80;
            }
            else
            {
                return 150;
            }
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0
        {
            
            return 85;
            
        }
        if indexPath.section == 1
        {
            
            return 80;
            
        }
        else if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4
        {
            
            return 95
            
            
        }
        else if indexPath.section == 5
        {
            
            return 160;
        }
        else if indexPath.section == 6
        {
            
            if indexPath.row == 3
            {
                return 95;
            }
            return 85;
            
            
        }
        else
        {
            if indexPath.row == 0
            {
                return 80;
            }
            else
            {
                return 150;
            }
            
            
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
        print("jflksjlfkjsf");
        print(imageneedtouploaddata);
        
        
        if selectedcompnay == "-1"
        {
            isvalid = ["isvalid":"0", "msg":"Please select company field"];
            return isvalid;
        
        }
        
        else if address!.isEmpty
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
            var imagepath = imageneedtouploaddata[imageuploadercount]["path"]!
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
            
            var uploadApiforimg = vbuildingfileupload;
            
            if uid == "mp4"
            {
                uidname = uidname + "." + uid;
                uploadApiforimg = vMp4videouploadingapi;
                
            }
             print(uploadApiforimg);
            print(uid);
            print(uidname);
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
            Alamofire.request(vsavebuildingApi, method: .post, parameters: parms).responseJSON { (resp) in

                print(resp);
                print(resp.result);

                if resp.result.value != nil
                {

                    print(resp.result.value)
                    let resultdata =  resp.result.value! as! NSDictionary
                    let statuscode = resultdata["status"] as! Int
                    if statuscode == 200
                    {
                        isOfflineMode = false;
                        refreshdata = true;
                        
                        DispatchQueue.main.async {
                            self.addBuildingHud.hide(animated: true);
                            let message = resultdata["message"] as! String
                            let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully added building"), preferredStyle: .alert);
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
        
        
        
        
        dtadict["documents"] = imageneedtouploaddata;
        
        var buildingsuperids = Array<String>();
        var buildingmanagersids = Array<String>();
         var buildingmechanicallas = Array<String>();
        
        
        
        
        
        
        
        for i in 0..<mechanialRoomList.count
        {
            let mechdata = mechanialRoomList[i].replacingOccurrences(of: " ", with: "");
            if !mechdata.isEmpty
            {
                buildingmechanicallas.append(mechdata);
                
            }
            
            
            
        }
        dtadict["mechanicals"] = buildingmechanicallas;
        for i in 0..<BuildigSuperDta.count
        {
            let superid = BuildigSuperDta[i]["id"];
            if !superid!.isEmpty
            {
                buildingsuperids.append(superid!);
                
            }
            
            
            
        }
        dtadict["supers"] = buildingsuperids;
        
        for i in 0..<BuildingManagersData.count
        {
            let mid = BuildingManagersData[i]["id"];
            if !mid!.isEmpty
            {
                buildingmanagersids.append(mid!);
                
            }
            
            
            
        }
        dtadict["supers"] = buildingsuperids;
        dtadict["managers"] = buildingmanagersids;
        
        
        
        
        datajson = JSON(dtadict);
        
        
        
        
        
        
        
        
        return datajson;
    }
    
    
    
    
   
   @objc  func SaveAndCloseBtnTapped(_ sender : UIButton)
   {
   
    let checkNetworks = Reachability()!;
    addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
    addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    addBuildingHud.bezelView.color = UIColor.white;
    self.addBuildingHud.label.text = "Loading..."
    
    
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
                
            
                let jdata =  self.createJSON();
                
              let savestatsu =   saetolocaldatabase(jdata.description, "addbuilding");
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
    
    //------Default Func -----
    
    
    func loadingDefaultUI()
    {
        
        
        menuDropDown.backgroundColor = UIColor.black;
        menuDropDown.dataSource = self;
        menuDropDown.delegate = self;
        menuDropDown.reloadAllComponents();
        CompatibleStatusBar(self.view);
        
        
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        callingStateCompanyList()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
    
    
    func getofflineStateCompanyList()
    {
        
       
        
        
        
    }
    
    
    func callingStateCompanyList()
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
        
        let companylists = "\(vcompanystateList)\(userid)/\(usertype)";
        
        Alamofire.request(companylists, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                print(resp.result.value)
                let resultdata =  JSON(resp.result.value!);
                
                
                    isOfflineMode = false
                
                    self.companiesList = resultdata["companies"].arrayValue;
                
                    self.statesLists = resultdata["states"].arrayValue;
                
                
                
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.addBuildingTable.reloadData();
                        self.addBuildingHud.hide(animated: true);
                    }
                    
                    
                    
                    
                    
               
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.addBuildingHud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_) in
                        self.callingStateCompanyList();
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
}




