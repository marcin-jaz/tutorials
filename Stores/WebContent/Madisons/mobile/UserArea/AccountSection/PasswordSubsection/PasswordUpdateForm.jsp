<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP will display the PasswordUpdate form for the mobile store with the following fields:
  *  - Current password
  *  - New password
  *  - New Verify password
  * If the user password has expired, this page will be displayed after the user logs on to the mobile store.
  *****
--%>

<%-- Start - JSP File Name:  PasswordUpdateForm.jsp --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>

<%@ include file="../../../../include/parameters.jspf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>


<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>
			<fmt:message key="MCHANGE_PASSWORD_TITLE" bundle="${storeText}">
				<fmt:param value="${storeName}" />
			</fmt:message>
		</title>
		
		<meta http-equiv="content-type" content="application/xhtml+xml" />
		<meta http-equiv="cache-control" content="max-age=300" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
	
		<link rel="stylesheet" href="${cssPath}" type="text/css" />
	</head>

	<body>
		<div id="wrapper">

			<%@ include file="../../../include/HeaderDisplay.jspf" %>				
			
			<div id="password_update" class="content_box">
				<div class="heading_container_with_underline">
					<h2><fmt:message key="MCHANGE_PASSWORD_TITLE" bundle="${storeText}" /></h2>
					<div class="clear_float"></div>
				</div>
				
				<c:if test="${!empty errorMessage}">
					<span class="error"><br/><c:out value="${errorMessage}"/><br/><br/></span>
				</c:if>				
				
				<p class="paragraph_blurb"><fmt:message key="MEXP_PASSWORD_TEXT" bundle="${storeText}" /></p>			
									
				<form id="password_update_form" method="post" action="PersonChangeServicePasswordReset">
					<input type="hidden" name="storeId" value='<c:out value="${WCParam.storeId}" />' id="WC_MPasswordUpdateForm_FormInput_storeId"/>
					<input type="hidden" name="catalogId" value='<c:out value="${WCParam.catalogId}" />' id="WC_MPasswordUpdateForm_FormInput_catalogId"/>
					<input type="hidden" name="langId" value='<c:out value="${langId}" />' id="WC_MPasswordUpdateForm_FormInput_langId"/>
					<input type="hidden" name="logonId" value='<c:out value="${WCParam.logonId}" />' id="WC_MPasswordUpdateForm_FormInput_logonId"/>
					<input type="hidden" name="reLogonURL" value="ChangePassword" id="WC_MPasswordUpdateForm_FormInput_reLogonURL"/>
					<input type="hidden" name="Relogon" value="Update" id="WC_MPasswordUpdateForm_FormInput_Relogon"/>
					<input type="hidden" name="errorViewName" value="ChangePassword" />
				
					<input type="hidden" name="fromOrderId" value="*" id="WC_MPasswordUpdateForm_FormInput_fromOrderId"/>
					<input type="hidden" name="toOrderId" value="." id="WC_MPasswordUpdateForm_FormInput_toOrderId"/>
					<input type="hidden" name="deleteIfEmpty" value="*" id="WC_MPasswordUpdateForm_FormInput_deleteIfEmpty" />
					<input type="hidden" name="continue" value="1" id="WC_MPasswordUpdateForm_FormInput_continue" />
					<input type="hidden" name="createIfEmpty" value="1" id="WC_MPasswordUpdateForm_FormInput_createIfEmpty" />
					<%-- the parameter 'calculationUsageId' and 'updatePrices' are used by the OrderCalculate command --%>
					<input type="hidden" name="calculationUsageId" value="-1" id="WC_MPasswordUpdateForm_FormInput_calculationUsageId" />
					<input type="hidden" name="updatePrices" value="1" id="WC_MPasswordUpdateForm_FormInput_updatePrices"/>
					<input type="hidden" name="URL" value="mMyAccountDisplay" id="WC_MPasswordUpdateForm_FormInput_URL"/>
					<input type="hidden" name="myAcctMain" value="1" id="WC_MPasswordUpdateForm_FormInput_myAcctMain"/>
				
					<fieldset>
						<div class="input_container">
							<div><label for="WC_MPasswordUpdateForm_FormInput_logonPasswordOld"><fmt:message key="MCURRENT_PASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MPasswordUpdateForm_FormInput_logonPasswordOld" name="logonPasswordOld" class="coloured_input" value=""/>		
						</div>
						
						<div class="input_container">
							<div><label for="WC_MPasswordUpdateForm_FormInput_logonPassword"><fmt:message key="MUSREG_PASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MPasswordUpdateForm_FormInput_logonPassword" name="logonPassword" class="coloured_input" value=""/>		
						</div>
						
						<div class="input_container">
							<div><label for="WC_MPasswordUpdateForm_FormInput_logonPasswordVerify"><fmt:message key="MUSREG_VPASSWORD" bundle="${storeText}" /></label></div>
							<input type="password" id="WC_MPasswordUpdateForm_FormInput_logonPasswordVerify" name="logonPasswordVerify" class="coloured_input" value=""/>		
						</div>								
					</fieldset>
					
					<br/>
					<input type="submit" id="password_update_form_submit" name="password_update_form_submit" value="<fmt:message key="MUSREGU_UPDATE" bundle="${storeText}" />" />	
				</form>
					
			</div>
			<%@ include file="../../../include/FooterDisplay.jspf" %>
		</div>

	</body>
</html>

<!-- END PasswordUpdateForm.jsp -->
