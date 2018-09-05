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
  * This JSP page displays fields for adding specifications to an RFQ 
  * product specification.
  *
  * Elements:
  * - Specification selection box
  * - Operator selection box
  * - Units selection box
  * - Add button
  * - Cancel button
  *
  * Imports:
  * - RFQModifyAddSpecificationStringDisplay.jsp 
  * - RFQModifyAddSpecificationIntegerDisplay.jsp
  * - RFQModifyAddSpecificationTimeStampDisplay.jsp
  * - RFQModifyAddSpecificationAttachmentDisplay.jsp
  *
  * Required parameters:
  * - offering_id
  * - catentryid
  * - rfqprod_id
  * - specJSP
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



    
<c:set var="catalogId" value="${WCParam.catalogId}" scope="request" />
<c:set var="rfqId" value="${WCParam.offering_id}" scope="request" />
<c:set var="catId" value="${WCParam.catentryid}" scope="request" />
<c:set var="rfqprodId" value="${WCParam.rfqprod_id}" scope="request" />
<c:set var="specJSP" value="${WCParam.specJSP}" scope="request" />
<c:set var="prevName" value="${param.prevName}" scope="request" />
<c:set var="WCParamValues" value="" scope="request" />

<c:set var="EC_UTF_MANDATORY" value="1" scope="request" />
<c:set var="EC_UTF_OPTIONAL" value="0" scope="request" />
<c:set var="EC_UTF_NON_CHANGEABLE" value="0" scope="request" />
<c:set var="EC_UTF_CHANGEABLE" value="1" scope="request" />
<c:set var="EC_OFFERING_ITEMBEAN" value="ItemBean" scope="request" />
<c:set var="EC_OFFERING_PACKAGEBEAN" value="PackageBean" scope="request" />
<c:set var="EC_OFFERING_ID" value="offering_id" scope="request" />
<c:set var="EC_OFFERING_CATENTRYID" value="catentryid" scope="request" />
<c:set var="EC_ATTR_VALUEDELIM" value="valuedelim" scope="request" />
<c:set var="EC_ATTR_USERDEF" value="userdefined" scope="request" />
<c:set var="EC_ATTR_ID" value="attr_id" scope="request" />
<c:set var="EC_RFQ_PRODUCT_ID" value="rfqprod_id" scope="request" />
<c:set var="EC_ATTR_MANDATORY" value="mandatory" scope="request" />
<c:set var="EC_ATTR_CHANGEABLE" value="changeable" scope="request" />
<c:set var="EC_ATTRTYPE_FREEFORM" value="FREEFORM" scope="request" />
<c:set var="EC_ATTR_NAME" value="name" scope="request" />

 
<wcbase:useBean id="QuantityUnitList" classname="com.ibm.commerce.common.beans.QuantityUnitListDataBean">
        <c:set target="${QuantityUnitList}" property="languageId" value="${langId}" />
</wcbase:useBean>
 
<c:set var="quantByLanguage" value="${QuantityUnitList.quantityUnitList}" scope="request" />
 
 
<c:choose>
<c:when test="${empty specJSP}" >        
       <c:set var="specJSP" value="RFQModifyAddSpecificationAttachmentDisplay.jsp" />       
</c:when>
<c:otherwise>
       <c:set var="specJSP" value="${specJSP}" />
</c:otherwise>
</c:choose>


<c:set var="isChangeable" value="${EC_UTF_CHANGEABLE}" /> 
<c:set var="isRequired" value="${EC_UTF_MANDATORY}" />
       
<fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="itemName" />



<c:choose>  
<c:when test="${rfqprodId eq ''}" >
       <fmt:message key="RFQListDisplay_MadeToOrder" bundle="${storeText}" var="itemName" />
