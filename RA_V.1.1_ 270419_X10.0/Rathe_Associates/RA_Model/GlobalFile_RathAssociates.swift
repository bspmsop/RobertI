import Foundation
import UIKit
import Reachability
import SwiftyStoreKit
import StoreKit
import ScrollingFollowView
import SWRevealViewController
import Alamofire
import FMDB
import MBProgressHUD
import SwiftyJSON


//*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- Custom Vaiables *-*-*-*-*-*-*-**--*-*-*--*-*--*-*-*-*-*-*-*


//--------Rathe_Associates API -------

/*

Admin -> 0
Super -> 1
Building Manager -> 2
Corporate Manager -> 3
Rathe Admin -> 4


*/



//------ Global Variables ----------
let apiCaller = ApiClassRatheAssociates();
let netReach = Reachability()!
let cachem = UserDefaults.standard;
var isLanguageChanged = false;
var isCompleteTransCalled = false;
var RAData = "\n \n ";
var downloadingProgress = Double();
let fileManag = FileManager.default;
var state =  1;
var mechanicalRoomName = "";
var mechanicalRoomID : Int =  -1
var loadLanguage = false;
var blueColor = "0CAEC6";
var headerFontSize : CGFloat = 18;
var  simplex = 18;
var warningMessage = "";
var user = 0;
var GbuildIdentifier  = -1
var IphoneX = 120.0;
var inspectionIDG : Int =  -1
var IphoneXR = 120.0;
var IphoneXSMAX = 120.0;
var IphoneXS = 120.0;
var OtherIphone = 44.0;
var rowidentifier = 12;
var sethteflow = true;
var statusHeight = 0.0;
var viewWindow = UIWindow()
var GlobalNav  : UINavigationController? = nil;
var GlobalNav2  : UINavigationController? = nil;
var isOfflineMode = false;
var Globalreveal : SWRevealViewController? = nil
var timerStatus = false;
 var Gmenu = [Dictionary<String, String>]();
var logstatus = "logstatus";
var isFromBackGround = false;
var GequipmentId = -1
var RaDemoData = "\n \n \n \n \n \n \n";
var networkMsg = "No network connection would you like to use offline data";
var isSyncRunning = false;
var work1 : DispatchWorkItem? = nil
var work2 : DispatchWorkItem? = nil
var GroomTitle = "";

var backgroundThred : DispatchWorkItem? = nil
var isEmergencyStop = false;

var bundle_DB = "FMDatabase2.sqlite"
var locale_DB = "RADB2"

var isSyncCompleted = false;
var vselectedbuildingId : String  = "0";
var vselectedmechanicalId : String  = "0";
var vselectedmechtitrle : String  = "";
var vselectedEquipmentID : String  = "0";
var refreshdata = false;
var gisFromDashboard = false;








/*


//Mechanical Room Sign In  **************************************

"MechanicalRooms" = "Mechanical Rooms";
"SELECTMECHANICALROOM" = "SELECT MECHANICAL ROOM";
"SelectMechanicalRoom" = "Select Mechanical Room";



//SYNC  **************************************

"Downloadallthedocuments(MechanicalRooms,Equipments,etc..)Whentheinternetaccessisavailable" = "Download all the documents(Mechanical Rooms, Equipments, etc..) When the internet access is available";

"Sync" = "Sync";




*/


var GPMenu = [["name": "Dashboard" , "id": "0", "img" : "dashboard", "isfull":"1", "isread": "", "isnodelete":""],
                 ["name": "Buildings" , "id": "1", "img" : "buildings", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Custom Inspectionsheets" , "id": "2", "img" : "userMangment", "isfull":"", "isread": "", "isnodelete":""], ["name": "Equipment Test" , "id": "3", "img" : "mech", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Mechanical Rooms" , "id": "4", "img" : "buildings", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Equipment" , "id": "5", "img" : "reports", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Inspections" , "id": "6", "img" : "subscribe", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Notifications" , "id": "7", "img" : "reports", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Reports" , "id": "8", "img" : "mech", "imgr":"menuright", "imaged" : "menudown", "isfull":"", "isread": "", "isnodelete":"", "id1" :"", "id2":"", "id3":"", "id4":"", "id5":""],
                 ["name": "Companies" , "id": "9", "img" : "dashboard", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "User Management" , "id": "10", "img" : "userMangment", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "Subscriptions" , "id": "11", "img" : "subscribe", "isfull":"", "isread": "", "isnodelete":""],
                 ["name": "SYNC" , "id": "12", "img" : "sync", "isfull":"", "isread": "", "isnodelete":""],["name": "My Profile" , "id": "13", "img" : "user11", "isfull":"1", "isread": "", "isnodelete":""],
                 ["name": "Logout" , "id": "14", "img" : "logout", "isfull":"1", "isread": "", "isnodelete":""]];


var DlData = [
    
    "email" : "Email",
    "password": "Password",
    "sign in": "Sign In",
    "forgot your password" : "Forgot your password",
    "building": "Building",
    
    "select building" : "Select Building",
    "search" : "Search",
    "are you sure  want to logout from the app" : "Are you sure  want to logout from the app",
    "please select mechanical room" : "Please Select Mechanical Room" ,
    "please select building" : "Please Select Building",
    "yes" : "Yes",
    "no " : "No ",
    "ok" : "Ok",
    "network alert" : "Network Alert",
    "no network connection would you like to use offline data" : "No network connection would you like to use offline data",
    "cancel" : "Cancel",
    "success" : "Success",
    "failed" : "Failed",
    "dashboard" : "Dashboard",
    "sync" : "Sync",
    "logout" : "Logout",
    "alert" : "Alert",
    "select mechanical room" : "Select Mechanical Room",
    "equipment" : "Equipment",
    "inspection form" : "Inspection Form",
    "scan equipment" : "Scan Equipment",
    "perform inspection" : "Perform Inspection",
    "sign out" : "Sign out",
    "scan" : "Scan",
    "model" : "Model",
    "serial" : "Serial",
    "document library" : "Document Library",
    "equipment test forms" : "Equipment Test Forms",
    "vendor Repair" : "Vendor Repair",
    "vendor Repairs" : "Vendor Repairs",
    "perform efficiency test" : "Perform Efficiency Test",
    "vendor repair summary" : "VENDOR REPAIR SUMMARY",
    "select document" : "Select document",
    "no documents" : "No documents",
    "vendor name" : "Vendor Name",
    "job status" : "Job Status",
    "repair details" : "Repair Details",
    "enter repair notes here" : "Enter repair notes here",
    "save and close" : "Save and Close",
    "efficiency test" : "Efficiency Test",
    "inspection" : "Inspection",
    "search equipment or repair status" : "Search equipment or repair status",
    "search documents" : "Search documents",
    "your request has been timed out, would you like to use offline data" : "Your request has been timed out, would you like to use offline data",
    "camera authorization has been denied" : "Camera authorization has been denied",
    "please select valid equipment qr code" : "Please select valid equipment QR code",
    "no netork connection, wouild you like to save in local" : "No netork connection, wouild you like to save in local",
    "successfully added a vendor" : "Successfully added a vendor",
    "successfully added a vendor to local database" : "Successfully added a vendor to local Database",
    "user signin mechanical room" : "User Signin Mechanical Room",
    "no data available" : "No data available",
    "please check your network connection and try again" : "Please check your network connection and try again",
    "failed to change your language please try again" : "Failed to change your language please try again",
    "your request has been timed out would like to use offline data" : "Your request has been timed out Would like to use offline data",
    "user signout mechanical room" : "User Signout Mechanical Room",
    "default inspection form" : "Default Inspection Form",
    
    "no netork connection wouild you like to save in local" : "No netork connection wouild you like to save in local",
    "your request has been timed out wouild you like to save in local database" : "Your request has been timed out Wouild you like to save in local database",
    "please enter all the fields" : "Please enter all the fields",
    "date" : "Date",
    "overall efficiency" : "Overall Efficiency",
    "invalid url request" : "Invalid URL Request",
    "unable to process your request" : "Unable to process your request",
    "an internal error occured please try again" : "An internal error occured please try again",
    "file does not exist locally" : "File does not exist locally",
    "repair history" : "Repair History",
    "no network connection would you like to save changes in local database" : "No network connection would you like to save changes in local database",
    "vendor information updated successfully" : "Vendor information updated successfully",
    "your request has been timed out please try again" : "Your request has been timed out please try again",
    "save" : "Save",
    "download all the documents(mechanical rooms, equipments, etc) when the internet access is available" : "Download all the documents(Mechanical Rooms, Equipments, etc) When the internet access is available",
    "choose file" : "Choose File",
    "please fill required fields" : "Please fill required fields",
    "unable to save attached file to the server please try again" : "Unable to save attached file to the server please try again",
    "choose below" : "Choose below",
    "gallery" : "Gallery",
    "more" : "More",
    "file size is too large" : "File size is too large",
    "successfully saved efficiency test sheet in local database" : "Successfully saved efficiency test sheet in local database",
    "please select valid image" : "Please select valid image",
    "inspection sheet saved successfully" : "Inspection sheet saved successfully",
    "efficiency test sheet saved successfully" : "Efficiency test sheet saved successfully",
    "successfully saved inspection sheet in local database" : "Successfully saved inspection sheet in local database",
    "no network connection please try again" : "No network connection please try again",
    "an internal error occured" : "An internal error occured",
    "sync successfully Completed" : "SYNC Successfully Completed",
    "choose language" : "Choose Language",
    "tekmar controls" : "Tekmar Controls",
    "outdoor temperature" : "Outdoor Temperature",
    "boiler supply temperature" : "Boiler Supply Temperature",
    "target temperature" : "Target Temperature",
    "bldg system pump" : "BLDG System pump",
    "pump #1 or #2 operating" : "Pump #1 or #2 Operating",
    "pump off" : "Pump Off",
    "failure lights flashing" : "Failure Lights Flashing",
    "cleared lights flashing" : "Cleared Lights Flashing",
    "pressed clear alarm" : "Pressed Clear Alarm",
    "dhw pump sequencer" : "DHW Pump Sequencer",
    "dhw heater" : "DHW Heater",
    "water guages temperature" : "Water gauges temperature",
    "thermometer readings" : "Thermometer Readings",
    "supply temp" : "Supply Temp",
    "return temp" : "Return Temp",
    "dhw supply temp after mixing valve" : "DHW Supply Temp After Mixing Valve",
    
    "boiler" : "Boiler",
    
    "daily/monthly/annual" : "Daily/Monthly/Annual",
    "check filters 1x month" : "Check filters 1x Month",
    "check water level" : "Check water level",
    "check for leaks" : "Check for leaks",
    "annual efficiency test" : "Annual Efficiency Test",
    "warning indicators" : "Warning Indicators",
    "visual check of boilers" : "Visual Check of Boilers"

    
];


