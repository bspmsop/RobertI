//
//  ScanQRCodeReaderViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 17/11/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

class ScanQRCodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingDefaultUI();
    }
    
     var video = AVCaptureVideoPreviewLayer()
    var captureSession = AVCaptureSession()
     var arrRes = [[String:AnyObject]]()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scanTitle: UILabel!
    
    @IBOutlet weak var generalview: UIView!
    @IBOutlet weak var square: UIImageView!
    var equipment_ids = Array<Int>();
    var headTitle = "";
    var isscanned = false
    
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false);
    }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        isscanned = false
    }

    
    
    func loadingDefaultUI()
    {
        
        scanTitle.text = translator("Scan");
        self.navigationController?.navigationBar.isHidden = true;
        
        let session = AVCaptureSession()
        
        //Define capture devcie
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
            
            let alerrt = UIAlertController.init(title: translator("Failed"), message: translator("Camera authorization has been denied"), preferredStyle: .alert);
            alerrt.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true);
            }))
            self.present(alerrt, animated: true, completion: nil)
            return
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: square)
         self.view.bringSubview(toFront: headerView)
         self.view.bringSubview(toFront: generalview)
        
        session.startRunning()
        
        
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if  isscanned == false
        {
        if      metadataObjects.count != 0
        {
            isscanned = true;
            
            
            
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    
                    
                   
                    
                    let outoputstr = object.stringValue;
                    var outputArray = outoputstr?.components(separatedBy: ",");
                    
                    
                    
                    
                    var mechani_ID = 0
                    var equipment_ID = "0"
                    
                    if outputArray == nil
                    {
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please select valid equipment QR code"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: { (_) in
                            self.isscanned = false
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    if outputArray!.count > 1
                    {
                        
                        
                          let mecharray = outputArray![0].components(separatedBy: ":");
                        let equiparray = outputArray![1].components(separatedBy: ":");
                        
                        let mychanicalId = Int(mecharray[1].replacingOccurrences(of: " ", with: ""));
                        
                        
                        if mychanicalId == nil
                        {
                            
                            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please select valid equipment QR code"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: { (_) in
                                self.isscanned = false
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                        else
                        {
                        mechani_ID  = mychanicalId!
                         
                        equipment_ID  =  equiparray[1].replacingOccurrences(of: " ", with: "")
                        }
                    }
                    else
                    {
                        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please select valid equipment QR code"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: { (_) in
                            self.isscanned = false
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    
                    
                   
                   
                    print(mechani_ID);
                     print(equipment_ID);
                    print(mechanicalRoomID);
                    
                    if mechani_ID == mechanicalRoomID
                    {
                    for i in 0..<equipment_ids.count
                    {
                        let equippmeStr = String(equipment_ids[i])
                        if equippmeStr == equipment_ID
                        {
                            
                            print(equippmeStr);
                            
                            var dict = arrRes[i]
                            
                            let eqpTitle = dict["title"] as! String
                            let eqpModel = dict["model"] as? String
                            let eqpSerial = dict["serial"] as? String
                            
                            let storyboard = UIStoryboard(name: "super", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "EquipmentViewController") as! EquipmentViewController
                            
                            let equipmentId = dict["id"] as? Int
                            
                            
                            
                            if equipmentId == nil
                            {
                                controller.equId =  -1;
                            }
                            else
                            {
                                controller.equId = equipmentId!
                                
                            }
                            
                            controller.mechId = mechanicalRoomID
                            controller.eqipTitle = eqpTitle
                            controller.eqipModel = eqpModel
                            controller.eqipSerial = eqpSerial
                            controller.mechanicalTitle = headTitle;
                            controller.effId = dict["effid"] as! Int
                            print(controller.effId);
                            let efficiencyname = dict["effname"] as? String
                            if efficiencyname != nil
                            {
                                controller.efficiencyTitle = efficiencyname!
                                
                            }
                            
                            self.navigationController?.pushViewController(controller, animated: true)
                            
                            break;
                        }
                        else
                        {
                            if i == equipment_ids.count - 1
                            {
                                isscanned = false;
                                let alert = UIAlertController(title: translator("Failed"), message: translator("Please select valid equipment QR code"), preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: translator("Ok"), style: .default, handler: nil))
                                
                                
                                present(alert, animated: true, completion: nil)
                            }
                            
                        }
                    }
                    
                }
                    
                    
                   
                    
                    
           
                else
                {
                    
                    
                    let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please select valid equipment QR code"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: { (_) in
                        self.isscanned = false
                    }))
                    
                    
                    
                    
                    self.present(alert, animated: true, completion: nil);
                    
                }
               }
        }
        
    }
        
        
    }
    

}
}
