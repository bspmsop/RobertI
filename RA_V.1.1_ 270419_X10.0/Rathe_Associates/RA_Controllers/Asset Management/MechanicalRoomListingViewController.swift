//
//  MechanicalRoomListingViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 17/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit







class MechanicalRoomListingViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
    
    
    @IBOutlet weak var signInBtn: UIButton!
    
    
    
    
    @IBOutlet weak var menuImg: UIImageView!
    
    
    
    
    
    
    
    
   
    
     
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mechanicalList")
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "MechanicalRoomDetailViewController") as! MechanicalRoomDetailViewController
        self.navigationController?.pushViewController(vController, animated: true);
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110;
    }
    
    
    @IBAction func addBuildingTapped(_ sender: UIButton) {
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "AddBuildingViewController") as! AddBuildingViewController
        self.navigationController?.pushViewController(vController, animated: true);
    }
    
    @IBAction func signInbtnTapped(_ sender: UIButton) {
       // let vController = self.storyboard?.instantiateViewController(withIdentifier: "BoilerRoomSignInViewController") as! BoilerRoomSignInViewController
        //self.navigationController?.pushViewController(vController, animated: true);
        
        
        
        
    }
    
    
    @IBAction func viewsignInlogTapped(_ sender: UIButton) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "NewDocumentLibraryViewController") as! NewDocumentLibraryViewController
        self.navigationController?.pushViewController(vController, animated: true);
        
    }
    
    
    //----- Default Func ----
    
    func loadingDefaultUI(){
        
        
        signInBtn.layer.cornerRadius = 5.0;
        signInBtn.clipsToBounds = true;
         
        if self.revealViewController() != nil
        {
           // menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            
        }
       
        
        
        
        
        
        
    }


}





