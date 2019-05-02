//
//  ApisClass_Rath_Associates.swift
//  Rathe_Associates
//
//  Created by Apple on 18/05/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import Foundation
 
//http://design.ratheassociates.com/testapi/login.php
//http://mybets360.com/getvendorinformation
//let BasicDomain = "http://mybets360.com/";
let BasicDomain = "http://v1-1.mybets360.com/";
/*
Admin -> 0
Super -> 1
Building Manager -> 2
Corporate Manager -> 3
Rathe Admin -> 4

*/


//----------------------- Version 1.1 --------------------------------

let vMp4videouploadingapi = "http://192.81.170.19/~mybetsco/wordpress-test/sample-page";
 let vDocdelteApi = BasicDomain + "documentsdeletebyid/";


 let vDashboardDataApi = BasicDomain + "dashbaordcount/";
let offlineVoneAPI = BasicDomain +  "overallapiv11/";

let myProfileupdate = BasicDomain +  "updateapiprofile";



//************* BuildingAPIS *****************
let vbuildingList = BasicDomain + "allbuildingsbyuser/";
let vcompanystateList = BasicDomain + "allbuildingrel/";
let vsavebuildingApi = BasicDomain + "savebuildings";
let vbuildingfileupload = BasicDomain + "bdupload";
let vbuildingDetailData = BasicDomain + "buildingviewbyid/";
let vbuildingDeleteApi = BasicDomain + "buildingdeletebyid/";
 let vbuildingEditdetailApi = BasicDomain + "buildingeviewbyid/";
 let vbuildingupdateApi = BasicDomain + "updatebuildings";
 let vbuildingDocsApi = BasicDomain + "buildingdocumentsbyid/";
 let vbuildingDeleteManager = BasicDomain + "delwbuildmanager/";
 let vbuildingDeleteSuper = BasicDomain + "delwbuildsuper/";
 let vbuildingAddSuper = BasicDomain + "savesuperfbuilding";
 let vbuildingAddmanager = BasicDomain + "savemanagerfbuilding";

//************* Mechanical Room API *****************
let vmechanicalListapi = BasicDomain + "allmechs/";
let vmechanicalDetailApi = BasicDomain + "mechdviewbyid/";
let vmechanicalBuildinglistapi = BasicDomain + "allmechsrel/";
let vmechanicalSaveApi = BasicDomain + "savemechs";

let vmechanicalEditData = BasicDomain + "mechedviewbyid/";
let vmechanicalupdateinsApi = BasicDomain + "cdiform";
let vmechanicalEditEquipmentDeleteApi = BasicDomain + "delmecheqp/";
let vmechanicalEditDeleteSuperApi = BasicDomain + "delmechsuper/";
let vmechanicalDeleteApi = BasicDomain + "mechdeletebyid/";


//************* Equipment API *****************
let vEquipmentListApi = BasicDomain + "alleqps/";
let vEquipmentUploadimageApi = BasicDomain + "edupload";
let vEquipmentCreatedataApi = BasicDomain + "alleqprels/";
let vEquipmentCreatesaveApi = BasicDomain + "saveeqps";
let vEquipmentDetaildataApi = BasicDomain + "eqpdviewbyid/";
let vEquipmentEditDetailDataApi = BasicDomain + "eqpedviewbyid/";
let vEquipmentUpdateDataApi = BasicDomain + "updateequipment";


//************* CustomInspection API *****************

let vAddCustomInspectionDetail = BasicDomain + "inscommechnicals/";
let vAddCustomInspectionSaveapi = BasicDomain + "saveinspectionform";
let vCustomInspectionListAPI = BasicDomain + "inslisting/";
let vCustomInspectionDeleteAPI = BasicDomain + "deleteinspectionform/";
let vCustomInspectionPreviewAPI = BasicDomain + "getapiinspectionform/";
let vCustomInspectionDetailAPI = BasicDomain + "viewinspectionlisting/";
let vEditCustomInspectionDetailAPI = BasicDomain + "editinspectionform/";
let vCustomInspectionSaveAsAPI = BasicDomain + "saveasinssheet";


//************* EfficiencyTest API *****************


let vEfficiencyTestListAPI = BasicDomain + "eqplisting/";
let vEfficiencyTestDeleteAPI = BasicDomain + "deleteeqpform/";
let vEffiecincyTestPreviewAPI = BasicDomain + "getapieqpform/";
let vEfficiencyTestCreateDetailAPI = BasicDomain + "alleqpcompanies/";
let vEfficiencyTestSaveAPI = BasicDomain + "saveeffciencytestform";
let vEfficiencyTestDetailAPI = BasicDomain + "viewequipment/";
let vEfficiencyTestEditDetailAPI = BasicDomain + "editeqpForm/";
let vEfficiencyTestSaveasAPI = BasicDomain + "saveaseffciencytestform";




