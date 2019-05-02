//
//  LanguageViewController.swift
//  Rathe_Associates
//
//  Created by nagamani on 15/12/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import Reachability


class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

       loadingDefaultUI()
    }
    
    var langauageHud = MBProgressHUD();

   let languages = [["lang": "Afrikaans", "elong": "af"],["lang": "Albanian", "elong": "sq"], ["lang": "Armenian", "elong": "hy"], ["lang": "Azerbaijani", "elong": "az"], ["lang": "Basque", "elong": "eu"], ["lang": "Belarusian", "elong": "be"], ["lang": "Bengali", "elong": "bn"], ["lang": "Bosnian", "elong": "bs"], ["lang": "Bulgarian", "elong": "bg"], ["lang": "Catalan", "elong": "ca"], ["lang": "Cebuano", "elong": "ceb"], ["lang": "Chichewa", "elong": "ny"], ["lang": "Chinese Simplified", "elong": "zh-cn"], ["lang": "Corsican", "elong": "co"], ["lang": "Czech", "elong": "cs"], ["lang": "Danish", "elong": "da"], ["lang": "Dutch", "elong": "nl"], ["lang": "English", "elong": "en"], ["lang": "Esperanto", "elong": "eo"], ["lang": "Estonian", "elong": "et"], ["lang": "Filipino", "elong": "tl"], ["lang": "Finnish", "elong": "fi"], ["lang": "French", "elong": "fr"], ["lang": "Frisian", "elong": "fy"], ["lang": "Galician", "elong": "gl"], ["lang": "Georgian", "elong": "ka"], ["lang": "German", "elong": "de"], ["lang": "Greek", "elong": "el"], ["lang": "Gujarati", "elong": "ht"], ["lang": "Hausa", "elong": "ha"], ["lang": "Hawaiian", "elong": "haw"], ["lang": "Hebrew", "elong": "iw"], ["lang": "Hindi", "elong": "hi"], ["lang": "Hmong", "elong": "hmn"], ["lang": "Hungarian", "elong": "hu"], ["lang": "Icelandic", "elong": "is"], ["lang": "Igbo", "elong": "ig"], ["lang": "Indonesian", "elong": "id"], ["lang": "Irish", "elong": "ga"], ["lang": "Italian", "elong": "it"],["lang": "Japanese", "elong": "ja"], ["lang": "Javanese", "elong": "jw"], ["lang": "Kannada", "elong": "kn"], ["lang": "Kazakh", "elong": "kk"], ["lang": "Khmer", "elong": "km"], ["lang": "Korean", "elong": "ko"], ["lang": "Lao", "elong": "lo"], ["lang": "Latin", "elong": "la"], ["lang": "Mongolian", "elong": "mn"], ["lang": "Nepali", "elong": "ne"], ["lang": "Portuguese", "elong": "pt"], ["lang": "Romanian", "elong": "ro"], ["lang": "Russian", "elong": "ru"], ["lang": "Spanish", "elong": "es"], ["lang": "Swedish", "elong": "sv"], ["lang": "Zulu", "elong": "zu"] ];
    
    
    /*'zu': 'Zulu'
    'lv': 'Latvian',
    'lt': 'Lithuanian',
    'lb': 'Luxembourgish',
    'mk': 'Macedonian',
    'mg': 'Malagasy',
    'ms': 'Malay',
    'ml': 'Malayalam',
    'mt': 'Maltese',
    'mi': 'Maori',
    'mr': 'Marathi',
    'mn': 'Mongolian',
    'my': 'Myanmar (Burmese)',
    'ne': 'Nepali',
    'no': 'Norwegian',
    'ps': 'Pashto',
    'fa': 'Persian',
    'pl': 'Polish',
    'pt': 'Portuguese',
    'ma': 'Punjabi',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sm': 'Samoan',
    'gd': 'Scots Gaelic',
    'sr': 'Serbian',
    'st': 'Sesotho',
    'sn': 'Shona',
    'sd': 'Sindhi',
    'si': 'Sinhala',
    'sk': 'Slovak',
    'sl': 'Slovenian',
    'so': 'Somali',
    'es': 'Spanish',
    'su': 'Sundanese',
    'sw': 'Swahili',
    'sv': 'Swedish',
    'tg': 'Tajik',
    'ta': 'Tamil',
    'te': 'Telugu',
    'th': 'Thai',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'ur': 'Urdu',
    'uz': 'Uzbek',
    'vi': 'Vietnamese',
    'cy': 'Welsh',
    'xh': 'Xhosa',
    'yi': 'Yiddish',
    'yo': 'Yoruba',
    'zu': 'Zulu'
    
    */
    
    
    
    
    
    @IBAction func closeWindow(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil);
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let netreach = Reachability.init()!;
       if  netreach.connection == .none
            {
                let alert = UIAlertController.init(title: translator("Alert"), message: translator("Please check your network connection and try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
                return
        }
        
        
        
        
        
        langauageHud = MBProgressHUD.showAdded(to: self.view, animated: true);
        if languages[indexPath.row]["elong"] != "en"
        {
            let lcode = demolanguages[indexPath.row]["elong"];
            print("lang code is \(lcode)")
          switch lcode
          {
          case "nef":
            stringSeparator = "("
            stringSeparator2 = ")"
          case "afdd":
            stringSeparator = "["
            stringSeparator2 = "]"
            
          default:
            stringSeparator = ""
            stringSeparator2 = ". "
            
            
            
          }
            
            
            loadLanguageData(demolanguages[indexPath.row]["elong"]!)
        }
        else
        {
            
            cachem.set("en", forKey: "lang")
            
            cachem.set(DlData, forKey: "dlang")
             let controlller = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "superRevealViewController")
              self.present(controlller, animated: false, completion: nil);
        }
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demolanguages.count;
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "langCellClass") as! langCellClass
        cell.title.text = demolanguages[indexPath.row]["lang"];
        
        
        return cell;
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50;
        
    }
    
    
    
    
    
    var stringSeparator : String = ""
    var stringSeparator2 : String = ""
   
    func loadLanguageData(_ lcode : String)
    {
        var defaultDict =  DlData;
        var Allvalues = "";
        
        for (_ , value) in defaultDict
        {
            let lvalue = value.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "&", with: "")
            
            if Allvalues != ""
            {
                Allvalues = Allvalues + stringSeparator + lvalue + stringSeparator2;
            }
            else
            {
                Allvalues = stringSeparator + lvalue + stringSeparator2
            }
            
        }
        
        Allvalues = Allvalues.replacingOccurrences(of: " ", with: "%20");
        
        
        
        print(Allvalues);
        
        
       // https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=hi&dt=t&q=Are%20you%20sure%20%20want%20to%20logout%20from%20the%20app.Success.Alert.Please%20Select%20Mechanical%20Room.Home.No%20network%20connection%20would%20you%20like%20to%20use%20offline%20data.Password.Forgot%20your%20password.Cancel.Yes.Dashboard.Logout.Email.Select%20Building.Sync.Fog.Please%20Select%20Building.Sign%20In.Search.Failed.Hello.Ok.sand.Network%20Alert.Building.
        
        Alamofire.request("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=\(lcode)&dt=t&q=\(Allvalues)").responseJSON { (resp) in
            print(resp.result);
            if resp.result.isSuccess
            {
                cachem.set(lcode, forKey: "lang")
                
                let meidatrdata = resp.result.value as? Array<Any>
                print(meidatrdata);
                
                if meidatrdata != nil
                {
                    
                    if meidatrdata!.count > 0
                    {
                        
                        let data1 = meidatrdata![0] as? Array<Any>;
                        
                        if data1 != nil
                        {
                            
                            if data1!.count > 0
                            {
                                
                                for l in 0..<data1!.count
                                {
                                
                                
                                let data2 = data1![l] as? Array<Any>;
                                
                                if data2 != nil
                                {
                                    if data2!.count > 1
                                    {
                                        
                                        print(data2!);
                                   
                                        
                                        
                                        
                                            var firstStr = data2![0] as? String
                                            var secondStr = data2![1] as? String
                                       
                                        
                                            if firstStr != nil || secondStr != nil
                                            {
                                                firstStr = firstStr!.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "&", with: "").replacingOccurrences(of: self.stringSeparator, with: "");
                                                firstStr = firstStr!.replacingOccurrences(of: ". ", with: "");
                                                firstStr = firstStr!.replacingOccurrences(of: ".", with: "");
                                                
                                                
                                                secondStr = secondStr!.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "&", with: "").replacingOccurrences(of: self.stringSeparator, with: "");
                                                  secondStr = secondStr!.replacingOccurrences(of: ". ", with: "")
                                                secondStr = secondStr!.replacingOccurrences(of: ".", with: "")
                                                
                                                
                                                
                                                print(firstStr);
                                                print(secondStr);
                                                
                                                
                                                
                                                
                                                        
                                                        for (_, key1) in defaultDict
                                                        {
                                                            
                                                            let mykey = key1.replacingOccurrences(of: "#", with: "")
                                                            if mykey == secondStr
                                                            {
                                                                defaultDict[key1.lowercased()] = firstStr
                                                            }
                                                        }
                                                        
                                                        
                                                        
                                                        
                                                
                                                    
                                                    
                                                    
                                                
                                                
                                                
                                                
                                                
                                              
                                                
                                                
                                                
                                            }
                                            
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                               
                                
                            }
                            
                                print(defaultDict);
                                cachem.set(defaultDict, forKey: "dlang")
                                
                                
                                let controlller = UIStoryboard.init(name: "super", bundle: nil).instantiateViewController(withIdentifier: "superRevealViewController")
                                self.present(controlller, animated: false, completion: nil);
                                
                                
                                return;
                            
                            
                            
                            
                            
                            
                            
                             
                                
                                
                            }
                            
                            
                            
                        }
                    
                    }
                   
                }
                
               
                
            }
            
            
            self.showFailedAlert()
            
            
        }
        
        
    
    
    

        
        
    
        
    }
    
    
    
    
    func showFailedAlert()
    {
        langauageHud.hide(animated: true);
        let alert = UIAlertController.init(title: translator("Alert"), message: translator("Failed to change your language please try again"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
        
        
    }
    
    
    
    
    
    @IBAction func searchingLang(_ sender: UITextField) {
        
        
        
        if sender.text != ""
        {
            demolanguages = [];
            
            for i in 0..<languages.count
            {
                
                let dict = languages[i]
                var estr = dict["lang"]
                estr = estr!.lowercased();
                if (estr!.contains(sender.text!.lowercased()))
                {
                    demolanguages.append(languages[i]);
                }
            }
        }
        else
        {
            demolanguages = languages
        }
        langTable.reloadData();
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //------default Func--------------
    
    
    @IBOutlet weak var headerLab: UILabel!
    @IBOutlet weak var searchText: UITextField!
    var demolanguages = Array<Dictionary<String, String>>();
    @IBOutlet weak var langTable: UITableView!
    
    func loadingDefaultUI()
    {
        headerLab.text = translator("Choose Language");
        searchText.placeholder = translator("Search");
       demolanguages =  languages
        langTable.reloadData();
        
        
    }
    
    
    
    
    

}




class langCellClass : UITableViewCell
{
    @IBOutlet weak var title: UILabel!
    
    
}
