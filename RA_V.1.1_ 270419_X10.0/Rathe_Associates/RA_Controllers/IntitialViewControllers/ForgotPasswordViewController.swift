//
//  ForgotPasswordViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 20/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import SWRevealViewController
class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadingDefaultUI()
    }
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var outerVw: UIView!
    
    @IBAction func forgotPassword(_ sender: Any)
    {
        self.view.endEditing(true);
        if(email.text == "")
        {
            let alert = UIAlertController(title: "Alert", message: "Please enter email address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        else
        {
            let parameters: Parameters=[
                "email":email.text!
            ]
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
            hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            hud.bezelView.color = UIColor.white;
            Alamofire.request(forgotPasswordApi, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        print(jsonData)
                        //if there is no error
                        let error = jsonData.value(forKey: "error") as! String
                        let msg = jsonData.value(forKey: "message") as! String
                        if(error=="false")
                        {
                            hud.hide(animated: true);
                            let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (_) in
                                self.dismiss(animated: true, completion: nil);
                            }))
                           
                            self.present(alert, animated: true, completion: nil)
                            self.email.text = ""
                            
                        }
                        else
                        {
                            hud.hide(animated: true);
                            let alert = UIAlertController(title: "Alert", message: "Invalid Email Address", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                             
                        }
                    }
                    
                    else
                    {
                        hud.hide(animated: true);
                        let alert = UIAlertController(title: "Alert", message: "Please check your network connection and try again", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
            }
        }
    }
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @objc func addShortCode2(_ sender : UIBarButtonItem)
    {
        
        email.text = email.text! + ".com"
        
        
    }
    @objc func addShortCode(_ sender : UIBarButtonItem)
    {
        
        email.text = email.text! + "@"
        
        
    }
    
    @objc func doneBtnTapped(_ sender : UIBarButtonItem)
    {
        
        self.view.endEditing(true);
        
        
    }
     
    
    
    func  loadingDefaultUI()
    {
        
        
        
        let mytool = UIToolbar();
        mytool.tintColor = UIColor.black;
        let shortBtn = UIBarButtonItem.init(title: "@ ", style: .done, target: self, action: #selector(addShortCode(_:)));
        let shortBtn2 = UIBarButtonItem.init(title: ".com", style: .done, target: self, action: #selector(addShortCode2(_:)));
        let doneBtn = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneBtnTapped(_:)));
        let spaceBtn = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        mytool.setItems([shortBtn2,spaceBtn,doneBtn ], animated: true);
        mytool.sizeToFit();
        mytool.barStyle = .default
        mytool.isTranslucent = true
        //email.inputAccessoryView = mytool;
       
        
        
        
        emailView.layer.cornerRadius = 5.0;
        emailView.clipsToBounds = true;
        emailView.layer.borderColor = UIColor.lightGray.cgColor;
        emailView.layer.borderWidth = 1.0
        middleView.layer.cornerRadius = 5.0;
        middleView.clipsToBounds = true;
        sendBtn.layer.cornerRadius = 5.0;
        sendBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
    }
}
