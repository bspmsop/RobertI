//
//  InspectionSheetViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView
 
class InspectionSheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadingDefaultUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    @IBOutlet weak var headTitle: UILabel!
    
  
    
    
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var inspectionTable: UITableView!
    @IBOutlet weak var swapingView: ScrollingFollowView!
    @IBOutlet weak var swapingtopConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var menuImg: UIImageView!
    var isFromInspection = true;
    
     var lastContentOffset: CGFloat = 0
    
    
    
    
    
   
    
    
    
    @objc func editBuildingBtnTapped(_ sender : UIButton)
    {
        let vContrller = self.storyboard?.instantiateViewController(withIdentifier: "AddInspectionSheetViewController") as! AddInspectionSheetViewController
        
        self.navigationController?.pushViewController(vContrller, animated: true);
        
    }
    
    
    @IBAction func editInspectionSheetTapped(_ sender: UIButton) {
        
        let vContrller = self.storyboard?.instantiateViewController(withIdentifier: "AddInspectionSheetViewController") as! AddInspectionSheetViewController
      
        self.navigationController?.pushViewController(vContrller, animated: true);
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inspectionList")
       
        return cell!;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170;
    }
    
    
    @IBAction func langBtnTapped(_ sender: UIButton) {
          
    }
    
    @IBAction func addInspectionSheet(_ sender: UIButton) {
        inspectionTable.setContentOffset(CGPoint.zero, animated: true);
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddInspectionSheetViewController") as! AddInspectionSheetViewController
        
        self.navigationController?.pushViewController(vController, animated: true);
    }
    
    
    
  
    
    
    //----Default Func---
    
    func loadingDefaultUI()
    {
        
        if isFromInspection
        {
            headTitle.text = "Inspection";
            
        }
        else
        {
            headTitle.text = "Inspection Sheet";
            
        }
       
        
        descLab.text = "This line of text is a short description of this page’s functionality. The content is yet to be determined. This is placeholder text to  provide a visual of 4 lines of text."
        
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            
        }
        
    }
    

}








