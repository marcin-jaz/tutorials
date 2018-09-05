//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2009 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/** 
 * @fileOverview This javascript provides all the functions needed for the B2B store logon and registration.
 * @version 1.9
 */

dojo.require("wc.service.common");

B2BLogonForm ={
   prepareSubmitOrgReg:function (form){
      /////////////////////////////////////////////////////////////////////////////
      // This javascript function is for 'Submit' button in the organization registration page.
      /////////////////////////////////////////////////////////////////////////////
      reWhiteSpace = new RegExp(/^\s+$/);
      if (form.org_orgEntityName !=null && (reWhiteSpace.test(form.org_orgEntityName.value) || form.org_orgEntityName.value=="")) {
         MessageHelper.formErrorHandleClient(form.org_orgEntityName.id,MessageHelper.messages["ERROR_OrgNameEmpty"]); return;
      }
      if (form.org_address1 !=null && (reWhiteSpace.test(form.org_address1.value) || form.org_address1.value=="")) {
         MessageHelper.formErrorHandleClient(form.org_address1.id,MessageHelper.messages["ERROR_AddressEmpty"]); return;
      }
      if (form.org_city !=null && (reWhiteSpace.test(form.org_city.value) || form.org_city.value=="")) {
         MessageHelper.formErrorHandleClient(form.org_city.id,MessageHelper.messages["ERROR_CityEmpty"]); return;
      }
      if (form.org_country !=null && (reWhiteSpace.test(form.org_country.value) || form.org_country.value=="")) {
         MessageHelper.formErrorHandleClient(form.org_country.id,MessageHelper.messages["ERROR_CountryEmpty"]); return;
      }
      var formState = document.getElementById('org_WC_OrganizationRegistrationAddForm_AddressEntryForm_FormInput_org_state_1');
      if (formState !=null && (reWhiteSpace.test(formState.value) || formState.value=="")) {
         MessageHelper.formErrorHandleClient(formState.id,MessageHelper.messages["ERROR_StateEmpty"]); return;
      }
      if (form.org_zipCode !=null && (reWhiteSpace.test(form.org_zipCode.value) || form.org_zipCode.value=="")) {
         MessageHelper.formErrorHandleClient(form.org_zipCode.id,MessageHelper.messages["ERROR_ZipCodeEmpty"]); return;
      }
      //email address
      if (form.org_email1 !=null && (reWhiteSpace.test(form.org_email1.value) || form.org_email1.value=="")) {
         MessageHelper.formErrorHandleClient(form.org_email1.id,MessageHelper.messages["ERROR_EmailEmpty"]); return;
      }else if(!MessageHelper.isValidEmail(form.org_email1.value)){
         MessageHelper.formErrorHandleClient(form.org_email1.id,MessageHelper.messages["WISHLIST_INVALIDEMAILFORMAT"]);return ;
      }
      //phone number
      if (!MessageHelper.IsValidPhone(form.org_phone1.value)) {
         MessageHelper.formErrorHandleClient(form.org_phone1.id,MessageHelper.messages["ERROR_INVALIDPHONE"]);
         return ;
      }
      /////////////////////////
      // Organization section end
      ////////////////////////

      if (form.usr_logonId !=null && (reWhiteSpace.test(form.usr_logonId.value) || form.usr_logonId.value=="")){
         MessageHelper.formErrorHandleClient(form.usr_logonId.id,MessageHelper.messages["ERROR_LogonIdEmpty"]); return;
      }

      if (form.logonPassword !=null && (reWhiteSpace.test(form.logonPassword.value) || form.logonPassword.value=="")){
         MessageHelper.formErrorHandleClient(form.logonPassword.id,MessageHelper.messages["ERROR_PasswordEmpty"]); return;
      }else if  (form.logonPasswordVerify !=null && (reWhiteSpace.test(form.logonPasswordVerify.value) || form.logonPasswordVerify.value=="")) {
         MessageHelper.formErrorHandleClient(form.logonPasswordVerify.id,MessageHelper.messages["ERROR_PasswordEmpty"]); return;
      }else if (form.logonPasswordVerify !=null && form.logonPasswordVerify.value!= form.logonPassword.value) {
         MessageHelper.formErrorHandleClient(form.logonPasswordVerify.id,MessageHelper.messages["PWDREENTER_DO_NOT_MATCH"]); return;
      }

      if(!AddressHelper.validateAddressForm(form,'usr_')){
         return;
      }

      if (form.usr_email1 !=null && (reWhiteSpace.test(form.usr_email1.value) || form.usr_email1.value=="")){
         MessageHelper.formErrorHandleClient(form.usr_email1.id,MessageHelper.messages["ERROR_EmailEmpty"]); return;
      }else if(!MessageHelper.isValidEmail(form.usr_email1.value)){
         MessageHelper.formErrorHandleClient(form.usr_email1.id,MessageHelper.messages["WISHLIST_INVALIDEMAILFORMAT"]);return ;
      }
      if (!MessageHelper.IsValidPhone(form.usr_phone1.value)) {
         MessageHelper.formErrorHandleClient(form.usr_phone1.id,MessageHelper.messages["ERROR_INVALIDPHONE"]);
         return ;
      }

      if(form.mobileDeviceEnabled != null && form.mobileDeviceEnabled.value == "true"){
         if(!MyAccountDisplay.validateMobileDevice(form)){
            return;
         }
      }
      if(form.birthdayEnabled != null && form.birthdayEnabled.value == "true"){
         if(!MyAccountDisplay.validateBirthday(form)){
            return;
         }
      }
      this.setSMSCheckBoxes(form);
      form.submit();
   },
   
   constructParentOrgDN: function (ancestorOrgs) {
      var parentOrgDN = ancestorOrgs;
      while(true) {
         var n = parentOrgDN.indexOf("/");
         if(n == -1) {
            break;
         }
         parentOrgDN = parentOrgDN.substring(0, n) + "," + orgPrefix + parentOrgDN.substring(n + 1, parentOrgDN.length);
      }
      parentOrgDN = orgPrefix + parentOrgDN + rootOrgDN;
      return parentOrgDN;
   },
   
   setParentMemberValue: function (){
      document.Register.parentMember.value = this.constructParentOrgDN(document.Register.ancestorOrgs.value);
   },

   fillAdminAddress: function(form){
      var checkbox = document.getElementById("WC_OrganizationRegistrationAddForm_Checkbox1");
      if (checkbox.checked){
         form.usr_address1.value = this.getFieldValue(form.org_address1);
         form.usr_address2.value = this.getFieldValue(form.org_address2);
         form.usr_country.value = this.getFieldValue(form.org_country);
         form.usr_zipCode.value = this.getFieldValue(form.org_zipCode);

         var orgCountry = document.getElementById('WC_OrganizationRegistrationAddForm_AddressEntryForm_FormInput_org_country_1');
         var index = orgCountry.selectedIndex;

         var usrCountry = document.getElementById('WC_OrganizationRegistrationAddForm_AddressEntryForm_FormInput_usr_country_1');
         usrCountry.options[index].selected=true;
         //using getElementById to get value because the input field is generated with javascript DOM
         //see AddressHelper.loadStatesUI
		 AddressHelper.loadStatesUI(form.name,'usr_','usr_stateDiv','WC_OrganizationRegistrationAddForm_AddressEntryForm_FormInput_usr_state_1',false,this.getFieldValue(document.getElementById('org_WC_OrganizationRegistrationAddForm_AddressEntryForm_FormInput_org_state_1')));
         form.usr_city.value = this.getFieldValue(form.org_city);

      }
   },

   getFieldValue: function (field){
      //returns the field value iff the the field value is not null or empty.
      return (field==null || field=='')?'':field.value;
   },
   
   setSMSCheckBoxes: function (form) {
	   /* 
	    * In PersonalInfoExtension.jspf, setSMSCheckBoxes and sendMeSMSPreference are used as the name of the checkboxes.
	    * But for the command BuyerRegistrationAdd to save the data, the name of the checkboxes must be 
	    * converted to receiveSMSNotification and receiveSMSPreference
	    * */
	   var sendMeSMSNotification = document.getElementById("WC_UserRegistrationAddForm_FormInput_sendMeSMSNotification_In_Register_2");
	   var sendMeSMSPreference = document.getElementById("WC_UserRegistrationAddForm_FormInput_sendMeSMSPreference_In_Register_3");
	   if (sendMeSMSNotification!=null && sendMeSMSNotification.checked) {form.receiveSMSNotification.value = true;} else {form.receiveSMSNotification.value = false;}
	   if (sendMeSMSPreference!=null && sendMeSMSPreference.checked) {form.receiveSMS.value=true; } else {form.receiveSMS.value=false; }
   }
}
