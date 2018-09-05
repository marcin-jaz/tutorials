<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//*---------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP code snippet displays the following information:
  *  - the order item list and the available time  
  *  - the list of req ship dates entered
  *  - the list of expedite entered 
  * 
  * This snippet assumes that the advanceOrderForm form is in the shopping cart page.
  * If the form is not the shopping cart page, you need to change the values for parameter 'URL' 
  * More information is provided in the JSP comments below.
  *
  * Prerequisites:
  * 1. Advanced Order model
  * 2. item(s) are in the shopping cart
  * How to use this snippet? 
  * 1. To use this snippet, you can import or cut and paste the code from the snippet to your shopping cart page.
  *    <!-- insert taglib on top -->
  *    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  *
  *    <!-- insert jsp snippet on the buttom -->
  *    <c:import url="Snippets/Order/Cart/AdvancedOrderForm.jsp" >
  *    <c:param name="orderId" value="the order id"/>
  *        <c:param name="showTieCode" value="true or false" />
  *        <c:param name="showItemId" value="true or false"/>
  *        <c:param name="showInstructions" value="true or false"/>
  *        <c:param name="showRequestedShipdate" value="true or false"/>
  *        <c:param name="showExpedite" value="true or false"/>
  *        <c:param name="allowOnlySingleShippingMethod" value="true or false"/>
           <c:param name="errorView" value="view for errors"/>
  *    </c:import>
  *
  * Limitation
  * inline frame <iframe> tag of standard HTML 4.0 is used which may not be supported by all browsers
  * Display of all items for one Order due to the behavior of OrderDataBean
  *****
--%>

<!-- Start - JSP File Name:  AdvancedOrderForm.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../OrderEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%--
  ***
  * Activate the data bean at the beginning of the JSP file.
  * If you create a JSP file based on the following code snippet, copy the data bean
  * activation code to your JSP file and uncomment it.
  ***
--%>


<%--
<iframe style='display:none;position:absolute;width:198;height:230;z-index=10' id='CalFrame' marginheight=0 marginwidth=0 frameborder=0 scrolling=no src='/webapp/wcs/tools/servlet/tools/common/Calendar.jsp' ></iframe>

<div style='visibility:hidden;display:none;position:absolute;width:198;height:230;z-index=10' id='CalFrame'>
Calendar code here
</div>
--%>

<flow:fileRef id="vfileColor" fileId="vfile.color"/>

<fmt:setBundle basename="${snippetJspStoreDir}tooltechtext" var="storeText" />
<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
	<fmt:param value="${beginIndex+1}"/>
	<fmt:param value="${resultCountOnPage}"/>
	<fmt:param value="${OrderBean.totalSize}"/>
</fmt:message>
<c:if test="${resultsText eq '???SEARCH_RESULT_LIST???'}">
	<fmt:setBundle basename="${snippetJspStoreDir}storetext" var="storeText" />
	<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
		<fmt:param value="${beginIndex+1}"/>
		<fmt:param value="${resultCountOnPage}"/>
		<fmt:param value="${OrderBean.totalSize}"/>
	</fmt:message>
</c:if>

<%--
  ***
  * Identify which pieces of function to show or hide.
  ***
--%>
<c:set var="orderId" value="${param.orderId}"/>
<c:if test="${param.showTieCode eq 'true'}" >
	<c:set var="showTieCode" value="true"/>
</c:if>
<c:if test="${param.showItemId eq 'true'}" >
	<c:set var="showItemId" value="true"/>
</c:if>
<c:if test="${param.showInstructions eq 'true'}" >
	<c:set var="showInstructions" value="true"/>
</c:if>
<c:if test="${param.showRequestedShipdate eq 'true'}" >
	<c:set var="showRequestedShipdate" value="true"/>
</c:if>
<c:if test="${param.showExpedite eq 'true'}" >
	<c:set var="showExpedite" value="true"/>
</c:if>
<c:if test="${param.allowOnlySingleShippingMethod eq 'true'}" >
	<c:set var="allowOnlySingleShippingMethod" value="true"/>
</c:if>
<c:if test="${!empty param.errorView}" >
	<c:set var="errorView" value="${param.errorView}"/>
</c:if>



<%-- 
	***
	* Check to see if shopcart is empty.  If empty, display shopcart is empty error message. If order items exist, display shopcart contents.
	***
