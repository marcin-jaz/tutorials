<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
%> 
<%--
  *****
  * This JSP page displays a list of comments and input fields to 
  * modify the comments of an RFQ product.
  *
  * Elements:  
  * - Add Comment button
  * - Return to Modify RFQ button
  * 
  * Imports:
  * - RFQModifyCommentDisplay_Row.jsp
  *
  * Required parameters:
  * - offering_id
  * - rfqprod_id
  * - catentryid
  * - productId
  * - catalogId
  * - storeId
  * - langId
  *
  *****
--%>
<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="../RFQModifyConstants.jspf" %>

<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="rfqId" value="${WCParam.offering_id}" scope="request" />
<c:set var="catId" value="${WCParam.catentryid}" scope="request" />
<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />
<c:set var="productId" value="${WCParam.productId}" />
 
<c:set var="returnToCatalog" value="" />
<c:set var="catalogButtonText" value="" />


<c:choose> 
<c:when test="${!empty productId}" >
	<c:set var="returnToCatalog" value="ProductDisplay?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}&productId=${productId}" />
	<fmt:message key="RFQList_Button_CatalogReturn" bundle="${storeText}" var="catalogButtonText" />
</c:when>
<c:otherwise>
	<c:set var="returnToCatalog" value="TopCategoriesDisplay?storeId=${storeId}&langId=${langId}&catalogId=${catalogId}" />
	<fmt:message key="RFQList_Button_Catalog" bundle="${storeText}" var="catalogButtonText" />
</c:otherwise>
</c:choose>

<wcbase:useBean id="rfqProduct"
	classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
	<jsp:setProperty property="*" name="rfqProduct"/>
	<c:set target="${rfqProduct}" property="RFQProdId" value="${rfqprodId}" />
	
</wcbase:useBean>
<c:set var="pcomment" value="${rfqProduct.productCommentsForProduct}" scope="request" />

 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQModifyCommentDisplay_Title" bundle="${storeText}"  /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript" src="<c:out value="${jspStoreImgDir}" />javascript/Util.js">
</script>
<script language="javascript">
	function submitUpdateAttachment(form)
	{
		for (var i = 0; i < form.numComment.value; i++) {
			var name = 'value_' + (i + 1);
			if (form[name].value=='') {
				error("<fmt:message key="RFQModifyCommentDisplay_Error1" bundle="${storeText}" />");

				return;
			}
                	else if (!isValidUTF8length(form[name].value, 254))
                	{
                 	       error("<fmt:message key="msgInvalidSize254" bundle="${storeText}" />");
                 	       return;
                	}
		}
		form.submit()
	}
	function error(errMsg)
	{
		alert(errMsg);
	}

