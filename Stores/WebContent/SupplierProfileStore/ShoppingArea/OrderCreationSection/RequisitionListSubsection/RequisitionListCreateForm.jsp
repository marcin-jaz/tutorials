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
  * This JSP page displays the New Requisition List page with the following elements:
  *  - 'Requisition list name' entry field
  *  - 'Type' drop down with values Private and Shared
  *  - A tabular list of pairs of 'SKU' and 'Quantity' fields
  *  - 'Save' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
	
<%-- Page specific error messages --%>
<c:choose>
<c:when test="${'_ERR_BAD_MISSING_CMD_PARAMETER' eq storeError.key}">
	<fmt:message key="Newreq_Error_Missing_Parameter" var="pageErrorMessage" bundle="${storeText}"/>			
</c:when>
<c:when test="${'_ERR_PROD_NOT_EXISTING' eq storeError.key}">
	<fmt:message key="Newreq_Error_SKU" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${storeError.messageParameters[0]}"/>
	</fmt:message>			
</c:when>
<c:when test="${'_ERR_PS_ENTRY_INVALID' eq storeError.key || '_ERR_PROD_NOT_ORDERABLE' eq storeError.key}">
	<fmt:message key="Newreq_Error_SKU" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${storeError.messageParameters[1]}"/>
	</fmt:message>			
</c:when>
<c:when test="${'_ERR_INVALID_INPUT' eq storeError.key}">
	<fmt:message key="Newreq_Error_Quantity" var="pageErrorMessage" bundle="${storeText}">			
		<fmt:param value="${WCParam.quantity}"/>
	</fmt:message>				
</c:when>
<c:when test="${'_ERR_PROCESSING_BUNDLE' eq storeError.key}">
	<fmt:message key="Newreq_Error_BundleAdd" var="pageErrorMessage" bundle="${storeText}" />
</c:when>
<c:otherwise>
	<c:set var="pageErrorMessage" value="${errorMessage}"/>
</c:otherwise>
</c:choose>

<c:set var="name" value="${WCParam.name}" />
<c:set var="status" value="${WCParam.status}"/>
<c:set var="type" value="${WCParam.type}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN RequisitionListCreateForm.jsp -->
<head>
<title><fmt:message key="Newreq_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<script language="javascript">
function Add2ReqList(form)
{
  var i;

  for (i=0;i<30;i++) 
  {
	if (( !(form.elements[i*2+4].value == "")) && (form.elements[i*2+5].value == ""))
	{
		form.elements[i*2+5].value = "1";
	}

  }

  form.name.value = form.name.value.replace(/^\s+/g, "");
      
   <fmt:message key="Newreq_Error_Name" bundle="${storeText}" var="Newreq_Error_Name"/>
  if (form.name.value == '') {
         alert(<wcf:json object="${Newreq_Error_Name}"/>);
  }
  else {
         form.submit();
  }
}

