<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2003
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
//
// Change History
//
// YYMMDD    F/D#   WHO       Description
//------------------------------------------------------------------------------
// 
////////////////////////////////////////////////////////////////////////////////
--%>


<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean" %>


<%@ page import="com.ibm.commerce.catalog.beans.ProductDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.ras.ECMessageKey" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>
<%
//Parameters may be encrypted. Use JSPHelper to get
//URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String storeId = jhelper.getParameter("storeId");
String catalogId = jhelper.getParameter("catalogId");
String languageId = jhelper.getParameter("langId");
String cmdStoreId = jhelper.getParameter("cmdStoreId");

// show Logon page if user is not registered or not approved
UserRegistrationDataBean bnRegUser = new UserRegistrationDataBean();
com.ibm.commerce.beans.DataBeanManager.activate(bnRegUser, request);
String userState = cmdcontext.getUser().getState();
String errorString = "";
String errorfile = storeDir + "UserArea/AccountSection/LogonSubsection/UserLogonForm.jsp";
if (!userState.equals("1"))  // if user is not approved
{
	errorString = "AUTHORIZATION_ERROR2";
	if (!bnRegUser.findUser()) // if user is a guest
		errorString = "AUTHORIZATION_ERROR1";
%>
	<jsp:include page="<%=errorfile%>" flush="true"/>
<%
	return;
}

String status = jhelper.getParameter("status");
// use count to determine total no. of rows to be displayed in the QuickOrder Page 
// in different scenarios.
int count=1;
if(!status.equals("i")&&!status.equals("s")) {
	count = Integer.parseInt(jhelper.getParameter("count"));
}
int a = 0;
if(count == 1) {
	a = count+29;
} else {
	a = count+20;
}
int p =0;
String sku = null;
String q = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dTD">
<html>

<HEAD>
	<TITLE><%=tooltechtext.getString("Quick_Title")%></TITLE>

<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>
<Script language="javascript">
var count="<%=count%>";
var strTmp="" ;