</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

	<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQModifyCommentDisplay_Table_1">

		<tr>
			<td valign="top" width="630" id="WC_RFQModifyCommentDisplay_TableCell_2">

				<table cellpadding="2" cellspacing="0" width="600" border="0"  id="WC_RFQModifyCommentDisplay_Table_2">
					<tbody><tr>
			            <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQModifyCommentDisplay_TableCell_3">
							<h1><fmt:message key="RFQModifyCommentDisplay_RFQComment" bundle="${storeText}"/></h1>
							<fmt:message key="RFQExtra_ModComment" bundle="${storeText}"  />							
						</td>
					</tr>
					<tr>
						<td  valign="top" width="400" class="topspace" id="WC_RFQModifyCommentDisplay_TableCell_4">	<br />

							<form name="RFQModifyCommentForm" action="RFQItemCommentUpdate" method="post" id="RFQModifyCommentForm">
							<input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifyCommentDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_RFQModifyCommentForm_1"/>
							<input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}" />" value="<c:out value="${catId}" />" id="WC_RFQModifyCommentDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}" />_In_RFQModifyCommentForm_1"/>
							<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyCommentDisplay_FormInput_langId_In_RFQModifyCommentForm_1"/>
							<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyCommentDisplay_FormInput_storeId_In_RFQModifyCommentForm_1"/>
							<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyCommentDisplay_FormInput_catalogId_In_RFQModifyCommentForm_1"/>

							<table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_RFQModifyCommentDisplay_Table_3">
								<tr>
									<td id="WC_RFQModifyCommentDisplay_TableCell_5">
										<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQModifyCommentDisplay_Table_4">
							  			<tbody>
											<tr>
												<th id="a1" valign="top" class="colHeader" id="WC_RFQModifyCommentDisplay_TableCell_6"><fmt:message key="RFQModifyCommentDisplay_Type" bundle="${storeText}"  /></th>
												<th id="a2" valign="top" class="colHeader" id="WC_RFQModifyCommentDisplay_TableCell_7"><fmt:message key="RFQModifyCommentDisplay_Comment" bundle="${storeText}"  /></th>
												<th id="a3" valign="top" class="colHeader" id="WC_RFQModifyCommentDisplay_TableCell_8"><fmt:message key="RFQModifyCommentDisplay_Man" bundle="${storeText}"  /></th>
												<th id="a4" valign="top" class="colHeader" id="WC_RFQModifyCommentDisplay_TableCell_9"><fmt:message key="RFQModifyCommentDisplay_Change" bundle="${storeText}"  /></th>
												<th id="a5" valign="top" class="colHeader_last" id="WC_RFQModifyCommentDisplay_TableCell_10">&nbsp;</th>
											</tr>
											
											<%--iterate  through list of ProductCommentsForProduct--%>
											<c:set var="color" value="cellBG_2" />
											<c:forEach var="aComment" items="${pcomment}" begin="0"	varStatus="iter">
												
												<c:choose>
													<c:when test="${color eq 'cellBG_1'}" >
														<c:set var="color" value="cellBG_2" />
													</c:when>
													<c:otherwise>
														<c:set var="color" value="cellBG_1" />
													</c:otherwise>
												</c:choose> 
												<tr class="<c:out value="${color}" />">
													<%--include file RFQProductDisplay_Comments_Row.jsp--%>
													<% out.flush(); %>
													<c:import url="RFQModifyCommentDisplay_Row.jsp">
														<c:param name="index" value="${iter.index}" />
													</c:import>
													<% out.flush(); %>
												</tr>
											</c:forEach>
											<%--end iterate  through list of ProductCommentsForProduct--%>
											<c:if test="${empty pcomment}"> 
												<tr class="cellBG_1">
													<td  valign="top" colspan="5" class="categoryspace t_td" id="WC_RFQModifyCommentDisplay_TableCell_11" ><fmt:message key="RFQModifyCommentDisplay_NoComment" bundle="${storeText}" /></td>
												</tr>
											</c:if>		
											
							  			</tbody>
										</table>
									</td>
								</tr>
							</table>
                   	
							<input type="hidden" name="numComment" value="<c:out value="${requestScope.numComment}" />" id="WC_RFQModifyCommentDisplay_FormInput_numComment_In_RFQModifyCommentForm_1"/>
							<input type="hidden" name="URL" value="RFQModifyCommentDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&;<c:out value="${requestScope.parmList}" />" id="WC_RFQModifyCommentDisplay_FormInput_URL_In_RFQModifyCommentForm_1"/>
							</form>

						</td>
					</tr> 

<tr>
<td id="WC_RFQModifyCommentDisplay_TableCell_17" width="700">

			<table id="WC_RFQModifyCommentDisplay_Table_10" width="700">
			<tr >

<!-- Start display for button "RFQModifyCommentDisplay_Add" -->
<td height="41"  id="WC_RFQModifyCommentDisplay_TableCell_18" >
<a class="button" href="RFQModifyAddCommentDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyCommentDisplay_Link_2"> &nbsp; <fmt:message key="RFQModifyCommentDisplay_Add" bundle="${storeText}" /> &nbsp;
</a>
&nbsp;
<!-- End display for button ... -->
 
<c:if test="${!empty pcomment}">	
<!-- Start display for button "RFQModifyCommentDisplay_Update" -->

<a class="button" href="javascript:submitUpdateAttachment(document.RFQModifyCommentForm)" id="WC_RFQModifyCommentDisplay_Link_3">	&nbsp; <fmt:message key="RFQModifyCommentDisplay_Update" bundle="${storeText}" /> &nbsp;
</a>
&nbsp;
<!-- End display for button ... -->
</c:if>						

<!-- Start display for button "RFQModifyCommentDisplay_Return" -->

<a class="button" href="RFQModifyDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyCommentDisplay_Link_4"> &nbsp; <fmt:message key="RFQModifyCommentDisplay_Return" bundle="${storeText}" /> &nbsp;
</a>
</td>
<!-- End display for button ... -->

			</tr>
			</table>

</td>
</tr>
				</tbody>
				</table>
<!--FINISH MAIN CONTENT-->
			</td>
		</tr>
	</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
	</body>
</html>



