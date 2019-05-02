//
//  CBMechanicalScanEquipViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 25/03/19.
//  Copyright © 2019 zonupTechnologies. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyJSON

class CBMechanicalScanEquipViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

         loadingDefaultUI();
    }
    var video = AVCaptureVideoPreviewLayer()
    var captureSession = AVCaptureSession()
    var arrRes = [[String:AnyObject]]()
    var equipment_ids = Array<Int>();
    @IBOutlet weak var scantitle: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    var headTitle = "";
    var isscanned = false
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subbervw: UIView!
    
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var generalView: UIView!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated);
        isscanned = false
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false);
    }
    
    
    func loadingDefaultUI()
    {
        
        
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
       
        self.view.bringSubview(toFront: generalView)
        self.view.bringSubview(toFront: scantitle)
        self.view.bringSubview(toFront: backBtn)
         self.view.bringSubview(toFront: headerView)
        self.view.bringSubview(toFront: subbervw)
        
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
                        
                        if mechani_ID == Int(vselectedmechanicalId)!
                        {
                            
                            
                                    
                                    let vController = self.storyboard?.instantiateViewController(withIdentifier: "EquipmentDetailViewController") as! EquipmentDetailViewController
                                   vController.selfequipid = equipment_ID;
                                    vselectedEquipmentID = equipment_ID;
                            
                                    self.navigationController?.pushViewController(vController, animated: true)
                            
                            
                            
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