var GPAdmiMenu = [["name": "Dashboard" , "id": "0", "img" : "dashboard", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Buildings" , "id": "1", "img" : "buildings", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Custom Inspectionsheets" , "id": "2", "img" : "userMangment", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Equipment Test" , "id": "3", "img" : "mech", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Mechanical Rooms" , "id": "4", "img" : "buildings", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Equipment" , "id": "5", "img" : "reports", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Inspections" , "id": "6", "img" : "subscribe", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Notifications" , "id": "7", "img" : "reports", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Reports" , "id": "8", "img" : "mech", "imgr":"menuright", "imaged" : "menudown", "isfull":"", "isread": "", "isnodelete":"", "id1" :"1", "id2":"1", "id3":"1", "id4":"1", "id5":"1"],
              ["name": "Companies" , "id": "9", "img" : "dashboard", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "User Management" , "id": "10", "img" : "userMangment", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Subscriptions" , "id": "11", "img" : "subscribe", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "SYNC" , "id": "12", "img" : "sync", "isfull":"1", "isread": "1", "isnodelete":"1"],["name": "My Profile" , "id": "13", "img" : "user11", "isfull":"1", "isread": "", "isnodelete":""],
              ["name": "Logout" , "id": "14", "img" : "logout", "isfull":"1", "isread": "", "isnodelete":""]];


public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            IphoneX = OtherIphone + 22.0;
            statusHeight = IphoneX + IphoneXSMAX;
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            
            switch identifier {
            case "iPod5,1":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPod Touch 5"
            case "iPod7,1":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":
                IphoneX = OtherIphone + IphoneXS;
                 statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPhone 4"
            case "iPhone4,1":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPhone 5s"
            case "iPhone7,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 6"
            case "iPhone7,1":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 6 Plus"
            case "iPhone8,1":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPhone 6s"
            case "iPhone8,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 7 Plus"
            case "iPhone8,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":
                IphoneX = OtherIphone + IphoneXS;
                 statusHeight = IphoneX -  OtherIphone + statusHeight;
                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX +  OtherIphone;
                return "iPhone X"
            case "iPhone11,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX + OtherIphone + IphoneXS;
                return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                 statusHeight = IphoneX + OtherIphone + IphoneXS + IphoneXSMAX;
                return "iPhone XS Max"
            case "iPhone11,8":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                 statusHeight = IphoneX + OtherIphone + IphoneXS + IphoneXSMAX + IphoneXR;
                return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                
                return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Air"
            case "iPad5,3", "iPad5,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Air 2"
            case "iPad6,11", "iPad6,12":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad 5"
            case "iPad7,5", "iPad7,6":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "iPad Pro 10.5 Inch"
            case "AppleTV5,3":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "Apple TV"
            case "AppleTV6,2":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "Apple TV 4K"
            case "AudioAccessory1,1":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "HomePod"
                
                
            case "i386", "x86_64":
                IphoneX = OtherIphone + IphoneXS;
                statusHeight = IphoneX -  OtherIphone;
                return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }

            
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}


class UIBotton : UIButton
{
    var hasTag = 0;
    var hederImg : UIImageView? = nil
    var radioBtn = UIButton();
    var jobstatus = "";
    var notes = ""
    var setTitlein = IndexPath.init(row: 0, section: 0);
    var vendorName  = "";
    var vendorId : Int32 = -1;
    var IradioBtns = [UIButton]();
    var uniqueId = ""
    var myparentVw = UIView();
    var myimageVw  = UIImageView();
    var actei = UIActivityIndicatorView();
    
    
}
 
func CompatibleStatusBar(_ viwer : UIView?)
{
    
    let statusView = UIView();
    let modelName = UIDevice.modelName
    
    if viwer == nil || viwer == UIView()
    {
    statusView.frame = CGRect.init(x: 0.0, y: 0.0, width: (viwer?.frame.width) as! Double , height: statusHeight);
        
    }
    viewWindow.addSubview(statusView)
    
    
    
}



class UITextVw : UITextView
{
    
    
     var setTitlein = IndexPath.init(row: 0, section: 0);
    
}

class InspectionTextFieldCellClass: UITableViewCell
{
    @IBOutlet weak var innerTextField: UITextFeild!
    
    @IBOutlet weak var upprView: NSLayoutConstraint!
    
    
    @IBOutlet weak var underline: UILabel!
    
    
    
    
}

    
    
    
class   InspectionRadiocellClass : UITableViewCell
{
    
    @IBOutlet weak var radioTitle: UILabel!
    var yesBtn = UIBotton();
    var noBtn = UIBotton()
    
}


 func getPath(fileName: String) -> String {
    
    let documentsURL = fileManag.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileURL = documentsURL.appendingPathComponent(fileName)
    
    print(fileURL)
    return fileURL.path
}

func getPathURL(fileName: String) -> URL {
    
    let documentsURL = fileManag.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileURL = documentsURL.appendingPathComponent(fileName)
    
    print(fileURL)
    return fileURL 
}



class InspectionsubmitBtncellClass : UITableViewCell
{
     
    @IBOutlet weak var hoBtn: NSLayoutConstraint!
    @IBOutlet weak var topPadding: NSLayoutConstraint!
    @IBOutlet weak var topBorder: NSLayoutConstraint!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    @IBOutlet weak var saveBtn: UIBotton!
    
    
    func loadingDefaultUI()
    {
        
        saveBtn.layer.cornerRadius = 5.0;
        saveBtn.clipsToBounds = true;
        
        
        
    }
    
    
    
    
}


class UITextFeild : UITextField
{
    
    var texet = IndexPath.init(row: 0, section: 0);
    var  hastag = 0;
    var kbType = 0;
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:))
        {
        
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    
}


class InspectionDropdownncellClass : UITableViewCell
{
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var dropDownField: UITextFeild!
    
    
    @IBOutlet weak var underbar: UILabel!
    
    
    
}




class InspectioncheckBoxcellClass : UITableViewCell
{
    @IBOutlet weak var firstBtn: UIBotton!
    @IBOutlet weak var secondBtn: UIBotton!
    
    @IBOutlet weak var checkBoxTitle: UILabel!
    
    
    
    
    
    
    
}


class InspectiontextAreacellClass : UITableViewCell
{
    
    
    @IBOutlet weak var textareaField: UITxtView!
    
    @IBOutlet weak var textareaTitle: UILabel!
    
    
    
    
    
    
    
    
    
}


class UITxtView : UITextView
{
    
    
    var textId = IndexPath.init(row: 0, section: 0);
    
    
    
}















//******************* Timer class ****************


class GlobalTimer {
    
   public static let sharedTimer: GlobalTimer = GlobalTimer()
    
     public static let backgroundSyn : GlobalTimer = GlobalTimer()
    var internalTimer: Timer?
    
    var controller = UIViewController();
    
    
    
    
    func startSync(_ sender : UIViewController)
    {
        /*
        print("start sync background");
        controller = sender;
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilitySaved(note:)), name:  .reachabilityChanged , object: netReach)
        do{
            try  netReach.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        */
        
    }
    
    
    
    
    @objc func reachabilitySaved(note: Notification) {
        
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

        
        let reach = note.object as! Reachability

        if reach.connection != .none
        {
            if !isSyncRunning
            {

                print("GlobalSyncStarted")
                isSyncRunning = true;
                
                backgroundThred = DispatchWorkItem.init(block: {
                    isFromBackGround = true
                    fetchingLocalDB(self.controller);
                })
                
                DispatchQueue.global().async(execute: backgroundThred!);

            }
             else
            {
               
                
                
            }
            
        }
                
            else
          {
            isSyncRunning = false;
            
            }
 
        
    }
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    func startTimer(){
         //32400
        print("timer started");
        self.internalTimer = Timer.scheduledTimer(timeInterval: 32400, target: self, selector: #selector(fireTimerAction(_ :)), userInfo: nil, repeats: false)
        
        
        
        
    }
    
    func stopTimer(){
        print("timer stopped")
        
        guard self.internalTimer != nil else {
            fatalError("No timer active, start the timer before you stop it.")
        }
        self.internalTimer?.invalidate()
    }
    
    @objc func fireTimerAction(_ sender: Timer){
         print("timer fired........")
        
        if GlobalNav != nil
        {
            
            
        if GlobalNav2 != nil
        {
            GlobalNav2?.dismiss(animated: false, completion: nil);
            GlobalNav?.dismiss(animated: false, completion: nil)
            
            
          }
            else
        {
             GlobalNav?.dismiss(animated: false, completion: nil)
            
            
            }
            
            
            
            
            
        }
        
    }
   
}



//************************************* SYNC Methods *******************************************************************************************************************

var localvendorId = 0;
var editorVendorId = 0;
var signInmechCounter = 0;
var inspectionGCounter = 0;
var efficiencyGCounter = 0;


var localVendorData = Array<Dictionary<String, Any>>();
var editedVendorData = Array<Dictionary<String, Any>>();
var mechSignInData =  Array<Dictionary<String, Any>>();
var inspectionGData =  Array<Dictionary<String, Any>>();
var efficiencyGData =  Array<Dictionary<String, Any>>();


var LVCcount = 0
var EVCount = 0
var MSCount = 0
var InCount =  0
var EffCount = 0
var DOCount  = 0
var TCCount : CGFloat  = 0
var NCCount : CGFloat = 0

 var GShud = MBProgressHUD();
var GSuserid: String? = nil;
var GSuserType : String? = nil;








func fetchingLocalDB(_ selfi: UIViewController)
{
    isSyncCompleted = false;
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }
    print("data fetching strted..");
    editorVendorId = 0
    localvendorId = 0;
    signInmechCounter = 0;
    inspectionGCounter = 0;
    efficiencyGCounter = 0;
    
