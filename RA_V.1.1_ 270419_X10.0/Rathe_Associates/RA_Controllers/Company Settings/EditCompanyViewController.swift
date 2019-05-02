//
//  EditCompanyViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 24/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import ScrollingFollowView
import MBProgressHUD
import SwiftyJSON
import Reachability
import SDWebImage
import FMDB
import MobileCoreServices
import PEPhotoCropEditor


class EditCompanyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  PECropViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }
    
    
    var ipath = "";
    
    var addBuildingHud = MBProgressHUD();
    var imagecount = 0
    var com_name = "";
    var com_id = "";
    var com_status = "";
    var com_url : URL?
    @IBOutlet weak var companyNamebox: UITextFeild!
    @IBOutlet weak var chosefileBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var companystatus: UISwitch!
    @IBOutlet weak var compImag: UIImageView!
    
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    @IBAction func choosefileBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true);
        
        
        
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
        alert.addAction(UIAlertAction.init(title: translator("Gallery"), style: .destructive, handler: { (_ ) in
            
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
        //        alert.addAction(UIAlertAction.init(title: translator("More"), style: .destructive, handler: { (_ ) in
        //            print("more..");
        //
        //            let importMenu = UIDocumentMenuViewController(documentTypes: ["kUTTypePDF", "public.image", "public.audio", "public.movie", "public.text", "public.item", "public.content", "public.source-code"], in: .import)
        //            importMenu.delegate = self
        //            importMenu.modalPresentationStyle = .formSheet
        //            self.present(importMenu, animated: true, completion: nil)
        //
        //
        //
        //        }))
        
        alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil);
        
        
        
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
            
            
            compImag.image = croppedImage;
            
            
            let tdate = Date();
            let dateformer = DateFormatter();
            dateformer.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateStr = dateformer.string(from: tdate);
            var imageName = "companylogo" + dateStr  + ".png";
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
                    self.chosefileBtn.setTitle(specificPath, for: .normal)
                    self.ipath = specificPath;
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
    
    
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        
        let checkNetworks = Reachability()!;
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."
        
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
        
        
        let cname  = companyNamebox.text!;
        
        if cname.isEmpty || com_id.isEmpty
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alert = UIAlertController.init(title: "Alert!", message: "Please enter company name", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil);
            }
            return;
        }
        else if ipath.isEmpty
        {
            
            uploadimagetoserver(false)
            
        }
        else
        {
            
            uploadimagetoserver(true)
            
        }
      
        
    }
    
    

    func uploadimagetoserver(_ isimg : Bool)
    {
        
        if isimg
        {
            
            
            
            let imagepath = ipath
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
            
            
            let uid =  localulrimgPath.lastPathComponent;
            print(uid);
            
            
            
            let user_id =  cachem.string(forKey: "userid")
            print(vCompanyupdateAPI);
            print(uid);
            let comname = companyNamebox.text!
            var comstatus = "0"
            if !companystatus.isOn
            {
                comstatus = "1"
            }
            
            print("loading to server....");
            Alamofire.upload(multipartFormData: { ( multiData ) in
                
                multiData.append(dtaim!, withName: "company_logo", fileName: uid, mimeType: "application");
                
                
                multiData.append(comname.data(using: String.Encoding.utf8)!, withName: "company_name");
                multiData.append(comstatus.data(using: String.Encoding.utf8)!, withName: "trash");
                multiData.append(self.com_id.data(using: String.Encoding.utf8)!, withName: "id");
                
                
            }, to: vCompanyupdateAPI , method: .post ) { (resp) in
                
                
                print(resp)
                switch resp {
                case .success(let upload, _, _):
                    
                    
                    
                    upload.responseJSON { response in
                        
                        
                        if  response.result.value != nil && response.result.isSuccess{
                            
                            let resp = response.result.value;
                            print(response.result);
                            
                            print(response.result.value)
                            
                            let midiatr = JSON(response.result.value!)
                            let respStatus = midiatr["status"].intValue;
                            print(respStatus)
                            if respStatus == 200
                            {
                                
                                DispatchQueue.main.async {
                                    self.addBuildingHud.hide(animated: true);
                                    
                                    let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully updated company"), preferredStyle: .alert);
                                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                                        
                                        
                                        
                                        self.navigationController?.popViewController(animated: true);
                                        
                                        
                                    }))
                                    self.present(alert, animated: true, completion: nil);
                                }
                                
                                
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
            var comstatus = "0"
            if !companystatus.isOn
            {
                comstatus = "1"
            }
            print(comstatus)
            let parms = ["company_name" : companyNamebox.text!, "trash" : comstatus, "id" : self.com_id];
            print(parms);
            Alamofire.request(vCompanyupdateAPI, method: .post, parameters: parms).responseJSON { (resp) in
                
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
                        
                        
                        DispatchQueue.main.async {
                            self.addBuildingHud.hide(animated: true);
                            
                            let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully updated company"), preferredStyle: .alert);
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
                            let mes = resultdata["msg"] as! String
                            
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
    
    
    
    
    func loadingDefaultUI()
    {
        companyNamebox.text = com_name;
        if com_status == "Active"
        {
            companystatus.setOn(true, animated: true)
        }
        else
        {
            companystatus.setOn(false, animated: true)
        }
        if self.com_url != nil
        {
            self.compImag.sd_setImage(with: self.com_url!, completed: { (_, _, _, _) in
                
                
            })
        }
        let uid = cachem.string(forKey: "userType")!
        if uid == "0" || uid == "4"
        {
           companyNamebox.isUserInteractionEnabled = true;
            
            
        }
        else
        {
            companyNamebox.isUserInteractionEnabled = false;
            
        }
        
        chosefileBtn.layer.cornerRadius = 5.0
        chosefileBtn.clipsToBounds = true;
        
        saveBtn.layer.cornerRadius = 5.0
        saveBtn.clipsToBounds = true;
        
        cancelBtn.layer.cornerRadius = 5.0
        cancelBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
    }
    

}
