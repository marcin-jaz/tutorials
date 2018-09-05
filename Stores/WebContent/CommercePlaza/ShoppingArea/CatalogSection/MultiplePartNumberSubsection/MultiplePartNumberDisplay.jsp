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


<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.beans.*" %>
<%@ page import="com.ibm.commerce.catalog.objects.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.ras.ECMessageKey" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>


<%
String error = jhelper.getParameter("emptyField");

request.setAttribute("pageName", "CommercePlazaCatalog");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=storeText.getString("MultiplePartNumber_Title")%></title>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />

<script language="javascript">
<!--
var busy = false;

//Function for adding list of items to Order
function addToOrder()
{
	var form = document.MultiplePartNumberForm;
	
	// Do not let a user submit this form twice
	if (busy == true) return;
	busy = true;
                
		 // Set all quantities equal to 1 if the quantity field is empty
                 for(var i=0; i<form.elements.length; i++)
                    {
     		      if(form.elements[i].type == "text")
			{
               			
               			if (form.elements[i].value != "" && form.elements[i+1].value == "") 
                			 {
                			   	form.elements[i+1].value = "1";
				         }	
		
              			  i = i+1 ;
                          }

  	              }

			var emptyFields = 0;
			for(var b=0; b<form.elements.length; b++)
  			  {
     				if(form.elements[b].type == "text")
					{
						if(form.elements[b].value == "")
						{ 
							if (form.elements[b+1].value == "")
							{
								form.elements[b].name = "temp1"+b;
								form.elements[b].value = "";
								form.elements[b+1].name = "temp2"+b;
								form.elements[b+1].value = "";
							}
							emptyFields++;
						}
							b++;	
					}
	
			}

			// Check if all fields are empty.  If so, redirect to this page with an error message
			if (emptyFields == 15) {
				document.MultiplePartNumberForm.URL.value= "MultiplePartNumberDisplayView?emptyField=<%=ECMessageKey._ERR_BAD_MISSING_CMD_PARAMETER%>";
			}else {
				document.MultiplePartNumberForm.URL.value = "OrderItemDisplay?partNumber*=&quantity*=&orderItemId*=";
			}

			document.MultiplePartNumberForm.status.value = "N";
			document.MultiplePartNumberForm.submit();
}
-->
</script>
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">

<%@ include file="../../../include/HeaderDisplay.jspf"%>

