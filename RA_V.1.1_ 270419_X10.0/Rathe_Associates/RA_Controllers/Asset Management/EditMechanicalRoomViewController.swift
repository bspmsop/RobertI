//
//  EditMechanicalRoomViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 09/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import SwiftHEXColors
import ScrollingFollowView
class EditMechanicalRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingDefaultUI()
    }
    
   
    
    
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
        
    }
    
    
    @IBOutlet weak var addTable: UITableView!
    @IBOutlet weak var headTitle: UILabel!
    
    
    
    var initialData = [["id":"875 N Michigan Ave", "placeholder": ""],["id":"Boiler Room", "placeholder":"Mechanical Room"]];
    var EquipmentData = [["id1": "", "id2": ""]];
    var superData = [["id":""]];
    
    
    
    let userPicer = UIPickerView();
     let userdata = ["testuser1", "user2", "user3"];
     var lastContentOffset: CGFloat = 0
    @IBOutlet weak var swapingView: ScrollingFollowView!
    @IBOutlet weak var swapingtopConstraint: NSLayoutConstraint!
    
    
    
   
   
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return initialData.count + EquipmentData.count + superData.count + 4;
        
    }
    
    
    
    
    @objc func actionBtnTapped(_ sender : UIButton)
    {
        if sender.currentTitle == "Vendor Repairs"
        {
            
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddRepairViewController") as! AddRepairViewController
            self.navigationController?.pushViewController(vController, animated: true);
            
            
            
        }
        else if sender.currentTitle == "Sign In"
        {
            let vController = self.storyboard?.instantiateViewController(withIdentifier: "MechanicalRoomSIgnInViewController") as! MechanicalRoomSignInViewController
            self.navigationController?.pushViewController(vController, animated: true);
            
        }
        else
        {
            
            
        }
        
        
    }
    
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row == 1 
        {
            let eptyField = Bundle.main.loadNibNamed("Rathe_Associates_Xib", owner: self, options: [:])![simplex - 16] as! EmptyTextFieldCellClass
            eptyField.loadingDefaultUI();
            
          
            
            
            eptyField.titleField.placeholder = initialData[indexPath.row]["placeholder"]
           
            return eptyField
        }
        else if indexPath.row > 1  && indexPath.row < initialData.count + EquipmentData.count
        {
            let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xibs_II", owner: self, options: [:])![simplex - 10] as! dynamicNotesCellClass
            cell.loadingDefaultUI();
            
            
            
            
           
            
            if indexPath.row == initialData.count + EquipmentData.count - 1
            {
                cell.addnotesBtn.setTitle("+", for: .normal);
                cell.addnotesBtn.setTitleColor(UIColor.init(hexString: "009C50"), for: .normal);
                
            }
            else
            {
                cell.addnotesBtn.setTitle("x", for: .normal);
                cell.addnotesBtn.setTitleColor(UIColor.init(hexString: "FD0009"), for: .normal);
                
            }
           
            
            
            
            
            
            
            return cell
            
            
        }
            
        else if  indexPath.row ==  initialData.count + EquipmentData.count
        {
            
            
            let sendBtnview = Bundle.main.loadNibNamed("Rathe_Associates_Xib", owner: self, options: [:])![simplex - 13] as! SendBtnCellClass
            sendBtnview.loadingDefaultUI();
            
            sendBtnview.sendBtn.setTitle("Add New Equipment", for: .normal)
            return sendBtnview
            
            
        }
            else if indexPath.row >  (initialData.count + EquipmentData.count) &&  indexPath.row < (initialData.count + EquipmentData.count + superData.count + 1)
        {
            
            let cell = Bundle.main.loadNibNamed("Rathe_Associates_Xib", owner: self, options: [:])![simplex - 15] as! EmptyDynamicTextFieldCellClass
            cell.titleField.placeholder = "Super"
            cell.loadingDefaultUI();
            
           
            
           
            
            if indexPath.row == (initialData.count + EquipmentData.count + superData.count)
            {
                cell.addFieldBtn.setTitle("+", for: .normal)
                cell.addFieldBtn.setTitleColor(UIColor.init(hexString: "009C50"), for: .normal);
                
            }
            else
            {
                cell.addFieldBtn.setTitle("x", for: .normal);
                cell.addFieldBtn.setTitleColor(UIColor.init(hexString: "FD0009"), for: .normal);
                
            }
           return cell
            
            
        }
            
        else{
            var btnTItles = ["Sign In", "Vendor Repairs", "Save and Close"];
            let sendBtnview = Bundle.main.loadNibNamed("Rathe_Associates_Xib", owner: self, options: [:])![simplex - 13] as! SendBtnCellClass
            sendBtnview.sendBtn.backgroundColor = UIColor.init(hexString: "009C50")
            sendBtnview.sendBtn.addTarget(self, action: #selector(actionBtnTapped(_:)), for: .touchUpInside)
            if (indexPath.row - (initialData.count + EquipmentData.count + superData.count + 1)) == 2
            {
                sendBtnview.sendBtn.backgroundColor = UIColor.init(hexString: "D54031");
            }
            sendBtnview.loadingDefaultUI();
            sendBtnview.sendBtn.setTitle(btnTItles[indexPath.row - (initialData.count + EquipmentData.count + superData.count + 1)], for: .normal)
            return sendBtnview
            
            
        }
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row > 1  && indexPath.row < initialData.count + EquipmentData.count
       {
            return 150
            
        }
        return 85;
    }
    
    
    
    
    //----DefaultFunc ----
    
    func loadingDefaultUI()
    {
     
        
        
        
        
        
        
        
        
    }
    
    
}
