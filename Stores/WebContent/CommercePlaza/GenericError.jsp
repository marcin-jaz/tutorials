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


<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific beans used %> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %> 
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>

<%@ include file="include/EnvironmentSetup.jsp"%>
<% response.setContentType(storeText.getString("ENCODESTATEMENT")); %> 

<%
ErrorDataBean errorBean = new ErrorDataBean ();
com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);

UserRegistrationDataBean bnRegUser = new UserRegistrationDataBean();
com.ibm.commerce.beans.DataBeanManager.activate(bnRegUser, request);

String errorMessageKey = errorBean.getMessageKey().trim();
String errorMessage = errorBean.getMessage();
%>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
       <title>
       <%
       //  If the store is closed or suspended, we get the message state _ERR_BAD_STORE_STATE (CMN1072E).
       //  We should display the store is closed page.
       if (errorBean.getMessageKey().equals("_ERR_BAD_STORE_STATE")) {
              %>
              <%=storeText.getString("GenericError_Text3")%>
              <%
       }
       else {
              %>
              <%=storeText.getString("GenericError_Title")%>
              <%
       }
       %>
	</title>
	<TITLE><%=storeText.getString("GenericError_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>PCDMarket.css" TYPE="text/css">

</HEAD>
	

<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0">

<!--START HEADER-->

<table cellspacing="0" cellpadding="0" width="750" border="0">
  <tbody>
  	<tr>
  	<td class="tbgc" width="150"><img height="55" alt="<%=storeText.getString("Breadcrumb_CommercePlaza")%>" src="<%=fileDir%>images/nav_logo.gif" width="150" border="0" class="imgHeightFix" /></a></td>
	<td width="125"><img src="<%=fileDir%>images/banner_left.jpg" alt="" width="125" height="55" border="0"></td>
	<td class="banner_tile"><img src="<%=fileDir%>images/banner_tile.gif" alt="" width="4" height="55" border="0"></td>
	<td width="475" align="right" class="searchBar"></td>
	</tr>
  </tbody>
</table>

<!--END HEADER-->

  
<!-- End Header File -->

<!-- Start Main Table  -->
<table border="0" cellpadding="0" cellspacing="0" width="750" height="350">
  <tr>
    <td VALIGN="top" width="150">
	<table background="<%=fileDir%>images/nav_back.gif" cellspacing="0" cellpadding="0" width="150" height="100%" border="0">
	 	<tbody>
		 <tr width="150">
			<td width="5">&nbsp;</td>
			<td>&nbsp;</td>
		 </tr>   
		</tbody>
	</table>
    </td>
    <!-- End  Left Nav Bar TD -->
    
    <!-- Begin Main Content TD -->
    <td valign="top" width="600">

    <!--MAIN CONTENT STARTS HERE-->
					
		<!-- Start Main JSP Content -->
			
		<table width="600" border="0" cellspacing="0" cellpadding="0">
  		<tbody>
  		  <tr>
		    <td width="10"></td>
		    <td width="590" colspan="2">
			<br /><br /><br /><br />
			<% 
		      	if (errorMessageKey != null)
		      	{
				if (errorMessageKey.equals("_ERR_USER_AUTHORITY"))
				{ 
					if (!bnRegUser.findUser())
					{ 
					%>
						<font class="medium"><%=storeText.getString("AUTHORIZATION_ERROR1")%></font>
						<br /><br /><br /><br />
						<font class="medium"><a href="LogonForm?langId=<%=languageId%>&storeId=<%=storeId%>"><%=storeText.getString("GENERICERR_LOGON")%></a></font>
						
					<%
					} else 	{
					%>
						<font class="medium"><%=storeText.getString("AUTHORIZATION_ERROR2")%></font>
				<%
					}
				}
				else if (errorMessageKey.equals("_ERR_BAD_STORE_STATE")) 
				{
				       %>
				       <font class="medium"><%=storeText.getString("GenericError_Text4")%></font>
					<%					
				} else if (errorMessage != null && !errorMessage.equals("")) {
              %>
              <font class="medium"><%=errorMessage%></font>
              <table cellspacing="0" cellpadding="0" width="95%" border="0">
							<tbody>
								<tr>
									<td height="12"><spacer type="block" width="12" height="12" /></td>
								</tr>
								<tr>
									<td><a href="javascript:history.back(1)"><img alt='<%=storeText.getString("PROHIBITEDCHAR_ERROR_BACK")%>' src="<%=fileDir%><%=locale.toString()%>/images/continue.gif"  border="0" name="GoBack" /></a></td>
								</tr>
							</tbody>
							</table>
              <%		
				} else 	{
					%>
					<font class="medium"><%=storeText.getString("GenericError_Text2")%></font>
					<%
				}
			}
			else 
			{ 	
			%>
			 	<font class="medium"><%=storeText.getString("GenericError_Text1")%></font>
		 	<%
		 	}
		 	%>
		 	
		 	<%
			if (! (errorMessageKey != null && errorMessageKey.equals("_ERR_BAD_STORE_STATE")) )
			{
				%>
				<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
				<hr width="580" noshade align="left"> <br />
					<%=storeText.getString("GENERICERR_DEVELOPER")%> <br />
					<%=storeText.getString("GENERICERR_HTML")%>
				<br /><br /><br /><br />				
				<%
			}
			%>			
		    </td></tr>
		
		                                          
		</tbody></table>
</td>

</tr></table>
</td>	
	<!-- End of Main Content TD -->
 
   
</tr></table>
   
   

<!-- start footer -->
<table cellspacing="0" cellpadding="0" width="750" border="0" background="<%=fileDir%>images/option_back.gif">
  <tbody>
  <tr>
    <td><img height="1" alt="" src="<%=fileDir%>images/c.gif" width="1" /></td>
  </tr>
  <tr valign="top">
    <td height="18">&nbsp;&nbsp;<span class="divider">&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
  </tr>
  </tbody>
</table>
<!-- End Footer-->

</BODY>
</HTML>

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
	out.println ("Exception:"+e);
}
%>
//*-------------------------------------------------------------------
//*
-->