</c:when>
<c:otherwise>
       
       <c:if test="${catId == null or catId eq ''}" >      
       		
  			<wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
				<jsp:setProperty property="*" name="rfqProduct"/>
				<c:set target="${rfqProduct}" property="RFQProdId" value="${rfqprodId}" />		
			</wcbase:useBean>	              
              
              <c:catch var="error">
                     <c:set var="catId" value="${rfqProduct.RFQProdCatentryId}"  scope="request" />              
                     
              </c:catch>
              <c:if test="${error != null}">
                     <c:set var="catId" value=""  scope="request" />       
              </c:if>              
       </c:if> 

       <c:if test="${catId != null and catId != ''}" >
		<wcbase:useBean id="ceDB" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		<jsp:setProperty property="*" name="ceDB"/>
		<c:set target="${ceDB}" property="catalogEntryID" value="${catId}" />		
		</wcbase:useBean>	
              
              
              <c:if test="${ceDB.type eq EC_OFFERING_ITEMBEAN}" >
				<wcbase:useBean id="iDB" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request" >	
					<c:set target="${iDB}" property="initKey_catalogEntryReferenceNumber" value="${catId}" />
					<c:set target="${iDB}" property="itemID" value="${catId}" />				
				</wcbase:useBean>					
				<c:set var="itemName" value="${iDB.description.name}" />		  
              </c:if>
              
			<c:if test="${ceDB.type eq EC_OFFERING_PACKAGEBEAN}" >
				<wcbase:useBean id="pDB" classname="com.ibm.commerce.catalog.beans.PackageDataBean">
					<c:set target="${pDB}" property="initKey_catalogEntryReferenceNumber" value="${catId}" />
					<c:set target="${pDB}" property="packageID" value="${catId}" />				
				</wcbase:useBean>
				<c:set var="itemName" value="${pDB.description.name}" />	
			</c:if>
              
       </c:if>       
              
</c:otherwise>

</c:choose>              
 <c:remove var="iDB" />
<c:remove var="pDB" />

 <wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>
  
             
<c:if test="${bnError.exceptionType != null}">
       <c:set var="strErrorMessage" value="${bnError.message}" />
       
       <c:set var="specification" value="${param.specification}" />
       <c:set var="value" value="${param.value}" />
       <c:set var="unit" value="${param.unit}" />
       <c:set var="operator" value="${param.operator}" />
       <c:set var="isChangeable" value="${param.isChangeable}" />
       <c:set var="isRequired" value="${param.isRequired}" />
              
       <c:if test="${empty isChangeable}" >
              <c:set var="isChangeable" value="${EC_UTF_CHANGEABLE}" />
       </c:if>

       <c:if test="${empty isRequired}" >
              <c:set var="isRequired" value="${EC_UTF_MANDATORY}" />
       </c:if>              
</c:if>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

<title><fmt:message key="RFQModifyAddSpecificationDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"       href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"       type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>

<script language="javascript">
       function error(errMsg) { alert(errMsg); }
</script>

</head>

<body class="noMargin">
<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<flow:ifEnabled feature="customerCare">
       <c:set var="liveHelpPageType" value="personal" />  
</flow:ifEnabled>

<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQModifyAddSpecificationDisplay_Table_1">
<tr>
       <td valign="top" width="630" id="WC_RFQModifyAddSpecificationDisplay_TableCell_2">

              <!--MAIN CONTENT STARTS HERE-->

              <table cellpadding="8" border="0" id="WC_RFQModifyAddSpecificationDisplay_Table_2">
              <tr>
                     <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_3">

                            <h1><fmt:message key="RFQModifyAddSpecificationDisplay_AddSpec" bundle="${storeText}" />
                            <c:out value="${itemName}" /></h1>
                            
<c:if test="${strErrorMessage != null}">
                            <p><span class="warning"><c:out value="${strErrorMessage}"/></span><br /><br /></p>
