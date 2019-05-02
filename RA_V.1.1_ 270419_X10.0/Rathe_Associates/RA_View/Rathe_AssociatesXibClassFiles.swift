//
//  Rathe_AssociatesXibClassFiles.swift
//  Rathe_Associates
//
//  Created by Apple on 14/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import Foundation
import UIKit


class LoaderView : UIView
{
    
    @IBOutlet weak var subLoader: UIView!
    
    func loadingDefaultUI()
    {
        
        subLoader.layer.cornerRadius = 8.0;
        subLoader.clipsToBounds = true;
        
    }
    
    func showLoader(obj : UIViewController)
    {
        self.frame = obj.view.frame;
        obj.view.addSubview(self)
        
    }
    
    func hideLoader()
    {
        self.removeFromSuperview();
        
    }
    
    
    
}



class popupTableViewClass : UIView
{
    @IBOutlet weak var closeBtn: UIBotton!
    
   // @IBOutlet weak var closeBtn: UIButton!
  //  @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIBotton!
    @IBOutlet weak var headertitle: UILabel!
    
    @IBOutlet weak var pview: UIView!
    
    @IBOutlet weak var mechanicalRoomViw: UIView!
    
    @IBOutlet weak var submitBtn: UIBotton!
    
    @IBOutlet weak var wariningLab: UILabel!
    
    @IBOutlet weak var roomNameField: UITextField!
    @IBOutlet weak var dropDownTable: UITableView!
    @IBOutlet weak var miniLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var bScroller: UIScrollView!
    
    
    func loadingDefaultUI()
    {
        pview.layer.cornerRadius = 10;
        submitBtn.layer.cornerRadius = 8;
        
        pview.layer.shadowColor = UIColor.darkGray.cgColor
        pview.layer.shadowOpacity = 1
        pview.layer.shadowOffset = CGSize.zero
        pview.layer.shadowRadius = 20
        miniLoader.isHidden = true;
        
    }
    
    
    
    
    
}







class MenuHeaderView : UIView{
    
    
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var dropdownImg: UIImageView!
    
    
    
    
}




class EmptyTextFieldCellClass : UITableViewCell
{
    
    @IBOutlet weak var backView: UIView!
   
   
    @IBOutlet weak var titleField: UITextField!
    
    
    func loadingDefaultUI()
    {
      //  addBorders([backView], col: "0CAEC6");
        
        
    
    
    }
    
    
}


class EmptyDynamicTextFieldCellClass : UITableViewCell
{
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var titleField: UITextField!
    
   
    @IBOutlet weak var addFieldBtn: UIButton!
    
    @IBOutlet weak var downArrow: UIImageView!
    
    func loadingDefaultUI()
    {
       // addBorders([backView], col: "0CAEC6");
        
        downArrow.isHidden = true;
        
        
    }
  
    
    
}



class CustomInspectionRowCellClass : UITableViewCell
{
    
    
    @IBOutlet weak var bView: UILabel!
    @IBOutlet weak var removeSelectonBtn: UIBotton!
    
    @IBOutlet weak var fieldLab: UITextFeild!
    
    
    @IBOutlet weak var addrowbtn: UIBotton!
    @IBOutlet weak var displayOrder: UITextFeild!
    @IBOutlet weak var typeField: UITextFeild!
    
    
    
    @IBOutlet weak var requiredField: UITextFeild!
    @IBOutlet weak var optionsField: UITextView!
    
    @IBOutlet weak var inputValidation: UITextFeild!
    @IBOutlet weak var defaultValue: UITextFeild!
    
    
    
    
    
    
    
}


















class BrowseBtnCellClass : UITableViewCell
{
    
    @IBOutlet weak var browseBtn: UIButton!
    
    func loadingDefaultUI()
    {
        browseBtn.layer.cornerRadius = 5.0;
        browseBtn.clipsToBounds = true;
        
        
        
        
    }
    
    
    
    
    
    
}



class SendBtnCellClass : UITableViewCell
{
    
    @IBOutlet weak var sendBtn: UIButton!
    func loadingDefaultUI()
    {
        sendBtn.layer.cornerRadius = 5.0;
        sendBtn.clipsToBounds = true;
        
        
        
        
    }
    
    
    
    
    
}





