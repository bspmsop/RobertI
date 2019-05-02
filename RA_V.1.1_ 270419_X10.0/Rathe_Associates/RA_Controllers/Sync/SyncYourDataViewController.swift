//
//  SyncYourDataViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 28/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import QuickLook
import AVKit
import FMDB
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability


var syncHandler : ((_ stopSync : Bool) -> Void)? = nil

class SyncYourDataViewController: UIViewController {
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
        
        
        
    }

    
   
    @IBOutlet weak var syncBtn: UIButton!
    @IBOutlet weak var controllerTitle: UILabel!
    @IBOutlet weak var sychDesc: UITextView!
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuImg: UIImageView!
    
   
   
    
    
    
    
    @IBAction func syncBtnTapped(_ sender: UIButton) {
        isEmergencyStop = true;
         syncHandler = nil
        let synchud = MBProgressHUD.showAdded(to: self.view, animated: true);
        synchud.label.text = "Fetching your local Data..."
        synchud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        synchud.bezelView.color = UIColor.white;
        
        
        if isSyncCompleted
        {
            synchud.hide(animated: true);
            isEmergencyStop = false;
            isFromBackGround = false;
            fetchingLocalDB(self)
            syncHandler = nil
            
            
        }
        else
        {
            if isSyncRunning
            {
            isEmergencystop { (isStoppeed) in
            synchud.hide(animated: true);
            isEmergencyStop = false;
            isFromBackGround = false;
            fetchingLocalDB(self)
            syncHandler = nil
            
        }
            }
            else
            {
                synchud.hide(animated: true);
                isEmergencyStop = false;
                isFromBackGround = false;
                fetchingLocalDB(self)
                syncHandler = nil
                
                
            }
        
        }
        
        
       
       
      
    }
    
    
    func isEmergencystop(handler : @escaping (_ stopSync : Bool) -> Void)
    {
        syncHandler = handler;
        
        
    }

    
    
    
 
    
        
        
    
    
    @IBOutlet weak var headewrLab: UILabel!
    
    //------------------- Default Function -----------------------
    
    
    func loadLangauage()
    {
        
        headewrLab.text = translator("Sync");
        sychDesc.text = translator("Download all the documents(Mechanical Rooms, Equipments, etc) When the internet access is available")
        
        syncBtn.setTitle(translator("Sync"), for: .normal);
        
        
        
        
    }
    
    
    func loadingDefaultUI()
    {
         netReach.stopNotifier();
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
       loadLangauage()
  
        
        
        
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            
        }
        self.navigationController?.navigationBar.isHidden = true;
        CompatibleStatusBar(self.view);
      
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