</c:if>
                            

                            <p><fmt:message key="RFQExtra_AddSpec" bundle="${storeText}" /></p>

                            <span class="reqd">*</span>
                            <fmt:message key="RFQModifyAddSpecificationDisplay_Req" bundle="${storeText}" />                            
                            <p>
                            </p>

                            <form name="addForm" action="RFQItemSpecificationAdd" method="post" enctype="multipart/form-data" id="addForm">
                            <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_storeId_In_addForm_1"/>
                            <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_langId_In_addForm_1"/>
                            <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_catalogId_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_OFFERING_ID}" />" value="<c:out value="${rfqId}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_OFFERING_ID}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_OFFERING_CATENTRYID}" />" value="<c:out value="${catId}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_OFFERING_CATENTRYID}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_ATTR_VALUEDELIM}" />" value=";" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_VALUEDELIM}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_ATTR_USERDEF}" />" value="1" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_USERDEF}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_ATTR_ID}" />" value="-1006" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_ID}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_RFQ_PRODUCT_ID}" />" value="<c:out value="${rfqprodId}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_RFQ_PRODUCT_ID}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_ATTR_MANDATORY}" />" value="<c:out value="${EC_UTF_MANDATORY}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_addForm_1"/>
                            <input type="hidden" name="<c:out value="${EC_ATTR_CHANGEABLE}" />" value="<c:out value="${EC_UTF_MANDATORY}" />" id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}" />_In_addForm_1"/>
                            <input type="hidden" name="URL" value="RFQModifySpecificationDisplay" id="WC_RFQModifyAddSpecificationDisplay_FormInput_URL_In_addForm_1"/>
                     <table border="0" id="WC_RFQModifyAddSpecificationDisplay_Table_3">
              
               
              <wcbase:useBean id="rfqProduct" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
                     <jsp:setProperty property="*" name="rfqProduct"/>                     
              </wcbase:useBean>
              <c:set var="attributesList" value="${rfqProduct.allAttributes}"  scope="request" />


<script language="javascript">
       function getValueFromSelection(formObject) {
              var selectedIndex = formObject.selectedIndex;
              return formObject.options[selectedIndex].value;
       }
       
       function changeType(form)
       {              
       <c:forEach var="attribute" items="${attributesList}" begin="0" varStatus="iter">              
              <c:choose>
              <c:when test="${attribute.attrTypeId eq EC_ATTRTYPE_FREEFORM or empty attribute.name }" >              
              </c:when>              
              <c:otherwise>              
                     if (getValueFromSelection(form.<c:out value="${EC_ATTR_NAME}" />) == '<c:out value="${attribute.name}" />')
                     {
                            form.attrType.value = '<c:out value="${attribute.attrTypeId}" />';
                     }              
              </c:otherwise>
              </c:choose>       
       </c:forEach>        
       
       <c:remove var="attributesList" />
       <c:remove var="pAttDB" />
       refreshHTML(form);
       
       }

