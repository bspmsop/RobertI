//
//  CompanyDetailViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 25/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
import SDWebImage
class CompanyDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        loadingDefaultUI();
        
    }
    
    @IBOutlet weak var comImage: UIImageView!
    var hud = MBProgressHUD();
    @IBOutlet weak var backimg: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var statusLab: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var overallview: UIView!
    var datajson = JSON();
    var imurl : URL?;
    var isfromcorportat = false;
     let alertview = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])?[rowidentifier + 19] as! DeleteWarinigAlertView;
    var sCompany_id = ""
    
    @objc func backTapped(_ sender : UIButton)
    {
         self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    @objc func cancelWarningTapped(_ sender : UIButton)
    {
        alertview.removeFromSuperview();
        
    }
    
    
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        
        alertview.frame = self.view.frame;
        self.view.addSubview(alertview);
        alertview.cancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.backCancelBtn.addTarget(self, action: #selector(cancelWarningTapped(_:)), for: .touchUpInside);
        alertview.descText.text = "You are about to delete C&C Management company and all associated data.";
        
        
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        
        if Gmenu.count > 9
        {
            let isread =  Gmenu[9]["isread"]!
            
            if isread == "1"
            {
                let alert = UIAlertController.init(title: "No Access!", message: "User does not have access", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                
                return;
            }
            
            
        }
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditCompanyViewController") as! EditCompanyViewController
        vController.com_id = datajson["cid"].stringValue
        vController.com_name = datajson["cname"].stringValue
        vController.com_status = datajson["status"].stringValue
        vController.com_url = imurl
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    
    
    
    
    func callcompanydetailData()
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
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler:   nil));
                self.present(alert, animated: true, completion: nil);
            }
            return;
        }
        
        
        var Buildingapi = "\(vCompanyDetailAPI)\(sCompany_id)"
        
        if isfromcorportat
        {
            let userid = cachem.string(forKey: "userid")!
            let usertype = cachem.string(forKey: "userType")!;
              Buildingapi = "\(vCompanyManagersAPI)\(userid)/\(usertype)"
            
        }
        else
            {
                  Buildingapi = "\(vCompanyDetailAPI)\(sCompany_id)"
                
        }
        
        
        
        
        
        
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                let scode = resultdata["status"].stringValue;
                let sdata = resultdata["data"].arrayValue;
                if  scode == "200" && sdata.count > 0
                {
                    
                    isOfflineMode = false
                    
                    DispatchQueue.main.async {
                        let status = sdata[0]["status"].stringValue;
                        if status == "Inactive"
                        {
                            self.statusLab.textColor = UIColor.red;
                        }
                        else
                        {
                            self.statusLab.textColor = UIColor.init(hexString: "20BF05");
                            
                        }
                     self.statusLab.text = status
                        self.datajson = sdata[0]
                      let imgurl = sdata[0]["clogo"].stringValue;
                        var urlstr = BasicDomain + imgurl;
                        urlstr = urlstr.replacingOccurrences(of: " ", with: "%20");
                         self.imurl = URL.init(string: urlstr);
                        if self.imurl != nil
                        {
                        self.comImage.sd_setImage(with: self.imurl!, completed: { (_, _, _, _) in
                            
                            
                        })
                        }
                        self.companyName.text = sdata[0]["cname"].stringValue;
                       self.overallview.isHidden = false;
                        self.hud.hide(animated: true);
                    }
                    
                    
                    
                    
                    
                }
                    
                else{
                    
                    DispatchQueue.main.async(execute: {
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: "Unknown error occured, please try again.", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        
                        self.callcompanydetailData()
                        // self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
                
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    func loadingDefaultUI()
    {
        if isfromcorportat
        {
            backimg.image = UIImage.init(named: "menu");
            if self.revealViewController() != nil
            {
                menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
                
            }
            
            self.navigationController?.navigationBar.isHidden = true
            
        }
        else
        {
             backimg.image = UIImage.init(named: "icons8-back-64.png");
            menuButton.addTarget(self, action: #selector(backTapped(_:)), for: .touchUpInside)
            
        }
        overallview.isHidden = true;
        callcompanydetailData();
        
        CompatibleStatusBar(self.view);
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }

}
