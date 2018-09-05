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



<% // All JSPs requires the first 4 packages for getResource.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>

<%  //Needed to catch & display error messages %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>

<% //Needed for switching currencies & languages %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>

<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%
// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted.
// JSPHelper Comes from Package com.ibm.commerce.server.*
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter("storeId");
String languageId = jhelper.getParameter("langId");
String errorMessage = request.getParameter("errorMessage");

String strlogonId = "";

%>
<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
String catalogId = Catalogs[0].getCatalogId();

// Using the ErrorDataBean, a problem with the user's input data will be detected here.

String strErrorMessage 		= null;

String[] strArrayAuth = (String [])request.getAttribute(ECConstants.EC_ERROR_CODE);

if (strArrayAuth != null)
	{
      if( strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_MISSING_LOGONID) == true)
         strErrorMessage = tooltechtext.getString("Logon_ID_MISSING");
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_INVALID_LOGONID) == true)  	
      	 strErrorMessage = tooltechtext.getString("Logon_INVALID");
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_MISSING_PASSWORD) == true)
         strErrorMessage = tooltechtext.getString("Logon_PASSWD_MISSING");
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_INVALID_PASSWORD) == true ||
      	      strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_DISABLED_ACCOUNT) == true) 
         strErrorMessage = tooltechtext.getString("Logon_INVALID");
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_LOGON_NOT_ALLOWED) == true)
         strErrorMessage = tooltechtext.getString("Logon_WAIT_TO_LOGIN");   
      else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_USER_IN_PENDING_APPROVAL)==true)
         strErrorMessage = tooltechtext.getString("Logon_Warning2");
      else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_PARENT_ORG_LOCKED)==true)
         strErrorMessage = tooltechtext.getString("Logon_ERROR_org_locked");
      else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_NOT_REGISTERED_CUSTOMER)==true)
         strErrorMessage = tooltechtext.getString("Logon_ERROR_Authority");                  
      else
      	 strErrorMessage = tooltechtext.getString("GenericError_Text1");   
      	 
      	 
	//Get the entered logonId from the URL parameters in order to re-display it.
	strlogonId = jhelper.getParameter("logonId");
      	 
	}

