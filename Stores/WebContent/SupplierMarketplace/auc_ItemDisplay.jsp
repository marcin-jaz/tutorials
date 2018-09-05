<%--
/* 
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
 ////////////////////////////////////////////////////////////////////
 //
 // Change History:
 //
 // YYMMDD      F/D#        WHO        Description
 // -----------------------------------------------------------------
 //
 ////////////////////////////////////////////////////////////////////
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="/WEB-INF/flow.tld" prefix="flow" %>
<%@ include file="./include/JSTLEnvironmentSetup.jspf"%>

<c:if test="${CommandContext.sessionData != null}">
	<c:set var="sessionStoreId" value="${CommandContext.sessionData.storeId}" />
</c:if>
<c:if test="${sessionStoreId == null}">
	<c:set var="sessionStoreId" value="${CommandContext.storeId}" />
</c:if>
<c:set var="flag" value="true" />
<c:set var="length" value="0" />
<c:set var="itemId" value="${WCParam.productId}" />
<c:set var="aucrfn" value="${WCParam.aucrfn}" />
<c:set var="fromAuction" value="${WCParam.fromAuction}" />
<c:set var="auctionStoreId" value="${WCParam.auctionStoreId}" />
<c:if test="${empty fromAuction }">
	<c:set var="flag" value="false" />
</c:if>
<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean" >
	<c:set property="catalogEntryID" value="${itemId}" target="${item}" />
</wcbase:useBean>
<c:set var="shortDesc" value="${item.description.shortDescription}" />
<c:set var="longDesc" value="${item.description.longDescription}" />
<c:set var="fullImage" value="${item.description.fullImage}" />
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title><fmt:message key="AuctionItem_Title" bundle="${storeText}" /> - <c:out value="${shortDesc}" /></title>
	<link rel="stylesheet" href="<c:out value="${fileDir}" />ToolTech.css" type="text/css" />
</head>

<body>

<flow:ifEnabled feature="customerCare">
<%--Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>

	<%@ include file="include/LayoutContainerTop.jspf"%>


<table border="0" cellpadding="0" cellspacing="0" width="790" id="WC_AuctionItem_Table_1">
<tr>
	

	<td valign="top" width="630" id="WC_AuctionItem_TableCell_2">
  
   <!--MAIN CONTENT STARTS HERE-->
   
<table cellpadding="0" cellspacing="8" border="0" id="WC_AuctionItem_Table_2">
<tr>
      <td width="10" rowspan="10" id="WC_AuctionItem_TableCell_3">&nbsp;</td>
 
      <td align="left" valign="top" width="100%" colspan="2" id="WC_AuctionItem_TableCell_4">          
         <font size="+1" color=#999900>
         <b>
         	<c:out value="${shortDesc}" />
         </b>
         </font>
         <hr width="580" noshade="noshade" align="left"/>
      </td>
</tr>

<tr>
      <td align="left" valign="top" id="WC_AuctionItem_TableCell_5">
	      <c:if test="${! empty fullImage }">
			<img src="<c:out value="${fullImage}"/>" alt="<c:out value="${shortDesc}"/>" width="150" height="150" hspace="8" border="0" />
	      </c:if>
      </td>      

      <td align="left" valign="top" id="WC_AuctionItem_TableCell_6">
         <font color=#999900><b><c:out value="${shortDesc}"/></b></font>
         <br /><br />
         <c:out value="${longDesc}"/>
         <br /><br /><br />
      </td>
</tr>

	<c:if test="${empty aucrfn }">
		<wcbase:useBean id="aidb" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean" >
			<c:set property="auctItem" value="${itemId}" target="${aidb}" />
		</wcbase:useBean>
		<c:set var="length" value="aidb.auctionsNum" />	
		<c:forEach var="anAuctionInfoDataBean" items="${aidb.auctions}" begin="0" end="${length}" varStatus="aStatus">
			<c:set var="aucrfn" value="${anAuctionInfoDataBean.Id}" />
			<c:set var="aucStoreId" value="${anAuctionInfoDataBean.storeId}" />
		</c:forEach>
	</c:if>
<tr>
      
      <td align="left" valign="top" id="WC_AuctionItem_TableCell_7">
         <table cellpadding="3" cellspacing="0" border="0" id="WC_AuctionItem_Table_3">
            <tr>
               <td align="center" valign="middle" class="buttonStyle" id="WC_AuctionItem_TableCell_8">
				<font class="buttonStyle">
					<c:choose>
						<c:when test="${flag==true}">
		                     <a href="DisplayAuctionRules?aucrfn=<c:out value="${aucrfn}" />&auctionStoreId=<c:out value="${auctionStoreId}" />" id="WC_AuctionItem_Link_1">
			                     <fmt:message key="AuctionItem_AucRules" bundle="${storeText}" />
	        		         </a>
						</c:when>
						<c:otherwise>
		                     <a href="AuctionHomeView?aucrfn=<c:out value="${aucrfn}" />&storeId=<c:out value="${sessionStoreId}" />" id="WC_AuctionItem_Link_2">
			                     <fmt:message key="AuctionItem_AucRules" bundle="${storeText}" />
	        		         </a>
						</c:otherwise>
					</c:choose>
				</font>
               </td>
            </tr>
         </table>
      </td>
</tr>
</table>     




	</td>
</tr>
</table>

<%@ include file="include/LayoutContainerBottom.jspf"%>
</body>
</html>