</script>
</head>
<body class="noMargin">
<flow:ifEnabled feature="customerCare"> 
<%--
Set header type needed for this JSP for LiveHelp.  This must be set before HeaderDisplay.jsp
--%>
<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled> 
<%@ include file="../../../include/LayoutContainerTop.jspf"%>
        <!--content start-->
        <c:if test="${!empty pageErrorMessage}">
			<span class="warning"><c:out value="${pageErrorMessage}"/></span>
		</c:if>
		<c:if test="${!empty WCParam.partNumber && empty WCParam.partNumber_1}">
			<c:set target="${WCParam}" property="partNumber_1" value="${WCParam.partNumber}"/>
		</c:if>
		<c:if test="${!empty WCParam.quantity && empty WCParam.quantity_1}">
			<c:set target="${WCParam}" property="quantity_1" value="${WCParam.quantity}"/>
		</c:if>		
		<c:url value="RequisitionListUpdateView" var="reqListUpdateViewURL">
		    <c:param name="storeId" value="${storeId}"/>
		    <c:param name="catalogId" value="${catalogId}"/>
   			<c:param name="partNumber_*" value="" />
   			<c:param name="quantity_*" value="" />
        </c:url>  
		<form name="NewRequisitionListForm" action="RequisitionListItemUpdate" method="post" id="NewRequisitionListForm">
          <table cellpadding="8" cellspacing="0" border="0" width="100%" id="WC_RequisitionListCreateForm_Table_2">
            <tbody>
              <tr>
                <td id="WC_RequisitionListCreateForm_TableCell_3"><h1><fmt:message key="Newreq_Title" bundle="${storeText}"/></h1>
                  <input type="hidden" name="URL" value="<c:out value='${reqListUpdateViewURL}'/>" id="WC_RequisitionListCreateForm_FormInput_URL_In_NewRequisitionListForm_1"/>
                  <input type="hidden" name="errorViewName" value="RequisitionListCreateView" id="WC_RequisitionListCreateForm_FormInput_errorViewName_In_NewRequisitionListForm_1"/>
                  <input type="hidden" name="storeId" value="<c:out value='${storeId}'/>" id="WC_RequisitionListCreateForm_FormInput_storeId_In_NewRequisitionListForm_1" />
                  <input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="WC_RequisitionListCreateForm_FormInput_catalogId_In_NewRequisitionListForm_1" />
                  <table cellspacing="0" border="0" id="WC_RequisitionListCreateForm_Table_3">
                    <tbody>
                      <tr>
                        <td id="WC_RequisitionListCreateForm_TableCell_4"><label for="RequisitionListCreateForm_Name"><fmt:message key="Newreq_Name" bundle="${storeText}"/></label></td>
                      </tr>
                      <%--
                      ***
                      * Requisition list name entry field
                      ***
                      --%>
                      <tr>
                        <td id="WC_RequisitionListCreateForm_TableCell_5"><input class="input" type="text" name="name" value="<c:out value="${name}"/>" id="RequisitionListCreateForm_Name"/></td>
                      </tr>
                      <tr>
                        <td id="WC_RequisitionListCreateForm_TableCell_6"><label for="RequisitionListCreateForm_Status"><fmt:message key="Newreq_Type" bundle="${storeText}"/></label></td>
                      </tr>
                      <%--
                      ***
                      * Requisition list type drop down
                      ***
                      --%>                      
                      <tr>
                        <td id="WC_RequisitionListCreateForm_TableCell_7">
                        <a name="status" id="WC_RequisitionListCreateForm_Link_1">
	                          <select class="select" name="status" id="RequisitionListCreateForm_Status">
	                          <c:choose>
	                          <c:when test="${status eq 'Y'}" >
	                          	<c:set var="selectedY" value="selected=\"selected\""/>
	                          	<c:set var="selectedZ" value=""/>                          	
	                          </c:when>
	                          <c:otherwise>
	                          	<c:set var="selectedY" value=""/>                          
	                          	<c:set var="selectedZ" value="selected=\"selected\""/>                          
	                          </c:otherwise>
	                          </c:choose>
	                            <option value="Y" <c:out value="${selectedY}"/>><fmt:message key="Newreq_Drop1" bundle="${storeText}"/></option>
	                            <option value="Z" <c:out value="${selectedZ}"/>><fmt:message key="Newreq_Drop2" bundle="${storeText}"/></option>
	                          </select>
                          </a> 
                          </td>
                      </tr>
                    </tbody>
                  </table>
                  <br /> <fmt:message key="Newreq_Text" bundle="${storeText}"/>  </td>
              </tr>
              <tr>
                <td id="WC_RequisitionListCreateForm_TableCell_8">
                    <table class="bgColor" width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_RequisitionListCreateForm_Table_5">
                             <fmt:message key="Newreq_SKU" bundle="${storeText}" var="SkuText"/>
                             <fmt:message key="Newreq_Quantity" bundle="${storeText}" var="QuantityText"/>                            
                              <tr>
                                        <th width="6%" valign="top" class="colHeader" id="RequisitionListCreateFormTH_Num1">&nbsp;</td>
                                        <th width="22%" valign="top" class="colHeader" id="RequisitionListCreateFormTH_SKU1"><c:out value='${SkuText}'/></th>
                                        <th width="22%" align="center" valign="top" class="colHeader_last" id="RequisitionListCreateFormTH_Quantity1"><c:out value='${QuantityText}'/></th>
                                        <th width="6%" valign="top" class="colHeader" id="RequisitionListCreateFormTH_Num2">&nbsp;</td>
                                        <th width="22%" valign="top" class="colHeader" id="RequisitionListCreateFormTH_SKU2"><c:out value='${SkuText}'/></th>
                                        <th width="22%" align="center" valign="top" class="colHeader_last" id="RequisitionListCreateFormTH_Quantity2"><c:out value='${QuantityText}'/></th>
                              </tr>      
                         <%--
                         ***
                         * Start: table of SKU, Quantity pairs of entry fields
                         ***
                         --%>
						<c:forEach var="i" begin="0" end="14">                                                                
                              <tr>
						        <c:set var="c1PartNumber" value="partNumber_${i*2+1}" />
                                <c:set var="c1Quantity" value="quantity_${i*2+1}" />                                
                                <c:set var="c2PartNumber" value="partNumber_${i*2+2}" />
                                <c:set var="c2Quantity" value="quantity_${i*2+2}" />    
                                <td align="center" class="<c:out value="cellBG_${((i+1) % 2) + 1}"/> t_td" id="WC_RequisitionListCreateForm_TableCell_28_<c:out value="${i}"/>"><c:out value="${i*2+1}"/></td>                                                   
                                <td headers="RequisitionListCreateFormTH_SKU1" class="<c:out value="cellBG_${((i+1) % 2) + 1}"/> t_td" id="WC_RequisitionListCreateForm_TableCell_29_<c:out value="${i}"/>">
                                	<label for="WC_RequisitionListCreateForm_FormInput_<c:out value="${c1PartNumber}"/>_In_NewRequisitionListForm_1_<c:out value="${i}"/>"></label>
                                	<input class="input" type="text" size="20" name="<c:out value="${c1PartNumber}"/>" title="<c:out value='${SkuText} ${i*2+1}'/>" value="<c:out value="${WCParam[c1PartNumber]}"/>" id="WC_RequisitionListCreateForm_FormInput_<c:out value="${c1PartNumber}"/>_In_NewRequisitionListForm_1_<c:out value="${i}"/>"/>
                                </td>
                                <td align="center" headers="RequisitionListCreateFormTH_Quantity1" class="<c:out value="cellBG_${((i+1) % 2) + 1}"/> t_td" id="WC_RequisitionListCreateForm_TableCell_30_<c:out value="${i}"/>">
                                	<label for="WC_RequisitionListCreateForm_FormInput_<c:out value="${c1Quantity}"/>_In_NewRequisitionListForm_1_<c:out value="${i}"/>"></label>
                                	<input class="input" type="text" size="3" name="<c:out value="${c1Quantity}"/>" title="<c:out value='${QuantityText} ${i*2+1}'/>" value="<c:out value="${WCParam[c1Quantity]}"/>" id="WC_RequisitionListCreateForm_FormInput_<c:out value="${c1Quantity}"/>_In_NewRequisitionListForm_1_<c:out value="${i}"/>"/>
                                </td>
                                <td align="center" class="<c:out value="cellBG_${((i+1) % 2) + 1}"/> t_td" id="WC_RequisitionListCreateForm_TableCell_31_<c:out value="${i}"/>"><c:out value="${i*2+2}"/></td>
                                <td headers="RequisitionListCreateFormTH_SKU2" class="<c:out value="cellBG_${((i+1) % 2) + 1}"/> t_td" id="WC_RequisitionListCreateForm_TableCell_32_<c:out value="${i}"/>"><input class="input" type="text" size="20" name="<c:out value="${c2PartNumber}"/>" title="<c:out value='${SkuText} ${i*2+2}'/>" size="8" value="<c:out value="${WCParam[c2PartNumber]}"/>" id="WC_RequisitionListCreateForm_FormInput_<c:out value="${c2PartNumber}"/>_In_NewRequisitionListForm_1_<c:out value="${i}"/>"/></td>
                                <td align="center" headers="RequisitionListCreateFormTH_Quantity2" class="<c:out value="cellBG_${((i+1) % 2) + 1}"/> t_td" id="WC_RequisitionListCreateForm_TableCell_33_<c:out value="${i}"/>"><input class="input" type="text" size="3" name="<c:out value="${c2Quantity}"/>" title="<c:out value='${QuantityText} ${i*2+2}'/>" size="6" value="<c:out value="${WCParam[c2Quantity]}"/>" id="WC_RequisitionListCreateForm_FormInput_<c:out value="${c2Quantity}"/>_In_NewRequisitionListForm_1_<c:out value="${i}"/>"/></td>
                              </tr>
 						</c:forEach>
                         <%--
                         ***
                         * End: table of SKU, Quantity pairs of entry fields
                         ***
                         --%>
                  </table></td>
              </tr>
            </tbody>
          </table>
           <c:set var="totalCatentryInBundle" value="${WCParam.totalCatentryInBundle}" scope="request" />
           <c:if test="${!empty totalCatentryInBundle}">
           	<c:forEach var="i" begin="1" end="${totalCatentryInBundle}">
							<c:set var="strAttrName" value="attrName_${i}" />
							<c:set var="strAttrValue" value="attrValue_${i}" />
							<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
								<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
									<c:if test="${aParam.key == strAttrName || aParam.key == strAttrValue}">
										<input type="hidden" name="<c:out value="${aParam.key}"/>" value="<c:out value="${aValue}"/>" id="WC_RequisitionListAddToListForm_FormInput_<c:out value="${aParam.key}${aValue}"/>_In_RequisitionListForm_1"/>
									</c:if>
								</c:forEach>
							</c:forEach>
 						</c:forEach>
 					</c:if>
        </form>
        <%--
        ***
        * Save button
        ***
        --%>
        <table cellpadding="0" cellspacing="0" border="0" id="WC_RequisitionListCreateForm_Table_12">
          <tr>
            <td id="WC_RequisitionListCreateForm_TableCell_34"><a class="button" href="javascript:Add2ReqList(document.NewRequisitionListForm)" id="WC_RequisitionListCreateForm_Link_2">
              <fmt:message key="Newreq_Button" bundle="${storeText}"/></a></td>
          </tr>
        </table>
        <!--content end-->
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END RequisitionListCreateForm.jsp -->
</html>