--%>
<c:set var="bHasShopCart" value="false" />
<c:choose>
	<%-- Check to see if there us an order id, if no, then shopping cart is empty--%>
	<c:when test="${ empty orderId }" >
		<c:set var="bHasShopCart" value="false"/>
	</c:when>
	<c:otherwise>
		
		<c:set var="pageSize" value="${maxOrderItemsPerPage}"/>
		<c:if test="${empty pageSize}">
			<c:set var="pageSize" value="20"/>
		</c:if>
		<c:set var="currentPage" value="${WCParam.currentPage}"/>
		<c:if test="${empty currentPage}">
			<c:set var="currentPage" value="1"/>
		</c:if>
	
		<%-- If there is an order id, then activate the orderbean--%>
		<flow:ifDisabled feature="GiftRegistry">
		<wcbase:useBean id="OrderBean" classname="com.ibm.commerce.order.beans.OrderDataBean" scope="page">
			<c:set value="${orderId}" target="${OrderBean}" property="orderId"/>
			<c:set value="${pageSize}" target="${OrderBean}" property="pageSize"/>
			<c:set value="${currentPage}" target="${OrderBean}" property="currentPage"/>
		</wcbase:useBean>
		
		<%-- get pageSize from OrderDataBean again - if passed in page size is greater than max value, pageSize will set to max value --%>
		<c:set var="pageSize" value="${OrderBean.pageSize}"/>
		
		<c:set var="orderItemDataBeans" value="${OrderBean.orderItemDataBeansInCurrentPage}"/>
		</flow:ifDisabled>
		
		<flow:ifEnabled feature="GiftRegistry">
			<c:remove var="OrderBean"/>
			<%@ include file="AdvancedOrderGRForm.jspf" %>
			<c:set var="orderItemDataBeans" value="${OrderBean.giftRegistryOrderItemDBs}"/>
		</flow:ifEnabled>
		
		<%-- If there is an order id, then check to see if there are items associated with the order id obtained from the command--%>
	    <c:choose>
	    	<%-- if there are items, then there are items in the shopping cart --%>
	   		<c:when test="${ !empty OrderBean.orderItemDataBeans }" >
				<c:set var="bHasShopCart" value="true"/>
	   		</c:when>
			<%--if there are no items,then the shopping cart is empty --%>
			<c:otherwise>
				<c:set var="bHasShopCart" value="false"/>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>
<%-- 
	***
	* End of check to see if shopcart is empty.  
	***
--%>
	
<%-- define variable rows on the page --%>
<flow:ifDisabled feature="GiftRegistry">
<c:set var="totalItemsInCurrentPage" value="0"/>
<c:forEach var="orderItem" items="${OrderBean.orderItemDataBeansInCurrentPage}">
	<c:set var="totalItemsInCurrentPage" value="${totalItemsInCurrentPage + 1}"/>