//Function to check whether quantity field for given SKU is filled and Vice Versa
function Fields() {
	var form = document.MQuickOrderForm;
	var j = 0;
	var flag = true ;
	if (strTmp != "order") {   
		for(var i=0; i<form.elements.length && flag==true; ++i) {
			if (form.elements[i].name=="partNumber_1" && form.elements[i].type == "text") {
				j = 1;
			} else {
				j = j+1;
			}
			
			if (form.elements[i].type == "text") {
				if(form.elements[i].value == "") {
					var temp = i;
					//alert(form.elements[i].name);
					if (form.elements[i].name.indexOf("partNumber") != -1) {
						alert("<%=tooltechtext.getString("Quick_Sku_fieldText")%>"+" "+"<%=tooltechtext.getString("Quick_Script_Non_Integer1")%>"+" "+form.elements[i].name.substring(11,form.elements[i].name.length)+" "+"<%=tooltechtext.getString("Quick_Script_Empty_Field")%>");
						flag = false ;
					}			
				}
			}
		}
	}

	if(flag == true) {
		for(var i=0; i<form.elements.length ; ++i) {
			if (form.elements[i].type == "text") {
          			if(form.elements[i].value == "") {
            			 	var temp = i;
             				//alert(form.elements[i].name);
                                        if (form.elements[i].name.indexOf("quantity") != -1) {
						form.elements[i].value = "1" ;
					}			
           			}
	       		}
		}
		
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
	        alert(form.elements[m+1].name.substring(0,8)+" "+"<%=tooltechtext.getString("Quick_Script_Non_Integer1")%>"+" "+form.elements[m+1].name.substring(9,form.elements[m+1].name.length)+" "+"<%=tooltechtext.getString("Quick_Script_Non_Integer2")%>");
		return false;
          	}
        }
         
        if ((field*1) == "0")
            {
	      alert(form.elements[m+1].name.substring(0,8)+" "+"<%=tooltechtext.getString("Quick_Script_Non_Integer1")%>"+" "+form.elements[m+1].name.substring(9,form.elements[m+1].name.length)+" "+"<%=tooltechtext.getString("Quick_Script_Zero_Field")%>");
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
                   			     alert("<%=tooltechtext.getString("Quick_Sku_fieldText")%>"+" "+"<%=tooltechtext.getString("Quick_Script_Non_Integer1")%>"+" "+form.elements[i].name.substring(11,form.elements[i].name.length)+" "+"<%=tooltechtext.getString("Quick_Script_Empty_Field")%>");
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
			alert("<%=tooltechtext.getString("Quick_Script_Empty_All")%>");
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


</Script>

<BODY MARGINHEIGHT="0" MARGINWIDTH="0" LEFTMARGIN="0" TOPMARGIN="0" onLoad="if (typeof top.updateStInfo == 'function') top.updateStInfo();">

<flow:ifEnabled feature="customerCare">
<%
// Set header type needed for this JSP for LiveHelp.  This must
// be set before HeaderDisplay.jsp
request.setAttribute("liveHelpPageType", "personal");
%>
</flow:ifEnabled>


<%
String incfile;
incfile = includeDir + "HeaderDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>  

<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="790" HEIGHT="99%">
<TR>
<TD VALIGN="top" BGCOLOR="#4c6178" WIDTH="160"> 
<%
incfile = includeDir + "SidebarDisplay.jsp";
%>
<jsp:include page="<%=incfile%>" flush="true"/>
</TD>

<!--END SEARCH-->
<TD valign="top" width="630">
<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
<TR>
<TD>
<!--MAIN CONTENT STARTS HERE-->

<%
	//use product data bean to obtain SKU no. of a Product. 
	ProductDataBean productBean = new ProductDataBean();
	String badPartNumberList = ""; 
	int i = 1;
	String partNumber = "";
	StringTokenizer goodList=null; //list of good SKUs returned by the command.
	StringTokenizer badList=null; //list of bad SKUs returned by the command.
	StringTokenizer list1=null; //list of quantity corresponding to good SKUs. 
	String unformatted = ""; 
	String formatted = "" ; 
	String strErrorCode = "";
	String name = "";

         // getting handle to errorData bean 
        ErrorDataBean errorBean = new ErrorDataBean ();
	com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);
	System.out.println ("ErrorDataBean:\n" + errorBean.toString()+"\n");

        String strMessageKey = errorBean.getMessageKey();

        if (strMessageKey != null && strMessageKey.length() > 0)
          {
	    if (strMessageKey.equals(ECMessageKey._ERR_PROD_NOT_EXISTING)) 
               strErrorCode = "_ERR_PROD_NOT_EXISTING";
            else if (strMessageKey.equals(ECMessageKey._ERR_GETTING_SKU))
               strErrorCode = "_ERR_GETTING_SKU"; 
              
          }


	
        TypedProperty nvps = errorBean.getExceptionData();
        String str = new String();
        
       
         if (nvps != null) 
          {
        	Enumeration en = nvps.keys();
		
		while(en.hasMoreElements()) {
	         name = (String)en.nextElement();
		if(name.equals("ErrorCode"))
			{
			name = (String)en.nextElement();
			
			}
		
		else{
    		badPartNumberList = nvps.getString("badPartNumberList");
          	 //GETTING LIST OF GOOD SKU# 
	           String temp1 = nvps.getString("goodPartNumberList", "");
		   String temp2 = nvps.getString("badPartNumberList", "");	

	           String good =  temp1.substring(1,temp1.length()-1);
	           goodList = new StringTokenizer(good,", "); 
              
                 //GETTING LIST OF BAD SKU#
                 //String temp2 = nvps.getString("badPartNumberList", "");
		 
		 
                 String bad = temp2.substring(1,temp2.length()-1);
		 
		 if(bad.equals(""))
		 bad = bad+" ";
		 badList = new StringTokenizer(bad,",");
		 

	           //GETTING QUANTITY FOR GOOD SKUs
        	   String temp3 = nvps.getString("goodPartNumberQuantityList", "");
	           String goodnum = temp3.substring(1,temp3.length()-1);
	           list1 = new StringTokenizer(goodnum,", ");
		}
		break;
		}
           
         }
       

%>
<p><H1><%= tooltechtext.getString("Quick_Title") %></H1>

