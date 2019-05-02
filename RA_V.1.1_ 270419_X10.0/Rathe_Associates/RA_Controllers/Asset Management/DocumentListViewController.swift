//
//  DocumentListViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 15/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import ScrollingFollowView

class DocumentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    let loader = Bundle.main.loadNibNamed("Rathe_Associates_Xib", owner: self, options: [:])![simplex - 18] as! LoaderView
    
    @IBOutlet weak var swapingtopConstraint: NSLayoutConstraint!
    @IBOutlet weak var swapingView: ScrollingFollowView!
    @IBOutlet weak var headTitle: UILabel!
   
    
    @IBOutlet weak var documentTable: UITableView!
      var lastContentOffset: CGFloat = 0
    
    
    
    
   
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentListCell") as! DocumentListCellClass
        cell.loadingDefaultUI();
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    
    
    func loadDocumentData()
    {
        
        
        
        
        
    }
    
    
  
    
    //------Default Func ----
    func loadingDefaultUI()
    {
        
        
        loadDocumentData()
        
        
       
        
        
    }
    
    
}


class DocumentListCellClass : UITableViewCell
{
    
    @IBOutlet weak var backView: UIView!
    
    
    func loadingDefaultUI()
    {
//        backView.layer.borderWidth = 1.0;
//       
//        backView.layer.borderColor = UIColor.lightGray.cgColor;
        
        
    }
    
    
    
    
}
