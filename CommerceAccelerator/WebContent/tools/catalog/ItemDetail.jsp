<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2000, 2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<HTML>
<HEAD>

<%@page import="java.util.*,
              com.ibm.commerce.beans.*,
                com.ibm.commerce.tools.catalog.beans.*,
                com.ibm.commerce.catalog.objects.*,
                com.ibm.commerce.tools.catalog.util.*,
                com.ibm.commerce.utils.*,
                com.ibm.commerce.tools.util.*,
                com.ibm.commerce.command.*"
%>
<%@ page import="com.ibm.commerce.command.CommandContext" %>  
<%@ page import="com.ibm.commerce.tools.common.ToolsConfiguration" %>
<%@ page import="com.ibm.commerce.discount.rules.DiscountConst" %> 

<%@include file="../common/common.jsp" %>

<%
  CommandContext cmdContext = (CommandContext)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_COMMANDCONTEXT);
  Locale jLocale = cmdContext.getLocale();
  Hashtable itemResource = (Hashtable)com.ibm.commerce.tools.util.ResourceDirectory.lookup("catalog.ItemNLS", jLocale);
  Hashtable calendarResource = (Hashtable)com.ibm.commerce.tools.util.ResourceDirectory.lookup("common.calendarNLS", jLocale);
  String fulfillmentCenterId = UIUtil.getFulfillmentCenterId(request);
%>


