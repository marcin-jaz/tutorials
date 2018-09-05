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
  * This JSP page displays a message verifying that the user has been logged off, and
  * provides a button to return to the Logon page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN UserLogoffView.jsp -->
<head>
<title><fmt:message key="Logoff_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}" />" type="text/css"/>
</head>
<body class="logon">

<flow:ifEnabled feature="customerCare">
<script language="javascript">
   if (typeof parent.setCustomerName == 'function')
     parent.setCustomerName (parent.WCSGUESTID, '')
   if (typeof parent.setShoppingCartItems == 'function')
     parent.setShoppingCartItems(0);
</script>
</flow:ifEnabled>

<!--MAIN CONTENT STARTS HERE-->
<table cellpadding="0" cellspacing="0" border="0" width="100%" id="WC_UserLogoffView_Table_1">
	<tr>
		<td width="40%" id="WC_UserLogoffView_TableCell_1">&nbsp;</td>
		<td valign="top" width="600" id="WC_UserLogoffView_TableCell_2">
			<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_UserLogoffView_Table_2">
				<tr>
					<td class="logonTop" id="WC_UserLogoffView_TableCell_3"><img src="<c:out value="${jspStoreImgDir}" />images/logon_top.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
				<tr>
					<td class="logonLogo" id="WC_UserLogoffView_TableCell_4">
						<flow:ifEnabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${storeImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifEnabled>
						<flow:ifDisabled feature="CustomLogo">
							<img alt="<c:out value="${storeName}" />" src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" align="middle"/>
						</flow:ifDisabled>
					</td>
				</tr>
				<tr>
				
					<%--
					//Use the following when custom logon banners can be chosen
					
					<flow:fileRef id="vfileSelectedLogonBanner" fileId="vfile.selectedLogonBanner"/>
					<flow:ifEnabled feature="CustomBanner">
						<c:set var="logonBannerImg" value="${storeImgDir}${vfileBanner}" />
					</flow:ifEnabled>	
					<flow:ifDisabled feature="CustomBanner">
				        <c:set var="logonBannerImg" value="${jspStoreImgDir}${vfileSelectedLogonBanner}" />
					</flow:ifDisabled>
					<td background="<c:out value="${logonBannerImg}" />" id="WC_UserLogoffView_TableCell_4a"><img src="<c:out value="${logonBannerImg}" />" alt="" width="600" height="99" border="0"/></td>
					--%>
					
					<td background="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" id="WC_UserLogoffView_TableCell_5"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />logon_image.jpg" alt="" width="600" height="99" border="0"/></td>
				</tr>
				<tr>
					<td class="logonwhite" width="600" id="WC_UserLogoffView_TableCell_6">
						<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogoffView_Table_3">
							<tr>
								<td class="logontitle" id="WC_UserLogoffView_TableCell_7"><span class="logontitle">+</span>
									<fmt:message key="Logoff_Title" bundle="${storeText}" />
								</td>
							</tr>
							<tr>
								<td class="logonspacing" id="WC_UserLogoffView_TableCell_8">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogoffView_Table_4">
										<tr>
											<td class="logontxt" id="WC_UserLogoffView_TableCell_9">
												<fmt:message key="Logoff_Success" bundle="${storeText}">
													<fmt:param value="${storeName}"/>
												</fmt:message>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>	
								<td id="WC_UserLogoffView_TableCell_10"><hr width="580" class="logon" /></td>
							</tr>
							<tr>
								<td class="logontitle" id="WC_UserLogoffView_TableCell_11"><span class="logontitle">+</span><fmt:message key="Logon_Title" bundle="${storeText}" /></td>
							</tr>
							<tr>
								<td class="logonspacing" id="WC_UserLogoffView_TableCell_12">
									<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogoffView_Table_5">
										<tr>
											<td class="logontxt" id="WC_UserLogoffView_TableCell_13">
												<fmt:message key="Logoff_LogonLink" bundle="${storeText}">
													<fmt:param value="${storeName}"/>
												</fmt:message>
											</td>
										</tr>
									</table>
									<br/>
									<table cellpadding="0" cellspacing="0" border="0" id="WC_UserLogoffView_Table_6">
										<tr>
											<td class="button" id="WC_UserLogoffView_TableCell_14">
												<c:url var="LogonFormURL" value="LogonForm">
													<c:param name="storeId" value="${storeId}" />
													<c:param name="langId" value="${langId}" />
													<c:param name="catalogId" value="${catalogId}" />
												</c:url>
												<a href="<c:out value="${LogonFormURL}"/>" class="button" id="WC_UserLogoffView_Link_1">
													<fmt:message key="Logon_Title" bundle="${storeText}" />
												</a>
											</td>
										</tr>
									</table>
								</td>
							</tr>				
						</table>
					</td>
				</tr>
				<tr>
					<td id="WC_UserLogoffView_TableCell_15"><img src="<c:out value="${jspStoreImgDir}" />images/logon_bottom.gif" alt="" width="600" height="19" border="0"/></td>
				</tr>
			</table>
		</td>
		<td width="40%" id="WC_UserLogoffView_TableCell_16">&nbsp;</td>
	</tr>
</table>
</body>
<!-- END UserLogoffView.jsp -->
</html>