</c:forEach>
<c:set value="${totalItemsInCurrentPage}" var="rows" scope="page" />
</flow:ifDisabled>
<flow:ifEnabled feature="GiftRegistry">
<c:set value="${OrderBean.numberOfOrderItems}" var="rows" scope="page" />
</flow:ifEnabled>
<script type="text/javascript" language="javascript">
<!--<![CDATA[
function order_SubmitCart(form, url, pageNumber)
{
	if(form.currentPage!= undefined){
		var pageNumber = parseInt(form.currentPage.value);
		if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber > <c:out value="${OrderBean.totalPages}" /> ) 
		{	
			form.currentPage.value=1;
			pageNumber = 1;
		}
	}
	<c:if test="${showInstructions eq true}" >
		if(form.instructions.checked){
	    form.URL.value = 'OrderPrepare?orderItemId*=&quantity*=&requestedShipDate*=&requestedDateYear*=&requestedDateMonth*=&requestedDateDay*=&isShipdateRequested*=&isExpeditedCB*=&isExpedited*=&tieShipCode*=&shipModeId*=&merge=*n&remerge=*&check=*n&allocate=*&backorder=*&reverse=*n&URL=<c:out value="${param.shippingInstructionsView}"/>';
	  } else {
	    form.URL.value = 'OrderDisplay?orderItemId*=&quantity*=&requestedShipDate*=&requestedDateYear*=&requestedDateMonth*=&requestedDateDay*=&isShipdateRequested*=&isExpeditedCB*=&isExpedited*=&tieShipCode*=&shipModeId*=&merge=*n&remerge=*&check=*n&allocate=*&backorder=*&reverse=*n';
	  }
	</c:if>
    
    if (url != undefined) {
			if (pageNumber == undefined) {
				form.URL.value = url + '&orderItemId*=&quantity*=&requestedShipDate*=&requestedDateYear*=&requestedDateMonth*=&requestedDateDay*=&isShipdateRequested*=&isExpeditedCB*=&isExpedited*=&tieShipCode*=&shipModeId*=';
			} else {
				form.URL.value = url + '&currentPage=' + pageNumber + '&orderItemId*=&quantity*=&requestedShipDate*=&requestedDateYear*=&requestedDateMonth*=&requestedDateDay*=&isShipdateRequested*=&isExpeditedCB*=&isExpedited*=&tieShipCode*=&shipModeId*=';
			}
		}
		
    <c:if test="${showTieCode eq true}" >
		if (order_BadTieCodeFormat(form) ) {
		  alert("<fmt:message key="ShippingMethod_BadTieCodeError" bundle="${orderText}" />");
		  return;
		}
	</c:if>
	
	<c:if test="${showRequestedShipdate eq true}" >
		if (order_SetAllShipDates(form) == false) {
			return;
		}
	</c:if>
	
	<c:if test="${showExpedite eq true}" >
		order_SetIsExpedited(form);
	</c:if>

	form.submit();
}

<c:if test="${showRequestedShipdate eq true}" >
	function order_SetupShipDate(count)
	{
		window.yearField = document.all["requestedDateYear_"+count];
		window.monthField = document.all["requestedDateMonth_"+count];
		window.dayField = document.all["requestedDateDay_"+count];
	
	}
	function order_SetAllShipDates(form)
	{
		var rowCount = '<c:out value="${rows}"/>';
		//alert("rowCount=" + rowCount);
		
		for(i=1; i <= rowCount; i++){
			if(form["isShipdateRequested_"+i].checked){
			    // check the date to see that it matches the form of a date
			    var strdate = form["requestedDateMonth_"+i].value + "/" + form["requestedDateDay_"+i].value + "/" + form["requestedDateYear_"+i].value;
			    if (isNaN(Date.parse(strdate))) {
			    	alert(strdate + "<fmt:message key="ShippingMethod_Invalid_Requested_Shipdate" bundle="${orderText}" />");
			    	return false;
			    } else {
					form["requestedShipDate_"+i].value = 
						order_ToJDBCTimestampString(form["requestedDateYear_"+i].value, 
										  form["requestedDateMonth_"+i].value, 
										  form["requestedDateDay_"+i].value);
				}
			} else {
			    // this results in " 00:00:00.000000000"
			    // the server will interpret this as no date  and reset the requested ship date
				form["requestedDateYear_"+i].value = '';
				form["requestedDateMonth_"+i].value= '';
				form["requestedDateDay_"+i].value  = '';
				form["requestedShipDate_"+i].value = 
					order_ToJDBCTimestampString('', '', '');
			}					
		}
		return true;
	}
</c:if>

<c:if test="${showExpedite eq true}" >
	// isExpedited should be sent regardless as part of the form regardless of whether is checked
	// or not. A checkbox is only sent when it is checked. This function circumvents that 
	// restriction. An alternative is to set the checked attribute, but that has the side
	// affect of showing up on the screen as checked after pushing the submit button.
	// So, a hidden field is used, which ends up posting 2 variables, the check box and the 
	// the hidden field.
	function order_SetIsExpedited(form)
	{
		var rowCount = '<c:out value="${rows}"/>';
			
		for (i=1; i <= rowCount; i++) {
		        
		        if (form["isExpeditedCB_"+i].checked) {
				   	form["isExpedited_"+i].value = "Y";
				} else {
					form["isExpedited_"+i].value = "N";
				}	
						
		}
	}
</c:if>

<c:if test="${showTieCode eq true}" >
function order_BadTieCodeFormat(form)
{
	var rowCount = '<c:out value="${rows}"/>';

	for(i=1; i <= rowCount; i++){
			  var theCode = form["tieShipCode_"+i].value;
			  //if ( new String(theCode) == "NaN"  )
			  if(!isValidNZPosInt(theCode)){
  				
      			return true;
  			  }
								
	}

	return false;
}

function isValidNZPosInt(myString) {
    var validChars = "0123456789";

    // if the string is empty it is a valid integer
    if (isEmpty(myString)) return true;

    // look for non numeric characters in the input string
    for (var i=0; i<myString.length; i++) {
      if (validChars.indexOf(myString.substring(i, i+1)) == "-1") {
        return false;
      }
    }
    return true;
}
function isEmpty(id) {
	if (typeof(id) == "string") {
		return !id.match(/[^\s]/);
	}
	else {
		return (id)?(false):(true);
	}
}
</c:if>

// timestamp in JDBC format yyyy-mm-dd hh:mm:ss.fffffffff
// The use of JDBC format has no tie to the JDBC impl
// instead being a globalized timestamp from java.sql.Timestamp which is supported by WC
function order_ToJDBCTimestampString(year, month, day)
{
	var returnString = year  + "-" +
			   month + "-" +
			   day   + " 00:00:00.000000000";
	return returnString;
}

<c:if test="${showRequestedShipdate eq true}" >
	// copied from DateUtil.js
	function order_ShowCalendar(calImg) {
	   var calFrame = document.getElementById("CalFrame");
	   var left=0;
	   var top=0;
	
	   for(var p=calImg;(p) && (p.tagName!='BODY'); p=p.offsetParent){
		      left+=p.offsetLeft;
		      top+=p.offsetTop;
	   }
	
	   var height=calImg.offsetHeight;
	   var pHeight=calFrame.style.pixelHeight;
	   var sTop=document.body.scrollTop;
	   calFrame.style.left=left;
	
	   if(top-pHeight >= sTop && top+height+pHeight > document.body.clientHeight+sTop)
	     calFrame.style.top=top-pHeight;
	   else
	     calFrame.style.top=top+height;
	
	   CalFrame.setDate(); // it's CalFrame not calFrame! using ID here
	   calFrame.style.display="block";
	   CalFrame.adjustFrameSize();
	}
</c:if>

function MM_findObj(n, d) { //v4.01
	var p,i,x;  
	if(!d) d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length) {
	   d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
	}
	if(!(x=d[n])&&d.all) x=d.all[n]; 
	for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n);
	return x;
}

function MM_showHideLayer() { //v6.0
	var i,p,v,obj,args=MM_showHideLayer.arguments;
	i=0;
	if ((obj=MM_findObj(args[i]))!=null) {
		if ((v=MM_findObj(args[i+2]))!=null) {
			if (obj.style) { 
				obj=obj.style;
				if(v.checked){
					obj.visibility='visible';
					obj.display='block';
				}
				else{
					obj.visibility='hidden';
					obj.display='none';
				} 
			}
		}
	}
}

function jumpToPage(form, url)
{
		var pageNumber = parseInt(form.currentPage.value);
    if ( pageNumber !="NaN" && pageNumber >=1 && pageNumber <= <c:out value="${OrderBean.totalPages}" /> ) {
    	 order_SubmitCart(form, url, pageNumber);
    } else {
    	alert("<fmt:message key="SEARCH_INVALID_PAGE_NUM" bundle="${storeText}"/>");
    }
}
//[[>-->  
</script>