<%
String badPartNumberString = "";
if (badPartNumberList != "" || name.equals("catEntryId"))
{
if(name.equals("catEntryId"))
{
productBean.setProductID(nvps.getString("catEntryId", ""));
DataBeanManager.activate(productBean, request);
badPartNumberString = productBean.getPartNumber();
}
else 
badPartNumberString = badPartNumberList ; 
%>

		<font color="red">
			<%=tooltechtext.getString("Quick_WrongSku1")%>
			<%=tooltechtext.getString("Quick_WrongSku2", jhelper.htmlTextEncoder(badPartNumberString))%>
		</font>
		<br />
<%
}
%>

</table>



<table cellpadding="8" cellspacing="0" border="0">
	<TR>
		<TD>

		<form name="MQuickOrderForm" method="POST" action="QuickOrderView">
			<INPUT type="hidden" name="catalogId" valign=center value=<%=catalogId%>>
			<INPUT type="hidden" name="langId" valign=center value=<%=languageId%>>
			<INPUT type="hidden" name="orderId" valign=center value=".">
			<INPUT type="hidden" name="outOrderName" valign=center value=orderId>
			<INPUT type="hidden" name="URL" valign=center value="OrderItemDisplayViewShiptoAssoc?cmdStoreId=&partNumber*=&quantity*=&orderItemId*=">
			<input type='hidden' name='status' value='N'>
			<input type='hidden' name='callingpage' value='QuickOrder'>	


			<table cellpadding="0" cellspacing="0" border="0">
				<tr>	
					<td>
						<b><label for="WC_QuickOrderForm_FormInput_cmdStoreId_1"><%= tooltechtext.getString("SupplierDropDown_SelectSupplier") %></label></b>
					</td>
					<td>
						<select name="cmdStoreId" id="WC_QuickOrderForm_FormInput_cmdStoreId_1">
							<option value=""></option>
							<%
								HashMap relatedStores = com.ibm.commerce.store.util.StoreRelationUtil.getRelatedOpenStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
								Integer[] anStoreIds = com.ibm.commerce.common.helpers.StoreUtil.getRelatedStores(new Integer(sessionStoreId),ECConstants.EC_STRELTYP_HOSTED_STORE);
								for (int s=0; s<anStoreIds.length; s++) {
									String rStoreId = anStoreIds[s].toString();
									String rStoreName = (String) relatedStores.get(rStoreId);
							%>
											<option value="<%= rStoreId %>" <% if (rStoreId.toString().equals(cmdStoreId)) { %>selected<% } %> ><%= rStoreName %></option>
							<%
									}
							%>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<%= tooltechtext.getString("Quick_Text")%>
		</td>
	</tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="620" bgcolor="#4c6178">
				<tr>
					<td>
						<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
							<TR bgcolor="#4C6178">
								<TD VALIGN="TOP">
									<TABLE align="center">
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF">
												<strong>&nbsp;</strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP" colspan="2">
									<TABLE align="center">
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Quick_Col1")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD  VALIGN="TOP">
									<TABLE align="center">
										<TR>
											<TD><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Quick_Col2")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP">
									<TABLE align="center">
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF">
												<strong>&nbsp;</strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD VALIGN="TOP" colspan="2">
									<TABLE align="center">
										<TR>
											<TD VALIGN="TOP"><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Quick_Col1")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
								<TD  VALIGN="TOP">
									<TABLE align="center">
										<TR>
											<TD><font style="font-family : Verdana;" color="#FFFFFF"><strong><%=tooltechtext.getString("Quick_Col2")%></strong></font></TD>
										</TR>
									</TABLE>
								</TD>
							</tr>
 
