<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
--%>


<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="include/JSTLEnvironmentSetup.jspf" %>
<c:set var="flag" value="true" />
<c:set var="length" value="0" />
<c:set var="itemId" value="${WCParam.productId}" />
<c:set var="aucrfn" value="${WCParam.aucrfn}" />
<c:set var="fromAuction" value="${WCParam.fromAuction}" />

<c:if test="${ empty fromAuction }">
	<c:set var="flag" value="false" />
</c:if>
<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
	<c:set property="catalogEntryID" value="${itemId}" target="${item}" />
</wcbase:useBean>
<c:set var="shortDesc" value="${item.description.shortDescription}" />
<c:set var="longDesc" value="${item.description.longDescription}" />
<c:set var="fullImage" value="${item.description.fullImage}" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title><fmt:message key="itemDisplayTitle" bundle="${storeText}" /> - <c:out value="${shortDesc}" /></title>
<link rel="stylesheet" href='<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>' type="text/css" />
</head>

<body>
<%@ include file="include/LayoutContainerTop.jspf"%>
<table cellpadding="0" cellspacing="0" border="0" width="600" id="WC_auc_ItemDisplay_Table_1">
	
	<tbody>
		<tr>
			
			<td bgcolor="#FFFFFF" width="600" valign="top" id="WC_auc_ItemDisplay_TableCell_1"><!--MAIN CONTENT STARTS HERE-->

			<table cellpadding="2" cellspacing="0" width="580" border="0" id="WC_auc_ItemDisplay_Table_2">
				<tbody>
					<tr>
						<td width="10" rowspan="10" id="WC_auc_ItemDisplay_TableCell_2">&nbsp;</td>

						<td align="left" valign="top" width="580" colspan="2" id="WC_auc_ItemDisplay_TableCell_3">
						<font size="+1" color="#999900">
							<b><c:out value="${shortDesc}" /></b>
						</font>
						<hr width="580" noshade="noshade" align="left" />
						</td>
					</tr>

					<tr>
						<td align="left" valign="top" id="WC_auc_ItemDisplay_TableCell_4">
						<c:if test="${! empty fullImage  }">
							<img
								src='<c:out value="${item.objectPath}"/><c:out value="${fullImage}"/>'
								alt='<c:out value="${shortDesc}"/>' width="150" height="150"
								hspace="8" border="0" />
						</c:if>
						</td>

						<td align="left" valign="top" id="WC_auc_ItemDisplay_TableCell_5">
							<font color="#999900">
							<b><c:out value="${shortDesc}" /></b>
							</font> 
							<br />
							<br />
							<c:out value="${longDesc}" />						
							<br />
							<br />
						</td>
					</tr>

					<c:if test="${empty aucrfn}">
						<wcbase:useBean id="aidb" classname="com.ibm.commerce.negotiation.beans.AuctionInfoListBean">
							<c:set property="auctItem" value="${itemId}" target="${aidb}" />
							<c:set property="auctStoreId" value="${storeId}" target="${aidb}" />
						</wcbase:useBean>
						<c:set var="length" value="${aidb.auctionsNum}" />
						<c:forEach var="anAuctionInfoDataBean" items="${aidb.auctions}"
							begin="0" end="${length}" varStatus="aStatus">
							<c:set var="aucrfn" value="${anAuctionInfoDataBean.id}" />
						</c:forEach>
					</c:if>

					<tr>
						<td id="WC_auc_ItemDisplay_TableCell_6"></td>

						<td align="left" valign="top" id="WC_auc_ItemDisplay_TableCell_7">
						<table cellpadding="3" cellspacing="0" border="0" id="WC_auc_ItemDisplay_Table_3">
							<tbody>
								<tr>
									<td align="center" valign="middle" class="buttonStyle" id="WC_auc_ItemDisplay_TableCell_8">
									<font class="buttonStyle"> 
									<c:choose>
										<c:when test="${flag=='true'}">
											<a
												href='DisplayAuctionRules?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_auc_ItemDisplay_Link_1">
											<fmt:message key="itemAucRules" bundle="${storeText}" />
											</a>
										</c:when>
										<c:otherwise>
											<a
												href='AuctionHomeView?storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&aucrfn=<c:out value="${aucrfn}" />' id="WC_auc_ItemDisplay_Link_2">
											<fmt:message key="itemAucRules" bundle="${storeText}" />
											</a>
										</c:otherwise>
									</c:choose> 
									</font>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
				</tbody>
			</table>

			</td>
		</tr>
		
	</tbody>
</table>
<%@ include file="include/LayoutContainerBottom.jspf"%>

</body>
</html>



