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
  * This JSP page displays RFQ products classified under a specific
  * RFQ category.
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQCategoryDisplay_ProductInfo_Row.jsp
  *
  * Required parameters:
  * - offering_id
  * - rfqCategoryId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<c:set var="rfqId" value="${WCParam.offering_id}" />
<c:set var="rfqCategoryId" value="${WCParam.rfqCategoryId}" />

            
<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request" >
	<jsp:setProperty property="*" name="rfqBean"/>
	<c:set target="${rfqBean}" property="rfqId" value="${rfqId}" />	
</wcbase:useBean>

<% out.flush(); %>
<c:import url="../CommonSection/RFQSetup.jsp" />
<% out.flush(); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQCategoryDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />

<script language="javascript">
	function submitDuplicate(form)
	{
		if (form.newRfqName.value=='') 
		{
			error('<fmt:message key="RFQDisplay_Err_1" bundle="${storeText}" />');
			return;
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
<%@ include file="../../include/LayoutContainerTop.jspf"%>
     

<fmt:message key="RFQExtra_NotCategorized" bundle="${storeText}" var="rfqCategoryName" />

<c:set var="rfqCategoryName" />
<fmt:message key="RFQExtra_NotCategorized" bundle="${storeText}" var="rfqCategoryName" />
<c:if test="${rfqCategoryId != null && !empty rfqCategoryId}" >
	<wcbase:useBean id="rfqCategoryAB" classname="com.ibm.commerce.rfq.beans.RFQCategryDataBean">
		<c:set target="${rfqCategoryAB}" property="initKey_rfqCategryId" value="${rfqCategoryId}" />
		<c:set var="rfqCategoryName" value="${rfqCategoryAB.name}" />
	</wcbase:useBean>
</c:if>


            <table cellpadding="2" cellspacing="0" width="100%" border="0" id="WC_RFQCategoryDisplay_Table_1">
                <tbody>
                    <tr>
                        <td rowspan="3" id="WC_RFQCategoryDisplay_TableCell_1" >&nbsp;</td>
                        <td  valign="top" colspan="3" class="categoryspace" id="WC_RFQCategoryDisplay_TableCell_2" >
                        <h1><fmt:message key="RFQCategoryDisplay_Category" bundle="${storeText}" /></h1>
                        <h2><fmt:message key="RFQCategoryDisplay_General" bundle="${storeText}" /></h2>
                        <fmt:message key="RFQCategoryDisplay_Name" bundle="${storeText}" />&nbsp;&nbsp;<c:out value="${rfqBean.name}" /><br />
                        <fmt:message key="RFQCategoryDisplay_Category_Name" bundle="${storeText}" />&nbsp;&nbsp;<c:out value="${rfqCategoryName}" /><br />

                        </td>
                    </tr>

                    <tr>
                        <td  valign="top" width="100%" class="topspace" id="WC_RFQCategoryDisplay_TableCell_3" >
                        <h2><fmt:message key="RFQCategoryDisplay_ProductInfo" bundle="${storeText}" /></h2>
                        
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="bgColor" id="WC_RFQCategoryDisplay_Table_2">
                            <tbody>
                                <tr>
                                    <td id="WC_RFQCategoryDisplay_TableCell_4">
                                    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQCategoryDisplay_Table_3">
                                        <tbody>
                                            <tr>
                                                <th id="a1" valign="top" class="colHeader" id="WC_RFQCategoryDisplay_TableCell_5"><fmt:message key="RFQCategoryDisplay_ProductInfo_Name" bundle="${storeText}" /></th>
						<th id="a2" valign="top" class="colHeader" id="WC_RFQCategoryDisplay_TableCell_6"><fmt:message key="RFQCategoryDisplay_ProductInfo_Desc" bundle="${storeText}" /></th>
						<th id="a3" class="colHeader" id="WC_RFQCategoryDisplay_TableCell_7"><fmt:message key="RFQDisplay_Product_Type" bundle="${storeText}" /></th>
                                  <c:if test="${requestScope.isContract}">
	                                        <th id="a4" class="colHeader_price" id="WC_RFQCategoryDisplay_TableCell_8"><fmt:message key="RFQModifyDisplay_Product_Offer_Price" bundle="${storeText}" /></th>                
						<th id="a5" class="colHeader" id="WC_RFQDisplay_TableCell_42"><fmt:message key="RFQDisplay_Product_PPAdjust" bundle="${storeText}" /></th>   
                                   </c:if>
						<th id="a6" class="colHeader_price" id="WC_RFQCategoryDisplay_TableCell_9"><fmt:message key="RFQCategoryDisplay_ProductInfo_Price" bundle="${storeText}" /></th>
						<th id="a7" valign="top" class="colHeader" id="WC_RFQCategoryDisplay_TableCell_10"><fmt:message key="RFQCategoryDisplay_ProductInfo_Currency" bundle="${storeText}" /></th>
						<th id="a8" valign="top" class="colHeader" id="WC_RFQCategoryDisplay_TableCell_11"><fmt:message key="RFQCategoryDisplay_ProductInfo_Quantity" bundle="${storeText}" /></th>
						<th id="a9" valign="top" class="colHeader" id="WC_RFQCategoryDisplay_TableCell_12"><fmt:message key="RFQCategoryDisplay_ProductInfo_Unit" bundle="${storeText}" /></th>
						<th id="a10" valign="top" class="colHeader_last" id="WC_RFQCategoryDisplay_TableCell_13"><fmt:message key="RFQDisplay_Product_Substitutable" bundle="${storeText}" /></th>
                                             </tr>

                           
                                         <wcbase:useBean id="prodList" classname="com.ibm.commerce.utf.beans.RFQProdListBean">
                                            <jsp:setProperty property="*" name="prodList"/>
                                            <c:set target="${prodList}" property="RFQId" value="${rfqId}" />
	                                            <c:choose>
	                                            	<c:when test="${rfqCategoryId != null}">
	                                            		<c:set target="${prodList}" property="RFQCategoryId" value="${rfqCategoryId}" />
	                                            	</c:when>
	                                            	<c:otherwise>
	                                            		<c:set target="${prodList}" property="RFQCategoryId" value="null" />
	                                            	</c:otherwise>
	                                            </c:choose>	                                           
                                          </wcbase:useBean>
						<c:set var="pList" value="${prodList.RFQProds}" scope="request" />
						

						<c:set var="color" value="cellBG_2" />
						<c:forEach var="product" items="${pList}" begin="0" varStatus="iter">
							<c:choose>
								<c:when test="${color eq 'cellBG_1'}">
									<c:set var="color" value="cellBG_2" />
								</c:when>
								<c:when test="${color eq 'cellBG_2'}">
									<c:set var="color" value="cellBG_1" />
								</c:when>
							</c:choose>
							
							<tr class="<c:out value="${color}" />">
								<% out.flush(); %>
								<c:import url="RFQCategoryDisplay_ProductInfo_Row.jsp">
									<c:param name="rfqId" value="${rfqId}" />
									<c:param name="index" value="${iter.index}" />
								</c:import>
								<% out.flush(); %>
							</tr> 
						</c:forEach>


						<c:if test="${empty pList}">
                            <tr class="cellBG_1">
                                <td  valign="top" colspan="10" class="categoryspace t_td" id="WC_RFQCategoryDisplay_TableCell_14"><fmt:message key="RFQCategoryDisplay_NoProduct" bundle="${storeText}" /></td>
                            </tr>
						</c:if>
                                        </tbody>
                                    </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>


                    <tr>
                        <td id="WC_RFQCategoryDisplay_TableCell_15">
                        <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQCategoryDisplay_Table_15">
                            <tbody>
                                <tr>                                                               
                                    

									<c:url var="RFQDisplayHref" value="RFQDisplay" >
										<c:param name="offering_id" value="${rfqId}" />
										<c:param name="langId" value="${langId}" />
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
									</c:url>
									<td height="41" id="WC_RFQCategoryDisplay_TableCell_16">
									<a class="button" href="<c:out value="${RFQDisplayHref}" />" > &nbsp; <fmt:message key="RFQCategoryDisplay_Ok" bundle="${storeText}" />
									</a>
									</td>			

                                    <td id="WC_RFQCategoryDisplay_TableCell_17">&nbsp;</td>

                                </tr>
                            </tbody>
                        </table>
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQCategoryDisplay_TableCell_18">&nbsp;</td>
                    </tr>
                </tbody>
            </table>



<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>







