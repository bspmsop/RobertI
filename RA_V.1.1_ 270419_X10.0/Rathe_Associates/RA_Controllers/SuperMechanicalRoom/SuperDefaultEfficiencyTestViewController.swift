//
//  SuperDefaultEfficiencyTestViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 14/11/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class SuperDefaultEfficiencyTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true;
        loadingDefaultUI()
    }
    
    

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    @IBOutlet weak var topBtn: UIButton!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var saveCloseBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    

    @IBAction func topBtnTappd(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    


    @IBAction func bottom(_ sender: UIButton) {
         sender.isSelected = !sender.isSelected
    }
    



    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    @IBAction func saveCloseTapped(_ sender: Any) {
        
        
    }
    
    
    
    
    
    
    
    func loadingDefaultUI()
    {
        
        saveCloseBtn.layer.cornerRadius = 8.0;
        saveCloseBtn.clipsToBounds = true;
        cancelBtn.layer.cornerRadius = 8.0;
        cancelBtn.clipsToBounds = true;
        
        
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
