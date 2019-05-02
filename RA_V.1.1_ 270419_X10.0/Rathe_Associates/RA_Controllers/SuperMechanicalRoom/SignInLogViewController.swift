//
//  SignInLogViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//
import ScrollingFollowView
import UIKit
import DXPopover
import SwiftHEXColors
class SignInLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var logTable: UITableView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var menuImg: UIImageView!
    let viw = UIView();
    let popover = DXPopover()
     var isFromMenu = false;
     var lastContentOffset: CGFloat = 0
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signinlogCell") as! SignInCellClass
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62;
    }
    
    @IBAction func vendorTapped(_ sender: Any) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "vendorlistnav");
        self.present(vController!, animated: false, completion: nil);
        
        
        
    }
    @IBAction func documentrayLibraryTapped(_ sender: Any) {
        
        let vController = self.storyboard?.instantiateViewController(withIdentifier: "diclibrary");
        self.present(vController!, animated: false, completion: nil);
        
        
    }
    
    
    @IBAction func dateBtnTapped(_ sender: UIButton) {
        
        
        
        
        popover.arrowSize = CGSize.init(width: 20, height: 20)
        
        popover.show(at: CGPoint.init(x:  self.view.frame.width  - 15 , y: 150), popoverPostion: .down, withContentView: viw, in: self.view);
        
        popover.blackOverlay.backgroundColor = UIColor.clear;
        
        self.view.endEditing(true);
        
        
        
        
        
        
        
    }
    
        
        
       
    
   
    
    
    
    
    
   

    
    //----- Default Func --------
    
    func loadingDefaultUI()
    {
        
        
        
        //C4C4C4
        //B3B3B3
        
        
        
        let sView = UIView()
         let mView = UIView()
        let dpicker = UIDatePicker()
         let subViewer = UIView();
        viw.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width  , height: 270);
        sView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 60);
        sView.backgroundColor = UIColor.init(hexString: "C4C4C4")
        
        let cancelBtn : UIButton = {
            let btn = UIButton();
            btn.setTitle("Cancel", for: .normal);
            btn.backgroundColor = UIColor.clear;
            btn.setTitleColor(UIColor.white, for: .normal);
            return btn
            
            
        }()
        let okBtn : UIButton = {
            let btn = UIButton();
            btn.setTitle("OK", for: .normal);
            btn.backgroundColor = UIColor.clear;
            btn.setTitleColor(UIColor.white, for: .normal);
            return btn
            
            
        }()
        let divider1 : UILabel = {
            let viw = UILabel();
            viw.textColor = UIColor.clear;
            viw.backgroundColor = UIColor.white;
            
            return viw
            
            
        }()
        let divider2 : UILabel = {
            let viw = UILabel();
            viw.textColor = UIColor.clear;
            viw.backgroundColor = UIColor.white;
            
            return viw
            
            
        }()
        
        
        let fromDt : UIButton = {
            let btn = UIButton();
            btn.setTitle("SEP 12, 2018", for: .normal);
            btn.backgroundColor = UIColor.clear;
            btn.setTitleColor(UIColor.white, for: .normal);
            return btn
            
            
        }()
        let toDt : UIButton = {
            let btn = UIButton();
            btn.setTitle("SEP 16, 2018", for: .normal);
            btn.backgroundColor = UIColor.clear;
            btn.setTitleColor(UIColor.white, for: .normal);
            return btn
            
            
        }()
        
        
        
        cancelBtn.frame = CGRect.init(x: 0, y: 0, width: (self.view.frame.width * 0.5 - 0.5), height: 60.0)
        
        
        
        dpicker.backgroundColor = UIColor.init(hexString: "C4C4C4")
        
        okBtn.frame = CGRect.init(x: (self.view.frame.width * 0.5 + 0.5), y: 0, width: (self.view.frame.width * 0.5 - 0.5), height: 60.0)
        
        divider1.frame = CGRect.init(x: (self.view.frame.width * 0.5 - 0.5), y: 8, width: 1.0, height: 44.0)
        
        dpicker.backgroundColor = UIColor.clear;
        
        
        
        mView.frame = CGRect.init(x: 0, y: 60.0, width: self.view.frame.width, height: 60);
        
        fromDt.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width * 0.5, height: 60)
        
        dpicker.datePickerMode = .date
        
        
        mView.addSubview(fromDt);
        mView.addSubview(toDt);
         mView.backgroundColor = UIColor.init(hexString: "B3B3B3")
        
        
        
        
        
        
        
        
        
        
        sView.addSubview(cancelBtn)
        sView.addSubview(okBtn)
        sView.addSubview(divider1)
        sView.addSubview(divider2)
        
        
        
        
        
        
        CompatibleStatusBar(self.view);
        
        
         divider2.frame = CGRect.init(x: 0, y: 58, width: self.view.frame.width, height: 1.0)
        dpicker.frame = CGRect.init(x: 0, y: 120, width: self.view.frame.width, height: 150);
        
       
        
        
       
       
        subViewer.backgroundColor = UIColor.init(hexString: "B3B3B3")
        viw.addSubview(subViewer);
        dpicker.setValue(UIColor.white, forKey: "textColor")
        toDt.frame = CGRect.init(x: self.view.frame.width * 0.5, y: 0, width: self.view.frame.width * 0.5, height: 60.0)
        subViewer.frame = CGRect.init(x: 0, y: 177, width: self.view.frame.width , height: 37)
         viw.backgroundColor   = UIColor.init(hexString: "C4C4C4")
        viw.addSubview(sView);
        viw.addSubview(mView);
        viw.addSubview(dpicker);
        
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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


class SignInCellClass : UITableViewCell
{
    
    
    
    
    
}
