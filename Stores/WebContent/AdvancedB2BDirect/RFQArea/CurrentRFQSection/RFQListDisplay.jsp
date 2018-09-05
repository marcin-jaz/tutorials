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
  * This JSP page displays the current user's RFQ list.
  *
  * Elements:  
  * - list of RFQs
  * - Go search button
  * - Create RFQ button
  * - Find RFQ button
  *
  * Imports:
  * - CommonSection/RFQPageNavigation.jsp
  * - RFQListDisplay_RFQ_Row.jsp
  *
  * Required parameters:
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

<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

    <c:choose>
	<c:when test="${langId <= -7 and langId >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
    </c:choose> 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title><fmt:message key="RFQListDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio" />
</head>

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>

<!--START MAIN CONTENT-->
<table border="0" cellpadding="8" cellspacing="0" width="790" id="WC_RFQListDisplay_Table_1">
    <tr>
	<td id="WC_RFQListDisplay_TableCell_1">	
	<form method="get" action="RFQFindResultDisplay" name="RFQSearchForm" id="RFQSearchForm">
	<input type="hidden" name="searchType" value="state" id="WC_RFQListDisplay_FormInput_searchType_In_RFQSearchForm_1" /> 
	<input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id=" WC_RFQListDisplay_FormInput_storeId_In_RFQSearchForm_1"/>
	<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQListDisplay_FormInput_langId_In_RFQSearchForm_1" /> 
	<input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQListDisplay_FormInput_catalogId_In_RFQSearchForm_1" />

	<table cellpadding="0" cellspacing="0" width="850" border="0" id="WC_RFQListDisplay_Table_2">
	<tbody>
	    <tr>
		<td width="10" rowspan="6" id="WC_RFQListDisplay_TableCell_3">&nbsp;</td>		
		<td valign="top" colspan="10" class="categoryspace" id="WC_RFQListDisplay_TableCell_4">
		    <h1><fmt:message key="RFQListDisplay_RFQList" bundle="${storeText}" /></h1>
		</td>
	    </tr>

	    <tr>
		<td id="WC_RFQListDisplay_TableCell_5">
	      
               <label for="WC_RFQListDisplay_Select_1"> 
                <fmt:message key="RFQModifyDisplay_Status" bundle="${storeText}" />
		</td>
	    </tr>

	    <tr valign="middle"> 
		<td width="1%" id="WC_RFQListDisplay_TableCell_6">
		   
			<select name="status" id="WC_RFQListDisplay_Select_1">
			    <option value=""><fmt:message key="RFQExtra_All" bundle="${storeText}" /></option>
			    <option value="<c:out value="1" />"><fmt:message key="RFQFind_Active" bundle="${storeText}" /></option>
			    <option value="<c:out value="5" />"><fmt:message key="RFQFind_Draft" bundle="${storeText}" /></option>
			    <option value="<c:out value="2" />"><fmt:message key="RFQFind_Canceled" bundle="${storeText}" /></option>
			    <option value="<c:out value="3" />"><fmt:message key="RFQFind_Closed" bundle="${storeText}" /></option>
			    <option value="<c:out value="4" />"><fmt:message key="RFQFind_Complete" bundle="${storeText}" /></option>
			    <option value="<c:out value="6" />"><fmt:message key="RFQFind_Future" bundle="${storeText}" /></option>
			    <option value="<c:out value="16" />"><fmt:message key="RFQFind_NextRound" bundle="${storeText}" /></option>
			</select> 
		    </label>
		</td>
				
		<td width="1%" id="WC_RFQListDisplay_TableCell_7">&nbsp;</td>
				
		<!-- Start display for Search "Go" button -->
		<td <c:out value="${wrap}" /> width="120" height="41" id="WC_RFQListDisplay_TableCell_8">
		    <a class="button" href="javascript:document.RFQSearchForm.submit()" id="WC_RFQListDisplay_Link_1">
			<fmt:message key="RFQListDisplay_Go" bundle="${storeText}" /> 
		    </a>
		</td>
		<!-- End display for Search "Go" button -->

		<td align="right" id="WC_RFQListDisplay_TableCell_9">	
		    <wcbase:useBean id="rfq" classname="com.ibm.commerce.utf.beans.RFQListBean" scope="page">					
			<jsp:setProperty property="*" name="rfq" />
			<c:set var="pageSize" value="10" />
			<c:set var="initPos" value="0" />
			<c:set var="numPages" value="10" />					 
			<c:if test="${!empty WCParam.pageSize}">
			    <c:set var="pageSize" value="${WCParam.pageSize}" />
			</c:if>
			<c:if test="${!empty WCParam.initPos}">
			    <c:set var="initPos" value="${WCParam.initPos}"  />
			</c:if>
			<c:set target="${rfq}" property="size" value="${pageSize}" />
			<c:set target="${rfq}" property="initialPosition" value="${initPos}" />
			<c:set target="${rfq}" property="storeId" value="${storeId}" />
			<c:set target="${rfq}" property="ownerId" value="${userId}" />					
		    </wcbase:useBean> 
				
		    <c:set var="rlist" value="${rfq.RFQs}" scope="request" />

		    <%-- set variables for RFQPageNavigation.jsp --%>
		    <c:set var="numRec" value="${rfq.rowCount}" />
		    <c:set var="linkAction" value="RFQListDisplay" scope="page" />
		    <c:set var="URL" value="" scope="page" />
				
		    <%-- Display navigation to next/previous page --%>
		    <% out.flush(); %>
		    <c:import url="../CommonSection/RFQPageNavigation.jsp" >
		        <c:param name="numRec" value="${numRec}" />
			<c:param name="initPos" value="${initPos}" />
			<c:param name="pageSize" value="${pageSize}" />
			<c:param name="numPages" value="${numPages}" />
		    </c:import>
		    <% out.flush(); %>
		    <%-- End Display navigation to next/previous page --%>
                </td>
                        
		<td id="WC_RFQListDisplay_TableCell_10"></td>
            </tr>

     	    <tr>
                <td  valign="top" class="topspace" colspan="5" id="WC_RFQListDisplay_TableCell_11"><br />
                <table cellpadding="0" cellspacing="0" border="0" class="bgColor" id="WC_RFQListDisplay_Table_3">
                <tbody>
                    <tr></tr>
                    <tr>
                         <td id="WC_RFQListDisplay_TableCell_12">
                         <table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQListDisplay_Table_4">
                         <tbody>
                             <tr>
                                <th id="a1" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_13"><fmt:message key="RFQListDisplay_Name" bundle="${storeText}"/></th>
                                <th id="a2" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_14"><fmt:message key="RFQListDisplay_Description" bundle="${storeText}"/></th>
                                <th id="a3" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_15"> <fmt:message key="RFQListDisplay_Status" bundle="${storeText}"/></th>
                                <th id="a4" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_16"><fmt:message key="AddToExistRFQList_Rounds" bundle="${storeText}"/></th>
				<th id="a5" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_17"><fmt:message key="RFQListDisplay_Create_time" bundle="${storeText}"/></th>
				<th id="a6" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_18"> <fmt:message key="RFQListDisplay_Submit_date" bundle="${storeText}"/></th>
                                <th id="a7" class="colHeader" <c:out value="${wrap}" /> id="WC_RFQListDisplay_TableCell_19"><fmt:message key="RFQListDisplay_Close_date" bundle="${storeText}"/></th>
                                <th id="a8" class="colHeader_last" id="WC_RFQListDisplay_TableCell_20"></th>
                   	    </tr>
                   		
			<!--iterate through rfq list-->
			<c:set var="color" value="cellBG_2" />
			<c:forEach var="rfqBean" items="${rlist}" begin="0" varStatus="iter">
			  <c:if test="${rfqBean.storeIdInEJBType eq storeId}">
			    <c:set var="rfqBean" value="${rfqBean}" scope="request" />	
			
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
				<c:import url="RFQListDisplay_RFQ_Row.jsp" >
				    <c:param name="index" value="${iter.index}" /> 
				</c:import>
				<% out.flush(); %>
			    </tr> 
			    </c:if>
			</c:forEach>
			<!--end iterate through rfq list-->	

			<c:if test="${empty rlist}">
		            <tr class="cellBG_1">
		                <td  valign="top" colspan="8" class="categoryspace t_td" id="WC_RFQListDisplay_TableCell_30"><fmt:message key="RFQListDisplay_NoRFQ" bundle="${storeText}"/></td>
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
                <td align="right" colspan="5" id="WC_RFQListDisplay_TableCell_31">
		    <%-- Display navigation to next/previous page --%>
		    <% out.flush(); %>
		    <c:import url="../CommonSection/RFQPageNavigation.jsp" >
			<c:param name="numRec" value="${numRec}" />
			<c:param name="initPos" value="${initPos}" />
			<c:param name="pageSize" value="${pageSize}" />
			<c:param name="numPages" value="${numPages}" />
		    </c:import>
		    <% out.flush(); %>
		    <%-- End Display navigation to next/previous page --%>
                </td>
            </tr>

            <tr>
                <td colspan="5" id="WC_RFQListDisplay_TableCell_32">
                <table cellpadding="0" cellspacing="0" id="WC_RFQListDisplay_Table_12">
                <tbody>
                    <tr>
                       	<td id="WC_RFQListDisplay_TableCell_33">
			<table id="WC_RFQListDisplay_Table_13">
			<tbody>
			    <tr>
				<!-- Start display for Search "CreateRFQ" button -->
				<td height="41" id="WC_RFQListDisplay_TableCell_34">
				    <c:url var="RFQCreateDisplayHref" value="RFQCreateDisplay">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />	
				    </c:url>
				    <a class="button" href="<c:out value="${RFQCreateDisplayHref}"/>" id="WC_RFQListDisplay_Link_26"> &nbsp; <fmt:message key="RFQListDisplay_Create" bundle="${storeText}"/> &nbsp; </a>
				</td>
				<!-- End display for Search "CreateRFQ" button -->
				
				<td id="WC_RFQListDisplay_TableCell_35">&nbsp;</td>
				
				<!-- Start display for Search "FindRFQ" button -->
				<td height="41" id="WC_RFQListDisplay_TableCell_36">
				    <c:url var="RFQFindDisplayHref" value="RFQFindDisplay">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />	
				    </c:url>
				    <a class="button" href="<c:out value="${RFQFindDisplayHref}"/>" id="WC_RFQListDisplay_Link_27"> &nbsp;<fmt:message key="RFQListDisplay_Find" bundle="${storeText}"/> &nbsp; </a>
				</td>
				<!-- End display for Search "FindRFQ" button -->
			    </tr>
			</tbody>
			</table>
                    	</td>
                    </tr>
                </tbody>
                </table>
                </td>
            </tr>

            <tr><td colspan="3" id="WC_RFQListDisplay_TableCell_37">&nbsp;</td></tr>    
        
	</tbody>
	</table>
	</form> 
      	</td>
    </tr>
</table>    
<!--FINISH MAIN CONTENT-->
        
<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body>
</html>
