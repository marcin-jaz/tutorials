<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans used %> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="com.ibm.commerce.common.beans.StoreDataBean" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %> 
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>

<%@ include file="include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="include/TransitionEnvironmentSetup.jspf"%>

<%

//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String languageId = jhelper.getParameter("langId");
String storeId = jhelper.getParameter("storeId");

ErrorDataBean errorBean = new ErrorDataBean ();
com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);

UserRegistrationDataBean bnRegUser = new UserRegistrationDataBean();
com.ibm.commerce.beans.DataBeanManager.activate(bnRegUser, request);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
       <title>
       <%
       //  If the store is closed or suspended, we get the message state _ERR_BAD_STORE_STATE (CMN1072E).
       //  We should display the store is closed page.
       if (errorBean.getMessageKey().equals("_ERR_BAD_STORE_STATE")) {
              %>
              <fmt:message key="GenericError_Text3" bundle="${storeText}" />
              
              <%
       }
       else {
              %>
              <fmt:message key="GenericError_Title" bundle="${storeText}" />
              
              <%
       }
       %>
	</title>
	<link rel="stylesheet" href="<%=jspStoreImgDir%><%=vfileStylesheet%>" type="text/css"/>
</head>


<body class="logon">

<%
String errorMessageKey = errorBean.getMessageKey().trim();


%>

<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_GenericError_Table_1">
	<tr>
		<td width="40%" id="WC_GenericError_TableCell_1">&nbsp;</td>
		<td valign="top" width="600" id="WC_GenericError_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="407" id="WC_GenericError_Table_2">
				<tr>
					<td class="logonTop" id="WC_GenericError_TableCell_3"><img src="<c:out value="${jspStoreImgDir}" />images/logon_top.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
				<tr>
					<td class="logonLogo" id="WC_GenericError_TableCell_4">
						<flow:ifEnabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${storeImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifEnabled>
						<flow:ifDisabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifDisabled>
					</td>
				</tr>
				<tr>
					<td background="<c:out value="${jspStoreImgDir}${vfileColor}" />error_image.jpg" id="WC_GenericError_TableCell_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />error_image.jpg" alt="" width="600" height="99" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" width="600" id="WC_GenericError_TableCell_6">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_GenericError_Table_3">
							<tr>
								<td class="logontitle" colspan="2" id="WC_GenericError_TableCell_7"><span class="logontitle"></span>
									
								</td>
							</tr>
							<tr>
								<td class="logonspacing" id="WC_GenericError_TableCell_8">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_GenericError_Table_4">
										<tr>
											<td class="logontxt" id="WC_GenericError_TableCell_9">
									
								
	<!--START MAIN CONTENT-->


	<%if (errorMessageKey != null){
	%>
		<%if (errorMessageKey.equals("_ERR_USER_AUTHORITY")){ 
		%>
			<%if (!bnRegUser.findUser()){ 
			%>	
												<span class="warning"><fmt:message key="AUTHORIZATION_ERROR1" bundle="${storeText}" /></span>
												<br />
												<br />
												<c:url var="LogonFormURL" value="LogonForm">
													<c:param name="storeId" value="${storeId}" />
													<c:param name="langId" value="${langId}" />
													<c:param name="catalogId" value="${catalogId}" />
												</c:url>
												<a href="<c:out value="${LogonFormURL}"/>" class="button" id="WC_GenericError_Link_1">
													<fmt:message key="Logon_Title" bundle="${storeText}" />
												</a>
			<%
			} else {
			%>
												<span class="warning"><fmt:message key="AUTHORIZATION_ERROR2" bundle="${storeText}" /></span>
			<%}%>

		<%
		}else if (errorMessageKey.equals("_ERR_BAD_STORE_STATE")) 
		{
			%>
												<span class="warning"><fmt:message key="GenericError_Text4" bundle="${storeText}" /></span>
		<%
		} else {
		%>
												<span class="warning"><fmt:message key="GenericError_Text1" bundle="${storeText}" /></span>
												<br />
												<strong><fmt:message key="GenericError_Text2" bundle="${storeText}" /></strong>
		<%}%>

	<%
	} else {
	%>		
												<span class="warning"><fmt:message key="GenericError_Text1" bundle="${storeText}" /></span>
												<br />
												<strong><fmt:message key="GenericError_Text2" bundle="${storeText}" /></strong>
	<%}%>

			<%
			  /* The section below is intended to aid store developers in debugging problems in the sample store. 
			   * For a real online store, this may not be required.
			   */
			   if (errorMessageKey==null || !errorMessageKey.equals("_ERR_BAD_STORE_STATE")) 
			   {
				%>
											</td>
										</tr>
										<tr>	
											<td colspan="2" id="WC_GenericError_TableCell_10"><hr width="495" class="logon" /></td>
										</tr>
										<tr>
											<td class="logonspacing" id="WC_GenericError_TableCell_11">
												<table cellpadding="0" cellspacing="0" border="0" width="220" id="WC_GenericError_Table_5">
														<tr>
															<td class="logontxt" id="WC_GenericError_TableCell_12">
										
									
																<fmt:message key="GENERICERR_DEVELOPER" bundle="${storeText}" />
																<br />
																<fmt:message key="GENERICERR_HTML" bundle="${storeText}" />
															</td>
														</tr>
												</table>
				<%
			   }
			   %>

	<!--END MAIN CONTENT-->
											</td>
										</tr>
									</table>
								</td>
							</tr>				
						</table>
					</td>
				</tr>
				<tr>
					<td id="WC_GenericError_TableCell_13"><img src="<c:out value="${jspStoreImgDir}" />images/logon_bottom.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_GenericError_TableCell_14">&nbsp;</td>
	</tr>
</table>

<!--
//********************************************************************
//*-------------------------------------------------------------------
<% 
try {
%>
<%=storeText.getString("GENERICERR_TEXT3")%>
<%=storeText.getString("GENERICERR_TEXT4")%>

<%=storeText.getString("GENERICERR_TYPE")%> <%= errorBean.getExceptionType()%>
<%=storeText.getString("GENERICERR_KEY")%> <%= errorBean.getMessageKey() %>
<%=storeText.getString("GENERICERR_MESSAGE")%> <%= errorBean.getMessage() %>
<%=storeText.getString("GENERICERR_SYSMESSAGE")%> <%= errorBean.getSystemMessage() %>
<%=storeText.getString("GENERICERR_CMD")%> <%= errorBean.getOriginatingCommand() %>
<%=storeText.getString("GENERICERR_CORR_ACTION")%> <%= errorBean.getCorrectiveActionMessage() %>
<%
	com.ibm.commerce.datatype.TypedProperty nvps = errorBean.getExceptionData();
	if (nvps != null) {
		Enumeration en = nvps.keys();
%>
<%=storeText.getString("GENERICERR_EXCEPTIONDATA")%>
<%
		while(en.hasMoreElements()) {
			String name = (String)en.nextElement();
%>
<%=storeText.getString("GENERICERR_NAME")%> <%= name %>    <%=storeText.getString("GENERICERR_VALUE")%> <%= nvps.getString(name, "") %>
<%	
		}
	}

} catch (Exception e) {
		out.println ("ex:"+e);
}
%>
//*-------------------------------------------------------------------
//*
-->

</body>
</html>