<%-- 
	***
	* Start: Shop cart Form
	***
--%>


<c:set var="pageErrorMessage" value="${errorMessage}"/>
<c:if test="${!empty pageErrorMessage}">
     <p><span class="error"><c:out value="${pageErrorMessage}"/></span><br />
        <br />
     </p>
</c:if>

<form name="AdvancedCartForm" method="post" action="OrderItemUpdate" id="AdvancedCartForm">
	<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="Advanced_OrderForm_FormInput_storeId_In_AdvancedCartForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${CommandContext.languageId}" />" id="Advanced_OrderForm_FormInput_langId_In_AdvancedCartForm_1"/>
	<input type="hidden" name="orderId" value="<c:out value="${orderId}" />" id="Advanced_OrderForm_FormInput_orderId_In_AdvancedCartForm_1"/>
	<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />"  id="Advanced_OrderForm_FormInput_catalogId_In_AdvancedCartForm_1"/>
	<input type="hidden" name="URL" value="OrderDisplay?orderItemId*=&quantity*=&requestedShipDate*=&requestedDateYear*=&requestedDateMonth*=&requestedDateDay*=&isShipdateRequested*=&isExpeditedCB*=&tieShipCode*=&shipModeId*=&reverse=*n" id="Advanced_OrderForm_FormInput_URL_In_AdvancedCartForm_1"/>
	<input type="hidden" name="ShippingURL" value="<c:out value="${param.shippingURL}"/>" id="Advanced_OrderForm_FormInput_ShippingURL_In_AdvancedCartForm_1"/>
	<%-- --%>
	<c:if test="${!empty errorView}">
		<input type="hidden" name="errorViewName" value="<c:out value="${errorView}"/>" id="Advanced_OrderForm_FormInput_errorViewName_In_AdvancedCartForm_1"/>
	</c:if>
	<%-- --%>
<c:choose> 
	<c:when test="${ !bHasShopCart }">
		<%-- If the shopcart is empty, display nothing --%>
		&nbsp;
	</c:when>
	<c:otherwise>
		<%-- Shopcart is not empty.  Display shopcart contents. --%>