<% 
   try {
     
    String languageId = request.getParameter(com.ibm.commerce.server.ECConstants.EC_LANGUAGE_ID);
    String itemRefNum = request.getParameter(ECConstants.EC_ITEM_NUMBER);
    String productRefNum = request.getParameter(ECConstants.EC_PRODUCT_NUMBER);


    ItemDataBean bnItem = null;
    ProductDataBean bnProduct = null;

    if(itemRefNum != null){
    	bnItem = new ItemDataBean();
    	bnItem.setItemRefNum(itemRefNum);

	DataBeanManager.activate(bnItem, request);
    }else{

	bnProduct = new ProductDataBean();
	bnProduct.setProductRefNum(productRefNum);
	
	DataBeanManager.activate(bnProduct, request);
    }
    
	
    

    String memberId= null;
   

    CatalogEntryDescriptionAccessBean catEntDesc = new CatalogEntryDescriptionAccessBean();

    String lastUpdateTS = null;
    lastUpdateTS = "";

    String lastUpdate = (itemResource.get("notAvailable")).toString();

    String onauction = (String)itemResource.get("no");

    String catEntName = null;
    catEntName = "";

    String partNumber = null;

    String published = null;
    published = "";

    String buyable = null;
    buyable = "";
    
    String startYear = null;
    startYear = "";
    
    String startMonth = null;
    startMonth = "";
    
    String startDay = null;
    startDay = "";
    
    String endYear = null;
    endYear = "";
    
    String endMonth = null;
    endMonth = "";
    
    String endDay = null;
    endDay = "";
    
    String availabilityYear="", availabilityMonth="", availabilityDay = "";
    String lastOrderYear="", lastOrderMonth="", lastOrderDay="";
    String endOfServiceYear="", endOfServiceMonth="", endOfServiceDay="";
    String discontinueYear="", discontinueMonth="", discontinueDay="";


    if(itemRefNum != null){

	catEntDesc = bnItem.getDescription(languageId);
    
     	memberId = bnItem.getMemberId();

	// no description for this item, create one for user to add description
    	if (catEntDesc == null) {
        	catEntDesc = new CatalogEntryDescriptionAccessBean(new Long(itemRefNum), new Integer(languageId));
                catEntDesc.setName("");
                catEntDesc.setShortDescription("");
                catEntDesc.setLongDescription("");
       		catEntDesc.commitCopyHelper();
    	}


	lastUpdateTS = bnItem.getLastUpdate();
	lastUpdateTS = (lastUpdateTS != null ? UIUtil.toJavaScript(lastUpdateTS) : "");
	if (lastUpdateTS != null && !lastUpdateTS.equals("")) {
        	lastUpdate = TimestampHelper.getDateTimeFromTimestamp(ECStringConverter.StringToTimestamp(lastUpdateTS), jLocale);
    	}


	if ((bnItem.getOnAuction()).equals(CatalogUtil.ON_AUCTION)) 
        onauction = (String)itemResource.get("yes");


	catEntName = catEntDesc.getName();
	catEntName = (catEntName != null ? UIUtil.toJavaScript(catEntName) : "");

	memberId = (memberId != null ? UIUtil.toJavaScript(memberId) : "");

	partNumber = bnItem.getPartNumber();

	published = catEntDesc.getPublished();

  	buyable = bnItem.getBuyable();
  	
    // Add the start and end date here: used by the notebook
  	
  	startYear = bnItem.getStartYear();
  	startMonth = bnItem.getStartMonth();
  	startDay = bnItem.getStartDay();
  	
  	endYear = bnItem.getEndYear();
  	endMonth = bnItem.getEndMonth();
  	endDay = bnItem.getEndDay();

  	availabilityYear = bnItem.getAvailabilityYear();
  	availabilityMonth = bnItem.getAvailabilityMonth();
  	availabilityDay = bnItem.getAvailabilityDay();
  	lastOrderYear = bnItem.getLastOrderYear();
  	lastOrderMonth = bnItem.getLastOrderMonth();
  	lastOrderDay = bnItem.getLastOrderDay();
  	endOfServiceYear = bnItem.getEndOfServiceYear();
  	endOfServiceMonth = bnItem.getEndOfServiceMonth();
  	endOfServiceDay = bnItem.getEndOfServiceDay();
  	discontinueYear = bnItem.getDiscontinueYear();
  	discontinueMonth = bnItem.getDiscontinueMonth();
  	discontinueDay = bnItem.getDiscontinueDay();

    }else{


	if(productRefNum != null){

		catEntDesc = bnProduct.getDescription(languageId);
    
     		memberId = bnProduct.getMemberId();

		// no description for this item, create one for user to add description
    		if (catEntDesc == null) {
        		catEntDesc = new CatalogEntryDescriptionAccessBean(new Long(productRefNum), new Integer(languageId));
       			catEntDesc.commitCopyHelper();
    		}


		lastUpdateTS = bnProduct.getLastUpdate();
		lastUpdateTS = (lastUpdateTS != null ? UIUtil.toJavaScript(lastUpdateTS) : "");
		if (lastUpdateTS != null && !lastUpdateTS.equals("")) {
        		lastUpdate = TimestampHelper.getDateTimeFromTimestamp(ECStringConverter.StringToTimestamp(lastUpdateTS), jLocale);
    		}


		if ((bnProduct.getOnAuction()).equals(CatalogUtil.ON_AUCTION)) 
        	onauction = (String)itemResource.get("yes");


		catEntName = catEntDesc.getName();
		catEntName = (catEntName != null ? UIUtil.toJavaScript(catEntName) : "");

		memberId = (memberId != null ? UIUtil.toJavaScript(memberId) : "");

		published = catEntDesc.getPublished();

  		buyable = bnProduct.getBuyable();

  		// Add the start and end date here: used by the notebook
  	
  		startYear = bnProduct.getStartYear();
  		startMonth = bnProduct.getStartMonth();
  		startDay = bnProduct.getStartDay();
  	
  		endYear = bnProduct.getEndYear();
  		endMonth = bnProduct.getEndMonth();
  		endDay = bnProduct.getEndDay();

  		availabilityYear = bnProduct.getAvailabilityYear();
  		availabilityMonth = bnProduct.getAvailabilityMonth();
  		availabilityDay = bnProduct.getAvailabilityDay();
  		lastOrderYear = bnProduct.getLastOrderYear();
  		lastOrderMonth = bnProduct.getLastOrderMonth();
  		lastOrderDay = bnProduct.getLastOrderDay();
  		endOfServiceYear = bnProduct.getEndOfServiceYear();
  		endOfServiceMonth = bnProduct.getEndOfServiceMonth();
  		endOfServiceDay = bnProduct.getEndOfServiceDay();
  		discontinueYear = bnProduct.getDiscontinueYear();
  		discontinueMonth = bnProduct.getDiscontinueMonth();
  		discontinueDay = bnProduct.getDiscontinueDay();
    	}

    }
	

	
       

      

    
%>





<META name="GENERATOR" content="IBM WebSphere Page Designer V3.0.2 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE><%=UIUtil.toHTML((String)itemResource.get("General"))%></TITLE>
<link rel=stylesheet href="<%= UIUtil.getCSSFile(jLocale) %>" type="text/css">


<SCRIPT LANGUAGE="JavaScript" SRC="/wcs/javascript/tools/common/Util.js"></SCRIPT>
<SCRIPT SRC="/wcs/javascript/tools/common/DateUtil.js"></SCRIPT>
<SCRIPT>

if (<%=ToolsConfiguration.isComponentEnabled(DiscountConst.COMPONENT_RULE_BASED_DISCOUNT) %>)
{
	parent.setPanelAttribute("Discounts","hasTab","NO");
	parent.setPanelAttribute("Manufacturer","next","SalesTax");  
	parent.setPanelAttribute("SalesTax","prev","Manufacturer"); 
	parent.TABS.location.reload();
}


function PropertyData(sku, name, published, buyable,
                      startYear, startMonth, startDay,
                      endYear, endMonth, endDay,
	                  availabilityYear, availabilityMonth, availabilityDay,
                	  lastOrderYear, lastOrderMonth, lastOrderDay,
		              endOfServiceYear, endOfServiceMonth, endOfServiceDay,
               		  discontinueYear, discontinueMonth, discontinueDay)
{
    this.sku = sku;
    this.name = name;

    this.published = published;
    this.buyable = buyable;
    this.oldSKU = "<%=(partNumber != null ? UIUtil.toJavaScript(partNumber) : "")%>";
    this.memberid = "<%=memberId%>";
    
    this.startYear = startYear;
    this.startMonth = startMonth;
    this.startDay = startDay;
    
    this.endYear = endYear;
    this.endMonth = endMonth;
    this.endDay = endDay;

    this.availabilityYear = availabilityYear;
    this.availabilityMonth = availabilityMonth;
    this.availabilityDay = availabilityDay;
    
    this.lastOrderYear = lastOrderYear;
    this.lastOrderMonth = lastOrderMonth;
    this.lastOrderDay = lastOrderDay;
    
    this.endOfServiceYear = endOfServiceYear;
    this.endOfServiceMonth = endOfServiceMonth;
    this.endOfServiceDay = endOfServiceDay;
    
    this.discontinueYear = discontinueYear;
    this.discontinueMonth = discontinueMonth;
    this.discontinueDay = discontinueDay;
}  




Property.ID = "details";


function Property(sku, name, published, buyable,
                  startYear, startMonth, startDay,
                  endYear, endMonth, endDay,
                  availabilityYear, availabilityMonth, availabilityDay,
                  lastOrderYear, lastOrderMonth, lastOrderDay,
                  endOfServiceYear, endOfServiceMonth, endOfServiceDay,
                  discontinueYear, discontinueMonth, discontinueDay) 
{
    this.data = new PropertyData(sku, name, published, buyable,
                                 startYear, startMonth, startDay,
                                 endYear, endMonth, endDay,
		                         availabilityYear, availabilityMonth, availabilityDay,
                	             lastOrderYear, lastOrderMonth, lastOrderDay,
		                         endOfServiceYear, endOfServiceMonth, endOfServiceDay,
               		             discontinueYear, discontinueMonth, discontinueDay);
    this.id = Property.ID;
    this.formref = null;
}    



function load() {
  
    this.data.sku = parent.cutspace(this.formref.sku.value);
    this.data.name = parent.cutspace(this.formref.name.value);
    
    this.data.startYear = parent.cutspace(this.formref.startYear.value);
    this.data.startMonth = parent.cutspace(this.formref.startMonth.value);
    this.data.startDay = parent.cutspace(this.formref.startDay.value);
    
    this.data.endYear = parent.cutspace(this.formref.endYear.value);
    this.data.endMonth = parent.cutspace(this.formref.endMonth.value);
    this.data.endDay = parent.cutspace(this.formref.endDay.value);
   
    this.data.availabilityYear = parent.cutspace(this.formref.availabilityYear.value);
    this.data.availabilityMonth = parent.cutspace(this.formref.availabilityMonth.value);
    this.data.availabilityDay = parent.cutspace(this.formref.availabilityDay.value);
    
    this.data.lastOrderYear = parent.cutspace(this.formref.lastOrderYear.value);
    this.data.lastOrderMonth = parent.cutspace(this.formref.lastOrderMonth.value);
    this.data.lastOrderDay = parent.cutspace(this.formref.lastOrderDay.value);
    
    this.data.endOfServiceYear = parent.cutspace(this.formref.endOfServiceYear.value);
    this.data.endOfServiceMonth = parent.cutspace(this.formref.endOfServiceMonth.value);
    this.data.endOfServiceDay = parent.cutspace(this.formref.endOfServiceDay.value);
    
    this.data.discontinueYear = parent.cutspace(this.formref.discontinueYear.value);
    this.data.discontinueMonth = parent.cutspace(this.formref.discontinueMonth.value);
    this.data.discontinueDay = parent.cutspace(this.formref.discontinueDay.value);

    if (this.formref.published.checked == true) {
        this.data.published = "true";
    } else {
        this.data.published = "false";
    }
 
    if (this.formref.buyable.checked == true) {
        this.data.buyable = "true";
    } else {
        this.data.buyable = "false";
    }
}
 


function display() 
{
    this.formref.sku.value = this.data.sku;
    this.formref.name.value = this.data.name;
    
    this.formref.startYear.value = this.data.startYear;
    this.formref.startMonth.value = this.data.startMonth;
    this.formref.startDay.value = this.data.startDay;
    
    this.formref.endYear.value = this.data.endYear;
    this.formref.endMonth.value = this.data.endMonth;
    this.formref.endDay.value = this.data.endDay;
   
    this.formref.availabilityYear.value = this.data.availabilityYear;
    this.formref.availabilityMonth.value = this.data.availabilityMonth;
    this.formref.availabilityDay.value = this.data.availabilityDay;
    
    this.formref.lastOrderYear.value = this.data.lastOrderYear;
    this.formref.lastOrderMonth.value = this.data.lastOrderMonth;
    this.formref.lastOrderDay.value = this.data.lastOrderDay;
    
    this.formref.endOfServiceYear.value = this.data.endOfServiceYear;
    this.formref.endOfServiceMonth.value = this.data.endOfServiceMonth;
    this.formref.endOfServiceDay.value = this.data.endOfServiceDay;
    
    this.formref.discontinueYear.value = this.data.discontinueYear;
    this.formref.discontinueMonth.value = this.data.discontinueMonth;
    this.formref.discontinueDay.value = this.data.discontinueDay;

    if (this.data.published == "true") {
        this.formref.published.checked = true;
    } else {
              this.formref.published.checked = false;
    }


    if (this.data.buyable == "true") {
        this.formref.buyable.checked = true;
    } else {
        this.formref.buyable.checked = false;
    }
}


function getData() {

    return this.data;
    
}



Property.prototype.load = load;
Property.prototype.display = display;
Property.prototype.getData = getData;

var prop = null;





function savePanelData()
{

   if (prop != null)
   {
       prop.formref = document.details;
       prop.load();
       parent.put(Property.ID, prop.getData());
       parent.put("fulfillmentCenterId",<%=fulfillmentCenterId%>);
   }
  
}





function initForm(){



    var dataObject = parent.get(Property.ID);
    
    if (dataObject == null) {
        
        prop = new Property("<%=(partNumber != null ? UIUtil.toJavaScript(partNumber) : "")%>", 
                          "<%=catEntName%>",   
                            <% if (published.equals(CatalogUtil.PUBLISHED)) {%>
                            "true",
                            <% } else {%>
                            "false",
                            <%}%>
                            <% if ((buyable.equals("")) || buyable.equals(CatalogUtil.BUYABLE)) {%>
                            "true"
                            <% } else {%>
                            "false"
                            <%}%>,
                            "<%=startYear%>",
                            "<%=startMonth%>",
                            "<%=startDay%>",
                            "<%=endYear%>",
                            "<%=endMonth%>",
                            "<%=endDay%>",
                            "<%=availabilityYear%>",
                            "<%=availabilityMonth%>",
                            "<%=availabilityDay%>",
                            "<%=lastOrderYear%>",
                            "<%=lastOrderMonth%>",
                            "<%=lastOrderDay%>",
                            "<%=endOfServiceYear%>",
                            "<%=endOfServiceMonth%>",
                            "<%=endOfServiceDay%>",
                            "<%=discontinueYear%>",
                            "<%=discontinueMonth%>",
                            "<%=discontinueDay%>");
 
         prop.formref = document.details;
            
        prop.display();
    } 
    else 
    {
        
        prop = new Property();
        prop.data = dataObject;
        prop.formref = document.details;
        prop.display();
         
    }


    if (parent.get("itemSkuRequiredMessage", false))
       {
        parent.remove("itemSkuRequiredMessage");
        document.details.sku.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("itemSkuRequiredMessage"))%>");
        
       }

    if (parent.get("itemNameRequiredMessage", false))
       {
        parent.remove("itemNameRequiredMessage");
        document.details.name.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("itemNameRequiredMessage"))%>");
               
       }
       
    if (parent.get("itemNameNotValidMessage", false))
       {
        parent.remove("itemNameNotValidMessage");
	document.details.name.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("itemNameNotValidMessage"))%>");
               
       }              

    if (parent.get("fieldSizeExceeded_sku", false))
       {
        parent.remove("fieldSizeExceeded_sku");
	document.details.sku.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("fieldSizeExceeded"))%>");
               
       }

    if (parent.get("fieldSizeExceeded_name", false))
       {
        parent.remove("fieldSizeExceeded_name");
	document.details.name.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("fieldSizeExceeded"))%>");
               
       }
       
      if (parent.get("notValidStartDate", false))
       {
        parent.remove("notValidStartDate");
		document.details.startYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidStartDate"))%>");
       }  
       
       if (parent.get("notValidEndDate", false))
       {
        parent.remove("notValidEndDate");
		document.details.endYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidEndDate"))%>");
       } 
       
       if (parent.get("notValidStartEndDate", false))
       {
        parent.remove("notValidStartEndDate");
		document.details.startYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidStartEndDate"))%>");
       } 
       
       if (parent.get("notValidAvailabilityDate", false))
       {
        parent.remove("notValidAvailabilityDate");
		document.details.availabilityYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidAvailabilityDate"))%>");
       }  
       
       if (parent.get("notValidLastOrderDate", false))
       {
        parent.remove("notValidLastOrderDate");
		document.details.lastOrderYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidLastOrderDate"))%>");
       }  
       
       if (parent.get("notValidEndOfServiceDate", false))
       {
        parent.remove("notValidEndOfServiceDate");
		document.details.endOfServiceYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidEndOfServiceDate"))%>");
       }  
       
       if (parent.get("notValidDiscontinueDate", false))
       {
        parent.remove("notValidDiscontinueDate");
		document.details.discontinueYear.select();
        alertDialog("<%= UIUtil.toJavaScript((String)itemResource.get("notValidDiscontinueDate"))%>");
       }  
       
      parent.setContentFrameLoaded(true);
}    



