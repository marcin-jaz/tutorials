<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2003
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<!-- BEGIN QUICKLINKS  -->
<%@ include file="EnvironmentSetup.jsp"%>

<%
String userId = cmdcontext.getUserId().toString();
String errorType = (String)request.getParameter("errorType");
String errorView = (String)request.getParameter("errorView");

boolean quickPriceAvailabilityError = false;

if (errorType != null && errorType.equals("InvalidEntry")) {
	quickPriceAvailabilityError = true;
}
%>

<script language="JavaScript">

function CallQuickOrder(form)
		{
		if (form.partNumber.value.length<1)
		{
			alert("<%=storeText.getString("QuickLinks_MissingSKU")%>");
			}
		else 
		{
			form.action='OrderItemAdd';
			form.submit();
			}
		}
		
function CallRequestPriceAvail(form)
		{
		if (form.partNumber.value.length<1)
		{
			alert("<%=storeText.getString("QuickLinks_MissingSKU")%>");
			}
		else if (form.quantity.value.length<1)
		{
			alert("<%=storeText.getString("QuickLinks_MissingQuantity")%>");
			}
		else if (form.quantity.value < 1)
		{
			alert("<%=storeText.getString("QuickLinks_InvalidQuantity")%>");
			}
		else 
		{
			form.action='CreateQuotationRequestView';
			form.submit();
			}
		}
</script>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tbody>
		<tr>
			<td class="tblue" height="20">&nbsp;<%=storeText.getString("QuickLinks_Title")%></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="1" alt="" src="<%=fileDir%>images/dotted_rule_150px.gif" width="150" /></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /></td>
		</tr>
		<tr>
			<td><b><%=storeText.getString("QuickLinks_ReqPriceAvail")%></b></td>
		</tr>
		<%
  if (quickPriceAvailabilityError) {
  	%>
		<tr>
			<td><font class="error"><%=storeText.getString("QuickLinks_InvalidEntry")%></font></td>
		</tr>
		<%
  	}
  	%>
		<tr>
			<td><label for="Quantity1"><%=storeText.getString("QuickLinks_Quantity")%></label></td>
		</tr>
		<tr>
			<td valign="bottom">
				<form name="RequestPriceAvail" action="javascript:CallRequestPriceAvail(document.RequestPriceAvail)" method="post" class="inlineform">
				<input type="hidden" name="storeId" value="<%=storeId%>" />
				<input type="hidden" name="catalogId" value="<%=catalogId%>" />
				<input type="hidden" name="errorViewName" value="<%=errorView%>" /> 
				<input type="hidden" name="errorType" value="InvalidEntry" />
					<table cellspacing="0" cellpadding="0" border="0">
					<tbody>
							<tr>
								<td colspan="2"><input type="text" class="iform" size="6" name="quantity" id="Quantity1" /></td>
							</tr>
							<tr>
								<td colspan="2"><label for="PartNumber1"><%=storeText.getString("QuickLinks_PartNumber")%></label></td>
							</tr>
							<tr>
								<td><input type="text" class="iform" size="11" name="partNumber" id="PartNumber1" /></td>
								<td valign="bottom">&nbsp; <input type="image" src="<%=fileDir%><%=locale.toString()%>/images/go.gif" border="0" name="go" alt='<%=storeText.getString("Logon_Go")%>' /></td>
							</tr>
					</tbody>
				</table>
				</form>
			</td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="1" alt="" src="<%=fileDir%>images/dotted_rule_150px.gif" width="150" /></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
		<tr>
			<td><b><%=storeText.getString("QuickLinks_AddToCart")%></b></td>
		</tr>
		<tr>
			<td><label for="PartNumber2"><%=storeText.getString("QuickLinks_PartNumber")%></label></td>
		</tr>
		<tr>
			<td>
				<form name="QuickOrderForm" action="javascript:CallQuickOrder(document.QuickOrderForm)" method="post" class="inlineform">
				<input type="hidden" name="storeId" value="<%=storeId%>" />
				<input type="hidden" name="orderId" value="." />
				<input type="hidden" name="catalogId" value="<%=catalogId%>" />
				<input type="hidden" name="langId" value="<%=languageId%>" />
				<input type="hidden" name="quantity" value="1" />
				<input type="hidden" name="allocate" value="*n" />
				<input type="hidden" name="reverse" value="*n" />
				<input type="hidden" name="backorder" value="*n" />
				<input type="hidden" name="check" value="*n" />
				<input type="hidden" name="merge" value="*n" />
				<input type="hidden" name="remerge" value="*n" />
				<input type="hidden" name="URL" value="OrderItemDisplay" />
				<input type="hidden" name="callingpage" value="QuickLinks" />
				<input type="hidden" name="errorViewName" value="MultiplePartNumberDisplayView" />
				<table cellspacing="0" cellpadding="0" border="0">
					<tbody>
							<tr>
								<td><input type="text" class="iform" size="11" name="partNumber" id="PartNumber2" value="" /></td>
								<td valign="bottom">&nbsp; <input type="image" src="<%=fileDir%><%=locale.toString()%>/images/go.gif" border="0" name="go" alt='<%=storeText.getString("Logon_Go")%>' /></td>
							</tr>
					</tbody>
				</table>
				</form>
			</td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="1" alt="" src="<%=fileDir%>images/dotted_rule_150px.gif" width="150" /></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
		<tr>
			<td><a style="text-decoration: none" href="MultiplePartNumberDisplayView?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><b><%=storeText.getString("QuickLinks_MultiplePartNumber")%></b></a></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="1" alt="" src="<%=fileDir%>images/dotted_rule_150px.gif" width="150" /></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /><spacer type="block" width="1" height="1"></spacer></td>
		</tr>
		<tr>
			<td><a style="text-decoration: none" href="FeaturedProductsDisplayView?catalogId=<%=catalogId%>&amp;storeId=<%=storeId%>&amp;langId=<%=languageId%>"><b><%=storeText.getString("QuickLinks_Featured")%></b></a></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="5" alt="" src="<%=fileDir%>images/c.gif" width="1" /></td>
		</tr>
		<tr>
			<td class="tdheightFix"><img height="1" alt="" src="<%=fileDir%>images/dotted_rule_150px.gif" width="150" /></td>
		</tr>
	</tbody>
</table>
<br />
<!-- END QUICKLINKS  -->