</script>  
                     <tr>
                            <td height="21" id="WC_RFQModifyAddSpecificationDisplay_TableCell_4">
                                   <label for="WC_RFQModifyAddSpecificationDisplay_Select_1"><fmt:message key="RFQModifyAddSpecificationDisplay_Spec" bundle="${storeText}" /> </label>
                            </td>
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_5">
                                   <select id="WC_RFQModifyAddSpecificationDisplay_Select_1" name="<c:out value="${EC_ATTR_NAME}" />" onchange="changeType(document.addForm)">



       <c:set var="previousAttrName" value="${WCParam[EC_ATTR_NAME]}" />              
       <c:if test="${empty previousAttrName}" >
              <c:set var="previousAttrName" value="" />
       </c:if>
        
      <wcbase:useBean id="rfqProduct2" classname="com.ibm.commerce.utf.beans.RFQProdDataBean">
                     <jsp:setProperty property="*" name="rfqProduct2"/>                     
       </wcbase:useBean>
       <c:set var="attributesList2" value="${rfqProduct2.allAttributes}"  scope="request" />
        
       <c:forEach var="attribute2" items="${attributesList2}" begin="0" varStatus="iter">
       
              <c:choose>
              <c:when test="${attribute2.attrTypeId eq EC_ATTRTYPE_FREEFORM}" >              
              </c:when>              
              <c:otherwise>                            
                     <c:set var="specDesc" value="${attribute2.name}" />
                     <c:choose>
                            <c:when test="${empty specDesc}" >                            
                            </c:when> 
                            <c:otherwise>
                                   <c:set var="spec" value="${attribute2.name}" />
                                   <c:set var="checked" value="" />
                                   <c:if test="${prevName eq spec}" >
                                          <c:set var="checked" value="selected" />
                                   </c:if>                                   
                                   <option value="<c:out value="${spec}" />" <c:out value="${checked}" />="<c:out value="${checked}" />"><c:out value="${specDesc}" /></option>                                                        
                            </c:otherwise>
                     </c:choose>                             
              </c:otherwise>
              </c:choose> 
       
       </c:forEach> 
       <c:remove var="attributesList2" />
       <c:remove var="pAttDB2" />

                                   </select></td>
                    
                     </tr>
                     
                     <c:set var="specJSP" value="${jspStoreDir}RFQArea/RFQModifySection/ProductSubsection/${specJSP}" />
                     <% out.flush(); %> 
                     <c:import url="${specJSP}" >       
                            <c:param name="rfqprod_id" value="${rfqprodId}"  />              
                     </c:import>
                     <% out.flush(); %>
                     </form>
                     
                     <form name="form2" action="" method="get" id="form2">

                     <tr><td id="WC_RFQModifyAddSpecificationDisplay_TableCell_6">&nbsp;</td></tr>
 
                     <tr>
                            <td height="21" colspan="3" id="WC_RFQModifyAddSpecificationDisplay_TableCell_7">
                <fmt:message key="RFQModifyAddSpecificationDisplay_isReq" bundle="${storeText}" />                                   
                            </td>
                     </tr>
                     <tr>
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_8">
                            
                            <c:choose>
                            <c:when test="${isRequired eq EC_UTF_MANDATORY}" >
                                   <c:set var="checked" value="checked" />
                            </c:when>
                            <c:otherwise>
                                   <c:set var="checked" value="" />
                            </c:otherwise>
                            </c:choose>
                                              <label for="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_form2_1"></label>
                            <input id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_form2_1" size="53" class="radio" type="radio" name="<c:out value="${EC_ATTR_MANDATORY}" />" value="<c:out value="${EC_UTF_MANDATORY}" />" <c:out value="${checked}" /> onMouseDown="document.addForm.<c:out value="${EC_ATTR_MANDATORY}" />.value=<c:out value="${EC_UTF_MANDATORY}" />" onKeyDown="document.addForm.<c:out value="${EC_ATTR_MANDATORY}" />.value=<c:out value="${EC_UTF_MANDATORY}" />"> <fmt:message key="RFQModifyAddSpecificationDisplay_Yes" bundle="${storeText}" />

                            </td>
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_9">
                            
                            <c:choose>
                            <c:when test="${isRequired eq EC_UTF_OPTIONAL}" >
                                   <c:set var="checked" value="checked" />
                            </c:when>
                            <c:otherwise>
                                   <c:set var="checked" value="" />
                            </c:otherwise>
                            </c:choose>
                                   
                                   <input id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_MANDATORY}" />_In_form2_2" size="53" class="radio" type="radio" name="<c:out value="${EC_ATTR_MANDATORY}" />" value="<c:out value="${EC_UTF_OPTIONAL}" />" <c:out value="${checked}" /> onMouseDown="document.addForm.<c:out value="${EC_ATTR_MANDATORY}" />.value=<c:out value="${EC_UTF_OPTIONAL}" />" onKeyDown="document.addForm.<c:out value="${EC_ATTR_MANDATORY}" />.value=<c:out value="${EC_UTF_OPTIONAL}" />"> <fmt:message key="RFQModifyAddSpecificationDisplay_No" bundle="${storeText}" />

                            </td>
                     </tr>

                     <tr><td id="WC_RFQModifyAddSpecificationDisplay_TableCell_10">&nbsp;</td></tr>

                     <tr>
                            <td height="21" colspan="3" id="WC_RFQModifyAddSpecificationDisplay_TableCell_11">
                            <fmt:message key="RFQModifyAddSpecificationDisplay_Change" bundle="${storeText}" />                                   
                            </td>
                     </tr>
                     <tr> 
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_12">
                            
                            <c:choose>
                            <c:when test="${isChangeable eq EC_UTF_CHANGEABLE}" >
                                   <c:set var="checked" value="checked" />
                            </c:when>
                            <c:otherwise>
                                   <c:set var="checked" value="" />
                            </c:otherwise>
                            </c:choose>                             

                                   <input id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}" />_In_form2_1" size="53" class="radio" type="radio" name="<c:out value="${EC_ATTR_CHANGEABLE}" />" value="<c:out value="${EC_UTF_CHANGEABLE}" />" <c:out value="${checked}" /> onmousedown="document.addForm.<c:out value="${EC_ATTR_CHANGEABLE}" />.value=<c:out value="${EC_UTF_CHANGEABLE}" />" onKeydown="document.addForm.<c:out value="${EC_ATTR_CHANGEABLE}" />.value=<c:out value="${EC_UTF_CHANGEABLE}" />" /> <fmt:message key="RFQModifyAddSpecificationDisplay_Yes" bundle="${storeText}" />
                            </td>
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_13">
                            
                            <c:choose>
                            <c:when test="${isChangeable eq EC_UTF_NON_CHANGEABLE}" >
                                   <c:set var="checked" value="checked" />
                            </c:when>
                            <c:otherwise>
                                   <c:set var="checked" value="" />
                            </c:otherwise>
                            </c:choose>              

                                   <input id="WC_RFQModifyAddSpecificationDisplay_FormInput_<c:out value="${EC_ATTR_CHANGEABLE}" />_In_form2_2" size="53" class="radio" type="radio" name="<c:out value="${EC_ATTR_CHANGEABLE}" />" value="<c:out value="${EC_UTF_NON_CHANGEABLE}" />" <c:out value="${checked}" /> onMouseDown="document.addForm.<c:out value="${EC_ATTR_CHANGEABLE}" />.value=<c:out value="${EC_UTF_NON_CHANGEABLE}" />" onKeyDown="document.addForm.<c:out value="${EC_ATTR_CHANGEABLE}" />.value=<c:out value="${EC_UTF_NON_CHANGEABLE}" />" /> <fmt:message key="RFQModifyAddSpecificationDisplay_No" bundle="${storeText}" />

                            </td>
                     </tr>
 
                     <tr>
                            <td colspan="4" id="WC_RFQModifyAddSpecificationDisplay_TableCell_14">