function checkAuction() {

    if (!document.details.buyable.checked && ("<%=UIUtil.toJavaScript(onauction)%>" == "<%=UIUtil.toJavaScript((String)itemResource.get("yes"))%>")) {
        alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("buyableFlagcannotBeChanged"))%>");
        document.details.buyable.checked = true;
    }

}


function validatePanelData(){

    var objSku = document.details.sku.value;
    var objName = document.details.name.value;
    var objStartYear = document.details.startYear.value;
    var objStartMonth = document.details.startMonth.value;
    var objStartDay = document.details.startDay.value;
    var objEndYear = document.details.endYear.value;
    var objEndMonth = document.details.endMonth.value;
    var objEndDay = document.details.endDay.value;
    var objAvailabilityYear = document.details.availabilityYear.value;
    var objAvailabilityMonth = document.details.availabilityMonth.value;
    var objAvailabilityDay = document.details.availabilityDay.value;
    var objLastOrderYear = document.details.lastOrderYear.value;
    var objLastOrderMonth = document.details.lastOrderMonth.value;
    var objLastOrderDay = document.details.lastOrderDay.value;
    var objEndOfServiceYear = document.details.endOfServiceYear.value;
    var objEndOfServiceMonth = document.details.endOfServiceMonth.value;
    var objEndOfServiceDay = document.details.endOfServiceDay.value;
    var objDiscontinueYear = document.details.discontinueYear.value;
    var objDiscontinueMonth = document.details.discontinueMonth.value;
    var objDiscontinueDay = document.details.discontinueDay.value;

    if(!document.details.sku.value){
	document.details.sku.select();
	alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("itemSkuRequiredMessage"))%>");
	return false;
    }
    
    if(!document.details.name.value){
	document.details.name.select();
	alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("itemNameRequiredMessage"))%>");
	return false;
    }


    if (! isValidItemName(document.details.name.value)){
    	document.details.name.select();
	alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("itemNameNotValidMessage"))%>");
	return false;
    }
    
    if ( !isValidUTF8length(objSku, 64)  ){
	document.details.sku.select();
	alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("fieldSizeExceeded"))%>");     	 
   	return false;
    }

    if ( !isValidUTF8length(objName, 128)  ){
	document.details.name.select();
	alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("fieldSizeExceeded"))%>");     	 
   	return false;
    }
    
    if ( !(objStartYear == "") || !(objStartMonth == "") || !(objStartDay == "") ) {
    	if ( !validDate(objStartYear,objStartMonth,objStartDay)  ){
		document.details.startYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidStartDate"))%>");     	 
   		return false;
    	}
    }

	if ( !(objEndYear == "") || !(objEndMonth == "") || !(objEndDay == "") ) {
    	if ( !validDate(objEndYear,objEndMonth,objEndDay)  ){
		document.details.endYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidEndDate"))%>");     	 
   		return false;
   		 }
    }
    
    if ( !(objStartYear == "") && !(objStartMonth == "") && !(objStartDay == "") && !(objEndYear == "") && !(objEndMonth == "") && !(objEndDay == "") ) {
    	if ( !validateStartEndDateTime(objStartYear,objStartMonth,objStartDay,objEndYear,objEndMonth,objEndDay,null,null)  || (validateStartEndDateTime(objStartYear,objStartMonth,objStartDay,objEndYear,objEndMonth,objEndDay,null,null) == -1) ){
		document.details.startYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidStartEndDate"))%>");     	 
   		return false;
    	}
    }

    if ( !(objAvailabilityYear == "") || !(objAvailabilityMonth == "") || !(objAvailabilityDay == "") ) {
    	if ( !validDate(objAvailabilityYear,objAvailabilityMonth,objAvailabilityDay)  ){
		document.details.availabilityYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidAvailabilityDate"))%>");     	 
   		return false;
    	}
    }

    if ( !(objLastOrderYear == "") || !(objLastOrderMonth == "") || !(objLastOrderDay == "") ) {
    	if ( !validDate(objLastOrderYear,objLastOrderMonth,objLastOrderDay)  ){
		document.details.lastOrderYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidLastOrderDate"))%>");     	 
   		return false;
    	}
    }

    if ( !(objEndOfServiceYear == "") || !(objEndOfServiceMonth == "") || !(objEndOfServiceDay == "") ) {
    	if ( !validDate(objEndOfServiceYear,objEndOfServiceMonth,objEndOfServiceDay)  ){
		document.details.endOfServiceYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidEndOfServiceDate"))%>");     	 
   		return false;
    	}
    }

    if ( !(objDiscontinueYear == "") || !(objDiscontinueMonth == "") || !(objDiscontinueDay == "") ) {
    	if ( !validDate(objDiscontinueYear,objDiscontinueMonth,objDiscontinueDay)  ){
		document.details.discontinueYear.select();
		alertDialog("<%=UIUtil.toJavaScript((String)itemResource.get("notValidDiscontinueDate"))%>");     	 
   		return false;
    	}
    }

    return true;
}


