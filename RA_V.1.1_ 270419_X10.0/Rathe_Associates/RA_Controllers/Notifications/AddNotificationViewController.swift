//
//  AddNotificationViewController.swift
//  Rathe_Associates
//
//  Created by Apple on 22/08/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//


import UIKit
import ScrollingFollowView
import SwiftyJSON
import Reachability
import Alamofire
import MBProgressHUD

class AddNotificationViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,  UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI()
    }

    @IBOutlet weak var superTableHt: NSLayoutConstraint!
    @IBOutlet weak var mtable: UITableView!
    @IBOutlet weak var stable: UITableView!
    @IBOutlet weak var ovView: UIScrollView!
    
    @IBOutlet weak var managersTable: NSLayoutConstraint!
    var addBuildingHud = MBProgressHUD();
    @IBOutlet weak var companyfields: UITextFeild!
    @IBOutlet weak var usertype: UITextFeild!
    @IBOutlet weak var sendLocation: UITextFeild!
    @IBOutlet weak var sendtocluster: UITextFeild!
    var alldata = [JSON]();
     var lemyvcar = -1
    @IBOutlet weak var overallViewHt: NSLayoutConstraint!
    @IBOutlet weak var suboverallView: NSLayoutConstraint!
    var selecteduser = 0;
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var uView: UIView!
    @IBOutlet weak var scView: UIView!
    @IBOutlet weak var sView: UIView!
    var managersdata = [["title" : "", "id": ""]];
     var supersdata = [["title" : "", "id": ""]];
    var usersdata = ["Super", "Building Manager", "Corporate Manager", "Admin"]
    @IBOutlet weak var mView: UIView!
    
    
    @IBOutlet weak var messageField: UITextView!
    let menuPicker = UIPickerView()
    var pickerDataList = Array<JSON>();
    var selectedcompany = -1
    @IBAction func setThedata(_ sender: UITextFeild) {
        
        if sender == companyfields
        {  lemyvcar = 0
            pickerDataList = alldata;
            
        }
        else if sender == usertype
        {
            lemyvcar = 1
           pickerDataList = JSON(usersdata).arrayValue
            
        }
        else if sender == sendLocation
        {
            if selectedcomrow < alldata.count &&  selectedcomrow != -1
            {
                lemyvcar = 2
                pickerDataList = alldata;
                
            }
            else
            {
                
                let alert = UIAlertController.init(title: "Alert!", message: "Please select company", preferredStyle: .alert);
                
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    sender.endEditing(true);
                 
                }))
                self.present(alert, animated: true, completion: nil);
            }
           
        }
        else if sender == sendtocluster
        {
            if selectedcomrow < alldata.count &&  selectedcomrow != -1
            {
                lemyvcar = 3
                pickerDataList = alldata;
                
            }
            else
            {
                
                let alert = UIAlertController.init(title: "Alert!", message: "Please select company", preferredStyle: .alert);
                
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    sender.endEditing(true);
                    
                }))
                self.present(alert, animated: true, completion: nil);
            }
            
            
        }
        else if sender.tag == 1
        {
            if selectedcomrow < alldata.count &&  selectedcomrow != -1
            {
                selecteduser = sender.hastag
                let mangadatta = alldata[selectedcomrow]["managers"].arrayValue
                var filtermanga = [JSON]();
                for v in 0..<mangadatta.count
                {
                     let oid = mangadatta[v]["id"].stringValue
                    var ismatched = false;
                    for l in 0..<managersdata.count
                    {
                        let myid = managersdata[l]["id"]!
                        if myid == oid
                        {
                            ismatched = true;
                            break;
                        }
                        
                        
                    }
                    if !ismatched
                    {
                        
                        filtermanga.append(mangadatta[v])
                    }
                    
                    
                    
                }
                pickerDataList = filtermanga;
                lemyvcar = 4
                selectedtextfile = sender;
                
                
                
            }
            else
            {
                
                let alert = UIAlertController.init(title: "Alert!", message: "Please select company", preferredStyle: .alert);
                
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    sender.endEditing(true);
                    
                }))
                self.present(alert, animated: true, completion: nil);
            }
            
            
           
            
            
            
        }
        else if sender.tag == 3
        {
            if selectedcomrow < alldata.count &&  selectedcomrow != -1
            {
                selecteduser = sender.hastag
                let mangadatta = alldata[selectedcomrow]["supers"].arrayValue
                var filtermanga = [JSON]();
                for v in 0..<mangadatta.count
                {
                    let oid = mangadatta[v]["id"].stringValue
                    var ismatched = false;
                    for l in 0..<supersdata.count
                    {
                        let myid = supersdata[l]["id"]!
                        if myid == oid
                        {
                            ismatched = true;
                            break;
                        }
                        
                        
                    }
                    if !ismatched
                    {
                        
                        filtermanga.append(mangadatta[v])
                    }
                    
                    
                    
                }
                pickerDataList = filtermanga;
               
                
                lemyvcar = 5
                selectedtextfile = sender;
                
                selecteduser = sender.hastag
                
            }
            else
            {
                
                let alert = UIAlertController.init(title: "Alert!", message: "Please select company", preferredStyle: .alert);
                
                alert.addAction(UIAlertAction.init(title: "ok", style: .default, handler: { (_) in
                    sender.endEditing(true);
                    
                }))
                self.present(alert, animated: true, completion: nil);
            }
            
           
        }
        
        
        
        menuPicker.reloadAllComponents();
        
        
        
    }
    @IBAction func addmanagers(_ sender: UIButton) {
        
        managersdata.append(["title" : "", "id": ""])
        mtable.reloadData();
       adjustView()
        
        
        
    }
    
    func adjustView()
    {
        var tcount = managersdata.count + supersdata.count;
        tcount = tcount * 65;
            overallViewHt.constant = CGFloat(800 + tcount)
                suboverallView.constant =  CGFloat(600 + tcount)
                managersTable.constant =  CGFloat(managersdata.count * 65)
        
               superTableHt.constant =  CGFloat(supersdata.count * 65)
        
       
    }
    
    
    @IBAction func addsupers(_ sender: UIButton) {
        
         supersdata.append(["title" : "", "id": ""])
        stable.reloadData();
        adjustView()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mtable
        {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "mtablenotification") as! BuildingMangersNotififationCellCLass
             cell.titlefld.tag = 1;
            cell.loadingdefaultUI();
            cell.titlefld.inputView = menuPicker;
            if indexPath.row < managersdata.count
            {
                cell.titlefld.text = managersdata[indexPath.row]["title"]
            }
              cell.titlefld.addTarget(self, action: #selector(setThedata(_:)), for: .editingDidBegin);
            cell.titlefld.hastag = indexPath.row;
            cell.deleteBtn.addTarget(self, action: #selector(deleteTherowintable(_:)), for: .touchUpInside)
            
//                cell.headerBtn.layer.cornerRadius = 5.0
//                cell.headerBtn.setTitlein = indexPath;
//                cell.headerBtn.setTitle(equipmentdataJn[indexPath.row]["title"].stringValue, for: .normal);
//                cell.deleteBtn.jobstatus = equipmentdataJn[indexPath.row]["title"].stringValue;
//                cell.deleteBtn.notes = equipmentdataJn[indexPath.row]["id"].stringValue;
//                cell.headerBtn.jobstatus = equipmentdataJn[indexPath.row]["id"].stringValue;
//                cell.deleteBtn.addTarget(self, action: #selector(equipmentdeleteTapped(_:)), for: .touchUpInside);
//                cell.headerBtn.addTarget(self, action: #selector(gotoEquipmentDetail(_:)), for: .touchUpInside);
            cell.deleteBtn.tag = 1;
            cell.deleteBtn.hasTag = indexPath.row;
                return cell;
           
            
            
            
            
            
        }
        else if tableView == stable{
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "stableNotification") as! BuildingSupersNotififationCellCLass
                  cell.loadingdefaultUI();
            cell.titlefld.tag = 3
            if indexPath.row < supersdata.count
            {
                cell.titlefld.text = supersdata[indexPath.row]["title"]
            }
            cell.titlefld.inputView = menuPicker;
             cell.titlefld.hastag = indexPath.row;
            cell.titlefld.addTarget(self, action: #selector(setThedata(_:)), for: .editingDidBegin);
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteTherowintable(_:)), for: .touchUpInside)
            //                cell.headerBtn.layer.cornerRadius = 5.0
            //                cell.headerBtn.setTitlein = indexPath;
            //                cell.headerBtn.setTitle(equipmentdataJn[indexPath.row]["title"].stringValue, for: .normal);
            //                cell.deleteBtn.jobstatus = equipmentdataJn[indexPath.row]["title"].stringValue;
            //                cell.deleteBtn.notes = equipmentdataJn[indexPath.row]["id"].stringValue;
            //                cell.headerBtn.jobstatus = equipmentdataJn[indexPath.row]["id"].stringValue;
            //                cell.deleteBtn.addTarget(self, action: #selector(equipmentdeleteTapped(_:)), for: .touchUpInside);
            //                cell.headerBtn.addTarget(self, action: #selector(gotoEquipmentDetail(_:)), for: .touchUpInside);
            
            cell.deleteBtn.hasTag = indexPath.row;
            
                return cell;
            
            
            
            
        }
        
        else
        {
            let cell = UITableViewCell();
            return cell;
        }
        
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true);
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == mtable
        {
            
            
                return managersdata.count
            
            
        }
        else if tableView == stable
        {
            
            
                return supersdata.count
            
        }
          
        else{
            
            return 0;
            
        }
    }
    
    
    @objc func deleteTherowintable(_ sender : UIBotton)
    {
        if sender.tag == 1
        {
            managersdata.remove(at: sender.hasTag)
            mtable.reloadData();
            adjustView();
            
        }
        else
        {
             supersdata.remove(at: sender.hasTag)
            stable.reloadData();
            adjustView();
            
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributed = NSAttributedString.init(string: "", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
        if lemyvcar == 0
        {
            pickerView.backgroundColor = UIColor.black;
              attributed = NSAttributedString.init(string: pickerDataList[row]["cname"].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            
            
        }
        else if lemyvcar == 1
        {
            
                pickerView.backgroundColor = UIColor.black;
            
                  attributed = NSAttributedString.init(string: pickerDataList[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
            
            
            
        }
        else if lemyvcar == 2
        {
            if selectedcomrow < alldata.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[selectedcomrow]["location"].arrayValue
                if row < locations.count
                {
                    attributed = NSAttributedString.init(string: locations[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                    
                }
                
            }
           
            
            
            
        }
        else if lemyvcar == 3
        {
            if selectedcomrow < alldata.count
            {
                pickerView.backgroundColor = UIColor.black;
               let locations = pickerDataList[selectedcomrow]["cluster"].arrayValue
                if row < locations.count
                {
                    attributed = NSAttributedString.init(string: locations[row].stringValue, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                    
                }
                
            }
            
        }
        else if lemyvcar == 4
        {
            if row < pickerDataList.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[row]["fname"].stringValue
                
                    attributed = NSAttributedString.init(string: locations, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                    
               
                
            }
            
        }
        else if lemyvcar == 5
        {
            if row < pickerDataList.count
            {
                pickerView.backgroundColor = UIColor.black;
                let locations = pickerDataList[row]["fname"].stringValue
                
                attributed = NSAttributedString.init(string: locations, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white]);
                
                
                
            }
            
           
            
            
        }
       
        return attributed;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerView.backgroundColor = UIColor.black;
        return 1
    }
    var selectedtextfile = UITextField();
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView.backgroundColor = UIColor.black;
        return pickerDataList.count
    }
    var selectedcomrow = -1;
    var selectedcomid = "";
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.backgroundColor = UIColor.black;
        
            if lemyvcar == 0
            {
                if row < pickerDataList.count
                {
                selectedcomrow = row;
                selectedcomid = pickerDataList[row]["cid"].stringValue
                
                let com = pickerDataList[row]["cname"].stringValue
                 companyfields.text = com;
                usertype.text = "";
                sendLocation.text = "";
                sendtocluster.text = "";
                managersdata = [["title" : "", "id": ""]];
                supersdata = [["title" : "", "id": ""]];
                mtable.reloadData();
                stable.reloadData();
                adjustView();
                }
                
            }
            
            else if lemyvcar == 1
            {
                
                if row < pickerDataList.count
                {
                   usertype.text =   pickerDataList[row].stringValue
                }
                
            }
            else if lemyvcar == 2
            {
                if selectedcomrow < alldata.count
                {
                    pickerView.backgroundColor = UIColor.black;
                    let locations = pickerDataList[selectedcomrow]["location"].arrayValue
                    if row < locations.count
                    {
                        sendLocation.text = locations[row].stringValue
                    }
                    
                   
                    
                }
                
                
                
                
            }
            else if lemyvcar == 3
            {
                if selectedcomrow < alldata.count
                {
                    pickerView.backgroundColor = UIColor.black;
                    let locations = pickerDataList[selectedcomrow]["cluster"].arrayValue
                    if row < locations.count
                    {
                        sendtocluster.text = locations[row].stringValue
                    }
                    
                    
                    
                }
                
                
                
                
            }
            else if lemyvcar == 4
            {
                
                if row < pickerDataList.count
                {
                    pickerView.backgroundColor = UIColor.black;
                    
                    
                        if selecteduser < managersdata.count
                        {
                            selectedtextfile.text =  pickerDataList[row]["fname"].stringValue
                            managersdata[selecteduser]["title"] =  pickerDataList[row]["fname"].stringValue
                            managersdata[selecteduser]["id"] =  pickerDataList[row]["id"].stringValue
                            
                        }
                        
                        
                    
                    
                }
                
                
                
            }
            else if lemyvcar == 5
            {
                
                if row < pickerDataList.count
                {
                    pickerView.backgroundColor = UIColor.black;
                    
                    
                    if selecteduser < supersdata.count
                    {
                        selectedtextfile.text =  pickerDataList[row]["fname"].stringValue
                        supersdata[selecteduser]["title"] =  pickerDataList[row]["fname"].stringValue
                        supersdata[selecteduser]["id"] =  pickerDataList[row]["id"].stringValue
                        
                    }
                    
                    
                    
                    
                }
                
                
               
                
                
                
                
            }
            
            
       
        
        
    }
    
    
    
    @IBAction func sendPushNotificationTapped(_ sender: UIButton) {
        
        let checkNetworks = Reachability()!;
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."


        let comname = companyfields.text!;
        let utyper =  usertype.text!;
        let locationname = sendLocation.text!;
        let clustername = sendtocluster.text!;
        var selectedmanagers = Array<String>();
        var selectedsupers = Array<String>();
        var enteredmsg = "";
        
        for l in 0..<managersdata.count
        {
            let mids  = managersdata[l]["id"]!;
            if !mids.isEmpty
            {
                selectedmanagers.append(mids);
            }
        }
        for v in 0..<supersdata.count
        {
            let mids  = supersdata[v]["id"]!;
            if !mids.isEmpty
            {
                selectedsupers.append(mids);
            }
        }
        

        
        
        
        
        if messageField.text != nil
        {
               enteredmsg = messageField.text!
        }
       
        var estatus = false;
        var emsg = "";
        
        if comname.isEmpty || selectedcomid.isEmpty
        {
            estatus = true;
            emsg = "Please select company";

        }
        else if utyper.isEmpty
        {
            estatus = true;
            emsg = "Please select usertype";

        }
        else if locationname.isEmpty
        {
            estatus = true;
            emsg = "Please enter location";
        }
        else if clustername.isEmpty
        {
            estatus = true;
            emsg = "Please select cluster";

        }
        else if selectedmanagers.count == 0 &&  selectedsupers.count == 0
        {
            
            estatus = true;
            emsg = "Please select Manager or super";
            
        }
            
        else if enteredmsg.isEmpty
        {
            estatus = true;
            emsg = "Please enter message";
            
        }
        
        
        
        
  
        if estatus
        {
            self.addBuildingHud.hide(animated: true);
            let alerts = UIAlertController.init(title: "Alert!", message: emsg, preferredStyle: .alert);
            alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
            self.present(alerts, animated: true, completion: nil);
            return ;
        }
        






        if checkNetworks.connection == .none
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);


            }

            return;
        }



        var parmdata = Dictionary<String,Any>();
//{"company":"21","user_type":"Building Manager","location":"547 Ferguson Street","cluster":"Manhattan","building_manager":["95"],"super":["81","64"],"message":"zxczxc"}
        parmdata["company"] = selectedcomid;
        parmdata["user_type"] = utyper;
        parmdata["location"] = locationname;
        parmdata["cluster"] = clustername;
        parmdata["building_manager"] = selectedmanagers;
        parmdata["super"] =  selectedsupers;
        parmdata["message"] = enteredmsg;

        
       
        
        let parms = ["ndata" :  JSON(parmdata)];
        print(parms);
        print(vNotificationSaveAPI)
        Alamofire.request(vNotificationSaveAPI, method: .post, parameters: parms).responseJSON { (resp) in

            print(resp);
            print(resp.result);

            if resp.result.value != nil && resp.result.isSuccess
            {

                print(resp.result.value)
                let resultdata = JSON(resp.result.value!)
                
                let statuscode = resultdata["msg"].stringValue;
                if statuscode == "Notification Created Successfully"
                {
                    isOfflineMode = false;
                    refreshdata = true;

                    DispatchQueue.main.async {
                        self.addBuildingHud.hide(animated: true);
                        
                        let alert = UIAlertController.init(title:  translator("Success!"), message: translator("Successfully sent notification"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in



                            self.navigationController?.popViewController(animated: true);


                        }))
                        self.present(alert, animated: true, completion: nil);
                    }




                }


                    
                else{
                    DispatchQueue.main.async(execute: {
                        self.addBuildingHud.hide(animated: true);
                        let mes = resultdata["msg"].stringValue

                        let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))

                        self.present(alert, animated: true, completion: nil);
                    })


                }




            }
            else
            {
                DispatchQueue.main.async(execute: {
                    self.addBuildingHud.hide(animated: true);

                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try agian"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;





                    }))


                    self.present(alert, animated: true, completion: nil);
                })

            }



        }
        
        
        
        
    }
    
    
    
    
    
    
  
    
    func callinformationData()
    {
        
        addBuildingHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        addBuildingHud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addBuildingHud.bezelView.color = UIColor.white;
        self.addBuildingHud.label.text = "Loading..."
        
        
        
        let checkNetwork = Reachability()!;
        
        
        if checkNetwork.connection == .none
        {
            DispatchQueue.main.async {
                self.addBuildingHud.hide(animated: true);
                let alerts = UIAlertController.init(title: "Network Alert!", message: "No network connection please try again", preferredStyle: .alert);
                alerts.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
                self.present(alerts, animated: true, completion: nil);
                
                
            }
            
            //getofflineStateCompanyList();
            return;
        }
        
        
        let userid = cachem.string(forKey: "userid")!
        let usertype = cachem.string(forKey: "userType")!;
        
        let buildingdetailapi =  vNotificationRelationAPI
        
        Alamofire.request(vNotificationRelationAPI, method: .get).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            
            if resp.result.value != nil && resp.result.isSuccess
            {
                
                isOfflineMode = false
                print(resp.result.value!)
                let buildinginfo =  JSON(resp.result.value!)
                
                  self.alldata = buildinginfo["data"].arrayValue
                if  self.alldata.count > 0
                {
                    
                    
                    DispatchQueue.main.async {
                        
                        
                      
                        
                        self.addBuildingHud.hide(animated: true);
                    }
                    
                }
                else{
                    DispatchQueue.main.async {
                        
                        self.addBuildingHud.hide(animated: true);
                        
                    }
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("No companies to display"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        
                        //  self.getOfflineBuildingData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    self.addBuildingHud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Your request has been timed out, please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: "Try again", style: .default, handler: { (_) in
                        self.callinformationData()
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                    
                }
                
                
                
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    func loadingDefaultUI()
    {
        adjustView()
        companyfields.inputView = menuPicker;
        usertype.inputView = menuPicker;
        sendLocation.inputView = menuPicker;
        sendtocluster.inputView = menuPicker;
        
        addGrayBorders([cView, mView,sView, scView, uView])
        sendBtn.layer.cornerRadius = 4.0
        sendBtn.clipsToBounds = true;
        menuPicker.delegate = self;
        menuPicker.dataSource = self;
        cancelBtn.layer.cornerRadius = 4.0
        cancelBtn.clipsToBounds = true;
        CompatibleStatusBar(self.view);
         callinformationData()
        isFromBackGround = true;
        GlobalTimer.backgroundSyn.startSync(self);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}




class BuildingMangersNotififationCellCLass : UITableViewCell
{
    @IBOutlet weak var deleteBtn: UIBotton!
    @IBOutlet weak var titlefld: UITextFeild!
    @IBOutlet weak var titleView: UIView!
    func loadingdefaultUI()
    {
        addGrayBorders([titleView])
        
    }
    
}








class BuildingSupersNotififationCellCLass : UITableViewCell
{
   
    @IBOutlet weak var deleteBtn: UIBotton!
    @IBOutlet weak var titlefld: UITextFeild!
    @IBOutlet weak var titleVw: UIView!
    
    
    
    
    func loadingdefaultUI()
    {
         addGrayBorders([titleVw])
        
    }
    
}
