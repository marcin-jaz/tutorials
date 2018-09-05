<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<%-- 
  *****
  * This JSP page displays the available languages/countries of the store
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>
		<fmt:message key="INDEX_TITLE" bundle="${storeText}">
			<fmt:param value="${storeName}"/>
		</fmt:message> 
	</title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
</head>

<body class="whiteBackground">

<table align="center" cellpadding="0" cellspacing="0" border="0" width="786">
<tr>
	<td colspan="3" height="35" class="lng_logo">
	<%-- 
	  ***
	  *  Start: Custom Logo
	  ***
	--%>                	                            

	<flow:ifEnabled feature="CustomLogo">
	       <img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<fmt:message key="HEADER_STORE_LOGO" bundle="${storeText}" />" />
	</flow:ifEnabled>
	<flow:ifDisabled feature="CustomLogo">
	       <img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<fmt:message key="HEADER_STORE_LOGO" bundle="${storeText}" />" />
	</flow:ifDisabled>

	<%-- 
	  ***
	  *  End: Custom Logo
	  ***
	--%>                                                  
	</td>
</tr>
<tr>
	<td>
 <object data="<c:out value="${jspStoreImgDir}"/>images/storefront.swf"
		 width="500" height="310" type="application/x-shockwave-flash">
  <param name="movie" value="<c:out value="${jspStoreImgDir}"/>images/storefront.swf" />
  <param name="quality" value="high"/>
  <param name="bgcolor" value="#FFFFFF"/>
  <param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer"/>
 </object>
	</td>
	<td>
		<img src="<c:out value="${jspStoreImgDir}"/>images/lang_line.gif" alt="" width="16" height="346" border="0"/>
	</td>
	<td valign="middle">	
		<table cellpadding="3" cellspacing="5" border="0">
		<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
		<tr>
			<c:url var="TopCategoriesDisplayURL" value="TopCategoriesDisplay">
				<c:param name="langId" value="${dbLanguage.languageId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
			</c:url>
			<td><a href="<c:out value="${TopCategoriesDisplayURL}"/>" class="lng_link"><c:out value="${dbLanguage.nativeDescriptionString}" escapeXml="false"/></a></td>
		</tr>
		</c:forEach>
		</table>
	</td>
</tr>
</table>
<script type="text/javascript" language="javascript" src="<c:out value="${jspStoreImgDir}javascript/CheckBrowserVersion.js"/>"></script>

<script language="javascript" type="text/javascript">

if(isBrowserSupported() == false) {
	alert("<fmt:message key="Logon_UnsupportedBrowser" bundle="${storeText}"/>");
}

</script>

</body>
</html>