function isValidItemName(myString) {
    var invalidChars = ""; // invalid chars
    invalidChars += "\t"; // escape sequences
    
    // if the string is empty it is not a valid name
    if (isEmpty(myString)) return false;
 
    // look for presence of invalid characters.  if one is
    // found return false.  otherwise return true
    for (var i=0; i<myString.length; i++) {
      if (invalidChars.indexOf(myString.substring(i, i+1)) >= 0) {
        return false;
      }
    }    
        
    return true;
}


function setupDate() {
	window.yearField = document.details.startYear;
	window.monthField = document.details.startMonth;
	window.dayField = document.details.startDay;
	
	// If the date has not been entered yet set the Calender to display the current
	// Date, otherwise set Calendar window to the previously entered date.
	if(document.details.startYear.value.length==0) {
		window.yearField.value = getCurrentYear();
	}
	else {
		window.yearField.value = document.details.startYear.value;
	}
	
	if(document.details.startMonth.value.length==0) {
		window.monthField.value = getCurrentMonth();
	}
	else {
		window.monthField.value = document.details.startMonth.value;
	}
	
	if(document.details.startDay.value.length==0) {
		window.dayField.value = getCurrentDay();
	}
	else {
		window.dayField.value = document.details.startDay.value;
	}
}

function setupDate2() {
	window.yearField = document.details.endYear;
	window.monthField = document.details.endMonth;
	window.dayField = document.details.endDay;

	// If the date has not been entered yet set the Calender to display the current
	// Date, otherwise set Calendar window to the previously entered date.
	if(document.details.endYear.value.length==0) {
		window.yearField.value = getCurrentYear();
	}
	else {
		window.yearField.value = document.details.endYear.value;
	}
	
	if(document.details.endMonth.value.length==0) {
		window.monthField.value = getCurrentMonth();
	}
	else {
		window.monthField.value = document.details.endMonth.value;
	}
	
	if(document.details.endDay.value.length==0) {
		window.dayField.value = getCurrentDay();
	}
	else {
		window.dayField.value = document.details.endDay.value;
	}
}

