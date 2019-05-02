//
//  AddInspectionSheetViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
import FMDB
import MobileCoreServices
import PEPhotoCropEditor



class AddInspectionSheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentMenuDelegate, UIDocumentPickerDelegate, PECropViewControllerDelegate, UITextFieldDelegate{
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingDefaultUI();
        
    }
    
    
    @IBOutlet weak var inspectionTable: UITableView!
    var IspectionId = -1;
    var pickedButton = UIBotton()
      var choosefileCounter = IndexPath.init(row: 0, section: 0);
    var EditingDropDown : UITextFeild? = nil
    
    var arrayDropDown = Array<UITextFeild>()
    var isfromvone = false;
    
    
    var textAreaId = IndexPath.init(row: 0, section: 0);
    let menuPicker = UIPickerView()
    var pickedImage = UIImageView()
    var demoChooseBtn = UIBotton();
    
    
    
    func showToast(message : String, sender : UIView) {
        let toastLabel = UILabel();
        self.view.addSubview(toastLabel)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false;
        toastLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        toastLabel.trailingAnchor.constraint(equalTo: sender.trailingAnchor).isActive = true;
        toastLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        toastLabel.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true;
        
       // let toastLabel = UILabel(frame: CGRect(x: sender.frame.width - 75, y: -(sender.frame.height), width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2
        {
        let charSet = CharacterSet.letters
        print(string);
        if string == " "
        {
            
            return true
        }
        if string.rangeOfCharacter(from: charSet.inverted) != nil
        {
            showToast(message: "Invalid Key", sender: textField);
            return false;
        }
        
        
        return true;
        }
        else
        {
            
            let numSet = CharacterSet.alphanumerics
            
          
            print(string);
            if string == " "
            {
                
                return true
            }
            if string.rangeOfCharacter(from: numSet.inverted) != nil
            {
                showToast(message: "Invalid Key", sender: textField);
                return false;
            }
            
            
            return true;
            
            
            
        }
    }
    
    
    
    
    
    var pickerData  = Array<String>();
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 ;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row < pickerData.count
        {
        if EditingDropDown != nil
        {
            
        var sectiondataarra = loadedData[EditingDropDown!.texet.section];
        let comm = EditingDropDown!.texet.row;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        fielddata[comm]["mytitle"] = pickerData[row]
        sectiondataarra["fields"] = fielddata
        loadedData[EditingDropDown!.texet.section] = sectiondataarra
            EditingDropDown!.text = pickerData[row]
            
        }
        }
        
    }
    
    
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
     let textv = textView as! UITxtView
        
        var sectiondataarra = loadedData[textv.textId.section];
        let comm = textv.textId.row;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        fielddata[comm]["mytitle"] = textView.text
        sectiondataarra["fields"] = fielddata
        loadedData[textv.textId.section] = sectiondataarra
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    
    @objc  func radioBtnTapped(_ sender : UIBotton)
    {
        sender.isSelected = true;
        let allData = sender.IradioBtns
        for i in 0..<allData.count
        {
            allData[i].isSelected = false;
            
            
        }
        
        
        
        
        var sectiondataarra = loadedData[sender.setTitlein.section];
        let comm = sender.setTitlein.row;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        
        fielddata[comm]["mytitle"] =  sender.notes;
        sectiondataarra["fields"] = fielddata
        loadedData[sender.setTitlein.section] = sectiondataarra
        
        
    }
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        pickerView.backgroundColor = .black;
        let title =  pickerData[row];
        
        let astring = NSAttributedString.init(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]);
        return astring;
        
    }
    
    
    @objc  func checkBoxTapped(_ sender : UIBotton)
    {
        
        
        sender.isSelected = !sender.isSelected;
        
        
        if sender.isSelected
        {
            
            
            
            var sectiondataarra = loadedData[sender.setTitlein.section];
            let comm = sender.setTitlein.row;
            var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
            

            var arrayOfCheckBox = fielddata[comm]["mytitle"] as? Dictionary<String, Any>;
            if arrayOfCheckBox != nil
            {
                
                arrayOfCheckBox![sender.jobstatus] = sender.notes;
                fielddata[comm]["mytitle"]  = arrayOfCheckBox;
            }
            else
            {
                print("nodata..")
                var emptyarray = Dictionary<String, Any>();
                emptyarray[sender.jobstatus] = sender.notes;
                fielddata[comm]["mytitle"] = emptyarray;
                
                
                
            }
            
 
            
            sectiondataarra["fields"] = fielddata
            
            loadedData[sender.setTitlein.section] = sectiondataarra
            
        }
        
        else
        {
            
            var sectiondataarra = loadedData[sender.setTitlein.section];
            let comm = sender.setTitlein.row;
            var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
            var arrayOfCheckBox = fielddata[comm]["mytitle"] as? Dictionary<String, Any>;
            
            if arrayOfCheckBox != nil
            {
                arrayOfCheckBox!.removeValue(forKey: sender.jobstatus);
                fielddata[comm]["mytitle"]  = arrayOfCheckBox;
            }
            else
            {
                let emptyarray = Dictionary<String, Any>();
                fielddata[comm]["mytitle"] = emptyarray;
                
            }
            
            
            sectiondataarra["fields"] = fielddata
            
            loadedData[sender.setTitlein.section] = sectiondataarra
            
            
            
        }
        
        
        
        
        
        
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
            //self.pickedImage = sender.hederImg!
            imagpicker.sourceType = .camera
            imagpicker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
            // self.pickedButton = sender;
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
            //self.pickedImage = sender.hederImg!
            imagpicker.sourceType = .photoLibrary;
            imagpicker.mediaTypes = [kUTTypeImage as String, kUTTypeLivePhoto as String]
           // self.pickedButton = sender;
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil);
        
    }
    
   
    
    var testdata : Data? = nil
    
    
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
         testdata = ImgeData!
         
            
         
          
         
         let tdate = Date();
         let dateformer = DateFormatter();
         dateformer.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let dateStr = dateformer.string(from: tdate);
         var imageName = "InspectionSheet_" + dateStr  + ".png";
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
            
            
            
            
            controller.dismiss(animated: true, completion: nil);
         demoChooseBtn.setTitle(specificPath, for: .normal)
         var sectiondataarra = loadedData[ self.choosefileCounter.section ];
         let comm = self.choosefileCounter.row;
         var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
         fielddata[comm]["mytitle"] = specificPath
         sectiondataarra["fields"] = fielddata
         loadedData[self.choosefileCounter.section] = sectiondataarra
         
          
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
        
        let file_Path = "InspectionSheet_" +  dateStr + myURL.lastPathComponent;
        
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

        
        
        
        

        
        
        demoChooseBtn.setTitle(savedfilePath, for: .normal)
        var sectiondataarra = loadedData[ self.choosefileCounter.section ];
        let comm = self.choosefileCounter.row;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        fielddata[comm]["mytitle"] = savedfilePath
        sectiondataarra["fields"] = fielddata
        loadedData[self.choosefileCounter.section] = sectiondataarra
        
        
        
        
        
        
        print("picked")
    }
    
    
    
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        
        present(documentPicker, animated: true, completion: nil)
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc  func cancelTapped(_ sender : UIButton)
    {
        
        self.navigationController?.popViewController(animated: true);
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  section == loadedData.count ||  section == loadedData.count + 1
        {
            
            return 1 ;
        }
        
        let sectiondataarra = loadedData[section]
        let fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        
        
        return fielddata.count
    }
    
    
    
    @objc func gettingTheTextEnteredByTextField(_ sender : UITextFeild)
    {
        
        var sectiondataarra = loadedData[sender.texet.section];
        let comm = sender.texet.row;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        fielddata[comm]["mytitle"] = sender.text
        sectiondataarra["fields"] = fielddata
        loadedData[sender.texet.section] = sectiondataarra
        
        
        
        
    }
    @objc func gettingDropDownTextField(_ sender : UITextFeild)
    {
        
        
        var sectiondataarra = loadedData[sender.texet.section];
        let comm = sender.texet.row;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        let optionString =  fielddata[comm]["ioptions"] as! String
        let options1 = optionString.components(separatedBy: "\n");
        var options = Array<String>();
        for l in 0..<options1.count
        {
            let mydataoption = options1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "");
            if mydataoption != ""
            {
                options.append(options1[l].replacingOccurrences(of: "\r", with: ""));
            }
        }
        
        EditingDropDown = sender;
        
        
        pickerData = options
       
             menuPicker.reloadAllComponents();
        
       
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        
        if indexPath.section == loadedData.count ||  indexPath.section == loadedData.count + 1
        {
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 3] as! InspectionsubmitBtncellClass
            
            
            if isfromvone
            {
                cell.saveBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                cell.hoBtn.constant = 44.0
                
                
                
            }
            
            cell.loadingDefaultUI();
            if indexPath.section == loadedData.count + 1
            {
                cell.saveBtn.backgroundColor = UIColor.init(red: 192/255, green: 0, blue: 2/255, alpha: 1.0)
                cell.saveBtn.setTitle(translator("Cancel") , for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside);
                
            }
            else
            {
                cell.saveBtn.backgroundColor = UIColor.init(red: 32/255, green: 191/255, blue: 5/255, alpha: 1.0)
                cell.saveBtn.setTitle(translator("Save and Close"), for: .normal)
                cell.saveBtn.addTarget(self, action: #selector(SaveAndCloseBtnTapped(_:)), for: .touchUpInside);
                
                
                
                
            }
            return cell
        }
        
        var sectiondataarra = loadedData[indexPath.section]
        let textfileder = indexPath;
        var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        let fieldtype = fielddata[indexPath.row]["itype"] as! String
        
       
        
        
        
        
        
        switch fieldtype {
        case "1":
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 1] as! InspectionTextFieldCellClass
             cell.innerTextField.texet = textfileder
             cell.underline.isHidden = false;
            if isfromvone
            {
//                cell.saveBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
//                cell.hoBtn.constant = 44.0
                cell.innerTextField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
                
            }
            
            
            
            let placeHoldy = fielddata[indexPath.row]["label"] as?  String
            if placeHoldy != nil
            {
                cell.innerTextField.placeholder = Apitranslator(placeHoldy!, GconvertInspectionTest);
            }
            
            
            
            if fielddata[indexPath.row]["mytitle"] != nil
            {
                let mytiteley = fielddata[indexPath.row]["mytitle"] as!  String
                cell.innerTextField.text =   mytiteley;
              
            }
            else
            {
                let idfvalue = fielddata[indexPath.row]["idefault"] as? String
                if idfvalue != nil
                {
                    fielddata[indexPath.row]["mytitle"] = idfvalue!
                    cell.innerTextField.text =   idfvalue!;
                    sectiondataarra["fields"]  = fielddata
                    
                    loadedData[indexPath.section] = sectiondataarra
                }
            }
            
             cell.innerTextField.addTarget(self, action: #selector(gettingTheTextEnteredByTextField(_:)), for: .editingChanged);
            
            if fielddata.count == indexPath.row + 1
            {
                
                cell.underline.isHidden = true;
                
            }
            
            let keybType : Int? = fielddata[indexPath.row]["valid"] as? Int
            switch keybType
            {
                
            case 1:
                print("test1")
                cell.innerTextField.keyboardType = .decimalPad;
                cell.innerTextField.delegate  = nil
                
                
            case 2:
                cell.innerTextField.keyboardType = .alphabet;
                cell.innerTextField.delegate = self;
                cell.innerTextField.tag = 2
                 print("test2")
                
            case 3:
                cell.innerTextField.keyboardType = .alphabet;
                cell.innerTextField.delegate = self;
                cell.innerTextField.tag = 3
                print("test3")
                
            case nil:
                 cell.innerTextField.keyboardType = .default;
                cell.innerTextField.delegate  = nil
                
            default:
                cell.innerTextField.keyboardType = .default;
                cell.innerTextField.delegate  = nil
                
                
            }
            
            
            
            
            
            
            
            
            return cell
            
        case "2":
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier] as! InspectionDropdownncellClass
            cell.dropDownField.texet = textfileder
            menuPicker.backgroundColor = .black;
            cell.dropDownField.inputView = menuPicker;
            
            if isfromvone
            {
                //                cell.saveBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                //                cell.hoBtn.constant = 44.0
                cell.dropDownField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
                
            }
             let placeHoldy = fielddata[indexPath.row]["label"] as?  String
            if placeHoldy != nil
            {
                cell.dropDownField.placeholder =  Apitranslator(placeHoldy!, GconvertInspectionTest);
                
            }
            
            
            
            if fielddata[indexPath.row]["mytitle"] != nil
            {
                cell.dropDownField.text = fielddata[indexPath.row]["mytitle"] as?  String
                
            }
            else
            {
                let idfvalue = fielddata[indexPath.row]["idefault"] as? String
                if idfvalue != nil
                {
                    fielddata[indexPath.row]["mytitle"] = idfvalue!
                    cell.dropDownField.text =   idfvalue!;
                     sectiondataarra["fields"]  = fielddata
                    
                    loadedData[indexPath.section] = sectiondataarra
                }
            }
            cell.dropDownField.addTarget(self, action: #selector(gettingDropDownTextField(_:)), for: .editingDidBegin);
           
           
            
            
            
            return cell
            
            
        case "3":
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 4] as! InspectioncheckBoxcellClass
            
            
            
            
            var firstBtns = [UIBotton]();
            
            var radiosViews = [IncheckBoxView]();
            let opt = fielddata[indexPath.row]["ioptions"] as! String
            
            let mytitle = indexPath;
            let optTitles1 = opt.components(separatedBy: "\n");
            var optTitles = Array<String>();
            for l in 0..<optTitles1.count
            {
                let splittedata =  optTitles1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
                if splittedata != ""
                {
                    optTitles.append(optTitles1[l].replacingOccurrences(of: "\r", with: ""))
                }
                
            }
            
            
            
            
            if optTitles.count >= 2
            {
                
                
                
                let totaldoubleRows = optTitles.count / 2 ;
                let totalSingleRows = optTitles.count % 2 ;
                
                let totalViews = totaldoubleRows
                var heightfromtop = 35
                for j in 0..<totalViews
                {
                    print(totalViews);
                    let checkBoxViwe = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 7] as!  IncheckBoxView;
                    checkBoxViwe.frame = CGRect.init(x: 35, y: heightfromtop, width: Int(self.view.frame.width - 70), height: 40);
                    
                    heightfromtop =  heightfromtop + 40;
                    cell.contentView.addSubview(checkBoxViwe);
                    radiosViews.append(checkBoxViwe);
                    firstBtns.append(checkBoxViwe.firstBtn)
                    firstBtns.append(checkBoxViwe.secondBtn)
                    checkBoxViwe.firstBtn.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
                    checkBoxViwe.secondBtn.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
                    
                    
                    
                    if j == (totalViews - 1)
                    {
                        if totalSingleRows != 0
                        {
                            
                            let checkBoxViwe = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 7] as!  IncheckBoxView;
                            checkBoxViwe.frame = CGRect.init(x: 35, y: heightfromtop, width: Int(self.view.frame.width - 70), height: 40);
                            
                            heightfromtop =  heightfromtop + 40;
                            cell.contentView.addSubview(checkBoxViwe);
                            radiosViews.append(checkBoxViwe);
                            firstBtns.append(checkBoxViwe.firstBtn)
                            
                            checkBoxViwe.secondBtn.isHidden = true;
                            checkBoxViwe.secondBtn.isEnabled = false;
                            checkBoxViwe.firstBtn.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
                            
                            
                            
                            
                        }                    }
                    
                }
                
            }
            else if optTitles.count == 1
            {
                
                    var heightfromtop = 35
                    let checkBoxViwe = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 7] as!  IncheckBoxView;
                    checkBoxViwe.frame = CGRect.init(x: 35, y: heightfromtop, width: Int(self.view.frame.width - 70), height: 40);
                    
                    heightfromtop =  heightfromtop + 40;
                    cell.contentView.addSubview(checkBoxViwe);
                    radiosViews.append(checkBoxViwe);
                    firstBtns.append(checkBoxViwe.firstBtn)
                    
                    checkBoxViwe.secondBtn.isHidden = true;
                    checkBoxViwe.secondBtn.isEnabled = false;
                    checkBoxViwe.firstBtn.addTarget(self, action: #selector(checkBoxTapped(_:)), for: .touchUpInside)
                    
                    
                    
              }
            
            for j in 0..<firstBtns.count
            {
                
                
                let eachBtn = firstBtns[j];
                let btnTtile =  optTitles[j];
                eachBtn.notes = btnTtile
                if isfromvone
                {
                    eachBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                    //                cell.hoBtn.constant = 44.0
                    
                    cell.checkBoxTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                    
                }
                eachBtn.setTitle(Apitranslator(btnTtile, GconvertInspectionTest), for: .normal);
                eachBtn.setTitlein = mytitle;
                eachBtn.jobstatus = String(j)
                if fielddata[indexPath.row]["mytitle"] != nil
                {
                    let selectedOne = fielddata[indexPath.row]["mytitle"] as!  Dictionary<String, Any>
                    if selectedOne[eachBtn.jobstatus] != nil
                    {
                        eachBtn.isSelected = true;
                    }
                }
                else
                {
                    
                    
                    let idfvalue = fielddata[indexPath.row]["idefault"] as? String
                    if idfvalue != nil
                    {
                        if (btnTtile == idfvalue)
                        {
                            var emptyarray = Dictionary<String, Any>();
                            emptyarray[eachBtn.jobstatus] = idfvalue;
                            fielddata[indexPath.row]["mytitle"] = emptyarray
                            eachBtn.isSelected = true;
                            
                            sectiondataarra["fields"]  = fielddata
                            loadedData[indexPath.section] = sectiondataarra
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                
                
                
            }
            let checkboxTitle =  fielddata[indexPath.row]["label"] as?  String
            if checkboxTitle != nil
            {
                cell.checkBoxTitle.text = Apitranslator(checkboxTitle!, GconvertInspectionTest)
            }
            
            
            
            
            
            
            
            return cell
            
            
           
            
           
        case "4":
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 5] as! InspectionRadiocellClass
            
            
            
             var firstBtns = [UIBotton]();
            
             var radiosViews = [ExtraRadioView]();
            let opt = fielddata[indexPath.row]["ioptions"] as! String
           
            let mytitle = indexPath;
            let optTitles1 = opt.components(separatedBy: "\n");
            var optTitles = Array<String>();
            for l in 0..<optTitles1.count
            {
                let splittedata =  optTitles1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
                if splittedata != ""
                {
                    optTitles.append(optTitles1[l].replacingOccurrences(of: "\r", with: ""))
                }
                
            }
            
            
            
            if optTitles.count >= 2
            {
               
                
                
                let totaldoubleRows = optTitles.count / 2 ;
                let totalSingleRows = optTitles.count % 2 ;
                
                let totalViews = totaldoubleRows
                var heightfromtop = 40
                for j in 0..<totalViews
                {
                    print(totalViews);
                    let radioview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 6] as!  ExtraRadioView;
                    radioview.frame = CGRect.init(x: 35, y: heightfromtop, width: Int(self.view.frame.width - 70), height: 40);
                    
                    heightfromtop =  heightfromtop + 40;
                    cell.contentView.addSubview(radioview);
                    radiosViews.append(radioview);
                    firstBtns.append(radioview.firstRadioBtn)
                     firstBtns.append(radioview.secondRadioBtn)
                    radioview.firstRadioBtn.addTarget(self, action: #selector(radioBtnTapped(_:)), for: .touchUpInside)
                    radioview.secondRadioBtn.addTarget(self, action: #selector(radioBtnTapped(_:)), for: .touchUpInside)
                  
                    
                    
                    if j == (totalViews - 1)
                    {
                        if totalSingleRows != 0
                        {
                            let radioview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 6] as!  ExtraRadioView;
                            radioview.frame = CGRect.init(x: 35, y: heightfromtop, width: Int(self.view.frame.width - 70), height: 40);
                            
                            heightfromtop =  heightfromtop + 40;
                        radioview.secondRadioBtn.isHidden = true;
                        radioview.secondRadioBtn.isEnabled = false;
                            cell.contentView.addSubview(radioview);
                            radiosViews.append(radioview);
                        firstBtns.append(radioview.firstRadioBtn)
                         
                        radioview.firstRadioBtn.addTarget(self, action: #selector(radioBtnTapped(_:)), for: .touchUpInside)
                        radioview.secondRadioBtn.addTarget(self, action: #selector(radioBtnTapped(_:)), for: .touchUpInside)
                        
                        }                    }
                    
                 }
                
                
                for j in 0..<firstBtns.count
                {
                    
                    
                    let eachBtn = firstBtns[j];
                    if isfromvone
                    {
                        eachBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                        //                cell.hoBtn.constant = 44.0
                        
                       cell.radioTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                        
                    }
                    eachBtn.notes = optTitles[j]
                    eachBtn.setTitle(Apitranslator(optTitles[j], GconvertInspectionTest) , for: .normal);
                    eachBtn.setTitlein = mytitle;
                    if fielddata[indexPath.row]["mytitle"] != nil
                    {
                        let selectedOne = fielddata[indexPath.row]["mytitle"] as!  String
                        if eachBtn.notes == selectedOne
                        {
                            eachBtn.isSelected = true;
                        }
                    }
                    else
                    {
                        
                       let idfvalue = fielddata[indexPath.row]["idefault"] as? String
                         if idfvalue != nil
                          {
                           fielddata[indexPath.row]["mytitle"] = idfvalue!
                            
                            if eachBtn.notes == idfvalue!
                            {
                                 sectiondataarra["fields"]  = fielddata
                                loadedData[indexPath.section] = sectiondataarra
                                eachBtn.isSelected = true;
                            }
                         }
                    }
                    
                    
                    for i in 0..<firstBtns.count
                    {
                    
                        if i != j
                        {
                            eachBtn.IradioBtns.append(firstBtns[i]);
                            
                        }
                        
                       
                        
                        
                    }
                    
                    
                    
                    
                }
                
            }
            let myRadioLab = fielddata[indexPath.row]["label"] as?  String
            if myRadioLab != nil
            {
                cell.radioTitle.text = Apitranslator(myRadioLab!, GconvertInspectionTest);
            }
            
           
            
            
            return cell
            
            
        case "5":
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 2] as! InspectiontextAreacellClass
            cell.textareaField.textId = indexPath
            cell.textareaField.delegate = self;
            
            let headerlabb =  fielddata[indexPath.row]["label"] as?  String
            
            if headerlabb != nil
            {
                cell.textareaTitle.text = Apitranslator(headerlabb!, GconvertInspectionTest);
            }
            
            if isfromvone
            {
                
                //                cell.hoBtn.constant = 44.0
                
                 cell.textareaTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                 
                cell.textareaField.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            }
            
            textAreaId = indexPath
            if fielddata[indexPath.row]["mytitle"] != nil
            {
                cell.textareaField.text =  fielddata[indexPath.row]["mytitle"] as?  String;
            }
            else
            {
                let idfvalue = fielddata[indexPath.row]["idefault"] as? String
                if idfvalue != nil
                {
                    fielddata[indexPath.row]["mytitle"] = idfvalue!
                     sectiondataarra["fields"]  = fielddata
                    loadedData[indexPath.section] = sectiondataarra
                    cell.textareaField.text =   idfvalue!;
                    
                }
            }
             return cell
            
        case "9":
            
            
            let cell  = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 10] as! chooseUsualFileCell
            cell.loadingDefaultUI();
            cell.chooseBtn.setTitlein  = indexPath
            let myimageLabb = fielddata[indexPath.row]["label"] as?  String
            if myimageLabb != nil
            {
                cell.headLab.text = Apitranslator(myimageLabb!, GconvertInspectionTest);
            }
            if isfromvone
            {
                cell.hoBtn.constant = 44.0
                //                cell.hoBtn.constant = 44.0
                cell.headLab.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                cell.chooseBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
                
            }
          
            cell.chooseBtn.setTitle(translator("Choose File"), for: .normal);
            cell.chooseBtn.addTarget(self, action: #selector(openGallary(_:)), for: .touchUpInside);
            if fielddata[indexPath.row]["mytitle"] != nil
            {
                let filePath = fielddata[indexPath.row]["mytitle"] as!  String
                
                cell.chooseBtn.setTitle( filePath, for: .normal);
            }
            
            return cell
           
            
            
            
        default:
            let cell  = UITableViewCell();
            
            
            return cell
            
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.section == loadedData.count ||  indexPath.section == loadedData.count + 1
        {
            if indexPath.section == loadedData.count + 1
            {
                return 90
            }
            
            return 70;
        }
        
        let sectiondataarra = loadedData[indexPath.section]
        let fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        let fieldtype = fielddata[indexPath.row]["itype"] as! String
        switch fieldtype {
        case "1":
            return 60
        case "2":
            
            return 60
            
        case "3":
            
            let opt = fielddata[indexPath.row]["ioptions"] as! String
            
            let optTitles1 = opt.components(separatedBy: "\n");
            var optTitles = Array<String>();
            for l in 0..<optTitles1.count
            {
                let splittedata =  optTitles1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
                if splittedata != ""
                {
                    optTitles.append(optTitles1[l].replacingOccurrences(of: "\r", with: ""))
                }
                
            }
            let totaldoubleRows = optTitles.count / 2 ;
            let totalSingleRows = optTitles.count % 2
            
            
            return CGFloat(((totaldoubleRows + totalSingleRows) * 40) + 50 );
            
        case "4":
            
            let opt = fielddata[indexPath.row]["ioptions"] as! String
            let optTitles1 = opt.components(separatedBy: "\n");
            var optTitles = Array<String>();
            for l in 0..<optTitles1.count
            {
                let splittedata =  optTitles1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
                if splittedata != ""
                {
                    optTitles.append(optTitles1[l].replacingOccurrences(of: "\r", with: ""))
                }
                
            }
            
            
            let totaldoubleRows = optTitles.count / 2 ;
            let totalSingleRows = optTitles.count % 2
            
            
            return CGFloat(((totaldoubleRows + totalSingleRows) * 40) + 50 );
            
        case "5":
            
            return 80
            
        case "9":
            
            return 115;
            
        default :
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  indexPath.section == loadedData.count ||  indexPath.section == loadedData.count + 1
        {
            if indexPath.section == loadedData.count + 1
            {
                return 90
            }
            
            return 70;
        }
        
        let sectiondataarra = loadedData[indexPath.section]
        let fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
        let fieldtype = fielddata[indexPath.row]["itype"] as! String
        switch fieldtype {
        case "1":
            return 60
        case "2":
            
            return 60
            
        case "3":
            
            let opt = fielddata[indexPath.row]["ioptions"] as! String
            
            let optTitles1 = opt.components(separatedBy: "\n");
            var optTitles = Array<String>();
            for l in 0..<optTitles1.count
            {
                let splittedata =  optTitles1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
                if splittedata != ""
                {
                    optTitles.append(optTitles1[l].replacingOccurrences(of: "\r", with: ""))
                }
                
            }
            let totaldoubleRows = optTitles.count / 2 ;
            let totalSingleRows = optTitles.count % 2
            
            
            return CGFloat(((totaldoubleRows + totalSingleRows) * 40) + 50 );
            
        case "4":
            
            let opt = fielddata[indexPath.row]["ioptions"] as! String
            let optTitles1 = opt.components(separatedBy: "\n");
            var optTitles = Array<String>();
            for l in 0..<optTitles1.count
            {
                let splittedata =  optTitles1[l].replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
                if splittedata != ""
                {
                    optTitles.append(optTitles1[l].replacingOccurrences(of: "\r", with: ""))
                }
                
            }
            
            
            let totaldoubleRows = optTitles.count / 2 ;
            let totalSingleRows = optTitles.count % 2
            
            
            return CGFloat(((totaldoubleRows + totalSingleRows) * 40) + 50 );
            
        case "5":
            
            return 80
            
        case "9":
            
            return 115;
            
        default :
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView =  Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier - 2] as! SuperInspectionHeaderView
        let sectiondataarra = loadedData[section]
        let fielddata = sectiondataarra["head"] as?  String
        if fielddata != nil
        {
            headerView.headtitle.text = Apitranslator(fielddata!, GconvertInspectionTest);
        }
        
        if isfromvone
        {
            
            //                cell.hoBtn.constant = 44.0
            headerView.headtitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            
        }
        return headerView;
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return loadedData.count + 2
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        if   section == loadedData.count ||   section == loadedData.count + 1
        {
            
            
            return 0;
        }
        return 50;
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if   section == loadedData.count ||   section == loadedData.count + 1
        {
            
            
            return 0;
        }
        return 50;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    var sectionData = Dictionary<String, Any>()
    var loadedData = [Dictionary<String, Any>]();
    
     var attachmentData = Array<Dictionary<String, Any>>()
    
    
    
    
    
    @objc func SaveAndCloseBtnTapped(_ sender : UIButton)
    {
    
        
        uploadingCounterRow = 0;
        uploadingCountersection = 0;
        var status = 2;
       
        for i in 0..<loadedData.count
        {
            
            
            
            
            let  mediator = loadedData[i]["fields"] as! Array<Dictionary<String, Any>>
            
            for j in 0..<mediator.count
            {
                
                
                let midator2 = mediator[j]
                 let isrequired = midator2["required"] as! String
                if isrequired != "N"
                {
                    
                    
                    let type = midator2["itype"] as! String
                    switch type {
                    case "1":
                        
                        
                        if midator2["mytitle"] != nil
                        {
                            let meidaotrtitle = midator2["mytitle"] as! String
                            if meidaotrtitle == ""
                            {
                                var filed = midator2["label"] as! String
                                filed = Apitranslator(filed, GconvertInspectionTest);
                                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed , preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                                status = 1
                                 break;
                            }
                            
                            
                            
                        }
                        else
                        {
                            var filed = midator2["label"] as! String
                            filed = Apitranslator(filed, GconvertInspectionTest);
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            status = 1
                            
                              break;
                        }
                        
                        
                        
                        
                    case "2":
                        
                        
                        if midator2["mytitle"] != nil
                        {
                            let meidaotrtitle = midator2["mytitle"] as! String
                            if meidaotrtitle == ""
                            {
                                var filed = midator2["label"] as! String
                                filed = Apitranslator(filed, GconvertInspectionTest);
                                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                                status = 1
                                break;
                            }
                            
                            
                            
                        }
                        else
                        {
                            var filed = midator2["label"] as! String
                            filed = Apitranslator(filed, GconvertInspectionTest);
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            status = 1
                            break;
                        }
                        
                        
                        
                        
                    case "3":
                        
                        
                        if midator2["mytitle"] != nil
                        {
                            let mydataArray =  midator2["mytitle"] as! Dictionary<String, Any>;
                            if mydataArray.count > 0
                            {
                                
                            }
                            else
                            {
                                var filed = midator2["label"] as! String
                                filed = Apitranslator(filed, GconvertInspectionTest);
                                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                                status = 1
                                break;
                                
                            }
                            
                            
                        }
                        else
                        {
                            var filed = midator2["label"] as! String
                            filed = Apitranslator(filed, GconvertInspectionTest);
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            status = 1
                            break;
                            
                        }
                        
                        
                    case "4":
                        
                        
                        
                        if midator2["mytitle"] != nil
                        {
                            
                            
                            
                            
                        }
                        else
                        {
                            var filed = midator2["label"] as! String
                            filed = Apitranslator(filed, GconvertInspectionTest);
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            status = 1
                            break;
                        }
                        
                        
                        
                    case "5":
                        
                        if midator2["mytitle"] != nil
                        {
                            let meidaotrtitle = midator2["mytitle"] as! String
                            if meidaotrtitle == ""
                            {
                                var filed = midator2["label"] as! String
                                filed = Apitranslator(filed, GconvertInspectionTest);
                                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                                status = 1
                                break;
                            }
                            
                            
                            
                        }
                        else
                        {var filed = midator2["label"] as! String
                            filed = Apitranslator(filed, GconvertInspectionTest);
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            status = 1
                            break;
                        }
                        
                        
                        
                    case "9":
                        
                        
                        
                        if midator2["mytitle"] != nil
                        {
                            let meidaotrtitle = midator2["mytitle"] as! String
                            if meidaotrtitle == ""
                            {
                                var filed = midator2["label"] as! String
                                filed = Apitranslator(filed, GconvertInspectionTest);
                                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                self.present(alert, animated: true, completion: nil);
                                status = 1
                                break;
                            }
                            
                            
                            
                        }
                        else
                        {
                            var filed = midator2["label"] as! String
                            filed = Apitranslator(filed, GconvertInspectionTest);
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields ") + filed, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            status = 1
                            break;
                        }
                        
                        
                        
                    default:
                        print("Im default ");
                    }
                    
                    
                    
                    
                    
                    
                }
               
                
                
                
                
                
            }
            
            
            if status == 1
            {
                break;
            }
            
            
            
            
        }
        
        
        if status == 2
        {

            hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            
            uploadingCountersection = 0;
            uploadingCounterRow = 0;
            
            let uploadReacher = Reachability()!;
            if uploadReacher.connection != .none
            {
                uploadingAttachment()
            }
            else
            {
                saveData();
                
            }
 
            

            
            
            
            
            
            
            
        }
       
    
    }
    
    
    
    
    
    
   
    
    var uploadingCountersection = 0;
    var uploadingCounterRow = 0;
    
    
    
    
    
    func uploadingAttachment()
    {
       
        
        if uploadingCountersection < loadedData.count
        {
        
        
                    var sectiondataarra = loadedData[uploadingCountersection]
                    var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
            
        if uploadingCounterRow < fielddata.count
        
        {
                
                
                
             
                    let fieldtype = fielddata[uploadingCounterRow]["itype"] as! String
                    let midator2 = fielddata[uploadingCounterRow]
            
        
        if fieldtype == "9"
        {
        print("its 9 got 9")
            if midator2["mytitle"] != nil
            {
                let meidaotrtitle = midator2["mytitle"] as! String
                if meidaotrtitle != ""
                {
 
                    
                    print(meidaotrtitle);
                    
                     
                    let dtaim = fileManag.contents(atPath: meidaotrtitle);
                    
                    if dtaim != nil
                    {
                        print("converted inot data")
                    }
                    else
                    {
                        print("got conversion error");
                        return;
                    }
                    
                   // "application/pdf"
                    let localulrimgPath = URL.init(fileURLWithPath: meidaotrtitle)
                    //let sname = localulrimgPath.lastPathComponent;
                    
                    let uid = localulrimgPath.pathExtension;
                    print(uid);


                    let userid = UserDefaults.standard
                    let user_id =  userid.string(forKey: "userid")
                    
                    print(uid);
                    print(user_id);
                    
                    print("loading to server....");
                    
                    Alamofire.upload(multipartFormData: { ( multiData ) in
                        
                        multiData.append(dtaim!, withName: "file", fileName: "test", mimeType: "application");
                       
                        multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "firstName");
                        
                        
                        
                        
                    }, to: imageUploadAPI , method: .post ) { (resp) in
                        
                   // imageUploadAPI
                    //http://192.168.1.37/upload.php
                     
                  
                     
                     print(resp)
                     switch resp {
                     case .success(let upload, _, _):
                     
 
                        
                     upload.responseJSON { response in
                      
                        
                     if let resp = response.result.value {
                      
                        
                        print(response.result);
                        
                        print(response.result.value)
                        
                        let midiatr = JSON(resp);
                        
                        let respStatus = midiatr["scode"].intValue;
                        print(respStatus)
                        if respStatus == 200
                        {
                            
                            
                            let  path = midiatr["filePath"].stringValue
                            
                            var sectiondataarra = self.loadedData[ self.uploadingCountersection ];
                            let comm = self.uploadingCounterRow;
                            
                            var fielddata = sectiondataarra["fields"] as! Array<Dictionary<String, Any>>
                            fielddata[comm]["mytitle"] = path
                            sectiondataarra["fields"] = fielddata
                            self.loadedData[self.uploadingCountersection] = sectiondataarra
                            
                            self.uploadingCounterRow =   self.uploadingCounterRow + 1;
                            
                            self.uploadingAttachment()
                            
                        }
                        else
                        {
                            let  msg = midiatr["message"].stringValue
                           
                            print("Error exist here");
                            
                            
                            
                            self.hud.hide(animated: true);
                            let alert = UIAlertController.init(title: translator("Failed"), message: msg, preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            self.present(alert, animated: true, completion: nil);
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                            
                            
                            
                        }
                        
                        else
                     {
                         self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unable to save attached file to the server please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        }
                        
                            
                        
                        
                        
                      
                        
                        
                        
                        
                     
                     }
                        
                        
                        
                     
                        
                        
                        
                     case .failure(let encodingError):
                      
                        print("eroror \(encodingError)");
                     
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Unable to save attached file to the server please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        
                        
                        
                        
                     
                     
                     }
                     
                     
                        
                        
                        
                        
                        
                        
                     
                     }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    uploadingCounterRow =   uploadingCounterRow + 1;
                    self.uploadingAttachment()
                    
                }
                
                
                
            }
            else
            {
                uploadingCounterRow =   uploadingCounterRow + 1;
                self.uploadingAttachment()
                
            }
            
            
            
            
        }
            else
        {
            uploadingCounterRow =   uploadingCounterRow + 1;
            self.uploadingAttachment()
            
            
            }
            
            
            
            
            }
            else
        {
            
            uploadingCounterRow = 0;
            uploadingCountersection =   uploadingCountersection + 1;
             self.uploadingAttachment()
            
            
            }
            
            
            
            
        
        }
        else
        {
            
            saveData();
            
        }
        
        
        
        
       
        
    }
    
    
    
    
    
    
    
    
    
    
    
    var hud = MBProgressHUD.init();
    
    func saveData()
    {
        
        
        
        
         print(loadedData);
        
        var params =  Dictionary<String, Any>()
        
        var arrayatfid =  Dictionary<String, String>()
        var aftype =  Dictionary<String, String>()
         var valuesDatas = Dictionary<String, Any>()
        var requiredType = Dictionary<String, String>()
        var attitleData = Dictionary<String, String>()
        
         var inspectionParametes =  Dictionary<String, Any>()
        
        
        print(loadedData.count);
        print("save data");
        
        
        for i in 0..<loadedData.count
        {
            
            let  mediator = loadedData[i]["fields"] as! Array<Dictionary<String, Any>>
            
           print("(mediatorcount)")
            print(mediator.count);
            print(i);
            for j in 0..<mediator.count
            {
                 var fieldid2 = Dictionary<String, String>()
                let fieldid = String(mediator[j]["id"] as! Int)
                 fieldid2[fieldid] = fieldid;
                 arrayatfid[fieldid] = fieldid;
                
                
                var aftypemedi2 = Dictionary<String, String>()
                let aftypemedi = mediator[j]["itype"] as! String
                 aftypemedi2[fieldid] = aftypemedi;
                aftype[fieldid] = aftypemedi;
                
                
                
                
                
                var requiredSym = Dictionary<String, String>()
                let requiredsymData = mediator[j]["required"] as! String
                requiredSym[fieldid] = requiredsymData;
                requiredType[fieldid] = requiredsymData;
                
                
                
                
                var valuesfromfield = Dictionary<String, Any>()
                
                
                
                
                
                var titleat = Dictionary<String, String>()
                var titleatData = "";
                
                switch aftypemedi
                {
                case "3":
                   
                    var vuldimdiator = Dictionary<String, Any>();
                    
                    if mediator[j]["mytitle"] != nil
                    {
                        vuldimdiator = mediator[j]["mytitle"] as! Dictionary<String, Any>;
                    }
                    
                     titleatData = mediator[j]["label"] as! String
                    valuesfromfield[fieldid] = vuldimdiator;
                    valuesDatas[fieldid] = vuldimdiator;
                    
                    
                case "4":
                    
                    
                   let genderData = mediator[j]["mytitle"] as? String
                   
                   if genderData != nil
                   {
                    valuesfromfield[fieldid] = genderData
                    valuesDatas[fieldid] = genderData;
                    titleatData = mediator[j]["label"] as! String
                   }
                   else
                   {
                    valuesDatas[fieldid] = "";
                    
                   }
                   
                    
                    
                case "2":
                    
                    
                    let genderData = mediator[j]["mytitle"] as? String
                    
                    if genderData != nil
                    {
                        valuesfromfield[fieldid] = genderData
                        valuesDatas[fieldid] = genderData;
                        titleatData = mediator[j]["label"] as! String
                    }
                    else
                    {
                        valuesDatas[fieldid] = "";
                        
                    }
                   
                    
                case "5":
                    let textareamdiat = mediator[j]["mytitle"] as? String
                    if textareamdiat != nil
                    {
                        valuesfromfield[fieldid] = textareamdiat
                        valuesDatas[fieldid] = textareamdiat;
                        titleatData = mediator[j]["label"] as! String
                    }
                    else
                    {
                        valuesDatas[fieldid] = "";
                        
                    }
                    
                case "1":
                     
                    let textareamdiat = mediator[j]["mytitle"] as? String
                    if textareamdiat != nil
                    {
                    valuesfromfield[fieldid] = textareamdiat
                     valuesDatas[fieldid] = textareamdiat;
                    titleatData = mediator[j]["label"] as! String
                    }
                    else
                    {
                        valuesDatas[fieldid] = "";
                        
                    }
                    
                case "9":
                    print("its 9")
                    
                    
                    let textareamdiat = mediator[j]["mytitle"] as? String
                    if textareamdiat != nil
                    {
                        valuesfromfield[fieldid] = textareamdiat
                        valuesDatas[fieldid] = textareamdiat;
                        titleatData = mediator[j]["label"] as! String
                        
                        
                        
                    }
                    else
                    {
                        valuesDatas[fieldid] = ""
                        
                    }
                default:
                    print("its default");
                    
                }
                
                titleat[fieldid] = titleatData;
                 attitleData[fieldid] = titleatData;
                
                
                
               
               
               
                
                
            }
            
            
        }
        
        let datewForm = DateFormatter()
        datewForm.dateFormat = "MM-dd-yyyy HH:mm:ss"
        
        let tdate = datewForm.string(from: Date());
        
        var dateAn = Dictionary<String, String>();
            dateAn["inspection_date"] = tdate;
          params["inspection_date"] = tdate;
        
        
        var mechData = Dictionary<String, Int>();
        mechData["mech_id"] = mechanicalRoomID;
         params["mech_id"] = mechanicalRoomID;
        
         
        let userid = UserDefaults.standard
       let user_id =  userid.string(forKey: "userid")
        
        params["user_id"] = user_id!
            
            
            
        var inspectionId = Dictionary<String, Int>();
        inspectionId["inspection_id"] = inspectionIDG;
        params["inspection_id"] = inspectionIDG;
        
        
        var atfid = Dictionary<String, Any>();
        atfid["atfid"] = arrayatfid;
        params["atfid"] = JSON(arrayatfid);
        
        
        var atftype = Dictionary<String, Any>();
        atftype["atftype"] = aftype;
        params["atftype"] = JSON(aftype);
        
        var requiredYRN = Dictionary<String, Any>();
        requiredYRN["atrequired"] = requiredType;
         params["atrequired"] = JSON(requiredType);
        
        var titleofField = Dictionary<String, Any>();
        titleofField["attitle"] = attitleData;
          params["attitle"] = JSON(attitleData);
        
        var valuedata = Dictionary<String, Any>();
        valuedata["atfvalue"] = valuesDatas;
         params["atfvalue"] = JSON(valuesDatas);
        let userType = cachem.string(forKey: "userType")!
         params["user_type"] = userType;
        
        let jparams = JSON(params);
        inspectionParametes["insepectionData"] = jparams
        let jinsopection   = JSON(inspectionParametes);
        print(inspectionParametes);
        
         let netReach = Reachability()!
        
        if netReach.connection == .none
        {
            
            if isOfflineMode
            {
                
                
                
               savetoLocalDB(jparams)
                
                
                return;
            }
            else
                
            {
                
                
                
                
                let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.savetoLocalDB(jparams)
                    
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    self.hud.hide(animated: true);
                }))
                self.present(alert, animated: true, completion: nil);
                return
                
                
                
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
     
            
        Alamofire.request(saveInspectionFormAPI, method: .post, parameters: inspectionParametes).responseJSON { (resp) in
            
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
                    
                   /*
                    if self.uploadImageData.count > 0
                    {
                        
                        self.uploadingImages(self.uploadImageData)
                        
                    }
                    else
                    {
                        */
                    self.hud.hide(animated: true);
                    
                    let message = resultdata["message"] as! String
                    let alert = UIAlertController.init(title:  translator("Success"), message: translator("Inspection sheet saved successfully"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        
                        
                        
                        self.navigationController?.popViewController(animated: true);
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                    }
                    
                    
               // }
                else{
                    self.hud.hide(animated: true);
                    let mes = resultdata["message"] as! String
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
            }
            else
            {
                
                self.hud.hide(animated: true);
                
               let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out Wouild you like to save in local database"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    
                    self.savetoLocalDB(jparams)
                    
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                
                
//                let alert = UIAlertController.init(title: "Failed", message: "Your request is timed out. Please try again.", preferredStyle: .alert);
//                alert.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: nil))
//                self.present(alert, animated: true, completion: nil);
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    func  savetoLocalDB(_ jsonData : JSON)
    {
        
        let myjsonText = jsonData.description;
        
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
            
            //create table inspectionData( userid varchar(50), sdata text );
            
            let datewForm = DateFormatter()
            datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let tdate = datewForm.string(from: Date());
            let uniqueCode = userid! + tdate
            try RAdb.executeUpdate("insert into inspectionData(userid, sdata, uniqueUserid) values (?, ?, ?)", values: [userid!, myjsonText, uniqueCode ])
            
            
            /*
            let rs = try RAdb.executeQuery("select * from inspectionData", values: nil)
            while rs.next() {
                if let x = rs.string(forColumn: "sdata") {
                    print("x = \(x)");
                    print(JSON(x));
                }
            }
            rs.close();*/
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        RAdb.close()
        
        let alert = UIAlertController.init(title: translator("Success"), message: translator("Successfully saved inspection sheet in local database"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
        
        
        
        
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
                        
                       
                        
                        
                            let inspectionData = mechroomData["inspection"] as! Dictionary<String, Any>
                            
                      // self.sectionData = inspectionData["sections"] as! [String : Any]
                        self.loadedData = inspectionData["sections"] as! [Dictionary<String, Any>]
                            
//
//                            for (key, value ) in  self.sectionData
//                            {
//
//                                print(key);
//                                print(value)
//                                let parseddata = value as! Dictionary<String, Any>
//                                self.loadedData.append(parseddata);
//
//                            }
//
                        
                            print("starting data");
                            print(self.loadedData);
                            self.inspectionTable.reloadData();
                            self.inspectionTable.isHidden = false;
                        
                            
                            
                            
                            
                            
                            
                       
                        
                        
                        
                        break;
                    }
                    
                    
                }
                
                
                
                
                
                
                break;
            }
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //----Default Func ----
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    
    func loadingDefaultLang()
    {
        headerLabel.text = translator("Inspection");
        
        
        
        
        
    }
    
    
    
    
    func loadingDefaultUI()
    {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
         loadingDefaultLang()
        inspectionTable.isHidden = true;
        menuPicker.delegate = self;
        menuPicker.dataSource = self;
        
        menuPicker.backgroundColor = UIColor.black;
        if isfromvone
        {
            
            headerLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0);
            
            
            
        }
        
        self.navigationController?.navigationBar.isHidden = true;
        
        
         let netReach = Reachability()!
        if netReach.connection == .none
        {
            if self.isfromvone
            {
                let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network connection, please try again", preferredStyle: .alert);
                
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil);
                return
                
            }
            
            
            if isOfflineMode
            {
                
                
                getOfflineData()
                
                
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
        
        
        
        
        
        
        
        
        
        
        
        
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
         let userType = cachem.string(forKey: "userType")!
         print("\(inspectionFormAPI)/\(IspectionId)/\(userType)")
        
        
        Alamofire.request("\(inspectionFormAPI)/\(IspectionId)/\(userType)").responseJSON { (responseData) in
            
            
            
            
            if((responseData.result.value) != nil)
            {
                 isOfflineMode = false
                print(responseData.result.value);
                let jdata =  responseData.result.value! as! Dictionary<String, Any>
               // self.sectionData = jdata["sections"] as! Dictionary<String, Any>
                
                self.loadedData = jdata["sections"] as! [Dictionary<String, Any>];
                
//                for (key, value ) in  self.sectionData
//                {
//
//                    print(key);
//                    print(value)
//                    let parseddata = value as! Dictionary<String, Any>
//                    self.loadedData.append(parseddata);
//
//                }
//
              
                GDoubleconvertIntoDict(["head", "label", "mytitle", "ioptions"], self.loadedData, ", . ", 1 , handler: { (_ , mydict) in
                    
                    GconvertInspectionTest = Dictionary<String, String>();
                    GconvertInspectionTest = mydict;
                   self.inspectionTable.reloadData();
                    
                    self.inspectionTable.isHidden = false;
                    hud.hide(animated: true);
                    
                    
                })
                
                
                
                
            }
            else
            {
                
                
                if self.isfromvone
                {
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network connection, please try again", preferredStyle: .alert);
                     hud.hide(animated: true);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
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
                
                
//
//                let alert = UIAlertController.init(title: "Failed!", message: "", preferredStyle: .alert);
//                alert.addAction(UIAlertAction.init(title: "Retry", style: .default, handler: { (_) in
//                    self.loadingDefaultUI();
//                }))
//                alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil));
//                self.present(alert, animated: true, completion: nil);
                
                hud.hide(animated: true);
                
                
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



class  textfieldCellClass : UITableViewCell
{
    @IBOutlet weak var innerText: UITextField!
    @IBOutlet weak var bottomborder: UILabel!
    
    
    
    
    
    
    
    
}


class superRadioCellClass : UITableViewCell
{
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var radioTitle: UILabel!
    
    
    
    
    
    
    
}


class SuperSubmitCellClass : UITableViewCell
{
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveCloseBtn: UIButton!
    
    func loadDefaultUI()
    {
        
        cancelBtn.layer.cornerRadius = 8.0;
        cancelBtn.clipsToBounds = true;
        saveCloseBtn.layer.cornerRadius = 8.0;
        saveCloseBtn.clipsToBounds = true;
        
    }
    
    
    
    
}


class SuperInspectionDropDown : UITableViewCell
{
    
    
    
}


class SuperIn : UITableViewCell
{
    
    
    
}

