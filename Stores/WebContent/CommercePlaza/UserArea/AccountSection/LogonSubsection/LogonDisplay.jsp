<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
    

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.catalog.beans.CatalogDataBean" %> 
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<%
String errorMessage = request.getParameter("errorMessage");
String strlogonId = "";
%>

<jsp:useBean id="bnError" class="com.ibm.commerce.beans.ErrorDataBean" scope="page">
	<% com.ibm.commerce.beans.DataBeanManager.activate(bnError, request); %>
</jsp:useBean>

<%
CatalogDataBean Catalogs[] = sdb.getStoreCatalogs();
catalogId = Catalogs[0].getCatalogId();

// Using the ErrorDataBean, a problem with the user's input data will be detected here.

String strErrorMessage 		= null;

String[] strArrayAuth = (String [])request.getAttribute(ECConstants.EC_ERROR_CODE);

if (strArrayAuth != null)
	{
      if( strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_MISSING_LOGONID) == true)
         strErrorMessage = storeText.getString("Logon_ID_MISSING");      
       else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_INVALID_LOGONID) == true ||  	
               strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_INVALID_PASSWORD) == true)
         strErrorMessage = storeText.getString("Logon_Incorrect");         
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_MISSING_PASSWORD) == true)
         strErrorMessage = storeText.getString("Logon_PASSWD_MISSING");
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_DISABLED_ACCOUNT) == true)
         strErrorMessage = storeText.getString("Logon_Warning1");
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_LOGON_NOT_ALLOWED) == true)
         strErrorMessage = storeText.getString("Logon_WAIT_TO_LOGIN");  
      else if(strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_USER_IN_PENDING_APPROVAL) == true)
         strErrorMessage = storeText.getString("Logon_Warning2");
      else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_PARENT_ORG_LOCKED)==true)
         strErrorMessage = storeText.getString("Logon_ERROR_org_locked");
      else if (strArrayAuth[0].equalsIgnoreCase(ECSecurityConstants.ERR_NOT_REGISTERED_CUSTOMER)==true)
         strErrorMessage = storeText.getString("Logon_ERROR_Authority");                  
      else
      	 strErrorMessage = storeText.getString("GenericError_Text1");   
      	 
      	 
	//Get the entered logonId from the URL parameters in order to re-display it.
	strlogonId = jhelper.getParameter("logonId");
      	 
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("Logon_Title")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />
	<script language="javascript">
	<!--

	function submitForm(form)
	{
		form.submit()
	}
	
	function pressEnter(keyStroke){

		isNetscape=(document.layers);
		keyCode = (isNetscape) ? keyStroke.which : event.keyCode;

		if (keyCode == 13){
			document.Logonpage.submit()
		}
	}

	-->
	</script>
	</head>
	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<%@ include file="../../../include/HeaderDisplay.jspf"%>
		<!-- Start Main Table - Consists of TD for Left Bar and TD for Content -->
		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody><tr>
				<td valign="top" class="dbg" width="150">
					<%
	    				String incfile = includeDir + "SidebarDisplay.jsp";
		    			%>
					<jsp:include page="<%=incfile%>" flush="true"></jsp:include>
				</td>
				<!-- End  Left Nav Bar TD -->
				<td width="10"><spacer type="horizontal" size="10" /><br />
				</td>
				<!-- Begin Main Content TD -->
				<td valign="top" width="590">
					<a name="mainContent"></a><img src="<%=fileDir%>images/c.gif" height="20" width="20" /></a>
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tbody><tr>
							<td valign="top">
								<div align="left">
									<img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
									<span class="title"><%=storeText.getString("Logon_Title")%></span></div>
							</td>
							<td valign="top"><div align="right">
									<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("Logon_Title")%>' /></div></td>
						</tr>
					</tbody></table>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody><tr valign="top">
							<td>
									<%
								 	 if (strErrorMessage != null) {
								  	   	//Display error messages. 
								   		%><span class="error"><%=strErrorMessage%></span>
										<br />
										<%		
								     	}			
									%>
								<table cellspacing="1" cellpadding="0" width="100%" border="0">
									<tbody><tr>
										<td>
											<form name="Logonpage" method="post" action="Logon">
												<input type="hidden" name="storeId" value="<%=storeId%>" />
												<input type="hidden" name="langId" value="<%=languageId%>" />
												<input type="hidden" name="catalogId" value="<%=catalogId%>" />
												<input type="hidden" name="reLogonURL" value="LogonForm" />
												<input type="hidden" name="URL" value="StoreCatalogDisplay" />
												<table border="0" width="100%" cellspacing="0" cellpadding="2">
													<tbody><tr>
														<td width="268" class="tdblue"><b><%=storeText.getString("Logon_Text1")%></b></td>
														<td width="1"><br /></td>
														<td width="268" class="tdblue"><b><%=storeText.getString("Logon_Text2")%></b></td>
													</tr>
													<tr>
														<td width="268" valign="top"><%=storeText.getString("Logon_Register1")%></td>
														<td width="1"></td>
														<td width="268" valign="top"><%=storeText.getString("Logon_Register2")%></td>
													</tr>
													<tr>
														<td class="bodytxt1" align="left" valign="top" width="268">
															<table border="0" cellpadding="0" cellspacing="2" width="122">
																<tbody>
																<tr>
																	<td colspan="2">
																		<b><label for="useridtext"><%=storeText.getString("Logon_UserID")%></label></b>
																	</td>
																</tr>	
																<tr>
																	<td colspan="2">
																		<input type="text" name="logonId" id="useridtext" value="<%=strlogonId%>" tabindex="1" onfocus="this.onkeypress = pressEnter;" onblur="this.onkeypress = null"  size="13" class="iform" />
																	</td>
																</tr>
																<tr>
																	<td colspan="2">
																		<b><label for="passwordtext"><%=storeText.getString("Logon_Password")%></label></b><br />
																	</td>
																</tr>
																<tr>
																	<td>
																		<input type="password" name="logonPassword" id="passwordtext" tabindex="2" onfocus="this.onkeypress = pressEnter;" onblur="this.onkeypress = null" size="13" class="iform" />
																	</td>
																	<td width="30">&nbsp;<a href="javascript:submitForm(document.Logonpage)" tabindex="3"><img src="<%=fileDir%><%=locale.toString()%>/images/go.gif" alt='<%=storeText.getString("Logon_Go")%>' border="0" /></a></td>
																</tr>
															</tbody></table>
															<br />
															<a href="ResetPasswordFormView?langId=<%=languageId%>&amp;catalogId=<%=catalogId%>&amp;storeId=<%=storeId%>"><%=storeText.getString("Logon_Text8")%></a></td>
														<td class="bodytxt1" align="left" valign="top" width="1"></td>
														<td class="bodytxt1" align="left" valign="top" width="268"><%=storeText.getString("Logon_Text3")%>&nbsp;<a href="LocationPromptFormView?langId=<%=languageId%>&amp;catalogId=<%=catalogId%>&amp;storeId=<%=storeId%>"><%=storeText.getString("Logon_Text4")%></a><br />
															<%=storeText.getString("Logon_Text5")%><br />
															<b><%=storeText.getString("Logon_Text6")%></b>&nbsp;<%=storeText.getString("Logon_Text11")%><br />
															<br />
															<%=storeText.getString("Logon_Text7")%>&nbsp;<a href="UserRegistrationFormView?langId=<%=languageId%>&amp;catalogId=<%=catalogId%>&amp;storeId=<%=storeId%>"><%=storeText.getString("Logon_Text9")%></a><br />
															<%=storeText.getString("Logon_Text10")%></td>
													</tr>
												</tbody></table>
											</form>
										</td>
									</tr>
								</tbody></table>
							</td>
						</tr>
					</tbody></table>
				</td>
			</tr>
		</tbody></table>
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>

</html>
