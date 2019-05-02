//
//  MechanicalRoomDetailViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 08/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
class MechanicalRoomDetailViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI()
    }

    

   
     var lastContentOffset: CGFloat = 0
    
    @IBOutlet weak var swapingtopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var swapingView: ScrollingFollowView!
    
    
    @IBAction func boilerBtnTapped(_ sender: UIButton) {
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "BoilerRoomViewController") as! BoilerRoomViewController
        self.navigationController?.pushViewController(vController, animated: true);
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
     
        self.navigationController?.popViewController(animated: true);
    }
    
    
    @IBAction func editBtnTapped(_ sender: UIButton) {
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "EditNewMechanicalRoomViewController") as! EditNewMechanicalRoomViewController
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddMechanicalRoomViewController") as! AddMechanicalRoomViewController
        self.navigationController?.pushViewController(vController, animated: true);
    
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true);
        
    }
    
   
    
    
   
    //----- Default Func ----
    
    func loadingDefaultUI(){
      
        
       
        
        
        
        
        
    }
    
    
}
