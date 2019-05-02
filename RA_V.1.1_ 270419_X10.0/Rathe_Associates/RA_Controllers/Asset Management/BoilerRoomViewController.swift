//
//  BoilerRoomViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 16/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class BoilerRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingDefaultUI()
        
    }
    
    @IBOutlet weak var vendorBtn: UIButton!
    @IBOutlet weak var perfromEfficiencyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
     
        self.navigationController?.popViewController(animated: true);
    }
    
    func loadingDefaultUI()
    {
        
       
        cancelBtn.layer.cornerRadius = 5.0;
        cancelBtn.clipsToBounds = true;
        
        perfromEfficiencyBtn.layer.cornerRadius = 5.0;
        perfromEfficiencyBtn.clipsToBounds = true;
        
        vendorBtn.layer.cornerRadius = 5.0;
        vendorBtn.clipsToBounds = true;
        
        
    }
    

}
