<%
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
%>
<%--
  *****
  * This JSP page displays input fields to add a comment to an RFQ product.
  *
  * Elements:
  * - Type selection box
  * - Add button
  * - Cancel button
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




<c:set var="catalogId" value="${WCParam.catalogId}" />
<c:set var="rfqId" value="${WCParam.offering_id}" scope="request" />
<c:set var="catId" value="${WCParam.catentryid}" scope="request" />
<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />


<c:set var="EC_OFFERING_ITEMBEAN" value="ItemBean" scope="request" />
<c:set var="EC_OFFERING_PRODUCTBEAN" value="ProductBean" scope="request" />
<c:set var="EC_OFFERING_PACKAGEBEAN" value="PackageBean" scope="request" />
<c:set var="EC_OFFERING_DYNAMICKITBEAN" value="DynamicKitBean" scope="request" />
<c:set var="EC_ATTR_MANDATORY" value="mandatory" scope="request" />
<c:set var="EC_ATTR_VALUE" value="value" scope="request" />
<c:set var="EC_ATTR_CHANGEABLE" value="changeable" scope="request" />
<c:set var="EC_RFQ_PRODUCT_ID" value="rfqprod_id" scope="request" />
<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />
<c:set var="EC_ATTR_ID" value="attr_id" scope="request" />
<c:set var="EC_OFFERING_CATENTRYID" value="catentryid" scope="request" />
<c:set var="EC_ATTR_NAME" value="name" scope="request" />
<c:set var="EC_ATTRTYPE_FREEFORM" value="FREEFORM" scope="request" />
<c:set var="EC_UTF_OPTIONAL" value="0" scope="request" />
<c:set var="EC_UTF_NON_CHANGEABLE" value="0" scope="request" />
<c:set var="EC_RFQ_PRODUCT_ID" value="rfqprod_id" scope="request" />



<c:set var="checked" value="" />
<c:set var="itemName" value="" />

<c:set var="strComment" value="" />
<c:set var="isRequired" value="1" />
<c:set var="isChangeable" value="1" />

<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="itemName" />

		<wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
			<jsp:setProperty property="*" name="rfqProduct"/>
			<c:set target="${rfqProduct}" property="RFQProdId" value="${rfqprodId}" />
			
		</wcbase:useBean>
		<c:set var="attributesList" value="${rfqProduct.allAttributes}"  scope="request" />
		
<c:if test="${empty catId or catId eq ''}" >
		
		<c:set var="catId" value="${rfqProduct.RFQProdCatentryId}"  scope="request" />
</c:if>
	 

<c:if test="${!empty catId}" >
	<wcbase:useBean id="ceDB"
		classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<c:set target="${ceDB}" property="catalogEntryID" value="${catId}" />
		
	</wcbase:useBean>

	<c:choose>
		<c:when test="${ceDB.type eq EC_OFFERING_ITEMBEAN}">
			<fmt:message key="RFQModifyDisplay_Item" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}">
			<fmt:message key="RFQModifyDisplay_Product" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}">
			<fmt:message key="RFQModifyDisplay_Prebuilt_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:when test="${ceDB.type eq EC_OFFERING_DYNAMICKITBEAN}">
			<fmt:message key="RFQModifyDisplay_Dynamic_Kit" bundle="${storeText}" var="type"/>
		</c:when>
		<c:otherwise>
			<c:set var="type" value="${ceDB.type}" />
		</c:otherwise>
	</c:choose>
	
	<c:if test="${ceDB.type eq EC_OFFERING_ITEMBEAN}" >
		<wcbase:useBean id="iDB" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request" >	
			<c:set target="${iDB}" property="initKey_catalogEntryReferenceNumber" value="${catId}" />
			<c:set target="${iDB}" property="itemID" value="${catId}" />			
		</wcbase:useBean>	
		<c:set var="itemName" value="${iDB.description.name}"  /> 
	</c:if>	
	<c:if test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}" >
		<wcbase:useBean id="pkDB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
			<c:set target="${pkDB}" property="initKey_catalogEntryReferenceNumber" value="${catId}" />
			<c:set target="${pkDB}" property="packageID" value="${catId}" />				
		</wcbase:useBean>
		<c:set var="itemName" value="${pkDB.description.name}" />	
	</c:if>	
	<c:if test="${ceDB.type eq EC_OFFERING_PRODUCTBEAN}" >
		<wcbase:useBean id="pDB"
			classname="com.ibm.commerce.catalog.beans.ProductDataBean">
			<c:set target="${pDB}" property="initKey_catalogEntryReferenceNumber" value="${catId}" />
			<c:set target="${pDB}" property="productID" value="${catId}" />			
		</wcbase:useBean>
		<c:set var="itemName" value="${pDB.description.name}"  />
	</c:if>
