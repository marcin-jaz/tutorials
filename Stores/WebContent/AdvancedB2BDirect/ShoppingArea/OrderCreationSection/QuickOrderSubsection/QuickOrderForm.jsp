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
  * This JSP page displays the Quick Order page with the following elements:
  *  - A tabular list of pairs of 'SKU' and 'Quantity' fields
  *  - 'Order' button
  *  - 'More Items' button
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf"%>
<%--
There are three values for status:
i - displays 32 of the 'SKU','Quantity' pairs of fields.  This status is used by
    the 'Enter More Items' link from the sidebar or header. This is the default value for status.
s - displays a single row (2 pairs) of 'SKU', 'Quantity' fields.  This status is used when handling
    an error while adding an item to the order through the 'Quick Order' sidebar (or header) function.
N - displays the number of 'SKU', 'Quantity' pairs of fields as specified by the 'count' parameter.
	This status is used when the 'More items' button is invoked.
--%>
<c:set var="status" value="${WCParam.status}" scope="request" />
<c:set var="count" value="1"/>
<c:if test="${empty status}">
	<c:set var="status" value="i" scope="request"/>
</c:if>
<c:if test="${(status != 'i') && (status != 's')}">
     <c:if test="${!empty WCParam.count}">
        <c:set var="count" value="${WCParam.count}"/>
     </c:if>
</c:if>
<c:choose>
<%--
The value of 'count' in the MQuickOrderForm form is set to the value contained in 'a'
--%>
<c:when test="${count == 1}">
    <c:set var="a" value="${count + 29}"/>
</c:when>
<c:otherwise>
    <c:set var="a" value="${count + 20}"/>
</c:otherwise>
</c:choose>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN QuickOrderForm.jsp -->
<head>
<title><fmt:message key='Quick_Title' bundle='${storeText}'/></title>
<link rel="stylesheet" href="<c:out value='${jspStoreImgDir}${vfileStylesheet}'/>" type="text/css"/>
<script language="javascript">
var count="<c:out value='${count}'/>";
var strTmp="" ;

//Function to check whether quantity field for given SKU is filled and Vice Versa
function Fields()
{
var form = document.MQuickOrderForm;
var j = 0;
var count=0;
var flag = true ;
if (strTmp != "order")
{   
  for(var i=0; i<form.elements.length && flag==true; ++i)
    {
     if (form.elements[i].name=="partNumber_1" && form.elements[i].type == "text")
        j = 1;
     else
        j = j+1;

     	if (form.elements[i].type == "text")
       		{
          		if(form.elements[i].value == "")
          			 {
            			 	var temp = i;

                                        if (form.elements[i].name.indexOf("partNumber") != -1)
             				{
					alert("<fmt:message key='Quick_Sku_fieldText' bundle='${storeText}'/>"+" "+"<fmt:message key='Quick_Script_Non_Integer1' bundle='${storeText}'/>"+" "+replaceMsgs("<fmt:message key='Quick_Script_Empty_Field' bundle='${storeText}'/>", "{0}", form.elements[i].name.substring(11,form.elements[i].name.length)));
					flag = false ;
					}			
                                        
					
           			} else {
           			 	count ++;
           			}
       		}
    }
}

if(flag == true)
{
for(var i=0; i<form.elements.length ; ++i)
    {
		if (form.elements[i].type == "text")
       		{
          		if(form.elements[i].value == "")
          			 {
            			 	var temp = i;
             				//alert(form.elements[i].name);
                                        if (form.elements[i].name.indexOf("quantity") != -1)
             				{
					form.elements[i].value = "1" ;
					}			
                                        
					
           			}
       		}
    }			
document.MQuickOrderForm.count.value = count;
document.MQuickOrderForm.submit();
}
}

