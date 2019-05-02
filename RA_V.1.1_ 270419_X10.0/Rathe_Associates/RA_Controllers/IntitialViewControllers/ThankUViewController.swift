//
//  ThankUViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class ThankUViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var closeBtn: UIButton!
    
    
    
   
    
    
    
func loadingDefaultUI()
{
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
    closeBtn.layer.borderColor = UIColor.lightGray.cgColor;
    closeBtn.layer.borderWidth = 1.0;
     CompatibleStatusBar(self.view);
    
    
    }
   

}