</c:if>	 

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>


<c:if test="${bnError.exceptionType != null}">
	<c:set var="strErrorMessage" value="${bnError.message}" />	
	<c:choose>
	<c:when test="${bnError.messageKey eq '_ERR_CMD_INVALID_PARAM'}" >
		<c:set var="strMessageParams" value="${bnError.messageParam}" />		
		<c:set var="strComment" value="${param[EC_ATTR_VALUE]}" />
		<c:set var="isRequired" value="${param[EC_ATTR_MANDATORY]}" />
		<c:set var="isChangeable" value="${param[EC_ATTR_CHANGEABLE]}" />		
	</c:when> 
	<c:otherwise>
		<c:set var="strComment" value="" />
		<c:set var="isRequired" value="" />
		<c:set var="isChangeable" value="" />		
	</c:otherwise>
	</c:choose>
	
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">

<head>

<title><fmt:message key="RFQModifyAddCommentDisplay_Title" bundle="${storeText}"  /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript" src="<c:out value="${jspStoreImgDir}" />javascript/Util.js">
</script>
<script language="javascript">
	function submitAdd(form)
	{
		
		if (form.value.value=='') {
			error("<fmt:message key="RFQMOdifyAddCommentDisplay_Error1" bundle="${storeText}" />");

			return;
		}
                else if (!isValidUTF8length(form.value.value, 254))
                {
                        error("<fmt:message key="msgInvalidSize254" bundle="${storeText}" />");
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
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
	<c:set var="liveHelpPageType" value="personal" />
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQModifyAddCommentDisplay_Table_1">
<tbody><tr>
	<td valign="top" width="630" id="WC_RFQModifyAddCommentDisplay_TableCell_2">

		<!--MAIN CONTENT STARTS HERE-->

		<table cellpadding="8" border="0" id="WC_RFQModifyAddCommentDisplay_Table_2">
		<tbody><tr>
			<td id="WC_RFQModifyAddCommentDisplay_TableCell_3">
			<h1><fmt:message key="RFQModifyAddCommentDisplay_RFQComment" bundle="${storeText}"  />  <c:out value="${itemName}"/></h1>
		
		<c:if test="${strErrorMessage != null}">
				<p><span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br /></p>
		</c:if>	
		
				<p><fmt:message key="RFQExtra_AddComment" bundle="${storeText}"  /></p>
				<span class="reqd">*</span><fmt:message key="RFQModifyAddCommentDisplay_Req" bundle="${storeText}"  />
				<p></p>

			<form name="addForm" action="RFQItemCommentAdd" method="post" id="addForm">
			<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" id="WC_RFQModifyAddCommentDisplay_FormInput_storeId_In_addForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" id="WC_RFQModifyAddCommentDisplay_FormInput_catalogId_In_addForm_1"/>
			<input type="hidden" name="langId" value="<c:out value="${langId}"/>" id="WC_RFQModifyAddCommentDisplay_FormInput_langId_In_addForm_1"/>
			<input type="hidden" name="<c:out value="${EC_RFQ_PRODUCT_ID}"/>" value="<c:out value="${rfqprodId}"/>" id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_RFQ_PRODUCT_ID}"/>_In_addForm_1"/>
			<input type="hidden" name="<c:out value="${EC_OFFERING_ID}"/>" value="<c:out value="${rfqId}"/>" id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_OFFERING_ID}"/>_In_addForm_1"/>
			<input type="hidden" name="<c:out value="${EC_ATTR_ID}"/>" value="-1000" id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_ID}"/>_In_addForm_1"/>
			<input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}"/>" value="<c:out value="${catId}"/>" id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}"/>_In_addForm_1"/>

			<table border="0" id="WC_RFQModifyAddCommentDisplay_Table_3"> 

			<tbody><tr>
				<td width="20%" height="21" id="WC_RFQModifyAddCommentDisplay_TableCell_4">
					<label for="WC_RFQModifyAddCommentDisplay_Select_1"><fmt:message key="RFQModifyAddCommentDisplay_Type" bundle="${storeText}"  /></label>
				</td>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_5">
     		                <select id="WC_RFQModifyAddCommentDisplay_Select_1" class="select" name="<c:out value="${EC_ATTR_NAME}"/>">	
					 
					
		<c:forEach var="attribute" items="${attributesList}" begin="0" varStatus="iter">	
		<c:set var="index" value="${iter.index}" />
		<c:choose>
		<c:when test="${attribute.attrTypeId eq EC_ATTRTYPE_FREEFORM}" >
			<c:set var="specDesc" value="${attribute.name}" />
			<c:set var="spec" value="${attribute.name}" />		 						
				<option value="<c:out value="${spec}" />"><c:out value="${specDesc}" /></option>											
		</c:when>		
		<c:otherwise>				 
		</c:otherwise>
		</c:choose>  
	
	</c:forEach>			

					</select>
			
				</td>
			</tr>

			<tr><td id="WC_RFQModifyAddCommentDisplay_TableCell_6">&nbsp;</td></tr>

			<tr>
				<td height="21" colspan="3" id="WC_RFQModifyAddCommentDisplay_TableCell_7">
					<span class="reqd">*</span>
					<label for="WC_RFQModifyAddCommentDisplay_Textarea_1"><fmt:message key="RFQModifyAddCommentDisplay_Comm" bundle="${storeText}"  />
					
				</label></td>
			</tr>

			<tr>
				<td colspan="3" id="WC_RFQModifyAddCommentDisplay_TableCell_8">
					<textarea id="WC_RFQModifyAddCommentDisplay_Textarea_1" cols="40" rows="6" name="<c:out value="${EC_ATTR_VALUE}" />"><c:out value="${strComment}" /></textarea>
				
				</td>
			</tr>

			<tr><td id="WC_RFQModifyAddCommentDisplay_TableCell_9">&nbsp;</td></tr>

			<tr>
				<td height="21" colspan="3" id="WC_RFQModifyAddCommentDisplay_TableCell_10">
					<fmt:message key="RFQModifyAddCommentDisplay_Man" bundle="${storeText}"  />					
				</td>
			</tr>
			<tr>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_11">
				
				<c:choose>
					<c:when test="${isRequired eq '1'}" >
						<c:set var="checked" value="checked" />
					</c:when>
					<c:otherwise>
						<c:set var="checked" value="" />
					</c:otherwise>
				</c:choose>
                                        <label for=WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_addForm_1">
					<input id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_addForm_1" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_MANDATORY}" />" value="1" <c:out value="${checked}" />="<c:out value="${checked}" />" /> <fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}"  />
				</label>
				</td>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_12">
				
				<c:choose>
					<c:when test="${isRequired eq EC_UTF_OPTIONAL}" >
						<c:set var="checked" value="checked" />
					</c:when>
					<c:otherwise>
						<c:set var="checked" value="" />
					</c:otherwise>
				</c:choose>
                                       <label for="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_addForm_2" ></label>
					<input id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_addForm_2" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_MANDATORY}" />" value="<c:out value="${EC_UTF_OPTIONAL}" />" <c:out value="${checked}" />="<c:out value="${checked}" />" /> <fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}"  />
				
				</td>
			</tr>

			<tr><td id="WC_RFQModifyAddCommentDisplay_TableCell_13">&nbsp;</td></tr>

			<tr>
				<td height="21" colspan="3" id="WC_RFQModifyAddCommentDisplay_TableCell_14">
					                                        <label for="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}" />_In_addForm_1">