//Function to validate the data in quantity field
function CheckField(field,m)
 {
	var flag = false;
	var form = document.MQuickOrderForm ;
        for (var i=0; i<field.length; i++)
	 {
          var ch = field.substring(i,i+1);
          if (ch < "0" || ch > "9")
		{
		  alert(form.elements[m+1].name.substring(0,8)+" "+"<fmt:message key='Quick_Script_Non_Integer1' bundle='${storeText}'/>"+" "+replaceMsgs("<fmt:message key='Quick_Script_Non_Integer2' bundle='${storeText}'/>", "{0}",form.elements[m+1].name.substring(9,form.elements[m+1].name.length)));	        
		  return false;
		}
        }
         
        if ((field*1) == "0")
		{	      
		  alert(form.elements[m+1].name.substring(0,8)+" "+"<fmt:message key='Quick_Script_Non_Integer1' bundle='${storeText}'/>"+" "+replaceMsgs("<fmt:message key='Quick_Script_Zero_Field' bundle='${storeText}'/>", "{0}",form.elements[m+1].name.substring(9,form.elements[m+1].name.length)));
		  return false;
		}
         
      
        return true;
 }

//Function for adding list of items to Order
function addToOrder()
{
var form = document.MQuickOrderForm;
var flag = false; 
var flag1 = false;
var count = 0; 
 for(var i=0; i<form.elements.length; i++)
    {
     		if(form.elements[i].type == "text")
			{
               			 if (form.elements[i].value != "" && form.elements[i+1].value != "")
                			  {     
						count++;
						if(!CheckField(form.elements[i+1].value,i))
							{
								flag = true ;	
								flag1 = true ;
								break;
							}				
						flag1 = true;
				
                                      
                  			}
               			 else if (form.elements[i].value == "" && form.elements[i+1].value != "") 
                			  {
                   			     alert("<fmt:message key='Quick_Sku_fieldText' bundle='${storeText}'/>"+" "+"<fmt:message key='Quick_Script_Non_Integer1' bundle='${storeText}'/>"+" "+replaceMsgs("<fmt:message key='Quick_Script_Empty_Field' bundle='${storeText}'/>", "{0}", form.elements[i].name.substring(11,form.elements[i].name.length)));
						flag = true ;
						flag1 = true;
						break;
					  }
               			 else if (form.elements[i].value != "" && form.elements[i+1].value == "") 
                			 {
                			   	
					  	 flag1 = true;
					}	

		
              			  i = i+1 ;
                  }

	}
	if(flag1 == false)
		{
			alert("<fmt:message key='Quick_Script_Empty_All' bundle='${storeText}'/>");
			flag = true ;
		}
	if(flag == false)
                {
                 for(var i=0; i<form.elements.length; i++)
                    {
     		      if(form.elements[i].type == "text")
			{
               			
               			if (form.elements[i].value != "" && form.elements[i+1].value == "") 
                			 {
                			   	form.elements[i+1].value = "1";
						count++;
				         }	
		
              			  i = i+1 ;
                          }

  	              }


			for(var b=0; b<form.elements.length; b++)
  			  {
     				if(form.elements[b].type == "text")
					{
						if(form.elements[b].value == "" && form.elements[b+1].value == "")
							{
								form.elements[b].name = "temp1"+b;
								form.elements[b].value = "";
								form.elements[b+1].name = "temp2"+b;
								form.elements[b+1].value = "";
							}
							b = b+1;
					}
	
			}
			document.MQuickOrderForm.action = "OrderItemAdd";
			document.MQuickOrderForm.status.value = "N";
			document.MQuickOrderForm.count.value = count;
			document.MQuickOrderForm.submit();
		}
}