class forgetPasswordView : UIView{
    
    
    @IBOutlet weak var femail: UITextField!
    @IBOutlet weak var warningLab: UILabel!
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var tView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    func loadingDefaultUI()
    {
        tView.layer.cornerRadius = 3.0;
        tView.clipsToBounds = true;
        tView.layer.borderWidth = 1.0;
        tView.layer.borderColor = UIColor.lightGray.cgColor;
        warningLab.text = ""
    }
    
    
    
    
    
    
}

class CustomInspectionHeaderViewClass : UIView
{
    @IBOutlet weak var deleteSectioNBtn: UIBotton!
    
    @IBOutlet weak var addSectionBtn: UIBotton!
    @IBOutlet weak var loaderforadd: UIActivityIndicatorView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deleteAct: UIActivityIndicatorView!
    @IBOutlet weak var displayorderField: UITextFeild!
    @IBOutlet weak var deleteBtnHt: NSLayoutConstraint!
    @IBOutlet weak var btn1: UIBotton!
    @IBOutlet weak var btn2: UIBotton!
    @IBOutlet weak var btn3: UIBotton!
    @IBOutlet weak var btn4: UIBotton!
    @IBOutlet weak var topborder: UIView!
    
    @IBOutlet weak var topborderht: NSLayoutConstraint!
    
    
    
   
    @IBOutlet weak var sectionTitleField: UITextFeild!
    
    
    
    
    
    
    func loadUI()
    {
        addGrayBorders([backView, btn1, displayorderField]);
        
        
        
        btn2.layer.cornerRadius = 5.0
        btn2.layer.borderColor = UIColor.lightGray.cgColor;
        btn2.layer.borderWidth = 1.0;
        
        btn3.layer.cornerRadius = 5.0
        btn3.layer.borderColor = UIColor.lightGray.cgColor;
        btn3.layer.borderWidth = 1.0;
        
        btn4.layer.cornerRadius = 5.0
        btn4.layer.borderColor = UIColor.lightGray.cgColor;
        btn4.layer.borderWidth = 1.0;
        
        
    }
    
    
    
}










class RoomBuildingListingCellClass : UITableViewCell
{
    
    @IBOutlet weak var buildName: UILabel!
    @IBOutlet weak var subBuildName: UILabel!
    @IBOutlet weak var assignPersonName: UILabel!
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var descriptionLab: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    
    
    
    
    func loadingDefaultUI()
    {
       // addLighterBorder([backView], opt : false);
        
        
    }
    
}








class UIImgeViewCell : UITableViewCell
{
    
    @IBOutlet weak var ImageTitle: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var selectImgBtn: UIBotton!
    
