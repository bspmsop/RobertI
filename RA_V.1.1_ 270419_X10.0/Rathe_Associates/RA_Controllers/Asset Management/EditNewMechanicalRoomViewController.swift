//
//  EditNewMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 20/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class EditNewMechanicalRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();

        loadingDefaultUI();
    }

   
    
    
    
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var vendorRepairBtn: UIButton!
    @IBOutlet weak var savenCloseBtn: UIButton!
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    
    @IBAction func vendorRepairTapped(_ sender: UIButton) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "VendorRepairViewController") as! VendorRepairViewController;
        self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
    }
    
    
    
    
    
  
    
    //----- Default Func ----
    
    func loadingDefaultUI(){
       
        
       
       
       
        vendorRepairBtn.layer.cornerRadius = 8.0;
        vendorRepairBtn.clipsToBounds = true;
        
        savenCloseBtn.layer.cornerRadius = 8.0;
        savenCloseBtn.clipsToBounds = true;
        
        
        signOutBtn.layer.cornerRadius = 8.0;
        signOutBtn.clipsToBounds = true;
        
        
        
        
    }
    
    
    
    

}