      LVCcount = 0
      EVCount = 0
      MSCount = 0
      InCount =  0
      EffCount = 0
      DOCount  = 0
      TCCount  = 0
      NCCount = 0
    
    localVendorData = Array<Dictionary<String, Any>>();
    editedVendorData = Array<Dictionary<String, Any>>();
    mechSignInData = Array<Dictionary<String, Any>>();
    inspectionGData = Array<Dictionary<String, Any>>();
    efficiencyGData = Array<Dictionary<String, Any>>();
    
    
    let defaultValues = UserDefaults.standard
     GSuserid = defaultValues.string(forKey: "userid")
     GSuserType = defaultValues.string(forKey: "userType")
    
    
    
    
    let mynetwork = Reachability()!
    if mynetwork.connection == .none
    {
        if !isFromBackGround
        {
        let alert = UIAlertController.init(title: translator("Alert"), message: translator("No network connection please try again"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .default, handler: nil))
        selfi.present(alert, animated: true, completion: nil)
            isSyncRunning = false;
        return
        }
    }
    
    if !isFromBackGround
    {
    GShud = MBProgressHUD.showAdded(to: selfi.view, animated: true);
        GShud.label.text = "Processing your files..."
    GShud.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    GShud.bezelView.color = UIColor.white;
    }
    
    let filePath = getPath(fileName: locale_DB);
    
    let RAdb = FMDatabase.init(path: filePath);
    guard RAdb.open() else {
        print("Unable to open database")
        return
    }
    do {
        
        let defaultValues = UserDefaults.standard
        let userid = defaultValues.string(forKey: "userid")
        
        
        
        //vendorList2---------------------------------------------------------------------------------------------------------------
        
        let rs = try RAdb.executeQuery("select * from vendorList2 where userid = ?", values: [userid!])
        while rs.next() {
            if let x = rs.string(forColumn: "vendorname"), let y = rs.string(forColumn: "jobstatus"), let z = rs.string(forColumn: "notes"), let j = rs.string(forColumn: "datesaved"), let l = rs.string(forColumn: "uniqueUserid") {
                let v = rs.int(forColumn: "equipmentid");
                
                print("x = \(x); y = \(y); z = \(z) : j = \(j), L = \(l)")
                print("Im updated......");
                var mydict = Dictionary<String, Any>();
                mydict["status"] = y;
                mydict["notes"] = z;
                mydict["daterep"] = j;
                mydict["vname"] = x;
                mydict["uid"] = l;
                mydict["equiId"] = v;
                print(mydict);
                
                localVendorData.append(mydict);
            }
        }
        
        
        
        //vendorList1 changedData-----------------------------------------------------------------------------------------------------------
        
        let qs = try RAdb.executeQuery("select * from vendorList1 where userid = ? and isChanged = ?", values: [userid!, "true"])
        
        while qs.next() {
            if let x = qs.string(forColumn: "vendorname"), let y = qs.string(forColumn: "jobstatus"), let z = qs.string(forColumn: "notes"), let j = qs.string(forColumn: "datesaved") {
                let v = qs.int(forColumn: "equipmentid");
                let l = qs.int(forColumn: "uniqueUserid");
                
                print("x = \(x); y = \(y); z = \(z) : j = \(j), L = \(l)")
                print("Im updated......");
                var mydict = Dictionary<String, Any>();
                mydict["status"] = y;
                mydict["notes"] = z;
                
                mydict["uid"] = l;
                mydict["equiId"] = v;
                print(mydict);
                editedVendorData.append(mydict);
            }
        }
        
       // insert into signInLog(userid, mechId, userType, dateSignIn, uniqueUserid) values (?, ?, ?, ?, ?)
        
        let ss = try RAdb.executeQuery("select * from signInLog where userid = ? ", values: [userid!])
        
        while ss.next() {
            if let x = ss.string(forColumn: "userType"), let y = ss.string(forColumn: "uniqueUserid"), let z = ss.string(forColumn: "dateSignIn")  {
                
                let v = ss.int(forColumn: "mechId");
                print(v)
                
                print("x = \(x); y = \(y); z = \(z)  ")
                
                var mydict = Dictionary<String, Any>();
                mydict["uniqueId"] = y;
                mydict["dateIn"] = z;
                
                mydict["mid"] = v;
                
                print(mydict);
                mechSignInData.append(mydict);
            }
        }
        
        
        
        
        //************* indspectiondata ***
        
        
        let ins = try RAdb.executeQuery("select * from inspectionData where userid = ? ", values: [userid!])
        
        while ins.next() {
            if let x = ins.string(forColumn: "sdata"), let y = ins.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                 mydict["sdata"] = x;
                 mydict["uid"] = y;
                
                
                print(mydict);
                inspectionGData.append(mydict);
            }
        }
        
        
        
             //************* efficiencydata ***
       
        
        let efs = try RAdb.executeQuery("select * from efficiencyData where userid = ? ", values: [userid!])
        