function setupDate3() {
	window.yearField = document.details.availabilityYear;
	window.monthField = document.details.availabilityMonth;
	window.dayField = document.details.availabilityDay;
	
	// If the date has not been entered yet set the Calender to display the current
	// Date, otherwise set Calendar window to the previously entered date.
	if(document.details.availabilityYear.value.length==0) {
		window.yearField.value = getCurrentYear();
	}
	else {
		window.yearField.value = document.details.availabilityYear.value;
	}
	
	if(document.details.availabilityMonth.value.length==0) {
		window.monthField.value = getCurrentMonth();
	}
	else {
		window.monthField.value = document.details.availabilityMonth.value;
	}
	
	if(document.details.availabilityDay.value.length==0) {
		window.dayField.value = getCurrentDay();
	}
	else {
		window.dayField.value = document.details.availabilityDay.value;
	}
}

function setupDate4() {
	window.yearField = document.details.lastOrderYear;
	window.monthField = document.details.lastOrderMonth;
	window.dayField = document.details.lastOrderDay;

	// If the date has not been entered yet set the Calender to display the current
	// Date, otherwise set Calendar window to the previously entered date.
	if(document.details.lastOrderYear.value.length==0) {
		window.yearField.value = getCurrentYear();
	}
	else {
		window.yearField.value = document.details.lastOrderYear.value;
	}
	
	if(document.details.lastOrderMonth.value.length==0) {
		window.monthField.value = getCurrentMonth();
	}
	else {
		window.monthField.value = document.details.lastOrderMonth.value;
	}
	
	if(document.details.lastOrderDay.value.length==0) {
		window.dayField.value = getCurrentDay();
	}
	else {
		window.dayField.value = document.details.lastOrderDay.value;
	}
}

