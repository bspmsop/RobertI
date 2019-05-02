//
//  SuperDefaultInspectionViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 14/11/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//


import UIKit
import ScrollingFollowView
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability
import FMDB

class SuperDefaultInspectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingDefaultUI();
        
    }
    
    @IBOutlet weak var cancelHt: NSLayoutConstraint!
    
    @IBOutlet weak var saveht: NSLayoutConstraint!
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    
    var lastContentOffset: CGFloat = 0
    
    var isEdit = false;
    
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var headTitle: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var lightsFlashingYesBtn: UIButton!
    @IBOutlet weak var lightsFlashingNoBtn: UIButton!
    
    @IBOutlet weak var outdoorTemp: UITextField!
    @IBOutlet weak var boilerSupplyTemp: UITextField!
    @IBOutlet weak var targetTemp: UITextField!
    @IBOutlet weak var pumpOperating: UITextField!
    @IBOutlet weak var pumpOff: UITextField!
    @IBOutlet weak var waterGuagesTemperature: UITextField!
    @IBOutlet weak var supplyTemp: UITextField!
    @IBOutlet weak var returnTemp: UITextField!
    @IBOutlet weak var dwhsupply: UITextField!
    @IBOutlet weak var checkFilter: UITextField!
    @IBOutlet weak var checkWaterLevel: UITextField!
    @IBOutlet weak var checkForLeaks: UITextField!
    @IBOutlet weak var annualEfficiencytest: UITextField!
    
    var failureLightsFlashing = false;
    var clearedlightsFlashing = false;
    var pressedclearAlarm = false;
    var DWHpumpOperating = false;
    var DWHfailurelightsflashing = false;
    var DWHClearedFlashingLights = false;
    var DWHPressedClearAlarm = false;
    var boiler1 = false;
    var boiler2 = false;
    var boiler3 = false;
    var boiler4 = false;
    var isfromvone = false;
    
    
    
    
    
    @IBAction func failutreLightsFlashingTapped(_ sender: UIButton) {
        
        
       
        
        
        if sender == lightsFlashingYesBtn
        {
            failureLightsFlashing = true;
            lightsFlashingNoBtn.isSelected = false
        }
        else
        {
            failureLightsFlashing = false;
            lightsFlashingYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
    }
    
    
    
    
    
    @IBOutlet weak var clearLightsYesBtn: UIButton!
    @IBOutlet weak var clearLightsNoBtn: UIButton!
    
    
    
    
    
    
    
    @IBAction func cleareedlightTapped(_ sender: UIButton) {
        
        
      
        if sender == clearLightsYesBtn
        {
            clearedlightsFlashing = true;
            clearLightsNoBtn.isSelected = false;
        }
        else
        {
            clearedlightsFlashing = false;
            clearLightsYesBtn.isSelected = false;
            
        }
        
        sender.isSelected = true;
        
        
        
    }
    
    
    
    
    
    
    
    @IBOutlet weak var pressedAlarmYesBtn: UIButton!
    @IBOutlet weak var pressedAlarmNoBtn: UIButton!
    
    
    @IBAction func pressedAlarmTapped(_ sender: UIButton) {
        
        
        
        if sender == pressedAlarmYesBtn
        {
            pressedclearAlarm = true
            pressedAlarmNoBtn.isSelected = false
        }
        else
        {
            pressedclearAlarm = false;
            pressedAlarmYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
    }
    
    
    @IBOutlet weak var DhwPumpYesBtn: UIButton!
    @IBOutlet weak var DhwPumpNoBtn: UIButton!
    @IBAction func DhwPumpBtnTapped(_ sender: UIButton) {
        
        
        
       
        
        
        
        if sender == DhwPumpYesBtn
        {
            DWHpumpOperating = true;
            DhwPumpNoBtn.isSelected = false
        }
        else
        {
             DWHpumpOperating = false;
            DhwPumpYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
        
    }
    
    @IBOutlet weak var pumpSequencerFlashingNoBtn: UIButton!
    
    @IBOutlet weak var pumpsequencerFlashingYesBtn: UIButton!
    
    
    @IBAction func sequencerPumpBtnTapped(_ sender: UIButton) {
        
        
        
       
        
        if sender == pumpsequencerFlashingYesBtn
        {
              DWHfailurelightsflashing = true;
            pumpSequencerFlashingNoBtn.isSelected = false
        }
        else
        {
             DWHfailurelightsflashing = false;
            pumpsequencerFlashingYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
    }
    
    
    
    @IBOutlet weak var pumpsequencerFlashingLightsYesBtn: UIButton!
    @IBOutlet weak var pumpsequencerFlasinglightsNoBtn: UIButton!
    
    @IBAction func pumpseuencerFloasingLightsTapped(_ sender: UIButton) {
        
        
        
        
       
        
        
        if sender == pumpsequencerFlashingLightsYesBtn
        {
            DWHClearedFlashingLights = true;
            pumpsequencerFlasinglightsNoBtn.isSelected = false
        }
        else
        {
             DWHClearedFlashingLights = false;
            pumpsequencerFlashingLightsYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
        
        
    }
    
    
    @IBOutlet weak var pubsequencerpressedAlarmYesBtn: UIButton!
    @IBOutlet weak var pumpsequencerPressedAlarmNoBtn: UIButton!
    
    @IBAction func PumpSequencealarmbtntapped(_ sender: UIButton) {
        
        
        
        
      
        
        
        if sender == pubsequencerpressedAlarmYesBtn
        {
            DWHPressedClearAlarm = true;
            pumpsequencerPressedAlarmNoBtn.isSelected = false
        }
        else
        {
            DWHPressedClearAlarm = false;
            pubsequencerpressedAlarmYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
    }
    
    @IBOutlet weak var warningYesBtn: UIButton!
    @IBOutlet weak var warningNoBtn: UIButton!
    @IBAction func warningBoilerTapped(_ sender: UIButton) {
        
        
        
       
        
        if sender == warningYesBtn
        {
            boiler1 = true;
            warningNoBtn.isSelected = false
        }
        else
        {
            boiler1 = false;
            warningYesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
    }
    
    @IBOutlet weak var bopiler2YesBtn: UIButton!
    @IBOutlet weak var boiler2NoBtn: UIButton!
    @IBAction func boilerTapped(_ sender: UIButton) {
        
        
        
        if sender == bopiler2YesBtn
        {
            boiler2 = true;
            boiler2NoBtn.isSelected = false
        }
        else
        {
            boiler2 = false;
            bopiler2YesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
        
    }
    
    
    
    @IBOutlet weak var boiler3NoBtn: UIButton!
    
    @IBOutlet weak var boiler3Tapped: UIButton!
    
    
    @IBAction func boiler3Tappedon(_ sender: UIButton) {
        
        
      
        
        
        if sender == boiler3Tapped
        {
            boiler3 = true;
            boiler3NoBtn.isSelected = false
        }
        else
        {
            boiler3 = false;
            boiler3Tapped.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
        
    }
    
    
    
    @IBOutlet weak var boiler4yesBtn: UIButton!
    @IBOutlet weak var boiler4NoBtn: UIButton!
    
    @IBAction func boiler4Tapped(_ sender: UIButton) {
        
        
        
        if sender == boiler4yesBtn
        {
             boiler4 = true;
            boiler4NoBtn.isSelected = false
        }
        else
        {
             boiler4 = false;
            boiler4yesBtn.isSelected = false
            
        }
        
        sender.isSelected = true;
        
        
        
        
    }
    
    
    
    
    
    let dformate = DateFormatter()
    
    @IBAction func saveAndCloseTapped(_ sender: Any) {
        
         let defaultFields = [outdoorTemp, boilerSupplyTemp, targetTemp, pumpOperating, pumpOff, waterGuagesTemperature, supplyTemp, returnTemp, dwhsupply, checkFilter, checkWaterLevel, checkForLeaks, annualEfficiencytest]
        
        
        
        for i in 0..<defaultFields.count
        {
            if defaultFields[i]?.text == ""
            {
              
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please fill required fields"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                self.present(alert, animated: true, completion: nil);
                return
                
            }
            
            
        }
        
        
         saveData()
        
        
        
        
        
        
        
        
        
        
    }
    
 
    func saveData()
    {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true);
        hud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        hud.bezelView.color = UIColor.white;
        
        
        var params =  Dictionary<String, Any>()
         var inspectionParameters =  Dictionary<String, Any>()
        
        
        
        let datewForm = DateFormatter()
        //datewForm.dateFormat = "yyyy-dd-MM"
        datewForm.dateFormat = "MM-dd-yyyy HH:mm:ss"
         let tdate = datewForm.string(from: Date());
         params["inspection_date"] = tdate;
        
        
        
        params["outdoor_temperature"] = outdoorTemp.text!
        params["boiler_supply_temperature"] = boilerSupplyTemp.text!
        params["target_temperature"] = targetTemp.text!
        params["pump_operating"] = pumpOperating.text!
        params["pump_off"] = pumpOff.text!
        params["failure_lights"] = failureLightsFlashing;
        params["cleared_flights"] = clearedlightsFlashing
        params["press_calarm"] = pressedclearAlarm;
        params["dhw_pump_operating"] = DWHpumpOperating;
        params["dhw_failure_lights"] = DWHfailurelightsflashing
        params["dhw_press_calarm"] = DWHPressedClearAlarm
        params["dhw_cleared_flights"] = DWHClearedFlashingLights
        
        
        params["water_gauges"] = waterGuagesTemperature.text!
        params["supply_temp"] = supplyTemp.text!
        params["return_temp"] = returnTemp.text!
        params["dhw"] = dwhsupply.text!
        params["boiler1"] = boiler1;
        params["boiler2"] = boiler2;
        params["boiler3"] = boiler3;
        params["boiler4"] = boiler4;
        
        params["condensation"] = "";
        params["check_filters"] = checkFilter.text!
        
        params["check_water_level"] = checkWaterLevel.text!
        params["check_for_leaks"] = checkForLeaks.text!
        params["annual_efficeiency_test"] = annualEfficiencytest.text!
        params["mech_id"] = mechanicalRoomID;
        let userid = UserDefaults.standard
        let user_id =  userid.string(forKey: "userid")
        
        params["user_id"] = user_id!
        let userType = cachem.string(forKey: "userType")!
         params["user_type"] = userType
        
           
        let jparams = JSON(params);
        
       
        
        
        inspectionParameters["insepectionData"] = jparams
       
        print(inspectionParameters);
        
        
        
        let netReach = Reachability()!
        
        if netReach.connection == .none
        {
            
            if isOfflineMode
            {
                
                if isfromvone
                {
                    hud.hide(animated: true);
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: "No network conection please try again.", preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
                     self.present(alert, animated: true, completion: nil);
                     return;
                    
                }
                savetoLocalDB(jparams)
                
                
                return;
            }
            else
                
            {
                
                
                let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                    isOfflineMode = true;
                    self.savetoLocalDB(jparams)
                    
                    
                    
                }))
                
                alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil);
                return
                
                
                
                
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        Alamofire.request(saveInspectionFormAPI, method: .post, parameters: inspectionParameters).responseJSON { (resp) in
            
            print(resp);
            print(resp.result);
            hud.hide(animated: true);
            if resp.result.value != nil
            {
                 isOfflineMode = false
                print(resp.result.value)
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    let message = resultdata["message"] as! String
                    let alert = UIAlertController.init(title: translator("Success"), message: message, preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        
                        
                        
                        self.navigationController?.popViewController(animated: true);
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                else{
                    
                    let mes = resultdata["message"] as! String
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: mes, preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
                
                
                
            }
            else
            {
                
                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Please check your network connection and try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil))
                self.present(alert, animated: true, completion: nil);
                
                
            }
            
            
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    func savetoLocalDB(_ jsonData : JSON)
    {
        
        
        
        
        let myjsonText = jsonData.description;
        
        let filePath = getPath(fileName: locale_DB);
        let RAdb = FMDatabase.init(path: filePath);
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        
        guard RAdb.open() else {
            print("Unable to open database")
            return
        }
        print("data base is opened");
        
        
        do {
            
            //create table inspectionData( userid varchar(50), sdata text );
            
            let datewForm = DateFormatter()
            datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let tdate = datewForm.string(from: Date());
             let uniqueCode = userid! + tdate
            try RAdb.executeUpdate("insert into inspectionData(userid, sdata, uniqueUserid) values (?,?,?)", values: [userid!, myjsonText, uniqueCode ])
            
            
            
             let rs = try RAdb.executeQuery("select * from inspectionData", values: nil)
             while rs.next() {
             if let x = rs.string(forColumn: "sdata") {
             print("x = \(x)");
             print(JSON(x));
             }
             }
             rs.close();
            
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        
        RAdb.close()
        
        let alert = UIAlertController.init(title: translator("Success"), message: translator("Successfully saved inspection sheet"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
        
        
        
        
    }
    
    
    
    
    
    
    
    
    //----Default Func ----
    
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var TekmarsControlsLabel: UILabel!
    @IBOutlet weak var BLDGPumpLabel: UILabel!
    @IBOutlet weak var failurelightsflash: UILabel!
    @IBOutlet weak var clearLightsflashing: UILabel!
    
    @IBOutlet weak var pressedClearAlarmlab: UILabel!
    @IBOutlet weak var dhwPumpdsequenlab: UILabel!
    @IBOutlet weak var pumpoperatingLabel: UILabel!
    @IBOutlet weak var failurelightsflashinglabel: UILabel!
    
    @IBOutlet weak var clearedFlashLightsLabel: UILabel!
    @IBOutlet weak var pressedClrAlarmLabel: UILabel!
    @IBOutlet weak var dhwHeaterLabel: UILabel!
    @IBOutlet weak var thermometerReadingLabel: UILabel!
    @IBOutlet weak var warningcheckLabel: UILabel!
    @IBOutlet weak var b1label: UILabel!
    @IBOutlet weak var b2label: UILabel!
    @IBOutlet weak var b3label: UILabel!
    @IBOutlet weak var b4label: UILabel!
    @IBOutlet weak var dmaLabel: UILabel!
    
    
    
    
    func loadingDefaultLang()
    {
       
        
        
        if isfromvone
        {
            cancelHt.constant = 44.0
            saveht.constant = 44.0
            headerLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0);
            
             TekmarsControlsLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             outdoorTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
             boilerSupplyTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             targetTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             BLDGPumpLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             pumpOperating.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             pumpOff.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             failurelightsflash.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             pumpsequencerPressedAlarmNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            pumpsequencerFlasinglightsNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             DhwPumpYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             DhwPumpNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             lightsFlashingYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             lightsFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             clearLightsYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             clearLightsNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             pressedAlarmYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             pressedAlarmNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            lightsFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             lightsFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             lightsFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             lightsFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
             lightsFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            
            
            clearLightsYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            clearLightsNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pressedAlarmYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pressedAlarmNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            pumpsequencerFlashingYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pumpsequencerFlashingLightsYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pumpSequencerFlashingNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            saveBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0);
            cancelBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0);
            pubsequencerpressedAlarmYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            warningYesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            warningNoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            bopiler2YesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            boiler2NoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            boiler3Tapped.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            boiler3NoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            boiler4yesBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            boiler4NoBtn.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            
            clearLightsflashing.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pressedClearAlarmlab.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            dhwPumpdsequenlab.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pumpoperatingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            failurelightsflashinglabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            clearedFlashLightsLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            pressedClrAlarmLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            dhwHeaterLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            waterGuagesTemperature.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            thermometerReadingLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            supplyTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            returnTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            dwhsupply.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            warningcheckLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            b1label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            b1label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            b2label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            b3label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            b4label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            dmaLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
            
            checkFilter.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            checkWaterLevel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            checkForLeaks.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            annualEfficiencytest.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0);
            
           
            
            
        }
        
        headerLabel.text = translator("Inspection");
        TekmarsControlsLabel.text = translator("Tekmar Controls").uppercased();
        outdoorTemp.placeholder = translator("Outdoor Temperature");
        boilerSupplyTemp.placeholder = translator("Boiler Supply Temperature");
        targetTemp.placeholder = translator("Target Temperature");
        BLDGPumpLabel.text = translator("BLDG System Pump").uppercased();
        pumpOperating.placeholder = translator("Pump #1 or #2 Operating");
        pumpOff.placeholder = translator("Pump Off");
        failurelightsflash.text = translator("Failure Lights Flashing");
        lightsFlashingYesBtn.setTitle(translator("Yes"), for: .normal);
         lightsFlashingNoBtn.setTitle(translator("No "), for: .normal);
         clearLightsYesBtn.setTitle(translator("Yes"), for: .normal);
         clearLightsNoBtn.setTitle(translator("No "), for: .normal);
         pressedAlarmYesBtn.setTitle(translator("Yes"), for: .normal);
         pressedAlarmNoBtn.setTitle(translator("No "), for: .normal);
        clearLightsflashing.text = translator("Cleared Lights Flashing");
        
        pressedClearAlarmlab.text = translator("Pressed Clear Alarm") + " ?";
        dhwPumpdsequenlab.text = translator("DHW Pump Sequencer");
        pumpoperatingLabel.text = translator("Pump #1 or #2 Operating");
        
        pumpsequencerFlashingYesBtn.setTitle(translator("Yes"), for: .normal);
         pumpsequencerFlashingLightsYesBtn.setTitle(translator("Yes"), for: .normal);
        pumpSequencerFlashingNoBtn.setTitle(translator("No "), for: .normal);
         pumpsequencerPressedAlarmNoBtn.setTitle(translator("No "), for: .normal);
        pumpsequencerFlasinglightsNoBtn.setTitle(translator("No "), for: .normal);
        
        
        
        DhwPumpYesBtn.setTitle(translator("Yes"), for: .normal);
         DhwPumpNoBtn.setTitle(translator("No "), for: .normal);
         lightsFlashingYesBtn.setTitle(translator("Yes"), for: .normal);
         lightsFlashingNoBtn.setTitle(translator("No "), for: .normal);
         clearLightsYesBtn.setTitle(translator("Yes"), for: .normal);
         clearLightsNoBtn.setTitle(translator("No "), for: .normal);
         pressedAlarmYesBtn.setTitle(translator("Yes"), for: .normal);
         pressedAlarmNoBtn.setTitle(translator("No "), for: .normal);
        failurelightsflashinglabel.text = translator("Failure Lights Flashing");
        clearedFlashLightsLabel.text = translator("Cleared Lights Flashing");
        pressedClrAlarmLabel.text = translator("Pressed Clear Alarm") + " ?";
        dhwHeaterLabel.text = translator("DHW Heater").uppercased();
        waterGuagesTemperature.placeholder = translator("Water gauges temperature");
        thermometerReadingLabel.text = translator("Thermometer Readings").uppercased();
        supplyTemp.placeholder = translator("Supply Temp");
        returnTemp.placeholder = translator("Return Temp");
        dwhsupply.placeholder = translator("DHW Supply Temp After Mixing Valve");
        let wholewarnignTxt = translator("Warning Indicators") + " & " +  translator("Visual Check of Boilers")
        warningcheckLabel.text = wholewarnignTxt.uppercased();
        b1label.text = translator("Boiler") + " 1";
        b2label.text = translator("Boiler") + " 2";
        b3label.text = translator("Boiler") + " 3";
        b4label.text = translator("Boiler") + " 4";
        warningYesBtn.setTitle(translator("Yes"), for: .normal);
        warningNoBtn.setTitle(translator("No "), for: .normal);
        bopiler2YesBtn.setTitle(translator("Yes"), for: .normal);
        boiler2NoBtn.setTitle(translator("No "), for: .normal);
        boiler3Tapped.setTitle(translator("Yes"), for: .normal);
        boiler3NoBtn.setTitle(translator("No "), for: .normal);
        boiler4yesBtn.setTitle(translator("Yes"), for: .normal);
        boiler4NoBtn.setTitle(translator("No "), for: .normal);
        dmaLabel.text = translator("Daily/Monthly/Annual").uppercased();
        checkFilter.placeholder = translator("Check filters 1x Month");
        checkWaterLevel.placeholder = translator("Check water level");
        checkForLeaks.placeholder = translator("Check for leaks");
        annualEfficiencytest.placeholder = translator("Annual Efficiency Test");
        saveBtn.setTitle(translator("Save and Close"), for: .normal);
        cancelBtn.setTitle(translator("Cancel"), for: .normal);
        pubsequencerpressedAlarmYesBtn.setTitle(translator("Yes"), for: .normal);
        
        
    }
    
    
    
    
    
    
    
    func loadingDefaultUI()
    {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        loadingDefaultLang();
        cancelBtn.layer.cornerRadius = 5.0;
        saveBtn.layer.cornerRadius = 5.0;
        cancelBtn.clipsToBounds = true;
        saveBtn.clipsToBounds = true;
        
        CompatibleStatusBar(self.view);
        lightsFlashingNoBtn.isSelected = true;
        clearLightsNoBtn.isSelected = true;
        DhwPumpNoBtn.isSelected = true;
        pressedAlarmNoBtn.isSelected = true;
        pumpSequencerFlashingNoBtn.isSelected = true;
        pumpsequencerFlasinglightsNoBtn.isSelected = true;
        pumpsequencerPressedAlarmNoBtn.isSelected = true;
        warningNoBtn.isSelected = true;
        boiler2NoBtn.isSelected = true;
        boiler3NoBtn.isSelected = true;
        boiler4NoBtn.isSelected = true;
        
        
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