        while efs.next() {
            if let x = efs.string(forColumn: "sdata"), let y = efs.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                
                print(mydict);
                efficiencyGData.append(mydict);
            }
        }
        
        
        //************* buildingdataaddapi ***
        
        
        let badata = try RAdb.executeQuery("select * from addbuilding where userid = ? ", values: [userid!])
        
        while badata.next() {
            if let x = badata.string(forColumn: "sdata"), let y = badata.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingaddData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingaddData.append(mydict);
            }
        }
        
        
        
        //************* buildingdeletdata   ***
        
        
        let bddataa = try RAdb.executeQuery("select * from deletebuilding where userid = ? ", values: [userid!])
        
        while bddataa.next() {
            if let x = bddataa.string(forColumn: "sdata"), let y = bddataa.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        //************* buildingmechroomdelete  ***
        
        
        let deletemechroom = try RAdb.executeQuery("select * from deletemechroom where userid = ? ", values: [userid!])
        
        while deletemechroom.next() {
            if let x = deletemechroom.string(forColumn: "sdata"), let y = deletemechroom.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //************* buildingdocumentedelete  ***
        
        
        let deletebuilddoc = try RAdb.executeQuery("select * from deletedocument where userid = ? ", values: [userid!])
        
        while deletebuilddoc.next() {
            if let x = deletebuilddoc.string(forColumn: "sdata"), let y = deletebuilddoc.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        //************* buildingmeanagersadd  ***
        
        
        let buildingmanagersadd = try RAdb.executeQuery("select * from addmanagersbuilding where userid = ? ", values: [userid!])
        
        while deletebuilddoc.next() {
            if let x = buildingmanagersadd.string(forColumn: "sdata"), let y = buildingmanagersadd.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        //************* buildingsuperadd  ***
        
        
        let buildingsuperdata = try RAdb.executeQuery("select * from addsupersbuilding where userid = ? ", values: [userid!])
        
        while buildingsuperdata.next() {
            if let x = buildingsuperdata.string(forColumn: "sdata"), let y = buildingsuperdata.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        //************* buildingmechadd ***
        
        
        let buildingsavemech = try RAdb.executeQuery("select * from savemechroom where userid = ? ", values: [userid!])
        
        while buildingsavemech.next() {
            if let x = buildingsavemech.string(forColumn: "sdata"), let y = buildingsavemech.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        //************* buildingmechadd ***
        
        
        let buildingdeletesupewrmanager = try RAdb.executeQuery("select * from deletebuildigsupermanager where userid = ? ", values: [userid!])
        
        while buildingdeletesupewrmanager.next() {
            if let x = buildingdeletesupewrmanager.string(forColumn: "sdata"), let y = buildingdeletesupewrmanager.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //************* buildingmechadd ***
        
        
        let buildingupadataer = try RAdb.executeQuery("select * from updatebuilding where userid = ? ", values: [userid!])
        
        while buildingupadataer.next() {
            if let x = buildingupadataer.string(forColumn: "sdata"), let y = buildingupadataer.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //************* addCustomform copy ***
        
        
        let addcustominspections = try RAdb.executeQuery("select * from addcustominspection where userid = ? ", values: [userid!])
        
        while addcustominspections.next() {
            if let x = addcustominspections.string(forColumn: "sdata"), let y = addcustominspections.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        
        //************* addCustomform saeas ***
        
        
        let custominspectionsavas = try RAdb.executeQuery("select * from custominspectionsaveas where userid = ? ", values: [userid!])
        
        while custominspectionsavas.next() {
            if let x = custominspectionsavas.string(forColumn: "sdata"), let y = custominspectionsavas.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        //************* custominspection delete ***
        
        
        let custominspectiondelete = try RAdb.executeQuery("select * from deletecustominspection where userid = ? ", values: [userid!])
        
        while custominspectiondelete.next() {
            if let x = custominspectiondelete.string(forColumn: "sdata"), let y = custominspectiondelete.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        //************* addefffeetest   ***
        
        
        let addefficeincytest = try RAdb.executeQuery("select * from addefficiencytest where userid = ? ", values: [userid!])
        
        while addefficeincytest.next() {
            if let x = addefficeincytest.string(forColumn: "sdata"), let y = addefficeincytest.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //************* efftest delete ***
        
        
        let deleteefficiency = try RAdb.executeQuery("select * from deleteefficiency where userid = ? ", values: [userid!])
        
        while deleteefficiency.next() {
            if let x = deleteefficiency.string(forColumn: "sdata"), let y = deleteefficiency.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //************* efftest update ***
        
        
        let updateefficiecy  = try RAdb.executeQuery("select * from saveasefficiencytest where userid = ? ", values: [userid!])
        
        while updateefficiecy.next() {
            if let x = updateefficiecy.string(forColumn: "sdata"), let y = updateefficiecy.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        //************* creat mechroom update ***
        
        
        let savemechroomer  = try RAdb.executeQuery("select * from savemechroomer where userid = ? ", values: [userid!])
        
        while savemechroomer.next() {
            if let x = savemechroomer.string(forColumn: "sdata"), let y = savemechroomer.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        //************* delete mechroom   ***
        
        
        let dmroom  = try RAdb.executeQuery("select * from deletemechroom where userid = ? ", values: [userid!])
        
        while dmroom.next() {
            if let x = dmroom.string(forColumn: "sdata"), let y = dmroom.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        
        
        //*************   mechroom  update ***
        
        
        let updatedmroom  = try RAdb.executeQuery("select * from mechupdate where userid = ? ", values: [userid!])
        
        while updatedmroom.next() {
            if let x = updatedmroom.string(forColumn: "sdata"), let y = updatedmroom.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        
        
        
        //*************   mechroomsuperdelete  update ***
        
        
        let mechroomsuperdelete  = try RAdb.executeQuery("select * from mechsuperdelete where userid = ? ", values: [userid!])
        
        while mechroomsuperdelete.next() {
            if let x = mechroomsuperdelete.string(forColumn: "sdata"), let y = mechroomsuperdelete.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        //*************   mechroomequipment delete ***
        
        
        let mechequipdelete  = try RAdb.executeQuery("select * from mechequipmentdelete where userid = ? ", values: [userid!])
        
        while mechequipdelete.next() {
            if let x = mechequipdelete.string(forColumn: "sdata"), let y = mechequipdelete.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //*************   mechdefaultinsopect ***
        
        
        let mechdefgaultdap  = try RAdb.executeQuery("select * from changedefaultinspection where userid = ? ", values: [userid!])
        
        while mechdefgaultdap.next() {
            if let x = mechdefgaultdap.string(forColumn: "sdata"), let y = mechdefgaultdap.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        //*************   addequipment  ***
        
        
        let addequpt  = try RAdb.executeQuery("select * from addequipment where userid = ? ", values: [userid!])
        
        while addequpt.next() {
            if let x = addequpt.string(forColumn: "sdata"), let y = addequpt.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        //*************   deleteEquipmet  ***
        
        
        let deleteequipm  = try RAdb.executeQuery("select * from deleteequipment where userid = ? ", values: [userid!])
        
        while deleteequipm.next() {
            if let x = deleteequipm.string(forColumn: "sdata"), let y = deleteequipm.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        //*************   updateequip  ***
        
        
        let updateequppj  = try RAdb.executeQuery("select * from updateequipment where userid = ? ", values: [userid!])
        
        while updateequppj.next() {
            if let x = updateequppj.string(forColumn: "sdata"), let y = updateequppj.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        //*************   adduserss  ***
        
        
        let adduserdd  = try RAdb.executeQuery("select * from adduser where userid = ? ", values: [userid!])
        
        while adduserdd.next() {
            if let x = adduserdd.string(forColumn: "sdata"), let y = adduserdd.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        //*************   deleteuseress  ***
        
        
        let deleteusers  = try RAdb.executeQuery("select * from deleteuser where userid = ? ", values: [userid!])
        
        while deleteusers.next() {
            if let x = deleteusers.string(forColumn: "sdata"), let y = deleteusers.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        //*************   updateuserss  ***
        
        
        let updateuser  = try RAdb.executeQuery("select * from updateuser where userid = ? ", values: [userid!])
        
        while updateuser.next() {
            if let x = updateuser.string(forColumn: "sdata"), let y = updateuser.string(forColumn: "uniqueUserid")  {
                
                
                
                print("x = \(x), y = \(y) ");
                
                var mydict = Dictionary<String, Any>();
                
                
                mydict["sdata"] = x;
                mydict["uid"] = y;
                
                var buildingdeleteData = Array<Dictionary<String, Any>>();
                print(mydict);
                buildingdeleteData.append(mydict);
            }
        }
        
        
        
        
        
        
        
        
        
        
        qs.close();
        rs.close();
        ss.close();
        ins.close();
        efs.close();
        print(localVendorData);
    } catch {
        print("failed: \(error.localizedDescription)")
        return;
    }
    
    
    RAdb.close();
    
    
    
    
      LVCcount = localVendorData.count
      EVCount = editedVendorData.count
      MSCount = mechSignInData.count
      InCount =  inspectionGData.count
      EffCount = efficiencyGData.count
      TCCount  = CGFloat(LVCcount + EVCount + MSCount + InCount + EffCount)
      NCCount = 0
    
    print("the data updated count")
    print("vendar count \(localVendorData.count)");
    print("edited vendor Data \(editedVendorData.count)");
    print("mechsign in data \(mechSignInData.count)");
    print("inspectiondata count \(inspectionGData.count)");
    print("efficiency data count \(efficiencyGData.count)");
    
    
    
    //----VendorList2 loadingto server-------------------------------------------------------------------------------------
    
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }
    
    
    
    
    
    
    
    
    
    
    
    
     loadingVendorDataToServerLoop1(selfi);
    
    
    
    
    
    
    
}


















func loadingVendorDataToServerLoop1(_ selfi : UIViewController)
{
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }

    
    let defaultValues = UserDefaults.standard
   let userid = defaultValues.string(forKey: "userid")
    let userType = defaultValues.string(forKey: "userType")
    
    if localVendorData.count > 0 && localvendorId < localVendorData.count
    {
        
        let equipIDE_mdiat = Int(localVendorData[localvendorId]["equiId"] as! Int32)
        let jobstatus_mdiat = localVendorData[localvendorId]["status"] as! String
        let notes_mdiat = localVendorData[localvendorId]["notes"] as! String
        let vname_mdiat = localVendorData[localvendorId]["vname"] as! String
        
        NCCount =   NCCount + 1
        
        if TCCount > 0
       {
        let percent = 95 * (NCCount / TCCount )
           //-- GShud.detailsLabel.text = "\(percent) %";
        
        }
        
        
        
        let parameters: Parameters=[
            "equipment_id": equipIDE_mdiat,
            "jobstatus": jobstatus_mdiat,
            "notes": notes_mdiat,
            "vendor_name": vname_mdiat,
            "user_id": userid!,
            "user_type" : userType!
            
        ]
        
        Alamofire.request(saveVendorAPI , method: .post, parameters: parameters).responseJSON { (resp) in
            
            
            if resp.result.value != nil
            {
                isOfflineMode = false
                
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    let filePath = getPath(fileName: locale_DB);
                    let RAdb = FMDatabase.init(path: filePath);
                    guard RAdb.open() else {
                        print("Unable to open database")
                        return
                    }
                    
                    
                    do {
                        
                        try RAdb.executeUpdate("Delete from vendorList2 where userid = ? and equipmentid = ? and vendorname = ? and  notes = ?", values: [userid!, equipIDE_mdiat, vname_mdiat, notes_mdiat]);
                        
                    } catch {
                        print("failed: \(error.localizedDescription)")
                        
                    }
                    
                    RAdb.close();
                    localvendorId =  localvendorId + 1;
                    
                     loadingVendorDataToServerLoop1(selfi);
                    
                    
                    
                }
                else{
                    
                   print("error in local vendor")
                    
                    if !isFromBackGround
                    {
                        DispatchQueue.main.async(execute: {
                            GShud.hide(animated: true);
                        })
                    let alert = UIAlertController.init(title:  translator("Failed"), message:  translator("An internal error occured"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title:  translator("Ok"), style: .destructive, handler: nil));
                    selfi.present(alert, animated: true, completion: nil);
                        
                    }
                    
                    
                     isSyncRunning = false;
                   
                }
                
            }
            else
            {
                print("error in local vendor")
                if !isFromBackGround
                {
                    DispatchQueue.main.async(execute: {
                        GShud.hide(animated: true);
                    })
                 
                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                selfi.present(alert, animated: true, completion: nil);
                }
                
                 isSyncRunning = false;
            }
            
            
            
        }
        
    }
    else
    {
        localVendorData = Array<Dictionary<String, Any>>();
        
        localvendorId = 0;
        
        print("editvendordatacalled")
        
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

        updateEditindOnlineVendorDatatoServerLoop2(selfi);
    }
    
}













func updateEditindOnlineVendorDatatoServerLoop2(_ selfi : UIViewController)
{
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }

    
    let defaultValues = UserDefaults.standard
    let userid = defaultValues.string(forKey: "userid")
    let userType = defaultValues.string(forKey: "userType")
    
    
    if editedVendorData.count > 0 && editorVendorId < editedVendorData.count
    {
        
        
        let vendor_mediat = editedVendorData[editorVendorId]["uid"] as! Int32
        let jobstatus_mdiat = editedVendorData[editorVendorId]["status"] as! String
        let notes_mdiat = editedVendorData[editorVendorId]["notes"] as! String
        
        
        NCCount =   NCCount + 1
        
        if TCCount > 0
        {
            let percent = 80 * (NCCount / TCCount )
           //-- GShud.detailsLabel.text = "\(percent) %";
            
        }
        
        
        
        
        
        
        
        
        let parameters: Parameters=[
            
            "vendor_id": vendor_mediat,
            "jobstatus": jobstatus_mdiat,
            "notes": notes_mdiat,
            "user_type" : userType!
            
        ]
        
        
        
        
        Alamofire.request(upadateVendorAPI , method: .post, parameters: parameters).responseJSON { (resp) in
            
            
            if resp.result.value != nil
            {
                isOfflineMode = false
                
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    
                    let filePath = getPath(fileName: locale_DB);
                    let RAdb = FMDatabase.init(path: filePath);
                    guard RAdb.open() else {
                        print("Unable to open database")
                        return
                    }
                    
                    do {
                        
                        try RAdb.executeUpdate("Delete from vendorList1 where userid = ? and isChanged = ? and uniqueUserid = ?", values: [userid!, "true", vendor_mediat])
                        
                        
                        
                    } catch {
                        print("failed: \(error.localizedDescription)")
                        
                    }
                    RAdb.close();
                    
                    
                    editorVendorId = editorVendorId + 1;
                    updateEditindOnlineVendorDatatoServerLoop2(selfi);
                    
                    
                }
                else{
                    if !isFromBackGround
                    {
                        DispatchQueue.main.async(execute: {
                            GShud.hide(animated: true);
                        })
                        
                    let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                    selfi.present(alert, animated: true, completion: nil);
                    }
                    
                     isSyncRunning = false;
                    print("error in edit vendor")
                }
                
                
                
                
            }
            else
            {
                if !isFromBackGround
                {
                    DispatchQueue.main.async(execute: {
                        GShud.hide(animated: true);
                    })
                    
                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                selfi.present(alert, animated: true, completion: nil);
                }
                
                 isSyncRunning = false;
                print("error in edit vendor")
            }
            
            
        }
    }
    else
    {
        
        editedVendorData = Array<Dictionary<String, Any>>();
        editorVendorId = 0;
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

        moveSignInDataLoop3(selfi);
        print("sign in loop called");
        
        
    }
    
    
}






func moveSignInDataLoop3(_ selfi : UIViewController)
{
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }
    
    let defaultValues = UserDefaults.standard
    let userid = defaultValues.string(forKey: "userid")
    let userType = defaultValues.string(forKey: "userType")
    
    
    if mechSignInData.count > 0 && signInmechCounter < mechSignInData.count
    {
        
        let mechId_mediat  =  mechSignInData[signInmechCounter]["mid"] as! Int32
        let mechUnique_meidat   = mechSignInData[signInmechCounter]["uniqueId"] as! String
 
        
        
        
        NCCount =   NCCount + 1
        
        if TCCount > 0
        {
            let percent = 80 * (NCCount / TCCount )
           //-- GShud.detailsLabel.text = "\(percent) %";
            
        }
        
        
        let parameters: Parameters = [
            "user_id": userid!,
            "mech_id": mechId_mediat,
            "user_type" : userType!
        ]
        
        
        print(parameters)
        
        Alamofire.request(mechanicalroomSignInApi , method: .post, parameters: parameters).responseJSON { (resp) in
            print("first api called");
            
            
            print(resp);
            if resp.result.value != nil
            {
                isOfflineMode = false
                
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                   
                    let eId = resultdata["signinid"] as! Int
                    
                    
                    let parameterss: Parameters = [
                        "signin_id": eId,
                        "user_type" : userType!
                        
                        
                    ]
                    print(parameters);
                    
                     Alamofire.request(signOutFromMechRoomAPI, method: .post, parameters: parameterss).responseJSON { (resp) in
                        
                        print("second api called");
                        if resp.result.value != nil
                        {
                            print(resp.result.value)
                            
                            
                            let resultdata =  resp.result.value! as! NSDictionary
                            let statuscode = resultdata["status"] as! Int
                            if statuscode == 200
                            {
                                
                                
                                let filePath = getPath(fileName: locale_DB);
                                let RAdb = FMDatabase.init(path: filePath);
                                guard RAdb.open() else {
                                    print("Unable to open database")
                                    return
                                }
                                
                                do {
                                    
                                    try RAdb.executeUpdate("Delete from signInLog where userid = ? and  uniqueUserid = ?", values: [userid!,  mechUnique_meidat])
                                    
                                    
                                    
                                } catch {
                                    print("failed: \(error.localizedDescription)")
                                    
                                }
                                RAdb.close();
                                
                                
                                signInmechCounter = signInmechCounter + 1;
                                
                                moveSignInDataLoop3(selfi);
                                
                                
                                
                                
                            }
                            else
                            {
                            if !isFromBackGround
                            {
                                DispatchQueue.main.async(execute: {
                                    GShud.hide(animated: true);
                                })
                                
                                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                                selfi.present(alert, animated: true, completion: nil);
                            }
                            
                            isSyncRunning = false;
                            print("error in sign out data")
                                
                                
                            }
                        
                    }
                        
                        else
                        {
                        if !isFromBackGround
                        {
                            DispatchQueue.main.async(execute: {
                                GShud.hide(animated: true);
                            })
                            
                            let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                            alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                            selfi.present(alert, animated: true, completion: nil);
                        }
                         
                        isSyncRunning = false;
                            
                            print("error in sign out data")
                        
                        }
                        
                    
                    
                    
                 
                 }
        
                }      }
            
            
            
            
            
            
            
         
            
            
 else
{
            
            
if !isFromBackGround
{
    DispatchQueue.main.async(execute: {
        GShud.hide(animated: true);
    })
    
    let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
    selfi.present(alert, animated: true, completion: nil);
}
 
isSyncRunning = false;
            print("error in sign in data")
            
}
            
            
            
            
            
            
            
            
            
            
            
        }
        
    }
    else
    {
        
        mechSignInData = Array<Dictionary<String, Any>>();
        signInmechCounter = 0;
        
        print("inspectionDatacalled")
        
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

        updateInspectionDatatoServerLoop4(selfi);
        
        
        
        
        
    }
    
    
}













func updateInspectionDatatoServerLoop4(_ selfi : UIViewController)
{
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }
    
    
    
    if inspectionGData.count > 0 && inspectionGCounter < inspectionGData.count
    {
        
        let jstr = inspectionGData[inspectionGCounter]["sdata"] as! String
        
        var dictData  : Dictionary<String, Any>? = nil
       
        
        NCCount =   NCCount + 1
        
        if TCCount > 0
        {
            let percent = 80 * (NCCount / TCCount )
           //-- GShud.detailsLabel.text = "\(percent) %";
            
        }
        
        print("converting jsonstrting into dictionary");

        if let data = jstr.data(using: .utf8) {
            do {
                  dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print(dictData);
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
        print("global upload attachment called");
        
        let isdefaultIns = dictData!["atftype"]
        storedpathdata = Array<Dictionary<String, String>>();
        storeupdatedatacounter = 0;
        
        if isdefaultIns != nil
        {
         
        let itypedata = dictData!["atftype"] as! Dictionary<String, String>;
        let imagepathData  = dictData!["atfvalue"] as! Dictionary<String, Any>;
        
        for (key, value) in itypedata
        {
            
            if value == "9"
            {
                print(key);
                
                for (tom, jerry) in imagepathData
                {
                    if tom == key
                    {
                        
                        var midict = Dictionary<String, String>()
                        let defaultPath = jerry as! String
                        
                        
                       
                        
                        if defaultPath != ""
                        {
                            if defaultPath.contains("/")
                            {
                                
                                midict[tom] = defaultPath
                                storedpathdata.append(midict);
                            }
                            else{
                                print("already stored");
                                print(defaultPath);
                            }
                            
                        }
                       
                    }
                }
                
                
                
            }
            
        }
    }
        
        GuploadingAttachmentToServer(dictData!, selfi);
        
    
        
        
        
        
        
        
            
        
        
    }
    else
    {
        
        inspectionGData = Array<Dictionary<String, Any>>();
        inspectionGCounter = 0;
        
        print("OfflineEfficiency called")
        updateEfficiencyDatatoServerLoop5(selfi);
        
        
        
    }
    
    
}









func updateEfficiencyDatatoServerLoop5(_ selfi : UIViewController)
{
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }

    
    
    
    if efficiencyGData.count > 0 && efficiencyGCounter < efficiencyGData.count
    {
        
        let jstr = efficiencyGData[efficiencyGCounter]["sdata"] as! String
        
        var dictData  : Dictionary<String, Any>? = nil
        
        NCCount =   NCCount + 1
        
        if TCCount > 0
        {
            let percent = 80 * (NCCount / TCCount )
           //-- GShud.detailsLabel.text = "\(percent) %";
            
        }
        
        
        print("converting jsonstrting into dictionary");
        
        if let data = jstr.data(using: .utf8) {
            do {
                dictData =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print(dictData);
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
        print("global upload attachment called");
        
        let itypedata = dictData!["atftype"] as! Dictionary<String, String>;
        let imagepathData  = dictData!["atfvalue"] as! Dictionary<String, Any>;
        storedpathdata = Array<Dictionary<String, String>>();
        storeupdatedatacounter = 0;
        for (key, value) in itypedata
        {
            
            if value == "9"
            {
                print(key);
                
                for (tom, jerry) in imagepathData
                {
                    if tom == key
                    {
                        var midict = Dictionary<String, String>()
                        let defaultPath = jerry as! String
                        if defaultPath != ""
                        {
                            if defaultPath.contains("/")
                            {
                                
                                midict[tom] = defaultPath
                                storedpathdata.append(midict);
                            }
                            else{
                                print("already stored");
                                print(defaultPath);
                            }
                            
                        }
                        
                        
                    }
                }
                
                
                
            }
            
        }
        
        
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

        
        GuploadingEfficiencyAttachmentToServer(dictData!, selfi)
        
        
        
        

        
        
        
        
        
    }
    else
    {
        
        efficiencyGData = Array<Dictionary<String, Any>>();
        efficiencyGCounter = 0;
        
        print("offlinedatacalled")
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

       // getOfflineData(selfi)
        
        
        
    }
    
    
}


var storedpathdata = Array<Dictionary<String, String>>();

var storeupdatedatacounter = 0;












func GuploadingAttachmentToServer(  _ apiparameters : Dictionary<String, Any>, _ selfi : UIViewController )
{
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }

    
    
    let defaultValues = UserDefaults.standard
    let userid = defaultValues.string(forKey: "userid")
    let userType = defaultValues.string(forKey: "userType")
    
    
    
    if storeupdatedatacounter < storedpathdata.count
    {
        let filepathRow = storedpathdata[storeupdatedatacounter];
        var meidaotrtitle = "";
        var okey = ""
        for (key, value) in filepathRow
        {
            
            meidaotrtitle = value;
            okey = key
            
            
        }
        
        
        print(meidaotrtitle);
        
       
        
        let dtaim = fileManag.contents(atPath: meidaotrtitle);
        
        if dtaim != nil
        {
            print("converted inot data")
        }
        else
        {
            print("got conversion error");
            return;
        }
        
        // "application/pdf"
        let localulrimgPath = URL.init(fileURLWithPath: meidaotrtitle)
        //let sname = localulrimgPath.lastPathComponent;
          let uid = localulrimgPath.pathExtension;
        
        print(uid);
        
        
        
        
        
        Alamofire.upload(multipartFormData: { ( multiData ) in
            
            multiData.append(dtaim!, withName: "file", fileName: "test", mimeType: "application");
            
            multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "firstName");
            
            
            
            
        }, to: imageUploadAPI , method: .post ) { (resp) in
            
            // imageUploadAPI
            //http://192.168.1.37/upload.php
            
            
            
            print(resp)
            switch resp {
            case .success(let upload, _, _):
                
                
                
                upload.responseJSON { response in
                    
                    
                    if let resp = response.result.value {
                        
                        
                        print(response.result);
                        
                        print(response.result.value)
                        
                        let midiatr = JSON(resp);
                        
                        let respStatus = midiatr["scode"].intValue;
                        print(respStatus)
                        if respStatus == 200
                        {
                            var mydata = apiparameters;
                             let  path = midiatr["filePath"].stringValue
                            
                            var imagepathData  = mydata["atfvalue"] as! Dictionary<String, Any>;
                            
                            for (v, l) in imagepathData
                            {
                                print(l);
                                if okey == v
                                {
                                    imagepathData[v] = path;
                                    
                                }
                            
                                
                                
                                
                            }
                            
                            mydata["atfvalue"] = imagepathData
                            
                            storeupdatedatacounter = storeupdatedatacounter + 1;
                            
                            
                            GuploadingAttachmentToServer(mydata, selfi);
                            
                            
                        }
                        else
                        {
                            
                            inspectionGCounter = inspectionGCounter + 1;
                            updateInspectionDatatoServerLoop4(selfi);
                            
                             print("got error");
                            
                            
                        }
                        
                    }
                        
                    else
                    {
                        inspectionGCounter = inspectionGCounter + 1;
                        updateInspectionDatatoServerLoop4(selfi);
                     print("got error");
                     
                    }
                    
                    
                }
                
            case .failure(let encodingError):
                
                inspectionGCounter = inspectionGCounter + 1;
                updateInspectionDatatoServerLoop4(selfi);
                print("got error");
                
            }
            
            
        }
        
        
        
        
    }
    else
    {
        
        
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }

        
        let apiJparams = JSON.init(apiparameters);
        print(apiJparams);
        
        
        
        let parameters: Parameters=[
            
            "insepectionData": apiJparams
            
        ]
        
        
        
        
        
        let unique_meida = inspectionGData[inspectionGCounter]["uid"] as! String
        
        
        
        
        Alamofire.request(saveInspectionFormAPI, method: .post, parameters: parameters).responseJSON { (resp) in
            
            
            if resp.result.value != nil
            {
                isOfflineMode = false
                
                let resultdata =  resp.result.value! as! NSDictionary
                print(resultdata);
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    
                    
                    let filePath = getPath(fileName: locale_DB);
                    let RAdb = FMDatabase.init(path: filePath);
                    guard RAdb.open() else {
                        print("Unable to open database")
                        return
                    }
                    
                    do {
                        
                        try RAdb.executeUpdate("Delete from inspectionData where userid = ? and uniqueUserid = ?", values: [userid!, unique_meida])
                        
                        
                        
                    } catch {
                        print("failed: \(error.localizedDescription)")
                        
                    }
                    RAdb.close();
                    
                    print("insepction sheet saved successfulley");
                    inspectionGCounter = inspectionGCounter + 1;
                    updateInspectionDatatoServerLoop4(selfi);
                    
                    
                }
                else{
                    if !isFromBackGround
                    {
                        DispatchQueue.main.async(execute: {
                            GShud.hide(animated: true);
                        })
                        
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        selfi.present(alert, animated: true, completion: nil);
                        
                        
                    }
                    else
                    {
                        inspectionGCounter = inspectionGCounter + 1;
                        updateInspectionDatatoServerLoop4(selfi);
                    }
                    
                    print("got errore1")
                    print("error in inspection data");
                }
                
                
                
                
            }
            else
            {
                if !isFromBackGround
                {
                    DispatchQueue.main.async(execute: {
                        GShud.hide(animated: true);
                    })
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                    selfi.present(alert, animated: true, completion: nil);
                    
                }
                else
                {
                    
                        inspectionGCounter = inspectionGCounter + 1;
                        updateInspectionDatatoServerLoop4(selfi);
                    
                    
                }
                
                print("got errore2")
                print("error in inspection data.")
                
            }
            
            
        }
        
        
        
    }
    
    
   
    
}












func GuploadingEfficiencyAttachmentToServer(  _ apiparameters : Dictionary<String, Any>, _ selfi : UIViewController )
{
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }

    
    
    let defaultValues = UserDefaults.standard
    let userid = defaultValues.string(forKey: "userid")
    
    
    
    if storeupdatedatacounter < storedpathdata.count
    {
        let filepathRow = storedpathdata[storeupdatedatacounter];
        var meidaotrtitle = "";
        var okey = ""
        for (key, value) in filepathRow
        {
            
            meidaotrtitle = value;
            okey = key
            
            
        }
        
        
        print(meidaotrtitle);
        
        
        
        let dtaim = fileManag.contents(atPath: meidaotrtitle);
        
        if dtaim != nil
        {
            print("converted inot data")
        }
        else
        {
            print("got conversion error");
            return;
        }
        
        // "application/pdf"
        let localulrimgPath = URL.init(fileURLWithPath: meidaotrtitle)
        //let sname = localulrimgPath.lastPathComponent;
          let uid = localulrimgPath.pathExtension;
        
        print(uid);
        
        
        
        
        
        Alamofire.upload(multipartFormData: { ( multiData ) in
            
            multiData.append(dtaim!, withName: "file", fileName: "test", mimeType: "application");
            
            multiData.append(uid.data(using: String.Encoding.utf8)!, withName: "firstName");
            
            
            
            
        }, to: imageUploadAPI , method: .post ) { (resp) in
            
            // imageUploadAPI
            //http://192.168.1.37/upload.php
            
            
            
            print(resp)
            switch resp {
            case .success(let upload, _, _):
                
                
                
                upload.responseJSON { response in
                    
                    
                    if let resp = response.result.value {
                        
                        
                        print(response.result);
                        
                        print(response.result.value)
                        
                        let midiatr = JSON(resp);
                        
                        let respStatus = midiatr["scode"].intValue;
                        print(respStatus)
                        if respStatus == 200
                        {
                            var mydata = apiparameters;
                            let  path = midiatr["filePath"].stringValue
                            
                            var imagepathData  = mydata["atfvalue"] as! Dictionary<String, String>;
                            
                            for (v, l) in imagepathData
                            {
                                print(l);
                                if okey == v
                                {
                                    imagepathData[v] = path;
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            mydata["atfvalue"] = imagepathData
                            
                            storeupdatedatacounter = storeupdatedatacounter + 1;
                            
                            GuploadingEfficiencyAttachmentToServer(mydata, selfi)
                            
                            
                            
                        }
                        else
                        {
                            
                            efficiencyGCounter = efficiencyGCounter + 1;
                            updateEfficiencyDatatoServerLoop5(selfi)
                            
                            
                            print("got error");
                            
                            
                        }
                        
                    }
                        
                    else
                    {
                        efficiencyGCounter = efficiencyGCounter + 1;
                          updateEfficiencyDatatoServerLoop5(selfi)
                        print("got error");
                        
                    }
                    
                    
                }
                
            case .failure(let encodingError):
                
                efficiencyGCounter = efficiencyGCounter + 1;
                updateEfficiencyDatatoServerLoop5(selfi)
                print("got error");
                
            }
            
            
        }
        
        
        
        
    }
    else
    {
        
        if isEmergencyStop
        {
            
            if syncHandler != nil
            {
                syncHandler!(true);
                
            }
            return;
        }
        
        let apiJparams = JSON.init(apiparameters);
        print(apiJparams);
        
        
        
        let parameters: Parameters = [
            
            "eqipmentsData": apiJparams
            
        ]
        
        
        
        let effieci_media = efficiencyGData[efficiencyGCounter]["uid"] as! String
        
        
        
        Alamofire.request(saveEfficiencyAPI, method: .post, parameters: parameters).responseJSON { (resp) in
            
            
            
            if resp.result.value != nil
            {
                isOfflineMode = false
                
                let resultdata =  resp.result.value! as! NSDictionary
                let statuscode = resultdata["status"] as! Int
                if statuscode == 200
                {
                    
                    
                    
                    let filePath = getPath(fileName: locale_DB);
                    let RAdb = FMDatabase.init(path: filePath);
                    guard RAdb.open() else {
                        print("Unable to open database")
                        return
                    }
                    
                    do {
                        
                        try RAdb.executeUpdate("Delete from efficiencyData where userid = ? and uniqueUserid = ?", values: [userid!, effieci_media])
                        
                        
                        
                    } catch {
                        print("failed: \(error.localizedDescription)")
                        
                    }
                    RAdb.close();
                    
                     print("efficiency sheet saved successfulley");
                    efficiencyGCounter = efficiencyGCounter + 1;
                    updateEfficiencyDatatoServerLoop5(selfi);
                    
                    
                }
                else{
                    if !isFromBackGround
                    {
                        DispatchQueue.main.async(execute: {
                            GShud.hide(animated: true);
                        })
                        
                        let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                        selfi.present(alert, animated: true, completion: nil);
                    }
                    
                    isSyncRunning = false;
                    print("error in efficiency data")
                    
                }
                
                
                
                
            }
            else
            {
                if !isFromBackGround
                {
                    DispatchQueue.main.async(execute: {
                        GShud.hide(animated: true);
                    })
                    
                    let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                    alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                    selfi.present(alert, animated: true, completion: nil);
                }
                
                isSyncRunning = false;
                print("error in efficiency data")
            }
            
            
        }
        
        
        
    }
    
    
    
    
}











































//--------------- get offline data ---------------------------------------



func getOfflineData(_ selfi : UIViewController)
{
    
    
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }

    
    let offdataURL = offlineDataAPI + "/\(Int(GSuserid!)!)/\(GSuserType!)"
    print("offlinedata urls \(offdataURL)")
    print(offdataURL);
    
    Alamofire.request(offdataURL).responseJSON { (resp) in
        
        
        if resp.result.value != nil
        {
            
           
            let respnese = JSON(resp.result.value!);
            
            let str = respnese.description;
            
            cachem.set(str, forKey: "offlinedata")
             print("offlinedataSuccess");
 
            if isEmergencyStop
            {
                
                if syncHandler != nil
                {
                    syncHandler!(true);
                    
                }
                return;
            }
           
            
            
            
            
            if isFromBackGround
            {
                DispatchQueue.global(qos: .default).async(execute: {
                    GsavingtoLocalDataBase(respnese, selfi);
                })
            }
            else
            {
                GsavingtoLocalDataBase(respnese, selfi);
            }
            
            
            
            
            
          
            
        }
        else
        {
            if !isFromBackGround
            {
                DispatchQueue.main.async(execute: {
                    GShud.hide(animated: true);
                })
                
                let alert = UIAlertController.init(title: translator("Failed"), message: translator("Your request has been timed out please try again"), preferredStyle: .alert);
                alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .destructive, handler: nil));
                selfi.present(alert, animated: true, completion: nil);
            }
            
             isSyncRunning = false;
             print("error in overall offline data")
        }
        
        
    }
    
    
}




func GsavingtoLocalDataBase(_ jdata : JSON, _ selfi : UIViewController)
{
    
    if isEmergencyStop
    {
        
        if syncHandler != nil
        {
            syncHandler!(true);
            
        }
        return;
    }
     isSyncCompleted = true;
    
    let buildingsData = jdata["buildings"].arrayObject
    
    
        
        if buildingsData != nil
        {
            
            let anyData = buildingsData!
            
            if anyData.count > 0
            {
                
                for vl in 0..<anyData.count
                {
                    let builer = anyData[vl] as! Dictionary<String, Any>;
                    let mymechDataDuplicate =  builer["mechanicals"] as? Array<Any>
                    
                    if mymechDataDuplicate != nil
                    {
                        
                        let mymechData =  builer["mechanicals"] as! Array<Any>
                        
                        if mymechData.count > 0
                        {
                            
                            for i1 in 0..<mymechData.count
                            {
                                
                                let mediator = mymechData[i1] as! Dictionary<String, Any>
                                
                                let equipdataDuplicate = mediator["equipments"] as? Array<Any>
                                
                                if equipdataDuplicate != nil
                                {
                                    
                                    let equipdata = mediator["equipments"] as! Array<Any>
                                    
                                    if equipdata.count > 0
                                    {
                                        
                                        
                                        
                                        for i in 0..<equipdata.count
                                        {
                                            
                                            let mediatro2 = equipdata[i] as! Dictionary<String, Any>
                                            let mediatrorDuplicate = mediatro2["drawings"] as? Array<Any>;
                                            
                                            if mediatrorDuplicate != nil
                                            {
                                                
                                                let mediatror = mediatro2["drawings"] as! Array<Any>;
                                                
                                                if mediatror.count > 0
                                                {
                                                    
                                                    
                                                    for f in 0..<mediatror.count
                                                    {
                                                        
                                                        var media3 =  mediatror[f] as! Dictionary<String, Any>
                                                        
                                                        let fileNmaeDulicate = media3["file_path"] as? String;
                                                        
                                                        if  fileNmaeDulicate != nil
                                                        {
                                                            
                                                            var fileNmae = media3["file_path"] as! String;
                                                            
                                                            
                                                            fileNmae = fileNmae.replacingOccurrences(of: " ", with: "%20");
                                                            
                                                            
                                                            let fileUrl =  URL.init(string: ImgFilePathAPI + fileNmae)
                                                            fileNmae = fileNmae.replacingOccurrences(of: "/", with: "_");
                                                            print(fileNmae);
                                                            
                                                            if isEmergencyStop
                                                            {
                                                                
                                                                if syncHandler != nil
                                                                {
                                                                    syncHandler!(true);
                                                                    
                                                                }
                                                                return;
                                                            }
                                                            
                                                            
                                                            
                                                            for _ in 0..<4
                                                            {
                                                                
                                                                let result =  GconvertIntoData(fileUrl!, fileNmae);
                                                                if result
                                                                {
                                                                    break;
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                            print(isFromBackGround);
                                                            
                                                        }
                                                            
                                                        
                                                    }
                                                }
                                                    
                                                
                                                
                                            }
                                                
                                            
                                            
                                        }
                                    }
                                        
                                    
                                    
                                }
                                    
                                
                                
                            }
                        }
                        
                    }
                    
                }
            }
            
            
        }
     GsyncCompleted(selfi)
}









func GsyncCompleted(_ selfi : UIViewController)
{
    
    print("all lopps completede");
    
    
    if !isFromBackGround
    {
       
        DispatchQueue.main.async(execute: {
            GShud.hide(animated: true);
        })
        
        let alert = UIAlertController.init(title: translator("Success"), message: translator("SYNC Successfully Completed"), preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: translator("Ok"), style: .cancel, handler: nil));
        selfi.present(alert, animated: true, completion: nil);
    }
    isSyncRunning = false;
    
    
    
}











func GconvertIntoData(_ sender : URL,  _ fileNmae : String) -> Bool
{
    let myfilePath =  getPath(fileName: fileNmae)
    
    if !fileManag.fileExists(atPath: myfilePath)
    {
        
        
        
        do
        {
            let mydata = try Data.init(contentsOf: sender);
            
            
            
            fileManag.createFile(atPath: myfilePath, contents: mydata, attributes: nil);
            
            print("saved file");
            
           
            
            return true;
            
        }
        catch
        {
            
            print(sender);
            print("unabletosave")
            return false
            
            
            
            
            
        }
    }
    print("already exists");
    return true
}











func completedSync(selfi : UIViewController)
{
    
    
    
    
}


func translator(_ data : String) -> String
{
    
     
    let lcode = cachem.string(forKey: "lang");
    if lcode == "en"
    {
        return data;
    }
    
    let ldata = data.lowercased();
    
    
    
    let defaultLangData = cachem.dictionary(forKey: "dlang") as! Dictionary<String, String>
    
    let itsExist = defaultLangData[ldata]
    
    if itsExist != nil
    {
        return itsExist!;
    }
    else
    {
        return data;
    }
    
    
    
    
    
}




func convertOnlineData(_ sender : String?, handler : @escaping (String) -> Void)
    
{
    print("input url");
    let mystr = sender?.replacingOccurrences(of: " ", with: "%20");
    print(mystr);
    Alamofire.request("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=hi&dt=t&q=" + mystr!).responseJSON { (resp) in
        print(resp.result);
        if resp.result.isSuccess
        {
            let meidatrdata = resp.result.value as! Array<Any>
            let data1 = meidatrdata[0] as! Array<Any>;
            let data2 = data1[0] as! Array<Any>;
            print(data2[0]);
            let data3 = data2[0] as! String
            handler(data3)
        }
        else
        {
        print(resp.result.value);
        print(resp);
        print("api Result")
        handler("api result")
        }
    }
    
    
}





//******************** global langage conversion from api **********************

var GconvertdApiData = Dictionary<String, String>();
var GconvertMechData = Dictionary<String, String>();
var GconvertMechDashData = Dictionary<String, String>();
var GconvertEquipData = Dictionary<String, String>();
var GconvertVendorList = Dictionary<String, String>();
var GconvertEfficiencyTest = Dictionary<String, String>();
var GconvertInspectionTest = Dictionary<String, String>();



func convertIntoDict(_ splitter : String, _ odata : Array<Any>, _ sep : String, handler : @escaping (Bool, Dictionary<String, String>) -> Void)
{
    
    let lcode = cachem.string(forKey: "lang")
    print(lcode)
    if lcode == "en"
    {
        handler(true, Dictionary<String, String>());
        return;
    }
    
    var mediator = Dictionary<String, String>();
    
    for i in 0..<odata.count
    {
        
        let rdata = odata[i] as! Dictionary<String, Any>
        
        let mydiatro =  rdata[splitter]
        
        if mydiatro != nil
        {
        let keyTitle = rdata[splitter] as! String
         
        mediator[keyTitle] = keyTitle;
        }
        
    }
   
    var defaultDict =  mediator;
    var Allvalues = "";
    
    
    let stringSeparator = ""
    let stringSeparator2 = sep
    //". "
    for (_ , value) in defaultDict
    {
        let myvalue = value.replacingOccurrences(of: "#", with: "");
        if Allvalues != ""
        {
            Allvalues = Allvalues + stringSeparator + myvalue + stringSeparator2;
        }
        else
        {
            Allvalues = stringSeparator + myvalue + stringSeparator2
        }
        
    }
    
    Allvalues = Allvalues.replacingOccurrences(of: " ", with: "%20");
    
    
    print("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=\(lcode)&dt=t&q=\(Allvalues)")
    print(Allvalues);
    
    
    // https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=hi&dt=t&q=Are%20you%20sure%20%20want%20to%20logout%20from%20the%20app.Success.Alert.Please%20Select%20Mechanical%20Room.Home.No%20network%20connection%20would%20you%20like%20to%20use%20offline%20data.Password.Forgot%20your%20password.Cancel.Yes.Dashboard.Logout.Email.Select%20Building.Sync.Fog.Please%20Select%20Building.Sign%20In.Search.Failed.Hello.Ok.sand.Network%20Alert.Building.
    
    Alamofire.request("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=\(lcode!)&dt=t&q=\(Allvalues)").responseJSON { (resp) in
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
                                            firstStr = firstStr!.replacingOccurrences(of:  stringSeparator, with: "");
                                            firstStr = firstStr!.replacingOccurrences(of: ". ", with: "");
                                            firstStr = firstStr!.replacingOccurrences(of: ".", with: "");
                                            
                                            
                                            secondStr = secondStr!.replacingOccurrences(of:  stringSeparator, with: "");
                                            secondStr = secondStr!.replacingOccurrences(of: stringSeparator2, with: "")
                                            
                                            
                                            print(stringSeparator2);
                                            
                                            print(firstStr);
                                            print(secondStr);
                                            
                                            
                                            
                                            
                                            
                                            for (key, value) in defaultDict
                                            {
                                                
                                                let keydata = key.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "\'", with: "");
                                                let secondData = secondStr!.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "\'", with: "");
                                                
                                                
                                                if keydata == secondData
                                                {
                                                    defaultDict[key] = firstStr
                                                }
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            print(defaultDict);
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
            
            
        }
        
        handler(true, defaultDict);
      
    }
    
    
    
}























//-----Double splitter-----




func GDoubleconvertIntoDict(_ splitter : [String], _ odata : Array<Any>, _ sep : String,_ type : Int, handler : @escaping (Bool, Dictionary<String, String>) -> Void)
{
    
    let lcode = cachem.string(forKey: "lang")
    print(lcode)
    if lcode == "en"
    {
        handler(true, Dictionary<String, String>());
        return;
    }
    
    var mediator = Dictionary<String, String>();
    
    
    
    
    if type == 0
    {
    
    for i in 0..<odata.count
    {
        let rdata = odata[i] as! Dictionary<String, Any>
        
        for j in 0..<splitter.count
        {
            let mydiatro =  rdata[splitter[j]]
            
            if mydiatro != nil
            {
                let keyTitle = rdata[splitter[j]] as! String
                
                mediator[keyTitle] = keyTitle;
                
            }
            
        }
        
    }
        
    }
    else if type == 1
    {
        
        for i in 0..<odata.count
        {
            let rdata = odata[i] as! Dictionary<String, Any>
            let headerTitle = rdata["head"]
            if headerTitle != nil
            {
                let keyTitle2 = rdata["head"] as! String
                
                mediator[keyTitle2] = keyTitle2;
                
            }
            let fieldsdata = rdata["fields"] as? Array<Dictionary<String, Any>>
            
            
            if fieldsdata != nil
            {
             
              for k in 0..<fieldsdata!.count
              {
                
            for j in 0..<splitter.count
            {
                
                
                let mydiatro =  fieldsdata![k][splitter[j]]
                
                if mydiatro != nil
                {
                     let keyTitle = fieldsdata![k][splitter[j]] as! String
                    
                    if splitter[j] == "ioptions"
                    {  let options = keyTitle.components(separatedBy: "\n");
                        for l in 0..<options.count
                        {
                            print(options[l].trimmingCharacters(in: NSCharacterSet.newlines).replacingOccurrences(of: "\r", with: ""))
                             mediator[options[l].trimmingCharacters(in: NSCharacterSet.newlines).replacingOccurrences(of: "\r", with: "")] = options[l].trimmingCharacters(in: NSCharacterSet.newlines).replacingOccurrences(of: "\r", with: "");
                        }
                        
                    }
                    else
                    {
                    mediator[keyTitle] = keyTitle;
                    }
                    
                }
                
                
                
            }
                
                }
            }
            
            
            
        }
        
        
        
    }
    var defaultDict =  mediator;
    var Allvalues = "";
    
    
    let stringSeparator = ""
    let stringSeparator2 = sep
    //". "
    for (_ , value) in defaultDict
    {
        let myvalue = value.replacingOccurrences(of: "#", with: "");
        if Allvalues != ""
        {
            Allvalues = Allvalues + stringSeparator + myvalue + stringSeparator2;
        }
        else
        {
            Allvalues = stringSeparator + myvalue + stringSeparator2
        }
        
    }
    
    Allvalues = Allvalues.replacingOccurrences(of: " ", with: "%20");
    
    
    print("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=\(lcode)&dt=t&q=\(Allvalues)")
    print(Allvalues);
    
    
    // https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=hi&dt=t&q=Are%20you%20sure%20%20want%20to%20logout%20from%20the%20app.Success.Alert.Please%20Select%20Mechanical%20Room.Home.No%20network%20connection%20would%20you%20like%20to%20use%20offline%20data.Password.Forgot%20your%20password.Cancel.Yes.Dashboard.Logout.Email.Select%20Building.Sync.Fog.Please%20Select%20Building.Sign%20In.Search.Failed.Hello.Ok.sand.Network%20Alert.Building.
    
    Alamofire.request("https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=\(lcode!)&dt=t&q=\(Allvalues)").responseJSON { (resp) in
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
                                            firstStr = firstStr!.replacingOccurrences(of:  stringSeparator, with: "");
                                            firstStr = firstStr!.replacingOccurrences(of: ". ", with: "");
                                            firstStr = firstStr!.replacingOccurrences(of: ".", with: "");
                                            
                                            
                                            secondStr = secondStr!.replacingOccurrences(of:  stringSeparator, with: "");
                                            secondStr = secondStr!.replacingOccurrences(of: stringSeparator2, with: "")
                                            
                                            
                                            print(stringSeparator2);
                                            
                                            print(firstStr);
                                            print(secondStr);
                                            
                                            
                                            
                                            
                                            
                                            for (key, value) in defaultDict
                                            {
                                                
                                                var keydata = key.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: "\r", with: "");
                                                keydata = keydata.trimmingCharacters(in: NSCharacterSet.newlines)
                                                var secondData = secondStr!.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "#", with: "").replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: "\r", with: "");
                                                secondData = secondData.trimmingCharacters(in: NSCharacterSet.newlines)
                                                
                                                if keydata == secondData
                                                {
                                                    defaultDict[key] = firstStr
                                                }
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            print(defaultDict);
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
            
            
        }
        
        handler(true, defaultDict);
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}






func Apitranslator(_ data : String, _ compareDict : Dictionary<String, String>) -> String
{
    
    let lcode = cachem.string(forKey: "lang");
    if lcode == "en"
    {
        return data;
    }
    
    let ldata = data
    
    
    
    let defaultLangData = compareDict
    
    let itsExist = defaultLangData[ldata]
    
    if itsExist != nil
    {
        return itsExist!;
    }
    else
    {
        return data;
    }
    
    
    
    
    
}

//*9**************************


class AddBuildingInitialCellClass : UITableViewCell
{
    
    
    @IBOutlet weak var companyfld: UITextFeild!
    @IBOutlet weak var backViw: UIView!
    @IBOutlet weak var headert: UILabel!
    @IBOutlet weak var imgwidth: NSLayoutConstraint!
    @IBOutlet weak var backViewHt: NSLayoutConstraint!
    @IBOutlet weak var bottomline: UILabel!
    @IBOutlet weak var labelHt: NSLayoutConstraint!
    @IBOutlet weak var dropdownArrow: UIImageView!
    @IBOutlet weak var headertopPadding: NSLayoutConstraint!
    @IBOutlet weak var backViewtopPadding: NSLayoutConstraint!
    @IBOutlet weak var rightpadding: NSLayoutConstraint!
    
    func loadUI()
    {
        addGrayBorders([backViw]);
        
        
    }
    
    
}

class CommonRoundTextFieldCellClass : UITableViewCell
{
    @IBOutlet weak var backviw: UIView!
    @IBOutlet weak var innerTextField: UITextFeild!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewWidthCostr: NSLayoutConstraint!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var imgWth: NSLayoutConstraint!
    
    @IBOutlet weak var dropImg: UIImageView!
    func loadUI()
    {
        addGrayBorders([backviw]);
        
        
    }
    
    
    
    
    
}


func addGrayBorders(_ sender : [UIView])
{
    for i in 0..<sender.count
    {
        let vw = sender[i];
        vw.layer.cornerRadius = 5.0;
        vw.layer.borderWidth = 1.0;
        vw.layer.borderColor = UIColor.lightGray.cgColor;
        
    }
    
}




class commonAddDeleteCellClass : UITableViewCell
{
    @IBOutlet weak var titleLabe: UILabel!
    @IBOutlet weak var addBtn: UIBotton!
    @IBOutlet weak var actIn: UIActivityIndicatorView!
    @IBOutlet weak var backvw: UIView!
    @IBOutlet weak var topbarLabel: UILabel!
    @IBOutlet weak var dropImg: UIImageView!
    @IBOutlet weak var chooseFileBtn: UIBotton!
    @IBOutlet weak var addBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var upperSpace: NSLayoutConstraint!
    
    @IBOutlet weak var imgwt: NSLayoutConstraint!
    @IBOutlet weak var choobtnHt: NSLayoutConstraint!
    @IBOutlet weak var innerField: UITextFeild!
    func loadingDefaultUI()
    {
        chooseFileBtn.layer.cornerRadius = 5.0
        addGrayBorders([backvw]);
        
        
    }
    
}


class DeleteWarinigAlertView : UIView
{
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var backCancelBtn: UIButton!
    
}



class BuildingEditUsualCellClass : UITableViewCell
{
    @IBOutlet weak var topborder: UILabel!
    
    @IBOutlet weak var headerField: UITextFeild!
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet weak var lpadinng: NSLayoutConstraint!
    
    
    
    
    
    
}



class headerViewForEditBuildingCellClass : UIView
{
    @IBOutlet weak var headTitle: UILabel!
    
    @IBOutlet weak var addBtn: UIBotton!
    @IBOutlet weak var topborder: UILabel!
    @IBOutlet weak var addVw: UIView!
    
    
}



class editDeleteBuildingRowCellClass : UITableViewCell
{
    
    @IBOutlet weak var deleteBtn: UIBotton!
    
    @IBOutlet weak var titleBtn: UIBotton!
    
    @IBOutlet weak var deleteImg: UIImageView!
    
    
    
}




func checkIsIndexOutOfBounds(_ cidi : Int, _ cData : Array<Any>) -> Bool
{
    if cData.count <= 0
    {
        return true;
        
    }
    
    
    let dataCounter = cData.count - 1
    
    if dataCounter < cidi
    {
        return true;
    }
    
    
    
    return false;
    
    
    
}







func saetolocaldatabase(_ jdata : String, _ defaultName : String) ->  Bool
{
    
    
    
    let filePath = getPath(fileName: locale_DB);
    let RAdb = FMDatabase.init(path: filePath);
    
    let defaultValues = UserDefaults.standard
    let userid = defaultValues.string(forKey: "userid")
    
    guard RAdb.open() else {
        print("Unable to open database")
        return false;
        
    }
    print("data base is opened");
    
    
    do {
        
        //create table inspectionData( userid varchar(50), sdata text );
        
        let datewForm = DateFormatter()
        datewForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let tdate = datewForm.string(from: Date());
        let uniqueCode = userid! + tdate
        try RAdb.executeUpdate("insert into \(defaultName)(userid, sdata, uniqueUserid) values (?, ?, ?)", values: [userid!, jdata, uniqueCode ])
        
        
        /*
         let rs = try RAdb.executeQuery("select * from inspectionData", values: nil)
         while rs.next() {
         if let x = rs.string(forColumn: "sdata") {
         print("x = \(x)");
         print(JSON(x));
         }
         }
         rs.close();*/
        
    } catch {
        print("failed: \(error.localizedDescription)")
        return false;
    }
    
    RAdb.close()
    
    return true;
    
    
    
    
}