<table id="WC_RFQModifyAddSpecificationDisplay_Table_4"><tr><td id="WC_RFQModifyAddSpecificationDisplay_TableCell_15">

<!-- Start display for button "RFQModifyAddSpecificationDisplay_Add" -->
<td height="41" id="WC_RFQModifyAddSpecificationDisplay_TableCell_16">
<a class="button" href="javascript:submitAdd(document.addForm);" id="WC_RFQModifyAddSpecificationDisplay_Link_1"> &nbsp; <fmt:message key="RFQModifyAddSpecificationDisplay_Add" bundle="${storeText}" />&nbsp;
</a>
</td>
<!-- End display for button ... -->

                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_17">&nbsp;</td>

<!-- Start display for button "RFQModifyAddSpecificationDisplay_Cancel" -->
<td height="41" id="WC_RFQModifyAddSpecificationDisplay_TableCell_18">
<a class="button" href="RFQModifySpecificationDisplay?<c:out value="${EC_RFQ_PRODUCT_ID}" />=<c:out value="${rfqprodId}" />&amp;<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;<c:out value="${EC_OFFERING_CATENTRYID}" />=<c:out value="${catId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyAddSpecificationDisplay_Link_2">&nbsp;<fmt:message key="RFQModifyAddSpecificationDisplay_Cancel" bundle="${storeText}" />&nbsp;
</a>
</td>
<!-- End display for button ... -->

</td></tr></table>
                            </td>
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_19">&nbsp;</td>
                            <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_20">&nbsp;</td>
                     </tr>

<!-- end cut -->                     
                     </table>

                     </form>

              <td id="WC_RFQModifyAddSpecificationDisplay_TableCell_21"></td>
              </tr>
              </table>

              <!--content end-->
       </td>
</tr> 
</table>

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>       
</body>
</html>