<!-- Start Main Table - Consists of TD for Left Bar, TD for Content and TD for Quicklinks -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
	<tbody><tr>
		<td valign="top" class="dbg" width="150">
			<%
      			String incfile = includeDir + "SidebarDisplay.jsp";
      			%>
      			<jsp:include page="<%=incfile%>" flush="true"></jsp:include>
      		</td>
		<!-- End  Left Nav Bar TD -->
		<td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10" /><br />
		</td>
		<!-- Begin Main Content TD -->
		<td valign="top" width="590">
			<!--MAIN CONTENT STARTS HERE-->
                        <%
                          //use product data bean to obtain SKU no. of a Product. 
                          ProductDataBean productBean = new ProductDataBean();
                          String badPartNumberList = "";
                          int i = 1;
                          String partNumber = "";
                          StringTokenizer goodList=null; 	//list of good SKUs returned by the command.
                          StringTokenizer badList=null; 	//list of bad SKUs returned by the command.
                          StringTokenizer list1=null; 		//list of quantity corresponding to good SKUs. 
                          String unformatted = ""; 
                          String formatted = "" ; 
                          String strErrorMsg = "";
                          String name = "";
                        
                                 // getting handle to errorData bean 
                                ErrorDataBean errorBean = new ErrorDataBean ();
                        	com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);
                                String strMessageKey = errorBean.getMessageKey();
                                		
                                TypedProperty nvps = errorBean.getExceptionData();
                                String str = new String();
                                
                                if (strMessageKey != null && strMessageKey.equals(ECMessageKey._ERR_BAD_MISSING_CMD_PARAMETER) ||   
                                	error != null && error.equals(ECMessageKey._ERR_BAD_MISSING_CMD_PARAMETER))
                                {
                                      strErrorMsg = storeText.getString("MultiplePartNumber_Script_Empty_All"); 
                                }         
                                if(strMessageKey != null && strMessageKey.equals(ECMessageKey._ERR_INVALID_INPUT)) {
                                	if(nvps != null && nvps.containsKey("quantity")) {
                                		strErrorMsg = nvps.getString("quantity", "") + " " + storeText.getString("MultiplePartNumber_Script_Non_Integer2");
                                	}
                                	else {
                                		strErrorMsg = errorBean.getSystemMessage();
                                	}
                                }
                               	 // Look for bad & good part numbers that were submitted
                                 else if (strMessageKey != null && strMessageKey.equals(ECMessageKey._ERR_PROD_NOT_EXISTING) && nvps != null) 
                                  {
                                	Enumeration en = nvps.keys();
                        		
                        		while(en.hasMoreElements()) {
                        	         name = (String)en.nextElement();
                        		if(name.equals("ErrorCode"))
                        		{
                        			name = (String)en.nextElement();
                        		}
                        		else if (name.equalsIgnoreCase("currency"))
                        		{ 
                        			strErrorMsg = errorBean.getSystemMessage();
                        		}
                        		else
                        		{
                            		   badPartNumberList = nvps.getString("badPartNumberList", "");
                            		   
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
                                 else { strErrorMsg = errorBean.getSystemMessage(); }
                               
                        
                        %>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td colspan="2">
						          	<span class="bct">&nbsp;&nbsp;&nbsp;</span>
								<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&amp;catalogId=<%=catalogId%>&amp;langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
								<span class="bct"><%=storeText.getString("Breadcrumb_SelectItems")%></span>	
						</td>
					</tr>
					<tr>
						<td valign="top">
							<img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
							<span class="title"><%=storeText.getString("MultiplePartNumber_Title")%></span>
						<td>
							<div align="right">
								<img src="<%=fileDir%>images/hdr_products.gif" width="280" height="72" alt='<%=storeText.getString("MultiplePartNumber_Title")%>' /></div>
						</td>
					</tr>
				</tbody>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tbody>
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
						<tr><td width="100%"><span class="error"><%=storeText.getString("MultiplePartNumber_WrongSku1")%>&nbsp; <%=JSPHelper.htmlTextEncoder(badPartNumberString)%>&nbsp;<%=storeText.getString("MultiplePartNumber_WrongSku2")%></span><br />
							<br /></td>
						</tr>
						<%
					    	}
						else if (!strErrorMsg.equals(""))
					    	{
					    		%><tr><td width="100%"><span class="error"><%=JSPHelper.htmlTextEncoder(strErrorMsg)%></span><br />
								<br /></td></tr>
							<%   	
					    	}
					    	%>
					<tr>
						<td width="100%"><%=storeText.getString("MultiplePartNumber_Text1")%><br />
						</td>
					</tr>
					<tr>
						<td width="100%"><br />
							<%=storeText.getString("MultiplePartNumber_Text2")%><br />
							<br />
						</td>
					</tr>
					<tr>
						<td valign="top" width="100%">
							<form name="MultiplePartNumberForm" action="OrderItemAdd" method="post">
								<input type="hidden" name="storeId" value="<%=storeId%>" /> <input type="hidden" name="catalogId" value="<%=catalogId%>" /> <input type="hidden" name="langId" value="<%=languageId%>" /> <input type="hidden" name="orderId" value="." /> <input type="hidden" name="outOrderName" value="orderId" /> <input type="hidden" name="URL" value="" /> <input type="hidden" name="status" value="N" /> <input type="hidden" name="callingpage" value="MultiplePartNumber" /> <input type="hidden" name="errorViewName" value="MultiplePartNumberDisplayView" />
								<input type="hidden" name="allocate" value="*n" />
								<input type="hidden" name="reverse" value="*n" />
								<input type="hidden" name="backorder" value="*n" />
								<input type="hidden" name="check" value="*n" />
								<input type="hidden" name="merge" value="*n" />
								<input type="hidden" name="remerge" value="*n" />
								<table cellspacing="1" cellpadding="0" width="100%" border="0">
									<tbody>
									<tr class="tdblue">
										<td colspan="2" class="tdblue" nowrap="nowrap"><img src="<%=fileDir%>images/c.gif" height="1" width="4" /><%=storeText.getString("MultiplePartNumber_ItemsToAdd")%></td>
									</tr>
											<tr>
											<td width="100%" class="#FFFFFF">
											<table cellspacing="1" cellpadding="0" border="0">
												<tbody>
													<tr valign="top">
														<th valign="top" align="center" width="10" id="th1" class="mbg"><br />
														</th>
														<td valign="top" align="center" nowrap="nowrap" width="280" id="th2" class="mbg"><div align="left"><img src="<%=fileDir%>images/c.gif" height="1" width="4" />
																<span class="small"><b><%=storeText.getString("MultiplePartNumber_PartNumberLabel")%></b></span></div>
														</td>
														<td valign="top" align="center" nowrap="nowrap" width="290" id="th3" class="mbg"><div align="left"><img src="<%=fileDir%>images/c.gif" height="1" width="4" />
																<span class="small"><b><%=storeText.getString("MultiplePartNumber_QuantityLabel")%></b></span></div>
														</td>
													</tr>
													<%
													int tempcount; 
													String tmpPartNum = "";
													String tmpQty = "";
													int d = 1;
		
													for(tempcount=1; tempcount<=15;){
													%>
													<tr class="white_bg">
														<td align="center" width="10" headers="th1"><%=tempcount%></td>
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
														<td align="center" width="280" headers="th2">
															<div align="left">
																<label for="partNumber_<%=tempcount%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("MultiplePartNumber_PartNumberLabel")%>"/></label>
																<input type="text" maxlength="64" id="partNumber_<%=tempcount%>" name="partNumber_<%=tempcount%>" size="8" value="<%=JSPHelper.htmlTextEncoder(tmpPartNum)%>" class="iform" /></div>
														</td>
														<td align="center" width="290" headers="th3">
															<div align="left">
																<label for="quantity_<%=tempcount%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("MultiplePartNumber_QuantityLabel")%>"/></label>
																<input type="text" maxlength="4" id="quantity_<%=tempcount%>" name="quantity_<%=tempcount%>" size="6" value="<%=JSPHelper.htmlTextEncoder(tmpQty)%>" class="iform" /></div>
														</td>
													</tr>
													<tr><td colspan="3" class="gbg" height="1"><img src="<%=fileDir%>images/c.gif" width="1" height="1" class="imgHeightFix" /></td></tr>
													<%
													      tempcount++;
													      d++;
												      }
												      %>
													<tr>
														<td colspan="3"  height="24"><spacer type="block" width="24" height="24" /></td>
													</tr>
													<tr>
																		<td colspan="2"><br /></td>
																		<td width="290">
																			<div align="left">
																				<table cellspacing="0" cellpadding="0" border="0">
																					<tbody>
																						<tr>
																							<td width="100%" valign="middle"><a href="#" onclick="addToOrder();return false;"><img alt='<%=storeText.getString("MultiplePartNumber_Button")%>' src="<%=fileDir%><%=locale.toString()%>/images/add_to_shopcart.gif" border="0" /></a></td>
																						</tr>
																					</tbody>
																				</table>
																				<br />
																			</div>
																		</td>
																	</tr>
												</tbody>
											</table>
										</td>
													</tr>
								</tbody>
							</table>
							</form>
						</td>
					</tr>
				</tbody>
			</table>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tbody>
					<tr valign="top">
						<td width="100%"></td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</tbody>
</table>
<%@ include file="../../../include/FooterDisplay.jspf"%>
</body>
</html>
