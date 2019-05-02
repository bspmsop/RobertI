//
//  SyncLoaderViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 24/04/19.
//  Copyright © 2019 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftHEXColors
class SyncLoaderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingDefaultUI()
        
    }
    
    
    @IBOutlet weak var syncBtn: UIButton!
    
    var syncLabels = [["title":"Buildings", "ischecked" : "0", "isdone":"0"],["title":"Mechanical Rooms", "ischecked" : "0", "isdone":"0"],["title":"Equipment", "ischecked" : "0", "isdone":"0"],["title":"User Management", "ischecked" : "0", "isdone":"0"],["title":"Companies", "ischecked" : "0", "isdone":"0"],["title":"Reports", "ischecked" : "0", "isdone":"0"],["title":"Equipment Test", "ischecked" : "0", "isdone":"0"],["title":"Custom Inspection Sheet", "ischecked" : "0", "isdone":"0"],["title":"Notifications", "ischecked" : "0", "isdone":"0"],]
    @IBOutlet weak var synctable: UITableView!
    
    
    @IBAction func backbtnTapped(_ sender: UIButton) {
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syncLabels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "synccell") as! SyncSelectCellClass
        let rownum = indexPath.row;
        let ischecked = syncLabels[indexPath.row]["ischecked"]
        if ischecked == "1"
        {
            cell.syncSelectImg.image = UIImage.init(named: "synccheck")
            
        }
        else
        {
            cell.syncSelectImg.image = UIImage.init(named: "syncuncheck")
            
        }
        
        
        cell.titlename.text = syncLabels[indexPath.row]["title"];
        if rownum % 2 == 0
        {
            cell.contentView.backgroundColor = UIColor.white
        }
        else{
            
             cell.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ischecked = syncLabels[indexPath.row]["ischecked"]
            if ischecked == "1"
            {
                syncLabels[indexPath.row]["ischecked"] = "0"
                
        }
        else
            {
                syncLabels[indexPath.row]["ischecked"] = "1"
                
        }
        
        
        synctable.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
 func loadingDefaultUI()
 {
    syncBtn.layer.cornerRadius = 4.0;
    self.navigationController?.navigationBar.isHidden = true;
    
    
    
    }

}




class SyncSelectCellClass : UITableViewCell
{
    
    @IBOutlet weak var syncSelectImg: UIImageView!
    @IBOutlet weak var titlename: UILabel!
    @IBOutlet weak var syncStatus: UILabel!
    
    
    
}

class SyncBtnCellClass : UITableViewCell
{
    
    
    
    
    
}
