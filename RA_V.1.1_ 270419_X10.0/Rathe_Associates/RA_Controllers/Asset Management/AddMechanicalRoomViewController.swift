//
//  AddMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 17/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
class AddMechanicalRoomViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI()
    }

  
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         super.viewWillAppear(animated);
        
    }
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
        
    }
    
    
   
    @IBOutlet weak var headTitle: UILabel!
    
     var lastContentOffset: CGFloat = 0
    
    var addingData = Array<Dictionary<String,String>>()
    let userPicer = UIPickerView();
    let userdata = ["testuser1", "user2", "user3"];
    @IBOutlet weak var buildingView: UIView!
    @IBOutlet weak var mechanicalRoomView: UIView!
    @IBOutlet weak var equipmentVIew: UIView!
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var swapingView: ScrollingFollowView!
    @IBOutlet weak var swapingtopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var addEquipmentBtn: UIButton!
    @IBOutlet weak var saveAndAddMechView: UIView!
    @IBOutlet weak var saveCloseBtn: UIButton!
    
    
    
    
    
    
    
    @IBAction func addEquipmentTapped(_ sender: UIButton) {
        
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddEquipmentViewController") as! AddEquipmentViewController
        self.navigationController?.pushViewController(vController, animated: true);
        
        
    }
    
    
    
    
    
    
    
    
    
    
  
  
    
  
   
    
    
    
    
    
    
    //----DefaultFunc ----
    
    func loadingDefaultUI()
    {
       
        scroller.delegate = self;
        
        
        
         
        userPicer.backgroundColor = UIColor.black;
        addingData = [["id":""],["id":""],["id":""] ];
         
        
        
        
        saveAndAddMechView.layer.cornerRadius = 5.0;
        saveAndAddMechView.clipsToBounds = true;
        
        addEquipmentBtn.layer.cornerRadius = 3.0;
        addEquipmentBtn.clipsToBounds = true;
        
        saveCloseBtn.layer.cornerRadius = 5.0;
        saveCloseBtn.clipsToBounds = true;
        
        
        
        
    }
    
    
}

