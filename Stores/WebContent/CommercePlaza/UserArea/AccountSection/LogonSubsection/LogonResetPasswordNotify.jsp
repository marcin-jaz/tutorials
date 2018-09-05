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

<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
/*
 * This JSP is associated with PasswordResetNotification view in the viewreg table.
 * This causes this JSP to be used to send an e-mail to the customer informing him/her
 * of a newly reset password. 
 * 
 */

try 
{
	response.setContentType("text/html;charset=UTF-8");

	String strLogonId = jhelper.getParameter(ECUserConstants.EC_UREG_LOGONID);
	String strPassword = jhelper.getParameter(ECUserConstants.EC_UREG_LOGONPASSWORD);

	if (strLogonId == null || strPassword == null ) 
	{
	    out.println(storeText.getString("PASSWORDNOTIFY_ERROR"));
	    return;
	}
	out.println(strLogonId);
	out.println(storeText.getString("PASSWD_SUCCESS"));
	out.println(storeText.getString("PASSWD_RESET"));
	out.println(strPassword);
	out.println(storeText.getString("CHANGE_PASSWD"));
} 
catch (Exception e)
{
	out.print( "Exception " + e);
}
%>