<%
int c = 1 ;
String color = "#ffffff" ;
//if (badList != null)
 if (strErrorCode.equals("_ERR_PROD_NOT_EXISTING"))
  { 

int tempcount; 
String tmpPartNum = "";
String tmpQty = "";
int d = 1;
String color5 = "";
for(tempcount=1; tempcount<=count; tempcount++){

if(d%2 == 0 )
color5 = "#bccbdb";
else color5 = "ffffff";
%>
							<TR bgcolor="<%=color5%>">
								<TD align="center"><%=tempcount%></TD>
<%
  if (jhelper.getParameter("partNumber_"+tempcount) != null)
    {
	tmpPartNum = jhelper.getParameter("partNumber_"+tempcount);
	tmpQty = jhelper.getParameter("quantity_"+tempcount);
    }
  else
   {
	tmpPartNum = "";
	tmpQty = "";
    }

%>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/></label>
<input type="text" maxlength="64" name='partNumber_<%=tempcount%>' size="8" value="<%=tmpPartNum%>" id="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>"></TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/></label>
<input type="text" maxlength="4" name='quantity_<%=tempcount%>' size="6" value="<%=tmpQty%>" id="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>"></TD>
<% 
tempcount++;
d++;
%>
								<TD align="center"><%=tempcount%></TD>

<%
  if (jhelper.getParameter("partNumber_"+tempcount) != null)
    {
	tmpPartNum = jhelper.getParameter("partNumber_"+tempcount);
	tmpQty = jhelper.getParameter("quantity_"+tempcount);
    }
  else
   {
	tmpPartNum = "";
	tmpQty = "";
    }

%>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/></label>
<input type="text" maxlength="64" name='partNumber_<%=tempcount%>' size="8" value="<%=tmpPartNum%>" id="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>"></TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/></label>
<input type="text" maxlength="4" name='quantity_<%=tempcount%>' size="6" value="<%=tmpQty%>" id="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>"></TD>
							</tr>

<%
}
%>
<input type='hidden' name='count' value=<%=(tempcount-1)%>>

<%
}
 else if (strErrorCode.equals("_ERR_GETTING_SKU"))
{
 int tempcount; 
String tmpPartNum = "";
String tmpQty = "";
int d = 1;
String color5 = "";
for(tempcount=1; tempcount<=count; tempcount++){

if(d%2 == 0 )
color5 = "#bccbdb";
else color5 = "ffffff";
%>
							<TR bgcolor="<%=color5%>">
								<TD align="center"><%=tempcount%></TD>
<%
  if (jhelper.getParameter("partNumber_"+tempcount) != null)
    {
	tmpPartNum = jhelper.getParameter("partNumber_"+tempcount);
	tmpQty = jhelper.getParameter("quantity_"+tempcount);
    }
  else
   {
	tmpPartNum = "";
	tmpQty = "";
    }

%>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/></label>
<input type="text" maxlength="64" name='partNumber_<%=tempcount%>' size="8" value="<%=tmpPartNum%>" id="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>"></TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/></label>
<input type="text" maxlength="4" name='quantity_<%=tempcount%>' size="6" value="<%=tmpQty%>" id="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>"></TD>
<% 
tempcount++;
d++;
%>
								<TD align="center"><%=tempcount%></TD>

<%
  if (jhelper.getParameter("partNumber_"+tempcount) != null)
    {
	tmpPartNum = jhelper.getParameter("partNumber_"+tempcount);
	tmpQty = jhelper.getParameter("quantity_"+tempcount);
    }
  else
   {
	tmpPartNum = "";
	tmpQty = "";
    }

%>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/></label>
<input type="text" maxlength="64" name='partNumber_<%=tempcount%>' size="8" value="<%=tmpPartNum%>" id="WC_QuickOrderForm_FormInput_partNumber_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>"></TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/></label>
<input type="text" maxlength="4" name='quantity_<%=tempcount%>' size="6" value="<%=tmpQty%>" id="WC_QuickOrderForm_FormInput_quantity_<%=tempcount%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>"></TD>
							</tr>

<%
}
%>
<input type='hidden' name='count' value=<%=(tempcount-1)%>>
<% }
else
{
if(!status.equals("i")&&!status.equals("s"))
{
int b = 1;
for (i=1; i<=count ;)
{
%>

<%
if(b%2 == 0)
color = "#bccbdb";
else color = "#ffffff";
++b ;
%>
							<TR bgcolor=<%= color %>>
								<TD align="center"><%= i %></TD>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=i%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/></label>
									<input type=text maxlength="64" name='<%="partNumber_"+i%>'  value='<%= jhelper.getParameter("partNumber_"+i) %>' size="8" id="WC_QuickOrderForm_FormInput_partNumber_<%=i%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>">
								</TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=i%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/></label>
									<input type=text size="6" maxlength="4" name='<%="quantity_"+i%>'  value='<%= jhelper.getParameter("quantity_"+i) %>' id="WC_QuickOrderForm_FormInput_quantity_<%=i%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>">
								</TD>
								<TD align="center"><%= (i+1) %></TD>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=i+1%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/></label>
									<input type=text maxlength="64" name='<%="partNumber_"+(i+1)%>'  value='<%= jhelper.getParameter("partNumber_"+(i+1)) %>' size="8" id="WC_QuickOrderForm_FormInput_partNumber_<%=i+1%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>">
								</TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=i+1%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/></label>
									<input type=text size="6" maxlength="4" name='<%="quantity_"+(i+1)%>'  value='<%= jhelper.getParameter("quantity_"+(i+1)) %>' id="WC_QuickOrderForm_FormInput_quantity_<%=i+1%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>">
								</TD>
							</tr>

<%
i = i+2 ;
}
}

%>



<%  

int b = (count/2)+1 ;
int x = 0;
if (count == 1)
x = 31;
else 
x = 21; 
for (int k=1 ; k<x ;)
{
if(count == 1)
p = count+k-1;
else
p = count+k;

%>
<%
if(b%2 == 0)
color = "#bccbdb";
else color = "#ffffff";
k  = k + 2;
++b ;
%>
							<TR bgcolor=<%= color %>>
								<TD align="center"><%= p %></TD>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=p%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/>
<input type="text" maxlength="64" name='<%="partNumber_"+p%>' size="8" value="" id="WC_QuickOrderForm_FormInput_partNumber_<%=p%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>"></TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=p%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/>
<input type="text" maxlength="4" name='<%="quantity_"+p%>' size="6" value="" id="WC_QuickOrderForm_FormInput_quantity_<%=p%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>"></TD>
								<TD align="center"><%= (p+1) %></TD>
								<TD align="center" colspan="2"><label for="WC_QuickOrderForm_FormInput_partNumber_<%=p+1%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col1")%>"/>
<input type="text" maxlength="64" name='<%="partNumber_"+(p+1)%>' size="8" value="" id="WC_QuickOrderForm_FormInput_partNumber_<%=p+1%>_1" title="<%=tooltechtext.getString("Quick_Col1")%>"></TD>
								<TD align="center"><label for="WC_QuickOrderForm_FormInput_quantity_<%=p+1%>_1"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=tooltechtext.getString("Quick_Col2")%>"/>
<input type="text" maxlength="4" name='<%="quantity_"+(p+1)%>' size="6" value="" id="WC_QuickOrderForm_FormInput_quantity_<%=p+1%>_1" title="<%=tooltechtext.getString("Quick_Col2")%>"></TD>
							</tr>

<%
}
%>
					<input type='hidden' name='count' value=<%=a%>>