<c:if test="${OrderBean.totalSize > pageSize}" >
				<c:choose>
					<c:when test="${currentPage == 1}">
						<c:set var="prevPageIndex" value="1"/>
					</c:when>
					<c:otherwise>
						<c:set var="prevPageIndex" value="${currentPage - 1}"/>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageSize*currentPage <= OrderBean.totalSize}">
						<c:set var="nextPageIndex" value="${currentPage + 1}"/>
					</c:when>
					<c:otherwise>
						<c:set var="nextPageIndex" value="${currentPage}"/>
					</c:otherwise>
				</c:choose>
				
				<c:url value="MultipleShippingMethodView" var="MultipleShippingMethodViewFirstURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${CommandContext.languageId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${OrderBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="1"/>
				</c:url>
				<c:url value="MultipleShippingMethodView" var="MultipleShippingMethodViewPrevURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${CommandContext.languageId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${OrderBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="${prevPageIndex}"/>
				</c:url>
				<c:url value="MultipleShippingMethodView" var="MultipleShippingMethodViewNextURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${CommandContext.languageId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${OrderBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="${nextPageIndex}"/>
				</c:url>
				<c:url value="MultipleShippingMethodView" var="MultipleShippingMethodViewLastURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${CommandContext.languageId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${OrderBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
					<c:param name="currentPage" value="${OrderBean.totalPages}"/>
				</c:url>
				<c:url value="MultipleShippingMethodView" var="MultipleShippingMethodViewJumpURL">
					<c:param name="storeId" value="${WCParam.storeId}"/>
					<c:param name="langId" value="${CommandContext.languageId}"/>
					<c:param name="catalogId" value="${WCParam.catalogId}"/>
					<c:param name="orderId" value="${OrderBean.orderId}"/>
					<c:param name="pageSize" value="${pageSize}"/>
				</c:url>
				
		<table cellpadding="0" cellspacing="0" border="0" class="t_table" id="WC_Advanced_OrderForm_Table_2">
			<tr>
				<td id="WC_Advanced_OrderForm_TableCell_2">	
					<table cellpadding="0" cellspacing="0" border="0" id="WC_Advanced_OrderForm_Table_3">
						<tr>
							<td id="WC_Advanced_OrderForm_TableCell_5"><a href="javascript:order_SubmitCart(document.AdvancedCartForm, '<c:out value="${MultipleShippingMethodViewFirstURL}" />');" id="WC_Advanced_OrderForm_Link_1"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_first.gif" alt="<fmt:message key="SEARCH_FIRST" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>																					
							<td class="ps_pad" id="WC_Advanced_OrderForm_TableCell_6"><a href="javascript:order_SubmitCart(document.AdvancedCartForm, '<c:out value="${MultipleShippingMethodViewPrevURL}" />');" id="WC_Advanced_OrderForm_Link_2"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_previous.gif" alt="<fmt:message key="SEARCH_PREV" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>
							<fmt:message var="pageNumberText" key="PAGE_NUMBER" bundle="${storeText}">
								<fmt:param><c:out value="${OrderBean.currentPage}" /></fmt:param>
								<fmt:param><c:out value="${OrderBean.totalPages}" /></fmt:param>
							</fmt:message>
							<td class="ps_text" id="WC_Advanced_OrderForm_TableCell_7"><c:out value="${pageNumberText}" /></td>																		
							<td class="ps_pad" id="WC_Advanced_OrderForm_TableCell_8"><a href="javascript:order_SubmitCart(document.AdvancedCartForm, '<c:out value="${MultipleShippingMethodViewNextURL}" />');" id="WC_Advanced_OrderForm_Link_3"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_next.gif" alt="<fmt:message key="SEARCH_NEXT" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>									
							<td class="ps_pad" id="WC_Advanced_OrderForm_TableCell_9"><a href="javascript:order_SubmitCart(document.AdvancedCartForm, '<c:out value="${MultipleShippingMethodViewLastURL}" />');" id="WC_Advanced_OrderForm_Link_4"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_last.gif" alt="<fmt:message key="SEARCH_LAST" bundle="${storeText}" />" width="14" height="14" border="0"></a></td>
							<td class="ps_text" id="WC_Advanced_OrderForm_TableCell_10"><label for="WC_Advanced_OrderForm_JumpToPage"><fmt:message key="JUMP_TO_PAGE" bundle="${storeText}"/></label></td>
							<td class="ps_pad" id="WC_Advanced_OrderForm_TableCell_11"><input type="text" maxlength="4" size="3" class="ps_input" name="currentPage" id="WC_Advanced_OrderForm_JumpToPage"><input type="hidden" name="pageSize" value="<c:out value="${pageSize}"/>" id="WC_Advanced_OrderForm_FormInput_pageSize_In_JumpToPageForm_1"/></td>
							<td class="ps_pad" id="WC_Advanced_OrderForm_TableCell_12"><a href="javascript:jumpToPage(document.AdvancedCartForm, '<c:out value="${MultipleShippingMethodViewJumpURL}" />');" id="WC_Advanced_OrderForm_Link_5"><img src="<c:out value="${snippetJspStoreImgDir}${vfileColor}"/>ps_page_jump.gif" alt="<fmt:message key="SEARCH_JUMP" bundle="${storeText}" />" width="16" height="16" border="0"></a></td>
						</tr>
					</table>
				</td>
				<td align="right" id="WC_Advanced_OrderForm_TableCell_12a">
					<table cellpadding="0" cellspacing="0" border="0" id="WC_Advanced_OrderForm_Table_3a">
						<tr>
							<c:set var="beginIndex" value="${currentPage*pageSize - pageSize}"/>
						  <c:set var="resultCountOnPage" value="${pageSize + beginIndex}"/>
							<c:choose>
								<c:when test="${resultCountOnPage > OrderBean.totalSize}">
									<c:set var="resultCountOnPage" value="${OrderBean.totalSize}"/>
								</c:when>
							</c:choose>
							<fmt:message var="resultsText" key="SEARCH_RESULT_LIST" bundle="${storeText}">
								<fmt:param value="${beginIndex+1}"/>
								<fmt:param value="${resultCountOnPage}"/>
								<fmt:param value="${OrderBean.totalSize}"/>
							</fmt:message>
							<td class="ps_text" id="WC_Advanced_OrderForm_TableCell_301"><c:out value="${resultsText}" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</c:if>

		<table cellpadding="2" cellspacing="1" border="0" width="100%" class="bgColor" id="Advanced_OrderForm_Table_1">
		    
		    <%-- 
		    <c:forEach var="aParam" items="${paramValues}" varStatus="paramStatus">
	    	    <tr>
	    	        <c:out value="key = ${aParam.key}"/>
					<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
						<c:out value="value = ${aValue}"/>
					</c:forEach>
				</tr>
			</c:forEach>
		
			<hr />
		    
		    <c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
	    	    <tr>
	    	        <c:out value="key = ${aParam.key}"/>
					<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
						<c:out value="value = ${aValue}"/>
					</c:forEach>
				</tr>
		    </c:forEach>
		    
		    <hr />
		    --%>
		    
		    
			<%--
				***
				* Start: Display the main heading
				***
			--%>
			<tr class="bgColor">
			    	<c:if test="${showItemId eq true}">
					<th valign="top" class="colHeader" id="Advanced_OrderForm_TableCell_6" >
						<fmt:message key="ShippingMethod_ITEM_ID" bundle="${orderText}" />
					</th>
				</c:if>
				<th valign="top" class="colHeader" id="Advanced_OrderForm_TableCell_7">
					<fmt:message key="ShippingMethod_DESC" bundle="${orderText}" />
				</th>
				<th valign="top" class="colHeader" id="Advanced_OrderForm_TableCell_8" >
					<span class="t_hd_cntr">
					<fmt:message key="ShippingMethod_QTY" bundle="${orderText}" />
					</span>
				</th>
				<th valign="top" class="colHeader" id="Advanced_OrderForm_TableCell_9">
					<fmt:message key="ShippingMethod_ADDRESS" bundle="${orderText}" />
				</th>
				<th valign="top" class="colHeader" id="Advanced_OrderForm_TableCell_10">
					<fmt:message key="ShippingMethod_AVAILABLE_DATE" bundle="${orderText}" />
				</th>
				<th valign="top" class="colHeader_last" id="Advanced_OrderForm_TableCell_11">
					<fmt:message key="ShippingMethod_SHIPPING_METHOD" bundle="${orderText}" />
				</th>
				<c:if test="${showTieCode eq true}">
					<th valign="top" class="colHeader" id="Advanced_OrderForm_TableCell_12">
						<fmt:message key="ShippingMethod_TIESHIPCODE" bundle="${orderText}" />
					</th>
				</c:if>
			</tr>
			<%--
				***
				* End: Display the main heading
				***
			--%>


			<%--
				***
				* Start: Display advanced order item information
				* For each order item, it displays the following information:
				*  - orderitem_id
				*  - quantity
				*  - item short description
				*  - available ship time
				*  - req ship date
				*  - isExpedited
				***
			--%>
			<c:forEach var="orderItem" items="${orderItemDataBeans}" varStatus="counter">
			<c:choose>
				<c:when test="${orderItem.catalogEntryDataBean.package}">
					<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.packageDataBean}"/>
					<c:set var="catalogEntryId" value="${catalogEntry.packageID}"/>
				</c:when>
				
				<c:when test="${orderItem.catalogEntryDataBean.item}">
					<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.itemDataBean.parentProductDataBean}"/>
					<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
				</c:when>
				
				<c:otherwise>
					<c:set var="catalogEntry" value="${orderItem.catalogEntryDataBean.productDataBean}" />
					<c:set var="catalogEntryId" value="${catalogEntry.productID}"/>
				</c:otherwise>
			</c:choose>
			<c:choose>
	            <c:when test="${sRowColor eq 'cellBG_1'}">
	               <c:set var="sRowColor" value="cellBG_2"/>
	        	</c:when>
	            <c:otherwise>
	               <c:set var="sRowColor" value="cellBG_1"/>
	            </c:otherwise>
			</c:choose>
			<tr valign="top">
			    	<c:if test="${showItemId eq true}">
					<td class="<c:out value="${sRowColor}"/> t_td" align="left" valign="top" headers="Advanced_OrderForm_TableCell_6" id="Advanced_OrderForm_TableCell_ItemID_<c:out value='${counter.count}' />">
						<c:out value="${orderItem.orderItemId}"/>
					</td>
				</c:if>
				<td class="<c:out value="${sRowColor}"/> t_td" width="30%" headers="Advanced_OrderForm_TableCell_7" id="Advanced_OrderForm_TableCell_ItemDesc_<c:out value="${counter.count}"/>" >
					 <%-- 
						 ***
						 * Display the item name as a link to the product display page 
						 ***
					 --%>
					 <c:url var="ProductDisplayURL" value="ProductDisplay">
							<c:param name="langId" value="${CommandContext.languageId}" />
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${WCParam.catalogId}" />
							<c:param name="productId" value="${catalogEntryId}" />
					</c:url>
					<a href="<c:out value="${ProductDisplayURL}"/>" id="Advanced_OrderForm_Link_1_<c:out value="${counter.count}"/>">
						<c:out value="${catalogEntry.description.name}" escapeXml="false"  /><br/>
					</a>
					<%-- Display the order item SKU number --%>
					<fmt:message key="ShippingMethod_SKU" bundle="${orderText}"/> <c:out value="${orderItem.catalogEntryDataBean.partNumber}" escapeXml="false"/>
				</td>
				<td class="<c:out value="${sRowColor}"/> t_td" align="center" headers="Advanced_OrderForm_TableCell_8" id="Advanced_OrderForm_TableCell_Quantity_<c:out value="${counter.count}"/>">
				    	<input type="hidden" name="orderItemId_<c:out value="${counter.count}"/>" value="<c:out value="${orderItem.orderItemId}"/>" />  
				    	<c:if test="${showRequestedShipdate eq true}" >
						<input type="hidden" name="requestedShipDate_<c:out value="${counter.count}"/>" value="" />
					</c:if>
					<c:set value="${counter.count}" var="rows2" scope="application" />
					<%-- Display the quantity  --%>
					<c:out value="${orderItem.formattedQuantity}"/>
				</td>
				<td class="<c:out value="${sRowColor}"/> t_td" headers="Advanced_OrderForm_TableCell_9" id="Advanced_OrderForm_TableCell_ShipAddress_<c:out value="${counter.count}"/>">
				<flow:ifDisabled feature="GiftRegistry">
					<c:set var="address" value="${orderItem.addressDataBean}"/>
					<%-- Print the appropriate address information out depending on locale --%>				
					<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
				</flow:ifDisabled>
					<%--
					  ***
					  * Start: Gift Registry Order integration
					  ***
					--%>   
					<flow:ifEnabled feature="GiftRegistry">                              
					<c:choose>
						<c:when test='${orderItem.shipToRegistrant == 1}'>
							<fmt:setBundle basename="${snippetJspStoreDir}storetext" var="storeText" />
							<fmt:message key="GR_SHIPTO_REGISTRY" bundle="${storeText}"/>
							<c:out value=": ${orderItem.externalGiftRegistryId}"/>
							<br/>
						</c:when>
						<c:otherwise>
							<c:set var="address" value="${orderItem.addressDataBean}"/>
							<%-- Print the appropriate address information out depending on locale --%>				
							<%@ include file="../../../Snippets/ReusableObjects/AddressDisplay.jspf"%>
						</c:otherwise>
					</c:choose>
					</flow:ifEnabled>
					<%--
					  ***
					  * End: Gift Registry Order integration
					  ***
					--%>                       				
				</td>
				<td class="<c:out value="${sRowColor}"/> t_td" headers="Advanced_OrderForm_TableCell_10" id="Advanced_OrderForm_TableCell_EstAvailTime_<c:out value="${counter.count}"/>">
					<%-- Display item estimatedShippingTime --%>
					<c:out value="${orderItem.formattedEstimatedShippingTime}" escapeXml="false" >
						<fmt:message key="ShippingMethod_NO_TIME_AVAILABLE" bundle="${orderText}" /> 
					</c:out>
				</td>
				<td class="<c:out value="${sRowColor}"/> t_td" headers="Advanced_OrderForm_TableCell_11" id="Advanced_OrderForm_TableCell_RSDs_<c:out value='${counter.count}' />" >

                    <c:choose>
                    	<c:when test="${allowOnlySingleShippingMethod}">
                    		<c:if test="${counter.count == 1}">
					<c:set value="${orderItem.allowableShippingModeDataBeans}" var="listOfShipModeId"/>
					<c:set value="${orderItem.shippingModeDataBean.shippingModeId}" var="selectedShipModeId"/>
					<label for="WC_BillingShippingDisplay_FormInput_shipModeId_In_ShipMethodPage_1_1"></label>
						<select id="WC_BillingShippingDisplay_FormInput_shipModeId_In_ShipMethodPage_1_1" class="select" name="shipModeId" size="1">
			                    	<c:forEach items="${listOfShipModeId}" var="shipModeId">
				                        <c:set var="aShipModeId" value="${shipModeId.shippingModeId}"/>
				                        <c:set var="shipModeDesc" value="${shipModeId.description}"/>
				                        <c:set var="aShipModeDesc" value="${shipModeDesc.description}"/>
			                        	<c:choose>
			                            		<c:when test="${!empty selectedShipModeId && selectedShipModeId==aShipModeId}">
			                                		<c:set var="sel" value="selected"/>
			                                	</c:when>
			                                	<c:otherwise>
			                                		<c:set var="sel" value=""/>
			                                	</c:otherwise>
			                            	</c:choose>
			                        	<option value="<c:out value="${aShipModeId}"/>" <c:if test="${!empty sel}" >selected="selected" </c:if>><c:out value="${aShipModeDesc}"/></option>                     
			                      	</c:forEach>
						</select>
					
				</c:if>
                        </c:when>
                        <c:otherwise>
				<c:set value="${orderItem.allowableShippingModeDataBeans}" var="listOfShipModeId"/>
				<label for="WC_BillingShippingDisplay_FormInput_shipModeId_In_ShipMethodPage_1_<c:out value='${counter.count}' />"></label>
					<select id="WC_BillingShippingDisplay_FormInput_shipModeId_In_ShipMethodPage_1_<c:out value='${counter.count}' />" class="select" name="shipModeId_<c:out value="${counter.count}"/>" size="1">
		                    	<c:forEach items="${listOfShipModeId}" var="shipModeId">
		                    		<c:set var="key" value="shipModeId_${counter.count}"/>		                    		
			                        <c:set var="aShipModeId" value="${shipModeId.shippingModeId}"/>
			                        <c:set var="shipModeDesc" value="${shipModeId.description}"/>
			                        <c:set var="aShipModeDesc" value="${shipModeDesc.description}"/>
		                        	<c:choose>
		                            		<c:when test="${!empty WCParam[key] && WCParam[key]==aShipModeId}">
		                                		<c:set var="sel" value="selected"/>
											</c:when>
		                                	<c:otherwise>
		                                		<c:set var="sel" value=""/>
		                                	</c:otherwise>
		                        	</c:choose>
		                        	<option value="<c:out value="${aShipModeId}"/>" <c:if test="${!empty sel}" >selected="selected" </c:if>><c:out value="${aShipModeDesc}"/></option>                     
		                      	</c:forEach>
					</select>
				
                        </c:otherwise>
		</c:choose>



					<br/>
					<c:if test="${showRequestedShipdate eq true}" >
						<input class="checkbox" type="checkbox" onclick="MM_showHideLayer('ShipdateRequestedLayer_<c:out value="${counter.count}"/>','','isShipdateRequested_<c:out value="${counter.count}"/>');" name="isShipdateRequested_<c:out value="${counter.count}"/>" id="isShipdateRequested_<c:out value="${counter.count}"/>" <c:if test="${!empty orderItem.requestedShipDateYear}" > checked="checked" </c:if> />
						<label for="isShipdateRequested_<c:out value="${counter.count}"/>"><fmt:message key="ShippingMethod_REQUESTED_SHIP_DATE" bundle="${orderText}" /></label>
						<br/>
						<div id="ShipdateRequestedLayer_<c:out value="${counter.count}"/>" 
							<c:choose>
								<c:when test="${empty orderItem.requestedShipDateYear}">
									style="visibility: hidden; display: none;"
								</c:when>
								<c:otherwise>
									style="visibility: visible; display: block;"
								</c:otherwise>
							</c:choose> 
						>
		                	<table cellpadding='0' cellspacing='0' id="Advanced_OrderForm_Table_2_<c:out value='${counter.count}' />">
		                    	<tr>
		                        	<td id="Advanced_OrderForm_TableCell_RSD_Year_Hdg_<c:out value='${counter.count}' />">
							<label for="requestedDateYear_<c:out value="${counter.count}"/>"><fmt:message key="ShippingMethod_YEAR" bundle="${orderText}" /></label>
						</td>
		                        	<td id="Advanced_OrderForm_TableCell_RSD_Month_Hdg_<c:out value='${counter.count}' />">
							<label for="requestedDateMonth_<c:out value="${counter.count}"/>"><fmt:message key="ShippingMethod_MONTH" bundle="${orderText}" /></label>
						</td>
		                        	<td id="Advanced_OrderForm_TableCell_RSD_Day_Hdg_<c:out value='${counter.count}' />">
							<label for="requestedDateDay_<c:out value="${counter.count}"/>"><fmt:message key="ShippingMethod_DAY" bundle="${orderText}" /></label>
						</td>
		                            <%--<td></td>--%>
		                        </tr>
		                        <tr>
		                           <td id="Advanced_OrderForm_TableCell_RSD_Year_<c:out value='${counter.count}' />">
		                           		<input class="input" type='text' name='requestedDateYear_<c:out value="${counter.count}"/>' id="requestedDateYear_<c:out value="${counter.count}"/>" value='<c:out value="${orderItem.requestedShipDateYear}"/>'  size='4' maxlength='4' />&nbsp;
		                           </td>
		                           <td id="Advanced_OrderForm_TableCell_RSD_Month_<c:out value='${counter.count}' />">
		                           		<input class="input" type='text' name='requestedDateMonth_<c:out value="${counter.count}"/>' id="requestedDateMonth_<c:out value="${counter.count}"/>" value='<c:out value="${orderItem.requestedShipDateMonth}"/>'  size='4' maxlength='2' />&nbsp;
		                           </td>
		                           <td id="Advanced_OrderForm_TableCell_RSD_Day_<c:out value='${counter.count}' />">
		                           		<input class="input" type='text' name='requestedDateDay_<c:out value="${counter.count}"/>' id="requestedDateDay_<c:out value="${counter.count}"/>"  value='<c:out value="${orderItem.requestedShipDateDay}"/>'  size= '4' maxlength='2' />
		                           </td>
		                           <%--
		                           <td valign=bottom id="Advanced_OrderForm_TableCell_RSD_Calendar_<c:out value='${counter.count}' />">
		                              <a href='javascript:setupShipDate(<c:out value="${counter.count}"/>);order_ShowCalendar(document.all.requestedDateImg_<c:out value="${counter.count}"/>)' >
		                                  <img src='/wcs/images/tools/calendar/calendar.gif' border='0'  
										  id='requestedDateImg_<c:out value="${counter.count}"/>' 
										  alt='<fmt:message key="ShippingMethod_REQUESTED_SHIP_DATE" bundle="${orderText}" />'/>
		                              </a>
		                           </td> 
		                           --%>
		                        </tr>
		                    </table>
					<div id="Advanced_OrderForm_TableCell_RSD_Calendar_Shipping_Date_Example">
						<label for="Advanced_OrderForm_TableCell_RSD_Calendar_Shipping_Date_Example">
							<fmt:message key="ShippingMethod_REQUESTED_SHIP_DATE_EXAMPLE" bundle="${orderText}"/>
						</label>
					</div>
	                    </div>
	                </c:if>
	                <c:if test="${showExpedite eq true}" >
						<input class="checkbox" type="checkbox" name="isExpeditedCB_<c:out value="${counter.count}"/>" id="isExpeditedCB_<c:out value="${counter.count}"/>" <c:if test="${orderItem.expedited}" > checked="checked" </c:if> />
						<label for="isExpeditedCB_<c:out value="${counter.count}"/>"><fmt:message key="ShippingMethod_EXPEDITE" bundle="${orderText}" /></label>
						<input type="hidden" name="isExpedited_<c:out value="${counter.count}"/>" value="N" />
                	</c:if>
                </td>
				<c:if test="${showTieCode eq true}">
					<td headers="Advanced_OrderForm_TableCell_12" align="left" valign="top" id="Advanced_OrderForm_TableCell_TieShipCode_<c:out value='${counter.count}' />"><font class="text">
						<label for="tieShipCode_<c:out value="${counter.count}"/>"></label><input class="input" type="input" size="3" name="tieShipCode_<c:out value="${counter.count}"/>" id="tieShipCode_<c:out value="${counter.count}"/>" value='<c:out value="${orderItem.tieCode}"/>' /></font>
					</td>
				</c:if>

			</tr>
		
			</c:forEach>

			<%--
				***
				* End: Display advanced order item information
				***
			--%>			
			</table>
			<c:if test="${showInstructions eq true}" >
				<input class="checkbox" type="checkbox" id="Advanced_OrderForm_Checkbox_instructions" name="instructions" value="instructions"  
					<c:if test="${!empty OrderBean.shipInstructsListDataBean}">
						checked="checked"
					</c:if>
				/> 
				<label for="Advanced_OrderForm_Checkbox_instructions"><fmt:message key="ShippingMethod_ShippingInstructionsRequired" bundle="${orderText}" /></label>
			</c:if>
			
	</c:otherwise>
</c:choose>
<%-- 
***
* End: Shop cart Form
***
--%>
		
</form>

<!-- End - JSP File Name:  AdvancedOrderForm.jsp -->
