//
//  AuditReportViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 08/06/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
import Reachability
import KxMenu
import DXPopover
import SwiftHEXColors




class AuditReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }

    
    @IBOutlet weak var reportTable: UITableView!
    var hud = MBProgressHUD();
    let viw = UIView();
    let popover = DXPopover()
    var fdata =   Array<JSON>()
    var dataDemo =   Array<JSON>()
    let dateForm =  DateFormatter()
    let fromDt : UIButton = {
        let btn = UIButton();
        
        
        btn.backgroundColor = UIColor.clear;
        btn.setTitleColor(UIColor.white, for: .normal);
        return btn
        
        
    }()
    let cancelBtn : UIButton = {
        let btn = UIButton();
        btn.setTitle("Cancel", for: .normal);
        btn.backgroundColor = UIColor.clear;
        btn.setTitleColor(UIColor.white, for: .normal);
        return btn
        
        
    }()
    let toDt : UIButton = {
        let btn = UIButton();
        
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
    let dpicker = UIDatePicker()
    
    
    
    
    
    
   
    @IBOutlet weak var menuButton: UIButton!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkNetworks = Reachability()!;
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        if checkNetworks.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
                
                
            }
            
            return;
        }
        
        let user_id =  cachem.string(forKey: "userid")
        let usertype = cachem.string(forKey: "userType")!;
        let parms = ["report_id" : dataDemo[indexPath.row]["id"].stringValue, "log_id" : user_id!, "user_type" : usertype];
        print(parms);
        Alamofire.request(vauditreportsVeiw, method: .post, parameters: parms).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                let resultdata =  JSON(resp.result.value!)
                let statuscode = resultdata["url"].stringValue
                if !statuscode.isEmpty
                {
                    isOfflineMode = false;
                    
                    
                    DispatchQueue.main.async {
                        self.hud.hide(animated: true);
                        let vContrroller = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController;
                        vContrroller.mytitle = "Audit Report";
                        
                        vContrroller.filePathURL =  statuscode
                        
                        
                        self.navigationController?.pushViewController(vContrroller, animated: false);
                        
                    }
                    
                    
                    
                    
                }
                    
                    
                    // }
                else{
                    DispatchQueue.main.async(execute: {
                        self.hud.hide(animated: true);
                        let mes = resultdata["msg"] as! String
                        
                        let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil);
                    })
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.hud.hide(animated: true);
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        
                        
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                })
                
            }
            
            
            
        }
        
    }
    @IBAction func searchingTapped(_ sender: UITextField) {
         
        if sender.text != ""
        {
            dataDemo = [];
            for i in 0..<fdata.count
            {
                let buildData =  fdata[i]
                var buildTitle = buildData["fullname"].stringValue;
                var buildTitle2 = buildData["cname"].stringValue;
                var buildTitle3 = buildData["section"].stringValue;
                buildTitle = buildTitle.lowercased();
                buildTitle2 = buildTitle2.lowercased();
                buildTitle3 = buildTitle2.lowercased();
                
                if buildTitle.contains(sender.text!.lowercased()) || buildTitle2.contains(sender.text!.lowercased()) || buildTitle3.contains(sender.text!.lowercased())
                {
                    dataDemo.append(fdata[i]);
                    
                }
                
                
            }
            self.reportTable.reloadData();
            
            
        }
        else{
            
            dataDemo = fdata;
            self.reportTable.reloadData();
            
        }
        
        
        
        
    }
    
    
    @IBAction func datePopupTapped(_ sender: Any) {
        
        
        popover.arrowSize = CGSize.init(width: 20, height: 20)
        
        popover.show(at: CGPoint.init(x:  self.view.frame.width  - 15 , y: 100), popoverPostion: .down, withContentView: viw, in: self.view);
        
        popover.blackOverlay.backgroundColor = UIColor.clear;
        
        self.view.endEditing(true);
        
        
    }
    
    @objc func dateBtTapped(_ sender : UIButton)
    {
        
        if sender == fromDt
        {
            
            
            isfromdate = true;
            fromDt.backgroundColor = UIColor.darkGray;
            toDt.backgroundColor = UIColor.lightGray;
            
        }
        else
        {
            
            isfromdate = false;
            toDt.backgroundColor = UIColor.darkGray;
            fromDt.backgroundColor = UIColor.lightGray;
        }
        
        
        
        
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if dataDemo.count > 0
        {
            numOfSections            =  1
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = translator("No data available");
            noDataLabel.textColor     = UIColor.white
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            
        }
        return numOfSections;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataDemo.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signinlogCell") as! VauditreportCellClass
        cell.uname.text = dataDemo[indexPath.row]["fullname"].stringValue;
        cell.company.text = dataDemo[indexPath.row]["cname"].stringValue;
        cell.buildinssss.text = dataDemo[indexPath.row]["section"].stringValue;
        cell.apartmentss.text = dataDemo[indexPath.row]["field"].stringValue;
        cell.bvalue.text = dataDemo[indexPath.row]["ovalue"].stringValue;
        cell.ovaleue.text = dataDemo[indexPath.row]["nvalue"].stringValue;
        cell.dateee.text = dataDemo[indexPath.row]["adtime"].stringValue;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114;
    }
    
    @objc func gettheDate(_ sender : UIDatePicker)
    {
        print(sender.date);
        let selecteddate  = dateForm.string(from: sender.date)
        print(selecteddate);
        
        if isfromdate
        {
            
            fromdateselected = sender.date;
            fromdateselected = Calendar.current.date(byAdding: .day, value: -1, to: fromdateselected)!
            fromDt.setTitle(selecteddate, for: .normal)
            
        }
        else{
            todateselected = sender.date;
            
            toDt.setTitle(selecteddate, for: .normal)
        }
        
        
    }
    
    
    
    @objc func oktapped(_ sender : UIButton)
    {
        let dfrom = DateFormatter();
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        dfrom.timeZone = TimeZone.init(abbreviation: "GMT+0:00")
        dfrom.dateFormat  = "MM-dd-yyyy"
        dataDemo = [];
        for l in 0..<fdata.count
        {
            
            let mydate = fdata[l]["adtime"].stringValue
            if !mydate.isEmpty
            {
                let  convertedd1 = dfrom.date(from: mydate);
                
                if (fromdateselected.timeIntervalSince1970.magnitude <= convertedd1!.timeIntervalSince1970.magnitude) && (convertedd1!.timeIntervalSince1970.magnitude <= todateselected.timeIntervalSince1970.magnitude)
                {
                    
                    dataDemo.append(fdata[l]);
                    
                    
                }
                
                
                let fromDate  = dateForm.string(from: fromdateselected);
                let toDate = dateForm.string(from: todateselected);
                
                
                
                
                print(fromDate)
                print(toDate)
                
                if fromDate == toDate
                {
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: "Alert!", message: "Please choose valid 'From Date' and 'To Date'", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .cancel, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                    return ;
                    
                }
                else if fromdateselected.timeIntervalSince1970 > todateselected.timeIntervalSince1970
                {
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: "Alert!", message: "Please choose valid 'From Date' and 'To Date'", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "ok", style: .cancel, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                    return ;
                    
                }
                
                
            }
            
            
            
            
        }
        
        self.reportTable.reloadData();
        self.hud.hide(animated: true);
        
        popover.dismiss();
        
    }
    @objc func cancelpiker(_ sender : UIButton)
    {
        self.dataDemo = self.fdata;
        self.reportTable.reloadData();
        popover.dismiss();
        
    }
    var isfromdate = true;
    var fromdateselected = Date();
    var todateselected = Date();
    
    
    
    func callreportData()
    {
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        self.hud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.hud.hide(animated: true);
                
                let alert = UIAlertController.init(title: "Network Alert!", message: "Please check your network connection and try again", preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
            
            return;
        }
        
        
        
        
        
        
        
        
        let userid = cachem.string(forKey: "userid")!
        
        let usertype = cachem.string(forKey: "userType")!;
        
        
        let Buildingapi = "\(vauditreports)\(userid)/\(usertype)"
        Alamofire.request(Buildingapi, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil
            {
                
                print(resp.result.value)
                var resultdata =  JSON(resp.result.value!);
                
                
                if  resp.result.isSuccess
                {
                    
                    isOfflineMode = false
                    self.fdata = resultdata["response"].arrayValue
                    self.dataDemo = self.fdata;
                    DispatchQueue.main.async {
                        self.reportTable.reloadData();
                        self.reportTable.isHidden = false;
                        self.hud.hide(animated: true);
                    }
                    
                    
                    
                    
                    
                }
                    
                else{
                    
                    DispatchQueue.main.async(execute: {
                        self.hud.hide(animated: true);
                        let alert = UIAlertController.init(title: translator("Failed"), message: "Unknown error occured, please try again.", preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil);
                        
                    })
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Try again"), style: .default, handler: { (_) in
                        self.callreportData();
                        
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title:  translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                }
                
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    //----- Default Func ----
    
    func loadingDefaultUI(){
        
        if self.revealViewController() != nil
        {
            menuButton.addTarget(self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer());
        }
        self.navigationController?.navigationBar.isHidden = true;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        dpicker.addTarget(self, action: #selector(gettheDate(_:)), for: .valueChanged)
        
        
        
        
        
        
        
        let sView = UIView()
        let mView = UIView()
        
        let subViewer = UIView();
        viw.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width  , height: 270);
        sView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 60);
        sView.backgroundColor = UIColor.init(hexString: "C4C4C4")
        CompatibleStatusBar(self.view);
        
        
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
        
        
        
        
        cancelBtn.frame = CGRect.init(x: 0, y: 0, width: (self.view.frame.width * 0.5 - 0.5), height: 60.0)
        
        
        
        dpicker.backgroundColor = UIColor.init(hexString: "C4C4C4")
        
        okBtn.frame = CGRect.init(x: (self.view.frame.width * 0.5 + 0.5), y: 0, width: (self.view.frame.width * 0.5 - 0.5), height: 60.0)
        
        divider1.frame = CGRect.init(x: (self.view.frame.width * 0.5 - 0.5), y: 8, width: 1.0, height: 44.0)
        
        dpicker.backgroundColor = UIColor.clear;
        
        
        
        mView.frame = CGRect.init(x: 0, y: 60.0, width: self.view.frame.width, height: 60);
        
        fromDt.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width * 0.5, height: 60)
        fromDt.backgroundColor = UIColor.darkGray;
        dpicker.datePickerMode = .date
        fromDt.addTarget(self, action: #selector(dateBtTapped(_:)), for: .touchUpInside)
        toDt.addTarget(self, action: #selector(dateBtTapped(_:)), for: .touchUpInside)
        okBtn.addTarget(self, action: #selector(oktapped(_:)), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelpiker(_:)), for: .touchUpInside)
        mView.addSubview(fromDt);
        mView.addSubview(toDt);
        mView.backgroundColor = UIColor.init(hexString: "B3B3B3")
        
        dateForm.dateFormat  = "MMM dd, yyyy"
        
        fromDt.setTitle(dateForm.string(from: Date()), for: .normal)
        toDt.setTitle(dateForm.string(from: Date()), for: .normal)
        
        
        
        
        
        
        sView.addSubview(cancelBtn)
        sView.addSubview(okBtn)
        sView.addSubview(divider1)
        sView.addSubview(divider2)
        
        
        
        
        
        
        
        
        
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
        fromdateselected = Calendar.current.date(byAdding: .day, value: -1, to: fromdateselected)!
        self.reportTable.isHidden = true;
        callreportData();
        
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
        
        
    }
    
    
    

}




class VauditreportCellClass : UITableViewCell
{
    @IBOutlet weak var uname: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var dateee: UILabel!
    @IBOutlet weak var buildinssss: UILabel!
    @IBOutlet weak var apartmentss: UILabel!
    @IBOutlet weak var bvalue: UILabel!
    @IBOutlet weak var ovaleue: UILabel!
    
    
    
    
    
    
    
}
