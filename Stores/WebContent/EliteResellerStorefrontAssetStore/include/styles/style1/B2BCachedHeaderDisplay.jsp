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
  * This JSP is called from HeaderDisplay.jsp. Only the B2B SignOn, User Registration form, 
  * and Organization Registration form use this page. 
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<flow:fileRef id="vfileLogo" fileId="vfile.logo"/>
<flow:fileRef id="vfileBanner" fileId="vfile.banner"/>
<flow:fileRef id="vfileSelectedBanner" fileId="vfile.selectedBanner"/>


                           
<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
  <wcf:param name="langId" value="${langId}" />
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
</wcf:url>


<div id="header">
		<div id="header_logo">
		<%-- 
		***
		*  Start: Custom Banner and Logo
		***
		--%>                      
			<%-- Height and store name removal is to adapt new style --%>
			
			<flow:ifEnabled feature="CustomLogo">
				<img src="<c:out value="${storeImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/>
			</flow:ifEnabled>
			<flow:ifDisabled feature="CustomLogo">
			  <img src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" alt="<c:out value="${storeName}" />" border="0"/>
			</flow:ifDisabled>
			
		<%-- 
		***
		*  End: Custom Banner and Logo
		***
		--%>
		</div>

	
	 <div id="header_links"></div>
</div>

<div id="header_nav"></div>