    func loadingDefaultUI()
    {
        
        selectImage.layer.borderColor = UIColor.lightGray.cgColor;
        selectImage.layer.borderWidth = 1.0;
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






























class BuildingHeaderViewCellClass : UIView
{
    @IBOutlet weak var addBtn: UIBotton!
    @IBOutlet weak var headTitle: UILabel!
    
    
    
    
    
    
    
}



class EditBuildingUsualCellClass : UITableViewCell
{
    @IBOutlet weak var headerTitle: UILabel!
    
    
    @IBOutlet weak var headerField: UITextFeild!
    
    
    
    
    
    
    
}







class dynamicAddBrowseBtnsClass : UITableViewCell
{
    
    @IBOutlet weak var chooseFileBtn: UIButton!
    @IBOutlet weak var addRremoveBtn: UIButton!
    
    
   
  
    
    
    
    
    
    
}


class MechanicalRoomCellClasss : UITableViewCell
{
    
    @IBOutlet weak var backView: UIView!
     
    @IBOutlet weak var detailImg: UIImageView!
    
    func loadingDefaultUI()
    {
        //addLighterBorder([backView], opt: true);
        
      
        
        
        
        
        
        
    }
    
    
    
}



class EditBuildingDeleteRowsCellClass : UITableViewCell
{
    
    @IBOutlet weak var deleteBtn: UIBotton!
     
    @IBOutlet weak var titleBtn: UIBotton!
    
    
}



class EnterMechanicalroomView : UIView
{
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var MechanicalRoomName: UITextField!
    
    @IBOutlet weak var submitBtn: UIBotton!
    @IBOutlet weak var warningLab: UILabel!
    
    func loadingDefaultUI()
    {
        
        submitBtn.layer.cornerRadius = 5.0;
        submitBtn.clipsToBounds = true;
        
    }
    
    
}





class DocumentLibraryCellClass : UITableViewCell
{
    @IBOutlet weak var addBtn: UIBotton!
    @IBOutlet weak var innerField: UITextFeild!
    @IBOutlet weak var chooseFileBtn: UIBotton!
    @IBOutlet weak var bottomLine: UILabel!
    @IBOutlet weak var underBar: UILabel!
    
    @IBOutlet weak var gapbwtTwo: NSLayoutConstraint!
    
    func loadingDefaultUI()
    {
        chooseFileBtn.layer.cornerRadius = 8.0;
        chooseFileBtn.clipsToBounds = true;
        
    }
    
    
}





class CompanyLogoCellClass : UITableViewCell
{
    
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoViewBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    
    func loadingDefaultUI()
    {
         //addLighterBorder([backview, logoView],opt: false)
       
       
        
        
    }
    
    
    
    
    
}





class syncingViewClass : UIView
{
    @IBOutlet weak var activityindi: UIActivityIndicatorView!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var statusPercentage: UILabel!
    
    func showLoader(obj : UIViewController)
    {
        self.frame = obj.view.frame;
        obj.view.addSubview(self)
        
    }
    
    
}

class IncheckBoxView : UIView
{
    
    @IBOutlet weak var firstBtn: UIBotton!
    @IBOutlet weak var secondBtn: UIBotton!
    
    
    
    
}






class AuditReportCellClass : UITableViewCell{
    
    @IBOutlet weak var baKView: UIView!
    
    
    func loadingDefaultUI()
    {
        //addLighterBorder([baKView], opt: false)
       
        
        
        
    }
    
    
}


class logoViewClass : UIView
{
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var imgScrollert: UIScrollView!
    
    func loadingDefaultUI()
    {
        
        imgScrollert.minimumZoomScale = 1.0
        imgScrollert.maximumZoomScale = 6.0
        exitBtn.layer.cornerRadius = 15;
        exitBtn.clipsToBounds = true;
        
    }
    
}





class dynamicAddMechanicalROom : UITableViewCell
{
    
    
    func loadingDefaultUI()
    {
        
        addRoomBtn.layer.cornerRadius = 3.0
        addRoomBtn.clipsToBounds = true;
        
    }
    
    @IBOutlet weak var backView: UIView!
  
    @IBOutlet weak var roomTitle: UITextField!
    @IBOutlet weak var addRowBtn: UIButton!
    @IBOutlet weak var addRoomBtn: UIButton!
    
    
   
    
    
    
}





class dynamciChooseFileWithTextClass : UITableViewCell
{
    
  
   
    @IBOutlet weak var drawingTitle: UITextField!
    
    @IBOutlet weak var addChooseFileBtn: UIButton!
    
    
    
    @IBOutlet weak var backView: UIView!
    func loadingDefaultUI()
    {
        //addBorders([backView], col: "0CAEC6");
        
        
        
        
    }
    
    
    
  
    
}



class dropDownListingCell : UITableViewCell
{
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var title: UITextField!
    
    
    
    func loadingDefaultUI()
    {
       // addBorders([backView], col: "0CAEC6");
        
       
        
        
    }
    
    
}




class selectCellClass : UITableViewCell
{
    
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var selectUnselectBtn: UIButton!
    
    
    
    
    
    
    
    
    
    
    
}



class CustomInspectionCellClass : UITableViewCell
{
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var propertyCode: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    
    
    
    
    func loadingDefaultUI()
    {
    // addLighterBorder([backView], opt: false);
        
    }
    
    
}






class InspectionSheeetDynamicCellClass : UITableViewCell
{
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fieldTypeBackView: UIView!
    
    @IBOutlet weak var fieldLabelBackView: UIView!
    @IBOutlet weak var addRowBtn: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    
    
    
    
    
    func loadingDefaultUI()
    {
       
        // addBorders([fieldTypeBackView, fieldLabelBackView], col: "0CAEC6");
        
        
    }
    
    
    
    
}




class InspectionSheetCellHeaderClass : UIView
{
    
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var addheaderBtn: UIButton!
    @IBOutlet weak var titleField: UITextField!
    
    
    
 
    
    
    func loadingDefaultUI()
    {
        
         //addBorders([backView], col: "0CAEC6");

        
    }
    
    
    
    
    
}












class DetailscreenHeaderCell : UITableViewCell
{
    
    @IBOutlet weak var valueLab: UILabel!
    @IBOutlet weak var keyLab: UILabel!
    
    
    
    
}




class DetailScreenSubHeader : UITableViewCell
{
    
    @IBOutlet weak var keyLab: UILabel!
    
    
}



class MechanicalRoomInspectionSheetCellClass : UITableViewCell
{
    
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var inspectionSheetName: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
   
    
    func loadingDefaultUI()
    {
        
      // addLighterBorder([backview], opt : false);
        
    }
    
    
    
    
}



class AssetManagementEquipmentCellClass : UITableViewCell
{
    
    @IBOutlet weak var propertyCode: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var equipment: UILabel!
    @IBOutlet weak var mechanicalRoom: UILabel!
    
    @IBOutlet weak var backview: UIView!
    
    
    
    func loadingDefaultUI()
    {
        
      //  addLighterBorder([backview], opt : false);
        
    }
    
    
    
    
    
    
}





class NotificationCellClass : UITableViewCell
{
    
    
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var companyName: UILabel!
    
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var clusterName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var testContent: UILabel!
    
    func loadingDefaultUI()
    {
        
        
       // addLighterBorder([backview], opt : false);
        
        
        
    }
    
    
    
}








class InspectionReportCellClass : UITableViewCell
{
    
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var datenTime: UILabel!
    @IBOutlet weak var previewBtn: UIButton!
    
    
   
    
    
    func loadingDefaultUI()
    {
        previewBtn.layer.cornerRadius = 5.0;
        previewBtn.clipsToBounds = true;
      //  addLighterBorder([backview], opt : false);
        
        
    }
    
    
    
}






class RepairNCostCellClass : UITableViewCell
{
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var usernme: UILabel!
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var equipmaentname: UILabel!
    
    @IBOutlet weak var datentime: UILabel!
   
    @IBOutlet weak var viewBtn: UIButton!
    
    @IBOutlet weak var backview: UIView!
    
    
    func loadingDefaultUI()
    {
        viewBtn.layer.cornerRadius = 5.0;
        viewBtn.clipsToBounds = true;
        // addLighterBorder([backview], opt: false);
        
        
    }
    
   
}





class TestDetailCellClass : UITableViewCell
{
    
    @IBOutlet weak var keyttitle: UILabel!
    
    @IBOutlet weak var valueTitle: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    
    func loadingDefaultUI()
    {
        self.contentView.layer.borderWidth = 1.0;
        self.contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor;
        
    }
    
    
    
    
    
}







class dynamicNotesCellClass : UITableViewCell
{
    @IBOutlet weak var notesOneCell: UIView!
    @IBOutlet weak var notesTwoCell: UIView!
  
    
    @IBOutlet weak var notesTwoField: UITextField!
    
    @IBOutlet weak var notesoneField: UITextField!
    
    @IBOutlet weak var addnotesBtn: UIButton!
    
    
    func loadingDefaultUI()
    {
       // addBorders([notesOneCell, notesTwoCell], col: blueColor);
        
        
    }
    
    
    
    
}








class buildingEditwithDeleteCanCell : UITableViewCell
{
    
    
    @IBOutlet weak var roomTitle: UITextField!
    
    
    @IBOutlet weak var edtBtn: UIButton!
    
  
    
    
    
    func loadingDefaultUI()
    {
        
         
        edtBtn.layer.cornerRadius = 3.0;
        edtBtn.clipsToBounds = true;
        
        
    }
    
    
    
    
    
    
    
    
}






class SuperInspectionHeaderView : UIView{
    @IBOutlet weak var upperviwht: NSLayoutConstraint!
    
    @IBOutlet weak var uppercons: NSLayoutConstraint!
    @IBOutlet weak var headtitle: UILabel!
    @IBOutlet weak var verytoplabel: UILabel!
    
    
    
    
    
    
}

class SuperVendorRepairHeaderCell : UIView
{
    @IBOutlet weak var vendorPic: UIImageView!
    @IBOutlet weak var dateNTime: UILabel!
    @IBOutlet weak var headerTitle: UILabel!
    
    @IBOutlet weak var selectBtn: UIBotton!
    
    
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var repairStatus: UILabel!
    
    
    
    
    
}

class ExtraRadioView : UIView
{
    
    
    @IBOutlet weak var firstRadioBtn: UIBotton!
    @IBOutlet weak var secondRadioBtn: UIBotton!
    
    
    
    
    
    
    
    
}

class chooseUsualFileCell : UITableViewCell
{
    @IBOutlet weak var headLab: UILabel!
    @IBOutlet weak var chooseBtn: UIBotton!
    @IBOutlet weak var hoBtn: NSLayoutConstraint!
    
    
    
    
    
    func loadingDefaultUI()
    {
        chooseBtn.layer.cornerRadius = 5.0;
        chooseBtn.clipsToBounds = true;
        
        
    }
    
    
    
}



class HeaderTextFieldCellClass : UITableViewCell
{
    
    @IBOutlet weak var textFieldTitle: UILabel!
    
    @IBOutlet weak var textFiledLab: UITextFeild!
    @IBOutlet weak var downArrow: UIImageView!
    
    
    
}




class inspectionCustomField : UITableViewCell
{
    
    @IBOutlet weak var addactivitier: UIActivityIndicatorView!
    
    @IBOutlet weak var optionHt: NSLayoutConstraint!
    @IBOutlet weak var optionsVw: UIView!
    @IBOutlet weak var addRowBtn: UIBotton!
    @IBOutlet weak var fieldLabelBackView: UIView!
    @IBOutlet weak var fieldOrderFd: UITextFeild!
    @IBOutlet weak var optionsHt: NSLayoutConstraint!
    @IBOutlet weak var deleteCellBtn: UIBotton!
    @IBOutlet weak var deleteActivitier: UIActivityIndicatorView!
    
    
    @IBOutlet weak var optionTextarea: UITextVw!
    
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var optionViw: UIView!
    
    @IBOutlet weak var requirednNoBtn: UIBotton!
    @IBOutlet weak var requiredyesBtn: UIBotton!
    @IBOutlet weak var validalphaBtn: UIBotton!
    @IBOutlet weak var validAnyBtn: UIBotton!
    @IBOutlet weak var validNumBtn: UIBotton!
    
    
   
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var rowTitle: UITextFeild!
    @IBOutlet weak var roeType: UITextFeild!
    
    @IBOutlet weak var defaultVlve: UITextFeild!
    
    
    func loadUI()
    {
        
        
        addGrayBorders([fieldLabelBackView, typeView, optionViw, requirednNoBtn, requiredyesBtn, validalphaBtn, validNumBtn, validAnyBtn, defaultView, fieldOrderFd])
    }
    
    
    
    
    
    
    
}



class buildingHeadCellClass : UIView
{
    @IBOutlet weak var address1: UILabel!
    @IBOutlet weak var address2: UILabel!
    
    
    
    
    
    
    
    
}



class chooseFileWithBorderCell : UITableViewCell
{
    
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var chooseFile: UIBotton!
    
    @IBOutlet weak var deleteBtn: UIBotton!
    @IBOutlet weak var title: UITextFeild!
    
    
    
    
    func loadUI()
    {
        chooseFile.layer.cornerRadius = 5.0;
        
        addGrayBorders([backview]);
    }
    
    
    
}



class menucellheaderCvlass : UIView
{
    @IBOutlet weak var headTapper: UIBotton!
    
    
    @IBOutlet weak var frontimg: UIImageView!
    @IBOutlet weak var rightimage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var backgroundVw: UIView!
    @IBOutlet weak var titlewt: NSLayoutConstraint!
    
    
    
}
