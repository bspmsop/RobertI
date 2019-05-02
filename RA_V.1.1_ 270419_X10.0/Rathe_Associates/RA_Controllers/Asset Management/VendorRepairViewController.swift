//
//  VendorRepairViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 20/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class VendorRepairViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }

   
    
    @IBOutlet weak var saveclosebtn: UIButton!
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true);
    }
    
    func loadingDefaultUI()
    {
        
        
        saveclosebtn.layer.cornerRadius = 5.0;
        saveclosebtn.clipsToBounds = true;
        
        
    }
   
    
    
    
    
    
    
    
    
    

}
