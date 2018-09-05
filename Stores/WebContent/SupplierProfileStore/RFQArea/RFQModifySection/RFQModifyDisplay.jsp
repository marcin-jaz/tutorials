<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page displays fields for modifying and submitting an RFQ.
  *
  * Elements:  
  * - general RFQ information
  * - attachments 
  * - terms and conditions
  * - category percentage price adjustments
  * - RFQ categories
  * - product adjustments
  * - Target lists (for MultiSeller)
  * - Add Product from Catalog button
  * - Add Product from Requisition List button
  * - Add Made-to-Order Item button
  * - Add New Category button
  * - Return to RFQ Summary button
  * - Submit RFQ button
  * - Cancel RFQ button
  * - Duplicate RFQ button
  *
  * Imports:
  * - CommonSection/RFQSetup.jsp
  * - RFQModifyDisplay_Setup.jsp
  * - RFQModifyDisplay_JS.jsp
  * - RFQModifyDisplay_DateTime.jsp
  * - RFQModify_Attachments.jsp
  * - RFQModify_TC.jsp
  * - RFQModifyDisplay_CategoryAdjustment.jsp
  * - RFQModifyDisplay_RFQCategory.jsp
  * - RFQModifyDisplay_Product.jsp
  *
  * Required parameters:
  * - offering_id
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

<wcbase:useBean id="bnError" classname="com.ibm.commerce.beans.ErrorDataBean" scope="request">
</wcbase:useBean>

<c:if test="${bnError.exceptionType != null}">
       <c:set var="strErrorMessage" value="${bnError.message}" />
</c:if>  
  
    <c:choose>
	<c:when test="${langId <= -7 and langId >= -10}">
		<c:set var="wrap" value="nowrap=\"nowrap\"" scope="request" />
	</c:when>
	<c:otherwise>
		<c:set var="wrap" value="" scope="request" />
	</c:otherwise>
    </c:choose>   
  
  
<c:set var="rfqId" value="${WCParam.offering_id}" scope="request" />
<c:set var="rfqCategoryId" value="${WCParam.rfqCategoryId}" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title><fmt:message key="RFQModifyDisplay_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"       href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css" />
<meta name="GENERATOR" content="IBM WebSphere Studio"/>
     
<wcbase:useBean id="rfqBean" classname="com.ibm.commerce.utf.beans.RFQDataBean" scope="request">
          <jsp:setProperty property="*" name="rfqBean"/>         
        <c:set property="rfqId" value="${rfqId}" target="${rfqBean}" />                        
</wcbase:useBean>  
 <% out.flush(); %>              
<c:import url="../CommonSection/RFQSetup.jsp" /> 
<% out.flush(); %>
<% out.flush(); %>
<c:import url="RFQModifyDisplay_Setup.jsp" />       
<% out.flush(); %>                    
  
<c:set var="endresult" value="${rfqBean.endResultInEJBType}"  scope="request" />
<c:set var="accessType" value="${rfqBean.accessTypeInEJBType}"  />          
<c:set var="ruleType" value="${rfqBean.ruleTypeInEJBType}"  />
<c:set var="rfqName" value="${rfqBean.name}"  />
<c:set var="numOfResponses" value="${rfqBean.numOfResponsesInEJBType}"  />
<c:set var="ppArray" value="${rfqBean.allPriceAdjustmentOnCategory}"  />
<c:set var="targetedStoreFromProds" value="${rfqBean.targetedStoreFromRFQProds}" scope="request" />
  
       <c:if test="${multiSeller}">                        
                 <wcbase:useBean id="targetListBean" classname="com.ibm.commerce.rfq.beans.RFQTargetListBean" scope="request">
                     <jsp:setProperty property="*" name="targetListBean"/>
                     <c:set property="tradingId" value="${rfqId}" target="${targetListBean}" />
              </wcbase:useBean> 
               
                <c:set var="targetDBs" value="${targetListBean.targets}" scope="request" />       
                <c:forEach items="${targetDBs}" varStatus="targetList"> 
                       <c:set var="targetCount" value="${iter.index}" />
                </c:forEach>
        </c:if> 
  
 <% out.flush(); %> 