//************ Company List API ***********************
let vCompanyListAPI = BasicDomain + "companylist/";
let vCompanysaveAPI = BasicDomain + "savecompany";
let vCompanyupdateAPI = BasicDomain + "updatecompanybyid";
let vCompanyDetailAPI = BasicDomain + "companyviewbyid/";
let vCompanyManagersAPI = BasicDomain + "companydetailsbyuserid/";


//************ Reports ****************


let vsigninLogReport = BasicDomain + "signlogreportlist/";
let vinsLogReport = BasicDomain + "insreportlist/";
let vrepaircost = BasicDomain + "repaircostreportlist/";
let vauditreports = BasicDomain + "auditreportlist/";
let vequipmentTestReports = BasicDomain + "eqptestreportlist/";

let vequipmentTestReportsVeiw = BasicDomain + "eqppdfreport";
let vrepaircostVeiw = BasicDomain + "rcostpdfreport";
let vinsLogReportVeiw = BasicDomain + "insapipdfreport";
let vauditreportsVeiw = BasicDomain + "eqppdfreport";
let vsigninLogReportVeiw = BasicDomain + "signlogapipdfreport";
//rp meech eqq

//*********** Users *******************
let vUserListAPI = BasicDomain + "userslist/";
let vUserDetailAPI = BasicDomain + "userviewbyid/";
let vUseraddAPI = BasicDomain + "saveuser";
let vUseraDeleteAPI = BasicDomain + "deleteuser/";
let vUseraaddCompaniesAPI = BasicDomain + "allcompaniesdropdown/";
let vUsereditDetailAPI = BasicDomain + "usereditviewbyid/";
let vUsereditUpdateAPI = BasicDomain + "updateuserbyid";


//*********** Notification *******************
let vNotificationListAPI = BasicDomain + "notificationlist";
let vNotificationDeleteAPI = BasicDomain + "deletenotification/";
let vNotificationResendAPI = BasicDomain + "resendnotification/";
let vNotificationRelationAPI = BasicDomain + "notificationrlist";
let vNotificationSaveAPI = BasicDomain + "savenotification";
let vNotificationDetailAPI = BasicDomain + "viewnotification/";




//*********** Subscriptions *******************
let vSubscriptionListAPI = BasicDomain + "subscriptionlist";
let vSubscriptionSaveAPI = BasicDomain + "savesubscription";
let vSubscriptionDeleteAPI = BasicDomain + "deletesubscription/";
let vSubscriptionDetailAPI = BasicDomain + "subscriptionviewbyid/";
let vSubscriptionUpdateAPI = BasicDomain + "updatesubscription";





 

//---------------------- Version 1.0 -----------------------------------

let loginApi = BasicDomain + "ulogin";


let registrationApi = BasicDomain + "savenewregistration";

let registrationStatesAPI = BasicDomain + "allstates";



let forgotPasswordApi = BasicDomain + "savenewForgot";


let buildingListApi = BasicDomain + "allbuildingsbyuser";



let mechanicalroomSignInApi = BasicDomain + "supersigninmechroom";


let mechanicalRoomApi = BasicDomain + "allmechsbybuilding";


let documentAPI = BasicDomain + "mechdocuments";


let signOutFromMechRoomAPI = BasicDomain + "supersignoutmechroom";


let mechanicalRoomDashboardAPI =  BasicDomain + "mechviewbyid";


let equipmentDocAPI = BasicDomain + "eqpdocuments";



let saveVendorAPI = BasicDomain + "savenewVendor";


let saveEfficiencyAPI = BasicDomain + "saveeffeciency";


let efficientyFormAPI = BasicDomain + "getapieqpform";


let inspectionFormAPI = BasicDomain + "getapiinspectionform";


let saveInspectionFormAPI = BasicDomain + "saveinspectionsheet";



let vaendorListingAPI = BasicDomain + "getvendorinformation";



let upadateVendorAPI = BasicDomain + "updatevendorrecord";

let InspectionUploadImageAPI = BasicDomain + "updatevendorrecord";


let offlineDataAPI = BasicDomain +  "getallinformation";


let imageUploadAPI = BasicDomain + "upload";




var ImgFilePathAPI = BasicDomain;




























































class ApiClassRatheAssociates
{
    
    
    
    
    public static var call  = ApiClassRatheAssociates();
    
    
    
    
    
    func callingSignup()
    {
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
}




