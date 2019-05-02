//
//  WarningViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 23/10/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit




class WarningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         loadingDefaultUI()
        
       
    }
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    
    
    @IBOutlet weak var warningText: UILabel!
    
    var warngiContent  = "";
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil);
    }
    
    
    
    
    
    
    

    func loadingDefaultUI()
    {
        warningText.text = warningMessage;
        deleteBtn.layer.cornerRadius = 5.0;
        deleteBtn.clipsToBounds = true;
        cancelBtn.layer.cornerRadius = 5.0;
        cancelBtn.clipsToBounds = true;
        
    }

}