<c:import url="RFQModifyDisplay_JS.jsp" />
<% out.flush(); %>
<script language="javascript">   
 
       function submitUpdatePercentagePricing(form)
       {
              if (form.tc_id_1.value=='null') {
                     return;
              }
              for (var i = 0; i < form.numPPTC.value; i++) {
                     var name = 'categoryPercentagePrice_' + (i + 1);                            
                     if (form[name].value=='') {                     
                            error("<fmt:message key="RFQModifyDisplay_Error17" bundle="${storeText}" />");
                            return;
                     }
                     var temp = parseInt(form[name].value);
                     if (isNaN(temp)) {                     
                            error('<fmt:message key='RFQModifyDisplay_Error16' bundle='${storeText}' />');
                            return;
                     }
                     if ((temp<0) || (temp>100)) {
                            error("<fmt:message key="RFQModifyDisplay_Error20" bundle="${storeText}" />");
                            return;
                     }                                   
              }              
              form.submit()
       }
         
       function submitUpdateProd(form)
       {        
              for (var i = 0; i < form.numProd.value; i++) {
                     var percentagePrice = 'percentagePrice_' + (i + 1);
                     var price = 'price_' + (i + 1);
                     var quantity = 'quantity_' + (i + 1);
                     var quantityunit = 'quantityunit_' + (i + 1);
                     var substitutable = 'subst_' + (i + 1);        
                     var prodType = 'prodType_' + (i + 1);                     
                     
                     var endresult = "0"; //is Contract                      
                     if (document.RFQModifyBasicForm.endresult[0].checked) {
                            endresult = "1"; //is Order
                     }                     
                      
                     if (form[percentagePrice]) {
                            var numPerAdjust = parseInt(form[percentagePrice].value);
                     }
                     var numFixedPrice = parseInt(form[price].value);
                     var numQuantity = parseInt(form[quantity].value);       
                     
                     if (form[percentagePrice]) { 
                            if (Trim(form[percentagePrice].value)!='') {
                                   if (form[percentagePrice].value!='0.0') {       
                                   
                                          if (form[price]) {
                                                 if (Trim(form[price].value)!='') {
                                                        error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
                                                        return;
                                                 }
                                          }                            
                                          
                                   }
                            } 
                     }                     
                        
                     if (endresult == '1'){       //Order
                            if (!isNaN(numPerAdjust)) {       
                            
                                   if (form[quantity]) {
                                          if (Trim(form[quantity].value)=='') {                                                        
                                                 error("<fmt:message key="RFQModifyDisplay_Error10" bundle="${storeText}" />");
                                                 return;
                                          }
                                   }
                                   
                                         
                                   
                                                                             
                            }        
                     }       
                      
                     if (endresult == '0'){       //Contract
                            if (!isNaN(numPerAdjust)) {       
                            
                                   if (form[quantity]) {
                                          if (Trim(form[quantity].value)!='') {
                                                 if (form[quantity].value!='0') { 
                                                        error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
                                                        return;
                                                 }
                                          }
                                   }       
                                   
                                   var index = form[quantityunit].selectedIndex;
                                   var item = form[quantityunit].options[index].value;              
                                                 
                                   if (Trim(item)!='') {
                                          error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
                                          return;
                                   }                                          
                            } 
                     }                            

                     if (form[price]) {
                            if (Trim(form[price].value)!='') {
                                   if (form[price].value!='0') {                                    
                                          
                                          if (isNaN(numFixedPrice)) {                      
                                                 error('<fmt:message key='RFQModifyDisplay_Error21' bundle='${storeText}' />');
                                                 return;
                                          }
                                          if ((numFixedPrice<0) ) {
                                                 error('<fmt:message key='RFQModifyDisplay_Error22' bundle='${storeText}' />');
                                                 return;
                                          }                                          
                                   }
                            }
                     }
                     
                     if (form[quantity]) {
                            if (Trim(form[quantity].value)!='') {
                                   if (form[quantity].value!='0') {                                                               
                                                                                    
                                          if (isNaN(numQuantity)) {                     
                                                 error('<fmt:message key='RFQModifyDisplay_Error23' bundle='${storeText}' />');
                                                 return;
                                          }
                                          if ((numQuantity<0)) {
                                                 error('<fmt:message key='RFQModifyDisplay_Error24' bundle='${storeText}' />');
                                                 return;
                                          }                                          
                                   } 
                            }
                     }                                           
                            
                     if (Trim(form[price].value)=='') {
                                   form[price].value = '';       
                     }
                     if (Trim(form[quantity].value)=='') {
                                   form[quantity].value = '';       
                     }                                          
              }              
              
              form.submit()
       }
       

       function submitForm(form)
       {
       
       for (var i = 0; i < form.numProd.value; i++) {
              var percentagePrice = 'percentagePrice_' + (i + 1);
              var price = 'price_' + (i + 1);
              var quantity = 'quantity_' + (i + 1);
              var quantityunit = 'quantityunit_' + (i + 1);
              var substitutable = 'subst_' + (i + 1);        
              var prodType = 'prodType_' + (i + 1);                     
                
              <c:if test="${multiSeller}">
              	<c:if test="${empty targetDBs}" >              
              		document.RFQModifyBasicForm.accessType.value = '0'; 
             	</c:if>
              </c:if>
              
              
                           
              <c:choose>
              <c:when test="${requestScope.endresult eq '1'}" >                     
                     var endresult = "1"; //is Order
              </c:when>
              <c:otherwise>                     
                     var endresult = "0"; //is Contract       
              </c:otherwise>
              </c:choose>
                       
              if (form[percentagePrice]) {
                     var numPerAdjust = parseInt(form[percentagePrice].value);
              }
              var numFixedPrice = parseInt(form[price].value);
              var numQuantity = parseInt(form[quantity].value);          
  
                if (form[percentagePrice]) {
                            if (Trim(form[percentagePrice].value)!='') {
                                   if (form[percentagePrice].value!='0.0') {       
                                   
                                          if (form[price]) {
                                                 if (Trim(form[price].value)!='') {
                                                        error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
                                                        return;
                                                 }
                                          }                            
                                          
                                   }
                            } 
                     }       
  
              if (endresult == '1'){       //Order
                     if (!isNaN(numPerAdjust)) {       
                            
                                   if (form[quantity]) {
                                          if (Trim(form[quantity].value)=='') {                                                        
                                                 error("<fmt:message key="RFQModifyDisplay_Error10" bundle="${storeText}" />");
                                                 return;
                                          }
                                   }
                                   
                                                                                                                      
                     }                             
              }       
                      
              if (endresult == '0'){       //Contract
                     if (!isNaN(numPerAdjust)) {                                   
                            if (form[quantity]) {
                                          if (Trim(form[quantity].value)!='') {
                                                 if (form[quantity].value!='0') { 
                                                        error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
                                                        return;
                                                 }
                                          }
                                   }       
                                   
                                   var index = form[quantityunit].selectedIndex;
                                   var item = form[quantityunit].options[index].value;              
                                                 
                                   if (Trim(item)!='') {
                                          error("<fmt:message key="RFQModifyDisplay_Error18" bundle="${storeText}" />");
                                          return;
                                   }                                                                      
                            }                             
                     }
              }       
              location.replace("RFQSubmit?offering_id=<c:out value="${rfqId}" />&langId=<c:out value="${langId}" />&storeId=<c:out value="${storeId}" />&catalogId=<c:out value="${catalogId}" />&URL=RFQListDisplay");       
       } 

       function submitDeleteTC(form, categoryID)
       {
              form.deleteTC.value = categoryID;
              form.submit()
       }

       function checkAccount(form)
       {
              if (form.account_id.value=='') {
                     error("<fmt:message key="RFQModifyDisplay_Error14" bundle="${storeText}" />");
                     form.endresult.value = '1';
                     return;
              }
       }

       function checkTargetList(form)
       {
              if (form.numTarget.value=='0') {
                     error("<fmt:message key="RFQTargetListStoreDisplay_Error1" bundle="${storeText}" />");
                     form.accessType.value = '0';
                     return;
              }
       }

       function error(errMsg)
       {
              alert(errMsg);
       }
       
       function Trim(str) {
               var r=/\b(.*)\b/.exec(str);
              return (r==null)?"":r[1];
       }