<fmt:message key="RFQModifyAddCommentDisplay_Change" bundle="${storeText}"  />					
					</label></td>
			</tr>
			<tr>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_15">
				
				<c:choose>
					<c:when test="${isChangeable eq '1'}" >
						<c:set var="checked" value="checked" />
					</c:when>
					<c:otherwise>
						<c:set var="checked" value="" />
					</c:otherwise>
				</c:choose>
					<input id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}" />_In_addForm_1" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_CHANGEABLE}" />" value="1" <c:out value="${checked}" />="<c:out value="${checked}" />" /> <fmt:message key="RFQModifyAddCommentDisplay_Yes" bundle="${storeText}"  />
			
				</td>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_16">
				
				<c:choose>
					<c:when test="${isChangeable eq EC_UTF_NON_CHANGEABLE}" >
						<c:set var="checked" value="checked" />
					</c:when>
					<c:otherwise>
						<c:set var="checked" value="" />
					</c:otherwise>
				</c:choose>				

					<input id="WC_RFQModifyAddCommentDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}" />_In_addForm_2" size="53" type="radio" class="radio" name="<c:out value="${EC_ATTR_CHANGEABLE}" />" value="<c:out value="${EC_UTF_NON_CHANGEABLE}" />" <c:out value="${checked}" />="<c:out value="${checked}" />" /> <fmt:message key="RFQModifyAddCommentDisplay_No" bundle="${storeText}"  />
				</td>
			</tr>

			<tr>
				<td colspan="4" id="WC_RFQModifyAddCommentDisplay_TableCell_17">
