<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%><% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support 
%><%@ page import="java.io.*" 
%><%@ page import="java.util.*" 
%><%@ page import="com.ibm.commerce.server.ECConstants" 
%><%@ page import="com.ibm.commerce.server.JSPHelper" 
%><%@ page import="com.ibm.commerce.server.JSPResourceBundle" 
%><%@ page import="com.ibm.commerce.command.CommandContext" 
%><% // Page specific imports
%><%@ page import="javax.servlet.*" 
%><%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" 
%><%@ page import="com.ibm.commerce.server.JSPResourceBundle" 
%><%@ page session="false"
%><%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" 
%><wcbase:useBean id="sdb" classname="com.ibm.commerce.common.beans.StoreDataBean" scope="request"/><%--
  *****
  * This JSP page is used to send an e-mail to a user informing him of a newly reset password.
  *****
--%><%
JSPResourceBundle storeText = (JSPResourceBundle) request.getAttribute("ResourceText");

if (storeText == null) 
{
	storeText =  new JSPResourceBundle(sdb.getResourceBundle("tooltechtext"));
	request.setAttribute("ResourceText", storeText);
}

try 
{
       response.setContentType("text/html;charset=UTF-8");
       JSPHelper jsphelper = new JSPHelper(request);

       String strLogonId = jsphelper.getParameter(ECUserConstants.EC_UREG_LOGONID);
       String strPassword = jsphelper.getParameter(ECUserConstants.EC_UREG_LOGONPASSWORD);

       if (strLogonId == null || strPassword == null ) 
       {
           out.println(storeText.getString("PASSWORDNOTIFY_ERROR"));
           return;
       }
	
       //LI 1075 - Reading from the ContentSpotDisplay.jsp
	pageContext.setAttribute("strPassword",strPassword);
%>

		<c:import url="${jspStoreDir}/Snippets/Marketing/Content/ContentSpotDisplay.jsp">
				<c:param name="spotName" value="Passwd_Success" />
				<c:param name="substitutionValues" value="{password},${strPassword}" />
		</c:import>
<%

} 
catch (Exception e)
{
       out.print( "Exception " + e);
}
%>