</script>
   
</head>    

<body class="noMargin">
<%@ include file="../../include/LayoutContainerTop.jspf"%>
                                                              
<table border="0" cellpadding="0" cellspacing="0" width="790" height="99%" id="WC_RFQModifyDisplay_Table_1">
    <tbody> 
        <tr valign="top"> 
            <!--START MAIN CONTENT-->                                   
            <td valign="top" width="630" id="WC_RFQModifyDisplay_TableCell_2">
            <table cellpadding="0" cellspacing="0" width="630" border="0"  id="WC_RFQModifyDisplay_Table_2">
            <tbody>
                   <tr valign="top">
                        <td rowspan="12" id="WC_RFQModifyDisplay_TableCell_3">&nbsp;</td>
                        <td  valign="top" class="categoryspace" id="WC_RFQModifyDisplay_TableCell_4">
                               <h1><fmt:message key="RFQModifyDisplay_RFQModify" bundle="${storeText}"/></h1>                        

                     <c:if test="${strErrorMessage != null}">
                                <span class="warning"><c:out value="${strErrorMessage}" /></span><br />
                               <br />
                     </c:if>
                    
                     <table cellpadding="0" cellspacing="0" border="0" id="WC_RFQModifyDisplay_Table_3">
                     <tbody>
                            <tr>
                                       <td class="header" background="<c:out value="${jspStoreImgDir}" />images/header_back.gif" id="WC_RFQModifyDisplay_TableCell_5"><fmt:message key="RFQModifyDisplay_RFQGeneral" bundle="${storeText}"/></td>
                            </tr>
                            <tr>
                                       <td id="WC_RFQModifyDisplay_TableCell_6"><img src="<c:out value="${jspStoreImgDir}" />images/strip.gif" alt="" width="630" height="2" border="0"/></td>
                            </tr>
                     </tbody>
                     </table>               

                          <form name="RFQModifyBasicForm" action="RFQModifyBasic" method="post" id="RFQModifyBasicForm">
                     <input type="hidden" name="offering_id" value="<c:out value="${rfqId}" />" id="WC_RFQModifyDisplay_FormInput_offeringId_In_RFQModifyBasicForm_1"/>
                     <input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_RFQModifyDisplay_FormInput_langId_In_RFQModifyBasicForm_1"/>
                     <input type="hidden" name="storeId" value="<c:out value="${storeId}" />" id="WC_RFQModifyDisplay_FormInput_storeId_In_RFQModifyBasicForm_1"/>
                     <input type="hidden" name="catalogId" value="<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_FormInput_catalogId_In_RFQModifyBasicForm_1"/>
                                           
       <c:choose> 
              <c:when test="${multiSeller}">
              </c:when>
              <c:otherwise>
                     <wcbase:useBean id="acctListBean" classname="com.ibm.commerce.payment.beans.EligibleAccountListDataBean">
                                 <jsp:setProperty property="*" name="acctListBean"/>                                             
                          </wcbase:useBean> 
       
                     <c:set var="accountid" value="${acctListBean.accountIdForLowestOrgEntity}"  />
                     <input type="hidden" name="account_id" value="<c:out value="${accountid}" />" id="WC_RFQModifyDisplay_FormInput_account_id_In_RFQModifyBasicForm_1"/>
              </c:otherwise>
       </c:choose>       
                                          
                              <table  border="0" width="630" id="WC_RFQModifyDisplay_Table_4">
                        <tbody>
                                    <tr>
                                           <td colspan="2" id="WC_RFQModifyDisplay_TableCell_7"><fmt:message key="RFQExtra_instructGeneral" bundle="${storeText}"/></td>
                                </tr>
                                <tr>
                                           <td colspan="2" id="WC_RFQModifyDisplay_TableCell_8"> <span class="reqd">*</span><fmt:message key="RFQModifyDisplay_Required" bundle="${storeText}"/><br />&nbsp;</td>
                                </tr>
                                <tr>
                                           <td id="WC_RFQModifyDisplay_TableCell_9"><span class="reqd">*</span><label for="WC_RFQModifyDisplay_FormInput_name_In_RFQModifyBasicForm_1">
                                           <fmt:message key="RFQModifyDisplay_Name" bundle="${storeText}"/>  </label></td>
                                           <td id="WC_RFQModifyDisplay_TableCell_10">
                                           <input type="text" class="input" name="productName" value="<c:out value="${rfqName}" />" size="42" id="WC_RFQModifyDisplay_FormInput_name_In_RFQModifyBasicForm_1"/></td>
                                         
                                </tr>
                                <tr> 
                                           <td id="WC_RFQModifyDisplay_TableCell_11"><label for="WC_RFQModifyDisplay_FormInput_shortdesc_In_RFQModifyBasicForm_1"><fmt:message key="RFQModifyDisplay_ShortDesc" bundle="${storeText}"/></label></td>
                                           <td id="WC_RFQModifyDisplay_TableCell_12"><input type="text" class="input" name="shortdesc" value="<c:out value="${rfq_short_desc}" />" size="42" id="WC_RFQModifyDisplay_FormInput_shortdesc_In_RFQModifyBasicForm_1"/></td>
                                
                                
                                </tr>
                                <tr>
                                           <td id="WC_RFQModifyDisplay_TableCell_13"><label for="WC_RFQModifyDisplay_TextArea_1"><fmt:message key="RFQModifyDisplay_LongDesc" bundle="${storeText}"/></label></td>
                                           <td id="WC_RFQModifyDisplay_TableCell_14"><textarea cols="31" rows="2" name="longdesc" id="WC_RFQModifyDisplay_TextArea_1" ><c:out value="${rfq_long_desc}" /></textarea></td>
                              
                                </tr>
                                <tr>
                                           <td id="WC_RFQModifyDisplay_TableCell_15"><fmt:message key="RFQModifyDisplay_Status" bundle="${storeText}"/></td>
                                           <td id="WC_RFQModifyDisplay_TableCell_16"><c:out value="${rfq_state}" /></td>
                                </tr>
  
                                <tr>  
                                           <td id="WC_RFQModifyDisplay_TableCell_17"><span class="reqd">*</span><fmt:message key="RFQModifyDisplay_EndResult" bundle="${storeText}"/></td>
                                           <td id="WC_RFQModifyDisplay_TableCell_18">

                        <input id="WC_RFQModifyDisplay_FormInput_endresult_In_RFQModifyBasicForm_1" type="radio" class="radio" name="endresult" value="1" 
                        <c:if test="${endresult eq '1'}">
                            checked                                                                       
                     </c:if>                                                                               
                                      >
                                <label for="WC_RFQModifyDisplay_FormInput_endresult_In_RFQModifyBasicForm_1"><fmt:message key="RFQModifyDisplay_Order" bundle="${storeText}"/>&nbsp;&nbsp;</label>  
                                 
             <c:choose>              
              <c:when test="${multiSeller}">
                     <input id="WC_RFQModifyDisplay_FormInput_endresult_In_RFQModifyBasicForm_2" type="radio" class="radio" name="endresult" value="0" <c:if test="${endresult eq '0'}"> checked  </c:if>  >
                          <label for="WC_RFQModifyDisplay_FormInput_endresult_In_RFQModifyBasicForm_2"><fmt:message key="RFQModifyDisplay_Contract" bundle="${storeText}"/></label>           
              </c:when>
              <c:otherwise>
                     <input id="WC_RFQModifyDisplay_FormInput_endresult_In_RFQModifyBasicForm_3" type="radio" class="radio" name="endresult" value="0" 
                      <c:if test="${endresult eq '0'}">
                            checked 
                     </c:if>                                                                 
                              onMouseDown="checkAccount(document.RFQModifyBasicForm);" onKeyDown="checkAccount(document.RFQModifyBasicForm);" >
                            <label for="WC_RFQModifyDisplay_FormInput_endresult_In_RFQModifyBasicForm_3"><fmt:message key="RFQModifyDisplay_Contract" bundle="${storeText}"/></label>                                                                                                                                
              </c:otherwise>
       </c:choose>
                                        
                                           </td>
                                </tr>                                
                                
        <c:choose>
              <c:when test="${multiSeller}">
                             <tr>
                                           <td id="WC_RFQModifyDisplay_TableCell_19"><span class="reqd">*</span>
                                           <label for="WC_RFQModifyDisplay_Select_1">
                                           <fmt:message key="RFQModifyDisplay_CloseRule" bundle="${storeText}"/></label></td>

                                           <td id="WC_RFQModifyDisplay_TableCell_20">
                                                  <select name="ruletype" class="select" id="WC_RFQModifyDisplay_Select_1" >                                   
                                                      <option selected="selected"><fmt:message key="RFQModifyDisplay_SelectRule" bundle="${storeText}"/></option>
                                                       <option value='1' 
                                                      <c:if test="${ruleType eq '1'}">
                                                        selected 
                                                 </c:if>                                               
                                                      ><fmt:message key="RFQModifyDisplay_Rule1" bundle="${storeText}"/>
                                                      </option>   
                                         
                                                      <option value='2' 
                                                      <c:if test="${ruleType eq '2'}">
                                                        selected                                                                                     
                                                 </c:if> 
                                                      ><fmt:message key="RFQModifyDisplay_Rule2" bundle="${storeText}"/>
                                                      </option>
                                        
                                                      <option value='3' 
                                                      <c:if test="${ruleType eq '3'}">
                                                        selected                                                                                     
                                                 </c:if> 
                                                      ><fmt:message key="RFQModifyDisplay_Rule3" bundle="${storeText}"/>
                                                      </option>
                                        
                                                      <option value='4' 
                                                      <c:if test="${ruleType eq '4'}">
                                                        selected                                                                                     
                                                 </c:if> 
                                                      ><fmt:message key="RFQModifyDisplay_Rule4" bundle="${storeText}"/>
                                                      </option>                                                                
                                                 
                                                  </select>
                                           </td>
                                  </tr>
                                   
              </c:when>  
              <c:otherwise>
                     <input type="hidden" name="ruletype" value="1" id="WC_RFQModifyDisplay_FormInput_ruletype_In_RFQModifyBasicForm_1"/>              
              </c:otherwise>
       </c:choose>                 
                              
       <!-- Display date/time -->  
	<% out.flush(); %>                           
         <c:import url="RFQModifyDisplay_DateTime.jsp" /> 
	<% out.flush(); %>
       <!-- End display date/time -->


 
         <c:choose>
           <c:when test="${multiSeller}">    
                                   <tr>
                                        <td id="WC_RFQModifyDisplay_TableCell_25">
                                               <input type="hidden" name="numTarget" value="<c:out value="${targetCount+1}" />" id="WC_RFQModifyDisplay_FormInput_numTarget_In_RFQModifyBasicForm_1"/>
                                               <label for="WC_RFQModifyDisplay_FormInput_numResponses_In_RFQModifyBasicForm_1">
                                               <fmt:message key="RFQModifyDisplay_MinResponse" bundle="${storeText}"/></label>
                                        </td>
                                        <td id="WC_RFQModifyDisplay_TableCell_26">
                                               <input size="6" type="text" class="input" maxlength="6" name="numResponses" value="<c:out value="${numOfResponses}" />" id="WC_RFQModifyDisplay_FormInput_numResponses_In_RFQModifyBasicForm_1"/>
                                        </td>
                                   
                                   </tr>
 
                                   <tr>
                                      <td id="WC_RFQModifyDisplay_TableCell_27"><span class="reqd">*</span><fmt:message key="RFQModifyDisplay_IsTargeted" bundle="${storeText}"/></td>
                                        <td id="WC_RFQModifyDisplay_TableCell_28">                
                 <c:choose>
                     <c:when test="${!empty targetedStoreFromProds }" >                     
                     
                           <input type="hidden" name="accessType" value="1" id="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_1"/>
                           <label for="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_1"><fmt:message key="RFQModifyDisplay_Targeted" bundle="${storeText}"/></label>      
                     </c:when>
                     <c:otherwise>
                           <input id="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_2" type="radio" class="radio" name="accessType" value="0" 
                           <c:if test="${accessType eq '0'}">
                                     checked 
                           </c:if> 
                           >
                          <label for="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_2"><fmt:message key="RFQModifyDisplay_Public" bundle="${storeText}"/></label>
                           &nbsp;&nbsp;
                           <input id="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_3" type="radio" class="radio" name="accessType" value="1" 
                           <c:if test="${accessType eq '1'}">
                                  checked 
                           </c:if> 
                           onMouseDown="checkTargetList(document.RFQModifyBasicForm);" onKeyDown="checkTargetList(document.RFQModifyBasicForm);">
                           <label for="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_3"><fmt:message key="RFQModifyDisplay_Targeted" bundle="${storeText}"/></label>  
                     </c:otherwise>
                 </c:choose>       
                                     </td>
                                  </tr>              
           </c:when>
           <c:otherwise>
                        <input type="hidden" name="accessType" value="<c:out value="${accessType}" />" id="WC_RFQModifyDisplay_FormInput_accessType_In_RFQModifyBasicForm_4"/>              
           </c:otherwise>
       </c:choose>              
         
                                <tr> 
                     <input type="hidden" name="URL" value="RFQModifyDisplay" id="WC_RFQModifyDisplay_FormInput_URL_In_RFQModifyBasicForm_1"/>
                                </tr>
           
                                <tr>
                                   <!-- Display Save Changes button -->
                                   <td colspan="2" height="41" id="WC_RFQModifyDisplay_TableCell_29">
                                          <a class="button" href="javascript:document.RFQModifyBasicForm.startdate.value=getValueFromSelection(document.RFQModifyBasicForm.beginYr)+'-'+getValueFromSelection(document.RFQModifyBasicForm.beginMon)+'-'+getValueFromSelection(document.RFQModifyBasicForm.beginDay);document.RFQModifyBasicForm.enddate.value=getValueFromSelection(document.RFQModifyBasicForm.endYr)+'-'+getValueFromSelection(document.RFQModifyBasicForm.endMon)+'-'+getValueFromSelection(document.RFQModifyBasicForm.endDay);submitUpdateBasic(document.RFQModifyBasicForm);" id="WC_RFQModifyDisplay_Link_1"> &nbsp; <fmt:message key="RFQ_SAVE_CHANGES" bundle="${storeText}"/> &nbsp;</a>
                                   </td>
                                   <!-- End display Save Changes button -->
                               </tr>
                        </tbody> 
                        </table>
                        </form>
                        </td> 
                     </tr>
    
              <!-- Attachments -->  
		  <% out.flush(); %>      
                  <c:import url="RFQModify_Attachments.jsp" />    
		 <% out.flush(); %>             
              <!-- End Attachments -->       

              <!-- Terms and Conditions -->
		  <% out.flush(); %>      
                  <c:import url="RFQModify_TC.jsp" /> 
		  <% out.flush(); %> 
                  <!-- End Terms and Conditions -->   
                           
              <!-- Category Adjustments -->                                 
       <c:if test="${! multiSeller}" >    
		 <% out.flush(); %>  
                  <c:import url="RFQModifyDisplay_CategoryAdjustment.jsp">
                       <c:param name="rfqId" value="${rfqId}" />
                       <c:param name="ppArray" value="${requestScope.ppArray}" />
                  </c:import>   
		<% out.flush(); %>
           </c:if>                                                             
              <!-- End Category Adjustments -->       

              <!-- RFQ Category  -->     
		<% out.flush(); %>
                  <c:import url="RFQModifyDisplay_RFQCategory.jsp" />  
		<% out.flush(); %>  
              <!-- End RFQ Category  -->  

              <!--display product-->  
              <c:set var="pageSize" value="${param.pageSize}" />
              <c:set var="initPos" value="${param.initPos}"  />
		<% out.flush(); %>
              <c:import url="RFQModifyDisplay_Product.jsp">
                     <c:param name="offeringId" value="${rfqId}" />
                     <c:param name="pageSize" value="${pageSize}" />
                     <c:param name="initPos" value="${initPos}" />                                                 
              </c:import> 
		<% out.flush(); %>                                   
              <!--end display product-->   

            </tbody>
            </table> 

            </td>
            <!--FINISH MAIN CONTENT-->
        </tr>
    </tbody>
</table>

<%@ include file="../../include/LayoutContainerBottom.jspf"%>
</body> 
</html>       
