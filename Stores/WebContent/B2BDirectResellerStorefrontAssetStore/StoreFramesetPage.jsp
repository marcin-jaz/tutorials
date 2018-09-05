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
--%>
<%-- 
  *****
  * This JSP page redirects the user into the store if the user is already logged in and a registered user.
  * Otherwise this JSP page redirects the user to the Logon page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.tools.util.UIUtil" %> 
<%@ include file="include/EnvironmentSetup.jspf"%>
<%
	JSPHelper jhelper = new JSPHelper(request);
	String catalogId=jhelper.getParameter("catalogId");
	String storeId = cmdcontext.getStoreId().toString();
	String langId = cmdcontext.getLanguageId().toString();
	String sWebPath=UIUtil.getWebPrefix(request);
	String sWebAppPath=UIUtil.getWebappPath(request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><%=ccResBundle.getString("customerCarePageTitleHome")%></title>
		<script language="javascript">
			<%@ include file="Sametime.js" %>
<c:set var="userType" value="${CommandContext.user.registerType}"/>
<c:set var="guest" value="G"/>
<c:choose>
	<c:when test="${userType eq guest}">
			var MainPageURL="<%=sWebAppPath%>LogonForm?storeId=<%=storeId%>&catalogId=<%=catalogId%>";
	</c:when>
	<c:otherwise>
			var MainPageURL="<%=sWebAppPath%>UserAccountView?storeId=<%=storeId%>&catalogId=<%=catalogId%>";
	</c:otherwise>
</c:choose>
			function refreshMainPage()
			{
				if (browserType.ns) {
					main.document.location.href=MainPageURL; 
				}
			 }
			function loadMainPage()
			{
				main.document.location.href=MainPageURL;
			 }
		
		</script>
	</head>
	<%
	String sSametimeUrl=sWebAppPath + "CCShopperFramePageView?storeId="+storeId;
	String sBlankUrl=sWebAppPath + "CCShopperBlankPageView?storeId="+storeId;
	String sUpdateUrl=sWebAppPath + "CCShopperInfoUpdatePageView?storeId="+storeId;
	%>
	<frameset border="0" framespacing="0" frameborder="0" rows="*,1,1,1" onload="refreshMainPage();">
		<frame name="main" title='<%=UIUtil.toHTML(ccResBundle.getString("customerCarePageTitleContent"))%>' src="javascript:top.loadMainPage();" marginwidth="0" scrolling="auto" frameborder="no" noresize="noresize">
		<frame name="JSFrame" title='<%=UIUtil.toHTML(ccResBundle.getString("customerCarePageTitleShopperReady"))%>' src="<%=sBlankUrl%>" marginwidth="0" scrolling="no" frameborder="no" noresize="noresize">
		<frame name="StUpdate" title='<%=UIUtil.toHTML(ccResBundle.getString("customerCarePageTitleShopperInformation"))%>' src="<%=sUpdateUrl%>" marginwidth="0" scrolling="no" frameborder="no" noresize="noresize">
		<frame name="sametime" title='<%=UIUtil.toHTML(ccResBundle.getString("customerCarePageTitleShopperApplet"))%>' src="<%=sSametimeUrl%>" marginwidth="0" scrolling="no" frameborder="no" noresize="noresize">
	</frameset>
</html>