function replaceMsgs(source, pattern, messages) {

	var pos = source.indexOf(pattern);
	var length = pattern.length;
	var before = source.substring(0, pos);
	var after = source.substring(pos+length);    
	source = before + messages + after;
	return source;
     
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
<form name="MQuickOrderForm" method="post" action="QuickOrderView" id="MQuickOrderForm">
          <input type="hidden" name="storeId" value="<c:out value='${storeId}'/>" id="WC_QuickOrderForm_FormInput_storeId_In_MQuickOrderForm_1"/>
          <input type="hidden" name="catalogId" value="<c:out value='${catalogId}'/>" id="WC_QuickOrderForm_FormInput_catalogId_In_MQuickOrderForm_1"/>
          <input type="hidden" name="langId" value="<c:out value='${langId}'/>" id="WC_QuickOrderForm_FormInput_langId_In_MQuickOrderForm_1"/>
          <input type="hidden" name="orderId" value="." id="WC_QuickOrderForm_FormInput_orderId_In_MQuickOrderForm_1"/>
          <input type="hidden" name="outOrderName" value="orderId" id="WC_QuickOrderForm_FormInput_outOrderName_In_MQuickOrderForm_1"/>
          <input type="hidden" name="URL" value="SetPendingOrder?partNumber_*=&amp;quantity_*=&amp;orderItemId*=&amp;temp*=&amp;updatePrices=1&amp;calculationUsageId=-1&amp;URL=OrderCalculate?URL=OrderItemDisplay" id="WC_QuickOrderForm_FormInput_URL_In_MQuickOrderForm_1"/>
          <input type='hidden' name='status' value='N' id="WC_QuickOrderForm_FormInput_status_In_MQuickOrderForm_1"/>
          <input type='hidden' name='errorViewName' value='QuickOrderView' id="WC_QuickOrderForm_FormInput_errorViewName_In_MQuickOrderForm_1"/>
          <table cellpadding="8" cellspacing="0" border="0" id="WC_QuickOrderForm_Table_2">
            <tbody>
              <tr> 
                <td id="WC_QuickOrderForm_TableCell_3"> 

                  <!--MAIN CONTENT STARTS HERE-->

                  <c:set var="badPartNumberList" value="${RequestProperties.excData.badPartNumberList}"/>
<h1><fmt:message key='Quick_Title' bundle='${storeText}'/></h1>
<c:choose>
<c:when test="${!empty badPartNumberList}">
	<fmt:message key="Quick_WrongSku2" bundle="${storeText}" var="badSKUErrorMessage"><fmt:param value="${badPartNumberList}"/></fmt:message>
	<span class="warning"><c:out value="${badSKUErrorMessage}"/></span> <br />
</c:when>
<c:when test="${'_ERR_PS_ENTRY_INVALID' eq storeError.key || '_ERR_PROD_NOT_ORDERABLE' eq storeError.key}">
	<fmt:message key="Newreq_Error_SKU" var="pageErrorMessage" bundle="${storeText}">
		<fmt:param value="${storeError.messageParameters[1]}"/>
	</fmt:message>
	<span class="warning"><c:out value="${pageErrorMessage}" /></span> <br />
</c:when>
<c:when test="${'_ERR_PROCESSING_BUNDLE' eq storeError.key}">
	<span class="warning"><fmt:message key='_ERR_PROCESSING_BUNDLE' bundle='${storeText}'/></span> <br />
</c:when>
<c:otherwise>
	<c:set var="hasErrorToken" value="false"/>
	<c:set var="firstToken" value="true"/>
	<c:forTokens items="${errorMessage}" delims="CMN" var="token">
		<c:if test="${firstToken==false}">
			<c:set var="hasErrorToken" value="true"/>
		</c:if>
		<c:set var="firstToken" value="false"/>
	</c:forTokens>
	<c:if test="${hasErrorToken==false && !(storeError.key == '_ERR_BAD_MISSING_CMD_PARAMETER' && storeError.messageParameters[0] == 'orderItemId')}">
		<span class="warning">&nbsp;<c:out value="${errorMessage}" /></span>
	</c:if>
	<br />
</c:otherwise>
</c:choose>
<br /> <fmt:message key='Quick_Text' bundle='${storeText}'/></td>
              </tr>
            </tbody>
          </table>
          <table cellpadding="8" cellspacing="0" border="0" id="WC_QuickOrderForm_Table_3">
            <tbody>
              <tr> 
                <td id="WC_QuickOrderForm_TableCell_4"> <table cellpadding="0" cellspacing="0" border="0" width="620" class="bgColor" id="WC_QuickOrderForm_Table_4">
                    <tbody>
                      <tr> 
                        <td id="WC_QuickOrderForm_TableCell_5"> <table width="100%" border="0" cellpadding="2" cellspacing="1" id="WC_QuickOrderForm_Table_5">
							<fmt:message key='Quick_Col1' bundle='${storeText}' var='SkuText'/>
							<fmt:message key='Quick_Col2' bundle='${storeText}' var='QtyText'/>
                            <tr class="bgColor"> 
                                      <td valign="top" id="WC_QuickOrderForm_TableCell_7">&nbsp;</td>
                                      <th valign="top" class="colHeader" id="QuickOrderForm_SKU1"><c:out value='${SkuText}'/></th>
                                      <th valign="top" class="colHeader" id="QuickOrderForm_Qty1"><c:out value='${QtyText}'/></th>
                                      <td valign="top" id="WC_QuickOrderForm_TableCell_13">&nbsp;</td>
                                      <th valign="top" class="colHeader" id="QuickOrderForm_SKU2"><c:out value='${SkuText}'/></th>
                                      <th valign="top" class="colHeader" id="QuickOrderForm_Qty2"><c:out value='${QtyText}'/></th>
                            </tr>
<c:choose>
<c:when test="${(storeError.key eq '_ERR_PROD_NOT_EXISTING') || ('_ERR_PS_ENTRY_INVALID' eq storeError.key) || ('_ERR_PROD_NOT_ORDERABLE' eq storeError.key)}">
<c:forEach begin="1" end="${count}" var="i" step="2" varStatus="b">
                            <tr> 
                              <td align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_18_<c:out value='${i}'/>"><c:out value='${i}'/></td>
                              <c:set var="partNumber_i" value="partNumber_${i}"/>
                              <c:set var="quantity_i" value="quantity_${i}"/>
                              <td headers="QuickOrderForm_SKU1" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_19_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"></label><input type="text" maxlength="64" name='partNumber_<c:out value='${i}'/>' title="<c:out value='${SkuText} ${i}'/>" size="8" value="<c:out value='${WCParam[partNumber_i]}'/>" id="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"/></td>
                              <td headers="QuickOrderForm_Qty1" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_20_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"></label><input type="text" maxlength="4" name='quantity_<c:out value='${i}'/>'  title="<c:out value='${QtyText} ${i}'/>" size="6" value="<c:out value='${WCParam[quantity_i]}'/>" id="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"/></td>
<c:set var="i" value="${i+1}"/>
                              <td align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_21_<c:out value='${i}'/>"><c:out value='${i}'/></td>

                              <c:set var="partNumber_i" value="partNumber_${i}"/>
                              <c:set var="quantity_i" value="quantity_${i}"/>                      
                              
                              <td headers="QuickOrderForm_SKU2" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_22_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_2_<c:out value='${i}'/>"></label><input type="text" maxlength="64" name='partNumber_<c:out value='${i}'/>' title="<c:out value='${SkuText} ${i}'/>" size="8" value="<c:out value='${WCParam[partNumber_i]}'/>" id="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_2_<c:out value='${i}'/>"/></td>
                              <td headers="QuickOrderForm_Qty2" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_23_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_2_<c:out value='${i}'/>"></label><input type="text" maxlength="4" name='quantity_<c:out value='${i}'/>'  title="<c:out value='${QtyText} ${i}'/>" size="6" value="<c:out value='${WCParam[quantity_i]}'/>" id="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_2_<c:out value='${i}'/>"/></td>
                            </tr>
 </c:forEach>
                            <input type='hidden' name='count' value="<c:out value='${count}'/>" id="WC_QuickOrderForm_FormInput_count_In_MQuickOrderForm_1"/>
</c:when>
<c:when test="${storeError.key eq '_ERR_GETTING_SKU'}">
<c:forEach begin="1" end="${count}" var="i">
                            <c:set var="partNumber_i" value="partNumber_${i}"/>
                            <c:set var="quantity_i" value="quantity_${i}"/>
                            <tr> 
                              <td align="center" class="<c:out value='cellBG_${((i+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_24_<c:out value='${i}'/>"><c:out value='${i}'/></td>                                                  
                              <td headers="QuickOrderForm_SKU1" align="center" class="<c:out value='cellBG_${((i+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_25_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_3_<c:out value='${i}'/>"></label><input type="text" maxlength="64" name='partNumber_<c:out value='${i}'/>' title="<c:out value='${SkuText} ${i}'/>" size="8" value="<c:out value='${WCParam[partNumber_i]}'/>" id="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_3_<c:out value='${i}'/>"/></td>
                              <td headers="QuickOrderForm_Qty1" align="center" class="<c:out value='cellBG_${((i+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_26_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_3_<c:out value='${i}'/>"></label><input type="text" maxlength="4" name='quantity_<c:out value='${i}'/>'  title="<c:out value='${QtyText} ${i}'/>" size="6" value="<c:out value='${WCParam[quantity_i]}'/>" id="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_3_<c:out value='${i}'/>"/></td>
<c:set var="i" value="${i+1}"/>

                            <c:set var="partNumber_i" value="partNumber_${i}"/>
                            <c:set var="quantity_i" value="quantity_${i}"/>
                              <td align="center" class="<c:out value='cellBG_${((i+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_27_<c:out value='${i}'/>"><c:out value='${i}'/></td>                                                       
                              <td headers="QuickOrderForm_SKU2" align="center" class="<c:out value='cellBG_${((i+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_28_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_4_<c:out value='${i}'/>"></label><input type="text" maxlength="64" name='partNumber_<c:out value='${i}'/>' title="<c:out value='${SkuText} ${i}'/>" size="8" value="<c:out value='${WCParam[partNumber_i]}'/>" id="WC_QuickOrderForm_FormInput_partNumber_<c:out value='${i}'/>_In_MQuickOrderForm_4_<c:out value='${i}'/>"/></td>
                              <td headers="QuickOrderForm_Qty2" align="center" class="<c:out value='cellBG_${((i+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_29_<c:out value='${i}'/>"><label for="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_4_<c:out value='${i}'/>"></label><input type="text" maxlength="4" name='quantity_<c:out value='${i}'/>'  title="<c:out value='${QtyText} ${i}'/>" size="6" value="<c:out value='${WCParam[quantity_i]}'/>" id="WC_QuickOrderForm_FormInput_quantity_<c:out value='${i}'/>_In_MQuickOrderForm_4_<c:out value='${i}'/>"/></td>
                            </tr>
</c:forEach>
                            <input type='hidden' name='count' value="<c:out value='${count}'/>" id="WC_QuickOrderForm_FormInput_count_In_MQuickOrderForm_2"/>
</c:when>
<c:otherwise>
<c:set var="seed" value="0"/>
<c:if test="${(status != 'i') && (status != 's')}">
<c:forEach begin='1' end='${count}' var='i' step='2' varStatus='b'>
                            <tr> 
                              <c:set var='partNumber_i' value='partNumber_${i}'/>
                              <c:set var='quantity_i' value='quantity_${i}'/>
                              <c:set var='partNumber_i1' value='partNumber_${i+1}'/>
                              <c:set var='quantity_i1' value='quantity_${i+1}'/>
                              <td align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_30_<c:out value='${i}'/>"><c:out value='${i}'/></td>
                              <td headers="QuickOrderForm_SKU1" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_31_<c:out value='${i}'/>"> 
                              	<label for="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"></label>
                                <input type="text" maxlength="64" name='<c:out value="${partNumber_i}"/>' value='<c:out value="${WCParam[partNumber_i]}"/>' title="<c:out value='${SkuText} ${i}'/>" size="8" id="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"/> 
                              </td>
                              <td headers="QuickOrderForm_Qty1" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_32_<c:out value='${i}'/>"> 
                                <label for="WC_QuickOrderForm_FormInput_<c:out value='${quantity_i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"></label>
                                <input type="text" size="6" maxlength="4" name='<c:out value="${quantity_i}"/>' value='<c:out value="${WCParam[quantity_i]}"/>'  title="<c:out value='${QtyText} ${i}'/>" id="WC_QuickOrderForm_FormInput_<c:out value='${quantity_i}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"/> 
                              </td>
                              <td align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_33_<c:out value='${i}'/>"><c:out value="${i+1}"/></td>
                              <td headers="QuickOrderForm_SKU2" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_34_<c:out value='${i}'/>"> 
                                <label for="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_i1}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"></label>
                                <input type="text" maxlength="64" name='<c:out value="${partNumber_i1}"/>' value='<c:out value="${WCParam[partNumber_i1]}"/>' title="<c:out value='${SkuText} ${i+1}'/>" size="8" id="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_i1}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"/> 
                              </td>
                              <td headers="QuickOrderForm_Qty2" align="center" class="<c:out value='cellBG_${((b.count+1) % 2) + 1}'/>" id="WC_QuickOrderForm_TableCell_35_<c:out value='${i}'/>"> 
                              	<label for="WC_QuickOrderForm_FormInput_<c:out value='${quantity_i1}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"></label>
                                <input type="text" size="6" maxlength="4" name='<c:out value="${quantity_i1}"/>' value='<c:out value="${WCParam[quantity_i1]}"/>'  title="<c:out value='${QtyText} ${i+1}'/>" id="WC_QuickOrderForm_FormInput_<c:out value='${quantity_i1}'/>_In_MQuickOrderForm_1_<c:out value='${i}'/>"/> 
                              </td>
                            </tr>
                            <c:set var='seed' value='${b.count}'/>
</c:forEach>
</c:if>
<c:choose>
<c:when test="${count == 1}">
    <c:set var="x" value="31"/>
</c:when>
<c:otherwise>
    <c:set var="x" value="21"/>
</c:otherwise>
</c:choose>

<c:forEach begin="1" end="${x}" var="k" step="2" varStatus="b">
<c:choose>
<c:when test="${count == 1}">
    <c:set var="p" value="${count + k - 1}"/>
</c:when>
<c:otherwise>
    <c:set var="p" value="${count + k}"/>
</c:otherwise>
</c:choose>

<c:set var="partNumber_p" value="partNumber_${p}"/>
<c:set var="quantity_p" value="quantity_${p}"/>
<c:set var="partNumber_p1" value="partNumber_${p+1}"/>
<c:set var="quantity_p1" value="quantity_${p+1}"/>
                            <tr class="<c:out value='cellBG_${((b.count + seed + 1) % 2) + 1}'/>"> 
                              <td align="center" id="WC_QuickOrderForm_TableCell_36_<c:out value='${k}'/>"><c:out value="${p}"/></td>                          
                              <td headers="QuickOrderForm_SKU1" align="center" id="WC_QuickOrderForm_TableCell_37_<c:out value='${k}'/>"><label for="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_p}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"></label><input type="text" maxlength="64" name='<c:out value="${partNumber_p}"/>' title="<c:out value='${SkuText} ${p}'/>" size="8" value="" id="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_p}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"/></td>
                              <td headers="QuickOrderForm_Qty1" align="center" id="WC_QuickOrderForm_TableCell_38_<c:out value='${k}'/>"><label for="WC_QuickOrderForm_FormInput_<c:out value='${quantity_p}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"></label><input type="text" maxlength="4" name='<c:out value="${quantity_p}"/>' title="<c:out value='${QtyText} ${p}'/>" size="6" value="" id="WC_QuickOrderForm_FormInput_<c:out value='${quantity_p}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"/></td>
                              <td align="center" id="WC_QuickOrderForm_TableCell_39_<c:out value='${k}'/>"><c:out value="${p+1}"/></td>                              
                              <td headers="QuickOrderForm_SKU2" align="center" id="WC_QuickOrderForm_TableCell_40_<c:out value='${k}'/>"><label for="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_p1}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"></label><input type="text" maxlength="64" name='<c:out value="${partNumber_p1}"/>' title="<c:out value='${SkuText} ${p+1}'/>" size="8" value="" id="WC_QuickOrderForm_FormInput_<c:out value='${partNumber_p1}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"/></td>
                              <td headers="QuickOrderForm_Qty2" align="center" id="WC_QuickOrderForm_TableCell_41_<c:out value='${k}'/>"><input type="text" maxlength="4" name='<c:out value="${quantity_p1}"/>' title="<c:out value='${QtyText} ${p+1}'/>" size="6" value="" id="WC_QuickOrderForm_FormInput_<c:out value='${quantity_p}'/>_In_MQuickOrderForm_1_<c:out value='${k}'/>"/></td>
                            </tr>
</c:forEach>
                            <input type='hidden' name='count' value="<c:out value='${a}'/>" id="WC_QuickOrderForm_FormInput_count_In_MQuickOrderForm_3"/>
</c:otherwise>
</c:choose>
                          </table></td>
                      </tr>
                    </tbody>
                  </table></td>
              </tr>
            </tbody>
          </table>
          <table cellpadding="8" cellspacing="0" border="0" width="620" id="WC_QuickOrderForm_Table_12">
            <tbody>
              <tr> 
                <td id="WC_QuickOrderForm_TableCell_42"> <a class="button" href="javascript:addToOrder()" id="WC_QuickOrderForm_Link_1"><fmt:message key='Quick_Add_To_Order' bundle='${storeText}'/></a> &nbsp; <a href="javascript:Fields()" class="button" id="WC_QuickOrderForm_Link_2"><fmt:message key='Quick_More_Items' bundle='${storeText}'/></a> </td>
              </tr>
            </tbody>
          </table>
        </form>
<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</body>
<!-- END QuickOrderForm.jsp -->
</html>
