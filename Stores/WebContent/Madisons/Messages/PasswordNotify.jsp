<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2007
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * After the customer has provided the necessary information on the Forget Password page, this email will be sent.
  * This email JSP page informs the customer about the newly reset password. 
  * This JSP page is associated with PasswordNotifyView view in the struts-config file.  
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../include/nocache.jspf"%>
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="eHostPath" />
<c:set value="${eHostPath}${jspStoreImgDir}" var="jspStoreImgDir" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title><fmt:message key="PASSWORDNOTIFY_TITLE" bundle="${storeText}"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

	<table width="792" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
		<%@ include file="EmailHeader.jspf"%>
		<tr>
			<td width="12" style="border-left: 1px solid #c9d3de;"></td>
			<td width="770" valign="top" style="font-family: Verdana, Arial; font-size: 14px; color: #59677d;">			
				<b><fmt:message key="PASSWORDNOTIFY_TITLE" bundle="${storeText}"/></b>
				<c:choose>
					<c:when test="${empty WCParam.logonId || empty WCParam.logonPassword}">
						<fmt:message key="PASSWORDNOTIFY_ERROR" bundle="${storeText}"/>
					</c:when>
					<c:otherwise>
						<% out.flush(); %>
						<c:import url="${jspStoreDir}Snippets/Marketing/Content/ContentSpotDisplay.jsp">
							<c:param name="spotName" value="Passwd_Success" />
							<c:param name="substitutionValues" value="{password},${WCParam.logonPassword}"/>
						</c:import>
						<% out.flush(); %>
					</c:otherwise>
				</c:choose>		
			</td>
			<td width="12" style="border-right: 1px solid #c9d3de;"></td>
		</tr>
		<tr>
			<td colspan="3" style="border-left: 1px solid #c9d3de; border-right: 1px solid #c9d3de; font-size: 11px;">&nbsp;</td>
		</tr>	
		<%@ include file="EmailFooter.jspf"%>
	</table>
</body>
</html>