function setupDate5() {
	window.yearField = document.details.endOfServiceYear;
	window.monthField = document.details.endOfServiceMonth;
	window.dayField = document.details.endOfServiceDay;

	// If the date has not been entered yet set the Calender to display the current
	// Date, otherwise set Calendar window to the previously entered date.
	if(document.details.endOfServiceYear.value.length==0) {
		window.yearField.value = getCurrentYear();
	}
	else {
		window.yearField.value = document.details.endOfServiceYear.value;
	}
	
	if(document.details.endOfServiceMonth.value.length==0) {
		window.monthField.value = getCurrentMonth();
	}
	else {
		window.monthField.value = document.details.endOfServiceMonth.value;
	}
	
	if(document.details.endOfServiceDay.value.length==0) {
		window.dayField.value = getCurrentDay();
	}
	else {
		window.dayField.value = document.details.endOfServiceDay.value;
	}
}

function setupDate6() {
	window.yearField = document.details.discontinueYear;
	window.monthField = document.details.discontinueMonth;
	window.dayField = document.details.discontinueDay;
	
	// If the date has not been entered yet set the Calender to display the current
	// Date, otherwise set Calendar window to the previously entered date.
	if(document.details.discontinueYear.value.length==0) {
		window.yearField.value = getCurrentYear();
	}
	else {
		window.yearField.value = document.details.discontinueYear.value;
	}
	
	if(document.details.discontinueMonth.value.length==0) {
		window.monthField.value = getCurrentMonth();
	}
	else {
		window.monthField.value = document.details.discontinueMonth.value;
	}
	
	if(document.details.discontinueDay.value.length==0) {
		window.dayField.value = getCurrentDay();
	}
	else {
		window.dayField.value = document.details.discontinueDay.value;
	}	
}
</SCRIPT>
</HEAD>



    
<BODY onload="initForm()" class="content">
<SCRIPT FOR=document EVENT="onclick()">
	document.all.CalFrame.style.display="none";
</SCRIPT>
<IFRAME STYLE="display:none;position:absolute;width:198;height:230;z-index=100" 
ID="CalFrame" MARGINHEIGHT=0 MARGINWIDTH=0 NORESIZE FRAMEBORDER=0 SCROLLING=NO
SRC="/webapp/wcs/tools/servlet/Calendar"
TITLE="<%= UIUtil.toHTML( (String)calendarResource.get("calendarTitle")) %>" > 
</IFRAME>
<H1><%=UIUtil.toHTML((String)itemResource.get("General"))%></H1> 

<FORM name="details">

