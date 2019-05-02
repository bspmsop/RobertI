//
//  DocumentViewController.swift
//  Rathe_Associates
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD
import Reachability

class DocumentViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var wView: UIView!
    
    @IBOutlet var loadSpinner: UIActivityIndicatorView!
    var filePathURL: String!
    var mytitle = "Document Library";
    
    var drawingId = -1
    var webView = WKWebView.init(frame: .zero, configuration: WKWebViewConfiguration());
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadingDefaultUI();
        
      
        
      
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated);
        
        webView.frame = wView.frame;
        
        self.wView.addSubview(webView);
        
        webView.translatesAutoresizingMaskIntoConstraints = false;
        webView.topAnchor.constraint(equalTo: wView.topAnchor).isActive = true;
        webView.bottomAnchor.constraint(equalTo: wView.bottomAnchor).isActive = true;
        webView.leadingAnchor.constraint(equalTo: wView.leadingAnchor).isActive = true;
        webView.trailingAnchor.constraint(equalTo: wView.trailingAnchor).isActive = true;
        
        
        webView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: wView.frame.height);
        
            if filePathURL != nil
            {
            var offlineURLPath = filePathURL!
            print(offlineURLPath);
            print("gotted path");
            filePathURL = ImgFilePathAPI + filePathURL!
            
            filePathURL = filePathURL.replacingOccurrences(of: " ", with: "%20");
            
            
            
            let networkReacher = Reachability()!
            
            if networkReacher.connection == .none
            {
                
                if isOfflineMode
                {
                    offlineURLPath =  offlineURLPath.replacingOccurrences(of: " ", with: "%20");
                    offlineURLPath = offlineURLPath.replacingOccurrences(of: "/", with: "_");
                    print(offlineURLPath);
                    
                    
                    
                    
                    self.loadOfflineData(offlineURLPath)
                    
                    
                    return;
                }
                else
                    
                {
                    let alert = UIAlertController.init(title: translator("Network Alert"), message: translator(networkMsg), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: { (_) in
                        isOfflineMode = true;
                        offlineURLPath =  offlineURLPath.replacingOccurrences(of: " ", with: "%20");
                        offlineURLPath = offlineURLPath.replacingOccurrences(of: "/", with: "_");
                        
                        self.loadOfflineData(offlineURLPath)
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction.init(title: translator("Cancel"), style: .destructive, handler: { (_) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil);
                    return
                    
                    
                    
                    
                }
                
            }
            
            
            
            
            
            
            
            let url = NSURL(string: filePathURL!)
            
            
            if url != nil
            {
                let request = URLRequest(url: url! as URL)
                webView.navigationDelegate = self
                webView.load(request)
//               if  UIApplication.shared.canOpenURL(url! as URL)
//               {
//
//                webView.load(request)
//                }
//                else
//               {
//                print("we cant load url")
//                }
            }
            else
            {
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Invalid URL Request"), preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil);
                loadSpinner.stopAnimating()
            }
            
            
            
            
            
            
            
        }
        
        else
        {
            let alert = UIAlertController.init(title: translator("Alert"), message: translator("Unable to process your request"), preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil);
            loadSpinner.stopAnimating()
        }
        
    }
 
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("got error while loading");
        print(error.localizedDescription);
        print(error.localizedDescription);
        
        loadSpinner.stopAnimating()
        let alert = UIAlertController.init(title: translator("Alert"), message: translator("An internal error occured please try again"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("ok"), style: .destructive, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        
//        print("got error while loading");
//        print(error.localizedDescription);
//        print(error.localizedDescription);
//         loadSpinner.stopAnimating()
//        let alert = UIAlertController.init(title: translator("Alert"), message: translator("An internal error occured please try again"), preferredStyle: .alert);
//        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
//        self.present(alert, animated: true, completion: nil);
        
        
    }
 
    
    
    func loadOfflineData(_ filename : String)
    {
        
        
        
        let myfile = getPath(fileName: filename)
        print("myfile .....")
        print(myfile)
        let isExist = fileManag.fileExists(atPath: myfile)
        if isExist
        {
            
            
            let url = URL.init(fileURLWithPath: myfile)
            
            
            
            
                webView.navigationDelegate = self
                
            webView.loadFileURL(url, allowingReadAccessTo: url)
            
            
            
            
        }
        else
        {
            
            let alert = UIAlertController.init(title: translator("Failed"), message: translator("File does not exist locally"), preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil);
            loadSpinner.stopAnimating()
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadSpinner.stopAnimating()
        
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         loadSpinner.startAnimating()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
         loadSpinner.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loadSpinner.stopAnimating()
        
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //*****Default func **********
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    func loadingDefaultUI()
    {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
        headerLabel.text = translator(mytitle);
        
        
        loadSpinner.isHidden = false;
        self.navigationController?.navigationBar.isHidden = true;
        
    }
    
    
    
}