Object loginTimeout = request.getAttribute("loginTimeout");
if(loginTimeout != null && loginTimeout instanceof String[]) {
	String[] strLoginTimeout = (String[])loginTimeout;
	if(strLoginTimeout.length != 0 && "true".equals(strLoginTimeout[0])) {
		strErrorMessage = tooltechtext.getString("Logon_ERROR_Timeout");
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><%=tooltechtext.getString("Logon_Title")%></title>
	<link rel="stylesheet" HREF="<%=fileDir%>ToolTech.css" type="text/css">
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" onload="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

<%
String incfile;
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  


<table cellpadding="0" cellspacing="0" border="0" height="99%" width="790">
<tr>
	<td valign="top" bgcolor="#4c6178" width="160"> 
		<%
		incfile = includeDir + "SidebarDisplay.jsp";
		%>
		<jsp:include page="<%=incfile%>" flush="true"/>  

	</td>

	<td valign="top" width="630">
  

<table border="0" width="630">




		<tr>
			<td width="10" rowspan="10">&nbsp;</td>
			<td align="left" valign="top" colspan="3" class="categoryspace">
				<FONT FACE="Verdana" STYLE="font-size : 17pt"><%=tooltechtext.getString("Logon_RegisterLogin")%></font>
				<hr width="610" noshade align="left">
			</td>
		</tr>
		<tr>
			<td align="left" valign="middle" width="305" class="textOverBackgroundMyAccount" bgcolor="#4c6178">
				<font class="textOverBackgroundMyAccount" color="#ffffff">&nbsp;<%=tooltechtext.getString("Logon_NewCustomer")%></font>
			</td>
			<td width="20" rowspan="5">&nbsp;&nbsp;</td>
			<td align="left" valign="middle" width="305" class="textOverBackgroundMyAccount" bgcolor="#4c6178">
				<font class="textOverBackgroundMyAccount" color="#ffffff">&nbsp;<%=tooltechtext.getString("Logon_ReturningCustomer")%></font>
			</td>
		</tr>


		<tr>
			<td align="left" valign="top" width="305" class="topspace">
				<font class="text"><%=tooltechtext.getString("Logon_Text")%><br /><br /></font>



				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
				</tr>
				<tr>
					<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ea2b2b">
						<table cellpadding="2" cellspacing="0" border="0">
						<tr>
							<td class="buttontext">
								<font color="#ffffff"><b>
								<a href="UserRegistrationForm?new=Y&langId=<%=languageId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>" style="color:#ffffff; text-decoration : none;">
								<%=tooltechtext.getString("Logon_Register")%>
								</a>
								</b></font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				</table>

			</td>
			<td align="left" valign="top" width="305" class="topspace">


				<table cellpadding="2" cellspacing="0" border="0">
				
					<tr>
						<td><%=tooltechtext.getString("Logon_Lang")%></td>
						<td>
							<!--This form is used to switch preferred language. By switching language, shopper switches language and currency.-->
				
							<form name="SwitchLanguage" action="LogonForm" method="post">
								<input type="hidden" name="storeId" value="<%= storeId %>">
								<input type="hidden" name="catalogId" value="<%= catalogId %>">
				
							<select name="langId" onChange="javascript:document.SwitchLanguage.submit()">
				
							<jsp:useBean id="supportedLanguageAccessBean" class="com.ibm.commerce.common.objects.SupportedLanguageAccessBean" scope="page" />
							
							<%
							Enumeration enStoreLangList = supportedLanguageAccessBean.findByStore(new Integer(storeId));
				
							while (enStoreLangList.hasMoreElements()) 
								{
								SupportedLanguageAccessBean storeLang = (SupportedLanguageAccessBean) enStoreLangList.nextElement();
								String storelangId = storeLang.getLanguageId();
				
								//Get the display name of the language in the language currently selected by the shopper.
								LanguageDescriptionAccessBean langDesc = new LanguageDescriptionAccessBean();
								langDesc.setInitKey_languageId(languageId);
								langDesc.setInitKey_descriptionLanguageId(storelangId);
				
								//If this language is currently selected, select it in the drop down list.
								if (languageId.equals(storelangId)) 
									{
				
									%>
									<option value="<%= storelangId %>" SELECTED><%=langDesc.getDescription()%></option>
									<%
									} 
								else 
									{
									%>
									<option value="<%= storelangId %>"><%=langDesc.getDescription()%></option>
									<%
									}
							} 
							
							%>
				
				
							</select>&nbsp;
												
				
						</td>
				
						</form>
					</tr>


					<form method="post" name="Logon" action="Logon">
						<input type="hidden" name="storeId" value="<%=storeId%>">
						<input type="hidden" name="catalogId" value="<%=catalogId%>">
						<input type="hidden" name="reLogonURL" value="LogonForm">
						<input type="hidden" name="URL" value="StoreCatalogDisplay">
						<input type="hidden" name="langId" value="<%=languageId%>">
				
					
					<tr>		
						<td><%=tooltechtext.getString("Logon_UserID")%></td>		
						<td><INPUT TYPE="text" NAME="logonId" VALUE="<%=strlogonId%>" SIZE="20"></td>		
					</tr>
					
					<tr>
						<td><%=tooltechtext.getString("Logon_Password")%></td>
						<td><INPUT TYPE="password" NAME="logonPassword" SIZE="20"></td>
					</tr>
					
					<tr>
						<td>&nbsp;</td>
						<td>
							<!-- DISPLAY INPUT FOR ID & PASSWORD -->
							<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
							</tr>
							<tr>
								<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
								<td bgcolor="#ea2b2b">
									<table cellpadding="2" cellspacing="0" border="0">
									<tr>
										<td class="buttontext">
											<font color="#ffffff"><b>
											<a href="javascript:document.Logon.submit()" style="color:#ffffff; text-decoration : none;">
											<%=tooltechtext.getString("Logon_Submit")%>
											</a>
											</b></font>
										</td>
									</tr>
									</table>
								</td>
								<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							<tr>
								<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
								<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
							</tr>
							</table>
						</td>
					</tr>
					
					</FORM>
					
					<tr>
						<td>&nbsp;</td>
						<td COLSPAN="3">
							<A HREF="ResetPasswordForm?storeId=<%=storeId%>&langId=<%=languageId%>&catalogId=<%=catalogId%>"><%=tooltechtext.getString("Logon_Forgot")%></A>
						</td>
					</tr>
					
				</table>
	
			</td>
		</tr>

</TABLE>


<!-- DISPLAY ERROR MESSAGES -->

<TABLE BORDER="0" WIDTH="446" ALIGN="center">
			
	<tr>
		<td>
			<BR>

			<% 
			if (strErrorMessage != null)
			{
			%>
			<FONT COLOR="red">
				<%=strErrorMessage%>
			</FONT>
			<%
			}
			if (errorMessage != null && !errorMessage.equals("")) 
			{ // the ResourceBundle key name for the error message is passed from the last request 
			%>
			<FONT COLOR="red">
				<%=tooltechtext.getString(errorMessage)%>
			</FONT>
			<%
			}
			%>
		</td>	
	</tr>
	
</TABLE>

</FORM>
		
</DIV>


	</td>
</tr>
</TABLE>


</BODY>
</HTML>