<table id="WC_RFQModifyAddCommentDisplay_Table_4"><tbody><tr>

<!-- Start display for button "RFQModifyAddCommentDisplay_Add" -->
<td height="41" id="WC_RFQModifyAddCommentDisplay_TableCell_18">
<a class="button" href="javascript:submitAdd(document.addForm)" id="WC_RFQModifyAddCommentDisplay_Link_1"> &nbsp; <fmt:message key="RFQModifyAddCommentDisplay_Add" bundle="${storeText}"  />&nbsp;
</a>
</td>
<!-- End display for button .... -->

				<td id="WC_RFQModifyAddCommentDisplay_TableCell_19">&nbsp;</td>

<!-- Start display for button "RFQModifyAddCommentDisplay_Cancel" -->
<td height="41" id="WC_RFQModifyAddCommentDisplay_TableCell_20">
<a class="button" href="RFQModifyCommentDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catId}" />&amp;<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyAddCommentDisplay_Link_2"> &nbsp; <fmt:message key="RFQModifyAddCommentDisplay_Cancel" bundle="${storeText}"  /> &nbsp;
</a>
</td>
<!-- End display for button .... -->

</tr></tbody></table>
				</td>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_21">&nbsp;</td>
				<td id="WC_RFQModifyAddCommentDisplay_TableCell_22">&nbsp;</td>
			</tr>

			</tbody>
			</table>
		<input type="hidden" name="URL" value="RFQModifyCommentDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;<c:out value="${EC_ATTR_VALUE}" />=" id="WC_RFQModifyAddCommentDisplay_FormInput_URL_In_addForm_1"/>
		</form>
		
		</td> 
		</tr>
		</tbody>
		</table>

		<!--content end-->
	</td>
</tr>
</tbody></table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
</html>

