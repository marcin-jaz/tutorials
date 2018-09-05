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
  * This JSP page displays the Header in all content pages that include the Layout Container JSP fragments.
  * The following elements are displayed:
  *  - Logo
  *  - Banner
  *  - 'Logoff' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>

<!-- BEGIN CachedHeaderDisplay.jsp -->

<table cellspacing="0" border="0" cellpadding="0" width="100%" id="WC_CachedHeaderDisplay_Table_2">
	<tbody>
	<tr>
		<td class="thickline" id="WC_CachedHeaderDisplay_TableCell_2"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="5" border="0"/></td>
	</tr>
	<tr>
		<td class="navline" id="WC_CachedHeaderDisplay_TableCell_3"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
	</tr>
	<tr>
		<td class="redline" id="WC_CachedHeaderDisplay_TableCell_4"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" width="2" height="1" border="0"/></td>
	</tr>
	<tr>
		<td id="WC_CachedHeaderDisplay_TableCell_5">
			<table cellspacing="0" border="0" cellpadding="0" width="100%" id="WC_CachedHeaderDisplay_Table_3">
				<tbody>
				<tr>
					<td id="WC_CachedHeaderDisplay_TableCell_6">
					<%-- 
					  ***
					  *	Start: Logo
					  * If a custom logo is being used, it is obtained from the Hosted Store home directory so that
					  * in a hosted environment, each Hosted Store can have its own unique logo. 
					  ***
					--%>
					<flow:ifEnabled feature="CustomLogo">
						<img alt="<c:out value="${storeName}" />" src="<c:out value="${storeImgDir}${vfileLogo}" />" align="middle"/>
					</flow:ifEnabled>
					<flow:ifDisabled feature="CustomLogo">
						<img alt="<c:out value="${storeName}" />" src="<c:out value="${jspStoreImgDir}${vfileLogo}" />" align="middle"/>
					</flow:ifDisabled>
					<%-- 
					  ***
					  *	End: Logo
					  ***
					--%>
					</td>
					<%-- Uncomment this to print out the store name
					<td class="title" id="WC_CachedHeaderDisplay_TableCell_7"><c:out value="${storeName}" /></td>
					--%>
					<td align="right" id="WC_CachedHeaderDisplay_TableCell_9">
					<%-- 
					  ***
					  *	Start: Banner
					  * If a custom banner is being used, it is obtained from the Hosted Store home directory so that
					  * in a hosted environment, each Hosted Store can have its own unique banner. 
					  ***
					--%>
					<flow:ifEnabled feature="CustomBanner">
						<img height="60" alt="" src="<c:out value="${storeImgDir}${vfileBanner}" />" border="0"/>
					</flow:ifEnabled>	
					<flow:ifDisabled feature="CustomBanner">
			        	<img height="60" alt="" src="<c:out value="${jspStoreImgDir}${vfileSelectedBanner}" />" border="0"/>
					</flow:ifDisabled>
					<%-- 
					  ***
					  *	End: Banner
					  ***
					--%>
					</td>
				</tr>
				</tbody>
			</table>
		</td>										
	</tr>
	<tr>
		<td class="thinline" id="WC_CachedHeaderDisplay_TableCell_11"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" height="1"/></td>
	</tr>
	<tr>
		<td id="WC_CachedHeaderDisplay_TableCell_12" height="21">
			<table cellspacing="0" border="0" cellpadding="0" id="WC_CachedHeaderDisplay_Table_4" width="100%">
				<tr>
					<td class="summary" id="WC_CachedHeaderDisplay_TableCell_13">
						&nbsp;
					</td>
					<td id="WC_CachedHeaderDisplay_TableCell_14" width="500" background="<c:out value="${jspStoreImgDir}${vfileColor}" />logoff_grad.gif">
						&nbsp;
					</td>
					<%-- 
					  ***
					  *	Start: 'Logoff' button
					  ***
					--%>
					<c:if test="${userState eq '1'}" >
					<td align="right" class="drkblu_bk" id="WC_CachedHeaderDisplay_TableCell_16">
						<c:url var="LogoffURL" value="Logoff">
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${storeId}" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:url>
						<a href="<c:out value="${LogoffURL}" />" class="logoff" id="WC_CachedHeaderDisplay_Link_10">
							<fmt:message key="Header_Logoff" bundle="${storeText}" />
						</a>
					</td>
					</c:if>
					<%-- 
					  ***
					  *	End: 'Logoff' button
					  ***
					--%>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="thinline" id="WC_CachedHeaderDisplay_TableCell_17"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />trans.gif" alt="" height="1"/></td>
	</tr>	
	</tbody>
</table>

<flow:ifEnabled feature="customerCare">
	<jsp:include page="../../CustomerCareHeaderSetup.jsp" flush="true" />
</flow:ifEnabled>

<!-- END CachedHeaderDisplay.jsp -->