<%
}
%>
			</table>
		</TD></tr></table>
	</TD></tr></table>

				<table cellpadding="8" cellspacing="0" border="0" width="620">
					<tr>
						<TD>
							<table><tr><TD>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
									<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
									<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
								</tr>
								<tr>
									<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
									<td bgcolor="#ea2b2b">
										<table cellpadding="2" cellspacing="0" border="0">
										<tr>
											<td class="buttontext">
												<font color="#ffffff"><b>
												<a href="javascript:addToOrder()" style="color:#ffffff; text-decoration : none;">
												<%=tooltechtext.getString("Quick_Add_To_Order")%>
												</a>
												</b></font>
											</td>
										</tr>
										</table>
									</td>
									<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
								</tr>	
								<tr>
									<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
									<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
									<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
								</tr>
								</table>
							</TD>
							<TD>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
									<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
									<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0" alt=""/></td>
								</tr>
								<tr>
									<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0" alt=""/></td>
									<td bgcolor="#ea2b2b">
										<table cellpadding="2" cellspacing="0" border="0">
										<tr>
											<td class="buttontext">
												<font color="#ffffff"><b>
												<a href="javascript:Fields()" style="color:#ffffff; text-decoration : none;">
												<%=tooltechtext.getString("Quick_More_Items")%>
												</a>
												</b></font>
											</td>
										</tr>
										</table>
									</td>
									<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
								</tr>	
								<tr>
									<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif" alt=""/></td>
									<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
									<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0" alt=""/></td>
								</tr>
								</table>							
							</TD>
						</tr></table>
			</TD>
		</TR>
</TABLE>

</FORM>
</TD></TR></table>
</TD></tr></table>

</body>

</html>