<TABLE cols=6>   
    <TH colspan="6"></TH>   
   
    <TR>
           <TD colspan="4">
               <LABEL for="codeID"><%=UIUtil.toHTML((String)itemResource.get("item_sku"))%></LABEL> 
           </TD>
    </TR>
    <TR>
           <TD colspan="4">
           <INPUT id="codeID" size="32" maxlength="64" type="text" name="sku"><BR><BR>
       </TD>
    </TR>

    <TR>
           <TD colspan="4">
               <LABEL for="nameID"><%=UIUtil.toHTML((String)itemResource.get("item_name"))%></LABEL>
           </TD>
    </TR>
    <TR>
           <TD colspan="4">
           <INPUT id="nameID" size="32" maxlength="128" type="text" name="name"><BR><BR>
       </TD>
    </TR>
    <TR>
           <TD colspan="3">
               <%=UIUtil.toHTML((String)itemResource.get("start_date"))%>
           </TD>
           <TD colspan="3">
               <%=UIUtil.toHTML((String)itemResource.get("end_date"))%>
           </TD>
    </TR>
    <TR>
           <TD colspan="3">
               <Table>
               	   <TR>
               	   		<TD><LABEL for="yearID1"><%=UIUtil.toHTML((String)itemResource.get("year"))%></LABEL></TD>
               	   		<TD><LABEL for="monthID1"><%=UIUtil.toHTML((String)itemResource.get("month"))%></LABEL></TD>
               	   		<TD><LABEL for="dayID1"><%=UIUtil.toHTML((String)itemResource.get("day"))%></LABEL></TD>
               	   </TR>
               	   <TR>
               	   		<TD><INPUT type=text  id="yearID1" value=""  name=startYear size="4" MAXLENGTH=4></TD>
               	   		<TD><INPUT type=text  id="monthID1" value=""  name=startMonth size="2" MAXLENGTH=2></TD>
               	   		<TD><INPUT type=text  id="dayID1" value=""  name=startDay size="2" MAXLENGTH=2>
               	            <A HREF="javascript:setupDate();showCalendar(document.details.calImg1)">
                            <IMG SRC="/wcs/images/tools/calendar/calendar.gif" BORDER=0 id=calImg1 alt="<%=UIUtil.toHTML((String)itemResource.get("start_date"))%>"></A>
                        </TD>
               	   </TR>
               </table>
           </TD>
           <TD colspan="3">
               <Table>
               	   <TR>
               	   		<TD><LABEL for="yearID2"><%=UIUtil.toHTML((String)itemResource.get("year"))%></LABEL></TD>
               	   		<TD><LABEL for="monthID2"><%=UIUtil.toHTML((String)itemResource.get("month"))%></LABEL></TD>
               	   		<TD><LABEL for="dayID2"><%=UIUtil.toHTML((String)itemResource.get("day"))%></LABEL></TD>
               	   </TR>
               	   <TR>
               	   		<TD><INPUT type=text  id="yearID2" value=""  name=endYear size="4" MAXLENGTH=4></TD>
               	   		<TD><INPUT type=text  id="monthID2" value=""  name=endMonth size="2" MAXLENGTH=2></TD>
               	   		<TD><INPUT type=text  id="dayID2" value=""  name=endDay size="2" MAXLENGTH=2>
               	            <A HREF="javascript:setupDate2();showCalendar(document.details.calImg2)">
                            <IMG SRC="/wcs/images/tools/calendar/calendar.gif" BORDER=0 id=calImg2 alt="<%=UIUtil.toHTML((String)itemResource.get("end_date"))%>"></A>
                        </TD>
               	   </TR>
               </table>
           </TD>
    </TR>
    <TR>
           <TD colspan="3">
               <%=UIUtil.toHTML((String)itemResource.get("availability_date"))%>
           </TD>
           <TD colspan="3">
               <%=UIUtil.toHTML((String)itemResource.get("lastOrder_date"))%>
           </TD>
    </TR>
    <TR>
           <TD colspan="3">
               <Table>
               	   <TR>
               	   		<TD><LABEL for="yearID3"><%=UIUtil.toHTML((String)itemResource.get("year"))%></LABEL></TD>
               	   		<TD><LABEL for="monthID3"><%=UIUtil.toHTML((String)itemResource.get("month"))%></LABEL></TD>
               	   		<TD><LABEL for="dayID3"><%=UIUtil.toHTML((String)itemResource.get("day"))%></LABEL></TD>
               	   </TR>
               	   <TR>
               	   		<TD><INPUT type=text  id="yearID3" value=""  name=availabilityYear size="4" MAXLENGTH=4></TD>
               	   		<TD><INPUT type=text  id="monthID3" value=""  name=availabilityMonth size="2" MAXLENGTH=2></TD>
               	   		<TD><INPUT type=text  id="dayID3" value=""  name=availabilityDay size="2" MAXLENGTH=2>
               	            <A HREF="javascript:setupDate3();showCalendar(document.details.calImg3)">
                            <IMG SRC="/wcs/images/tools/calendar/calendar.gif" BORDER=0 id=calImg3 alt="<%=UIUtil.toHTML((String)itemResource.get("availability_date"))%>"></A>
                        </TD>
               	   </TR>
               </table>
           </TD>
           <TD colspan="3">
               <Table>
               	   <TR>
               	   		<TD><LABEL for="yearID4"><%=UIUtil.toHTML((String)itemResource.get("year"))%></LABEL></TD>
               	   		<TD><LABEL for="monthID4"><%=UIUtil.toHTML((String)itemResource.get("month"))%></LABEL></TD>
               	   		<TD><LABEL for="dayID4"><%=UIUtil.toHTML((String)itemResource.get("day"))%></LABEL></TD>
               	   </TR>
               	   <TR>
               	   		<TD><INPUT type=text  id="yearID4" value=""  name=lastOrderYear size="4" MAXLENGTH=4></TD>
               	   		<TD><INPUT type=text  id="monthID4" value=""  name=lastOrderMonth size="2" MAXLENGTH=2></TD>
               	   		<TD><INPUT type=text  id="dayID4" value=""  name=lastOrderDay size="2" MAXLENGTH=2>
               	            <A HREF="javascript:setupDate4();showCalendar(document.details.calImg4)">
                            <IMG SRC="/wcs/images/tools/calendar/calendar.gif" BORDER=0 id=calImg4 alt="<%=UIUtil.toHTML((String)itemResource.get("lastOrder_date"))%>"></A>
                        </TD>
               	   </TR>
               </table>
           </TD>
    </TR>
    <TR>
           <TD colspan="3">
               <%=UIUtil.toHTML((String)itemResource.get("endOfService_date"))%>
           </TD>
           <TD colspan="3">
               <%=UIUtil.toHTML((String)itemResource.get("discontinue_date"))%>
           </TD>
    </TR>
    <TR>
           <TD colspan="3">
               <Table>
               	   <TR>
               	   		<TD><LABEL for="yearID5"><%=UIUtil.toHTML((String)itemResource.get("year"))%></LABEL></TD>
               	   		<TD><LABEL for="monthID5"><%=UIUtil.toHTML((String)itemResource.get("month"))%></LABEL></TD>
               	   		<TD><LABEL for="dayID5"><%=UIUtil.toHTML((String)itemResource.get("day"))%></LABEL></TD>
               	   </TR>
               	   <TR>
               	   		<TD><INPUT type=text  id="yearID5" value=""  name=endOfServiceYear size="4" MAXLENGTH=4></TD>
               	   		<TD><INPUT type=text  id="monthID5" value=""  name=endOfServiceMonth size="2" MAXLENGTH=2></TD>
               	   		<TD><INPUT type=text  id="dayID5" value=""  name=endOfServiceDay size="2" MAXLENGTH=2>
               	            <A HREF="javascript:setupDate5();showCalendar(document.details.calImg5)">
                            <IMG SRC="/wcs/images/tools/calendar/calendar.gif" BORDER=0 id=calImg5 alt="<%=UIUtil.toHTML((String)itemResource.get("endOfService_date"))%>"></A>
                        </TD>
               	   </TR>
               </table>
           </TD>
           <TD colspan="3">
               <Table>
               	   <TR>
               	   		<TD><LABEL for="yearID6"><%=UIUtil.toHTML((String)itemResource.get("year"))%></LABEL></TD>
               	   		<TD><LABEL for="monthID6"><%=UIUtil.toHTML((String)itemResource.get("month"))%></LABEL></TD>
               	   		<TD><LABEL for="dayID6"><%=UIUtil.toHTML((String)itemResource.get("day"))%></LABEL></TD>
               	   </TR>
               	   <TR>
               	   		<TD><INPUT type=text  id="yearID6" value=""  name=discontinueYear size="4" MAXLENGTH=4></TD>
               	   		<TD><INPUT type=text  id="monthID6" value=""  name=discontinueMonth size="2" MAXLENGTH=2></TD>
               	   		<TD><INPUT type=text  id="dayID6" value=""  name=discontinueDay size="2" MAXLENGTH=2>
               	            <A HREF="javascript:setupDate6();showCalendar(document.details.calImg6)">
                            <IMG SRC="/wcs/images/tools/calendar/calendar.gif" BORDER=0 id=calImg6 alt="<%=UIUtil.toHTML((String)itemResource.get("discontinue_date"))%>"></A>
                        </TD>
               	   </TR>
               </table>
           </TD>
    </TR>

    <% if(itemRefNum != null){ %>
    <TR>
           <TD colspan="4">
               <BR><%=UIUtil.toHTML((String)itemResource.get("lastUpdated"))%>&nbsp;<I><%=UIUtil.toHTML(lastUpdate)%></I> <BR><BR>
       </TD>
    </TR>
    
    <%}%>
    
    <TR>
           <TD colspan="4">
               <LABEL for="publishedID"><INPUT type="checkbox" id="publishedID" name="published"> &nbsp;<%=UIUtil.toHTML((String)itemResource.get("published"))%></LABEL><BR>
       </TD>
    </TR>
    <TR>
           <TD colspan="4">
               <LABEL for="buyableID"><INPUT type="checkbox" id="buyableID" name="buyable" onclick=checkAuction()> &nbsp;<%=UIUtil.toHTML((String)itemResource.get("buyable"))%></LABEL><BR>
       </TD>
    </TR>
    
    <% if(itemRefNum != null){ %>    
    
    <TR>
           <TD colspan="4"><%=UIUtil.toHTML((String)itemResource.get("auction"))%>&nbsp;<I><%=UIUtil.toHTML(onauction)%></I></TD>
    </TR>
    
    <%}%>
</TABLE>

</FORM>
 
<%
}
catch (Exception e) 
{
       com.ibm.commerce.exception.ExceptionHandler.displayJspException(request, response, e);
}

%>

</BODY>
</HTML>


