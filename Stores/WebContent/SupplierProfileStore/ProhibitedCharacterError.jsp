<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%-- 
  *****
  * This JSP displays error message when trying to execute some URL that is found to be
  * harmful to the server.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="PROHIBITEDCHAR_ERROR_TITLE" bundle="${storeText}" /></title>
	<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css"/>
</head>

<body class="logon">
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
	
	<!-- JSP File Name:  ProhibitedCharacterError.jsp -->
	
	<!--MAIN CONTENT STARTS HERE-->

						<fmt:message key="PROHIBITEDCHAR_ERROR_DESC" bundle="${storeText}" />
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_3">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_3">
						<fmt:message key="PROHIBITEDCHAR_ERROR_BACK_DESC" bundle="${storeText}" />
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_3">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td valign="top" id="WC_ProhibitedCharacterError_TableCell_4">
						<a href="javascript:history.back(1)" class="button" id="WC_ProhibitedCharacterError_Link_1">
        			<fmt:message key="PROHIBITEDCHAR_ERROR_BACK" bundle="${storeText}"/>
        		</a>

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

</body>
</html>
