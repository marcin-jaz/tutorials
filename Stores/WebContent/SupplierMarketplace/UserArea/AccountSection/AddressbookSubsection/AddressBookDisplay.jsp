<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*tooltechtext
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<% // Page specific imports%> 
<%@ page import="com.ibm.commerce.beans.DataBeanManager" %>

<%@ page import="com.ibm.commerce.user.beans.AddressDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.AddressBookDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.OrgEntityDataBean" %>
<%@ page import="com.ibm.commerce.user.beans.UserRegistrationDataBean" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>


<jsp:useBean id="dbAddressBook" class="com.ibm.commerce.user.beans.AddressBookDataBean" scope="page">
</jsp:useBean>

<%

//Get the user reference number.
CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
Long userRef = commandContext.getUserId();

//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
JSPHelper jhelper = new JSPHelper(request);

String catalogId = jhelper.getParameter("catalogId");
String storeId = jhelper.getParameter("storeId");
String languageId = jhelper.getParameter("langId");
String mode = jhelper.getParameter("mode");
if (mode == null) mode = "";

// Get the payment method if the user is in AddressBookReturnToCheckout mode
String paymentMethod = jhelper.getParameter("paymentMethod");
if (paymentMethod == null) paymentMethod = "";

// we have to URL encode text strings that are passed throught he URL
paymentMethod = java.net.URLEncoder.encode(paymentMethod);  

String checkoutPage = jhelper.getParameter("page");
if (checkoutPage == null) checkoutPage = "";
String orderRn = jhelper.getParameter("orderId");

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<HEAD>
	<TITLE><%=tooltechtext.getString("AddBook_Title")%></TITLE>
	<LINK REL=stylesheet HREF="<%=fileDir%>ToolTech.css" TYPE="text/css">
</HEAD>


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

	<TD valign="top" width="630">

	<!-- Main JSP Content Here -->
	
	
<TABLE CELLPADDING="8" CELLSPACING="0" BORDER="0">
<TR>
	<TD>
		<H1><%=tooltechtext.getString("AddBook_Title")%></H1><P> <BR>
		<strong><font class="text"><%=tooltechtext.getString("AddBook_Pal")%></font></strong><P>

		<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605">
		<TR>
			<TD>
			
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
				</tr>
				<tr>
					<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
					<td bgcolor="#ea2b2b">
						<table cellpadding="2" cellspacing="0" border="0">
						<tr>
							<td class="buttontext">
								<font color="#ffffff">
								<b>
								<%
								if (mode.equals("AddressBookReturnToCheckout"))
									{
									%><a href="AddressForm?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>&orderId=<%=orderRn%>&paymentMethod=<%=paymentMethod%>&mode=AddressBookReturnToCheckout&page=<%=checkoutPage%>" style="color:#ffffff; text-decoration : none;"><%=tooltechtext.getString("AddBook_Add")%></a><% 
									} 
								else
									{ 
									%><a href="AddressForm?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>" style="color:#ffffff; text-decoration : none;"><%=tooltechtext.getString("AddBook_Add")%></a><% 
									} 
								%>
								</b>
								</font>
							</td>
						</tr>
						</table>
					</td>
					<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>	
				<tr>
					<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
					<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
				</tr>
				</table>				
			</td>
		</tr>
		<tr>
			<td>
				<BR>
				<%

				//Find all the addresses.

				if (userRef!=null)
					{
					dbAddressBook.setUserId(userRef);
					}

				com.ibm.commerce.beans.DataBeanManager.activate(dbAddressBook, request);
				AddressDataBean[] enAddressList = dbAddressBook.getAddressDataBeansList();
				AddressDataBean addr;

				int diffColour = 0;

				%>

				<!-- start row -->
				<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
				<TR>
					<TD>
						<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" BORDER="0">

						<% 
						
						//Start address while loop
						for (int k=0; k<enAddressList.length; k++)
							{
							addr = enAddressList[k];

							String strFirstName = addr.getFirstName();
							String strLastName = addr.getLastName();
							String strAddress1 = addr.getAddress1();
							String strAddress2 = addr.getAddress2();
							String strCity = addr.getCity();
							String strState = addr.getStateProvDisplayName();
							String strCountry = addr.getCountryDisplayName();
							String strZipCode = addr.getZipCode();
							String strPhone1= addr.getPhone1();
							String strNickName= addr.getNickName();

							if (strFirstName == null) strFirstName = "";
							if (strLastName == null) strLastName = "";
							if (strAddress1 == null) strAddress1 = "";
							if (strAddress2 == null) strAddress2 = "";
							if (strCity == null) strCity = "";
							if (strState == null) strState = "";
							if (strPhone1 == null) strPhone1 = "";
							if (strCountry == null) strCountry = "";
							if (strZipCode == null) strZipCode = "";

							if (diffColour == 0) 
								{
								%><TR bgcolor="#ffffff"><% 	
								diffColour++;
								} 
							else 
								{
								diffColour --;
								%><TR bgcolor="#BCCBDB"><% 
								} 
								%>
										
								<td width="480">
									<p>
									<font class="product">
									<%=strNickName%></font><br>
											
									<%	
									if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
										{ 
										// Format Name (Lastname, Firstname) for Double Byte Countries
										%>
										<font class="address"><%=strLastName%><%=strFirstName%></font><br>
										<%
										if (locale.toString().equals("ja_JP"))
											{
											// Format Address (Country, Zip, State/Region, City, Street Address) for Japan
											%>
											<font class="address">
												<%=strCountry%>&nbsp;<%=strZipCode%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strAddress1%>&nbsp;<%=strAddress2%><br>
												<%=strPhone1%>
											</font><br>											
											<%
											}
										else if (locale.toString().equals("ko_KR"))
											{
											// Format Address (Zip, Country, State/Region, City, Street Address) for Korea
											%>
											<font class="address">
												<%=strCountry%>&nbsp;<%=strZipCode%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strAddress1%><BR><%=strAddress2%><br>
												<%=strPhone1%>
											</font><br>												
											<%
											}
										else if (locale.toString().equals("zh_CN"))
											{
											// Format Address (Country, State/Region, City, Street Address, Zip) for China
											%>
											<font class="address">
												<%=strCountry%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strAddress1%>&nbsp;<%=strAddress2%><br>
												<%=strZipCode%><BR>
												<%=strPhone1%>
											</font><br>												
											<%
											}
										else if (locale.toString().equals("zh_TW"))
											{
											// Format Address (Country, State/Region, City, Zip, Street Address) for Taiwan	
											%>
											<font class="address">
												<%=strCountry%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strZipCode%><BR>
												<%=strAddress1%>&nbsp;<%=strAddress2%><br>
												<%=strPhone1%>
											</font><br>												
											<%
											}					

										} 
										else
											{
											// Format Name (Firstname, Lastname) for Single Byte Countries	
											%>
											<font class="address"><%=strFirstName%> <%=strLastName%></font><br>
											<%											
											
											// Format Address : Single Byte Countries
											if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES"))
												{
												// Format Address(Zip,City,State/Region,Country) for France, Germany, Italy and Spain
												%>
												<font class="address">
													<%=strAddress1%>&nbsp;<%=strAddress2%><br>
													<%=strZipCode%>&nbsp;<%=strCity%><BR>
													<%=strState%>&nbsp;<%=strCountry%><BR>
													<%=strPhone1%>
												</font><br>													
												<%
												}
											else
												{
												// Format Address(City,State/Region,Country & Zip) for Brazil and English US and unhandled locales.
												%>
												<font class="address">
													<%=strAddress1%>&nbsp;<%=strAddress2%><br>
													<%=strCity%>&nbsp;<%=strState%><BR>
													<%=strCountry%>&nbsp;<%=strZipCode%><BR>
													<%=strPhone1%>
												</font><br>													
												<%
												}
											}

											%>

									</p>
								</TD>
								<td align="center" width="80">
								
									<table cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
										<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
										<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
									</tr>
									<tr>
										<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
										<td bgcolor="#ea2b2b">
											<table cellpadding="2" cellspacing="0" border="0">
											<tr>
												<td class="buttontext">
													<font color="#ffffff">
													<%
													if (mode.equals("AddressBookReturnToCheckout"))
														{
														%>
														<a href="AddressForm?storeId=<%=storeId%>&orderId=<%=orderRn%>&paymentMethod=<%=paymentMethod%>&mode=AddressBookReturnToCheckout&page=<%=checkoutPage%>&catalogId=<%=catalogId%>&langId=<%=languageId%>&<%= ECUserConstants.EC_ADDR_ADDRESSID %>=<%=addr.getAddressId()%>" style="color:#ffffff; text-decoration : none;">
														&nbsp; <%=tooltechtext.getString("AddBook_Link1")%> &nbsp;
														</a>
														<% 
														} 
													else 
														{ 
														%>
														<a href="AddressForm?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>&<%= ECUserConstants.EC_ADDR_ADDRESSID %>=<%=addr.getAddressId()%>" style="color:#ffffff; text-decoration : none;">
														&nbsp; <%=tooltechtext.getString("AddBook_Link1")%> &nbsp;
														</a>
														<%
														} 
														%>
													</b>
													</font>
												</td>
											</tr>
											</table>
										</td>
										<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
									</tr>	
									<tr>
										<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
										<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
										<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
									</tr>
									</table>
								</TD>
								
								<% 
								if (!mode.equals("AddressBookReturnToCheckout"))
									{ 
									%>
								<td align="center" width="70">
									<table cellpadding="0" cellspacing="0" border="0">
										<%  
										//Cannot delete primary address
										if (!addr.isSelfAddress())
											{    
											%>

									<tr>
										<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
										<td bgcolor="#ff2d2d" class="pixel"><img src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
										<td class="pixel"><img src="<%=jspStoreImgDir%>images/r_top.gif" border="0"/></td>
									</tr>
									<tr>
										<td bgcolor="#ff2d2d"><img alt="" src="<%=jspStoreImgDir%>images/lb.gif" border="0"/></td>
										<td bgcolor="#ea2b2b">
											<table cellpadding="2" cellspacing="0" border="0">
											<tr>
												<td class="buttontext">
												<font color="#ffffff">
													<b>
													<a href="AddressDelete?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>&<%= ECUserConstants.EC_ADDR_ADDRESSID %>=<%=addr.getAddressId()%>&URL=AddressBookForm" style="color:#ffffff; text-decoration : none;"> 
													<%=tooltechtext.getString("AddBook_Link2")%>
													</a>
													</b>
												</td>
											</tr>
											</table>
										</td>
										<td bgcolor="#7a1616"><img alt="" src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
									</tr>	
									<tr>
										<td class="pixel"><img src="<%=jspStoreImgDir%>images/l_bot.gif"/></td>
										<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
										<td bgcolor="#7a1616" class="pixel" valign="top"><img src="<%=jspStoreImgDir%>images/db.gif" border="0"/></td>
									</tr>
									<% 
									} 
								else
									{ 
									%>
									<tr>
										<td> &nbsp; </td>
									</tr>
									<% 
									} 
									%>
									</table>
								</td>
								<% 
								} 
								// end if
								%>
							</tr>

							<!-- end row --> <% 	
							} 
						//end while
						%>

						</TABLE>

					</TD>
				</TR>
				</TABLE>

			</TD>
		</TR>
		</TABLE>

		<P></P>
		<hr width="605" color="#4C6178" align="left">
		<P><strong><font class="text"><%=tooltechtext.getString("AddBook_Oal")%></font></strong></P>

		<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" width="605" bgcolor="#4C6178">
		<TR>
			<TD>
				<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" BORDER="0">
				<TR BGCOLOR="#4C6178">
					<TD VALIGN="TOP">
						<TABLE cellspacing="0" cellpadding="0" border="0">
						<TR>
							<TD VALIGN="TOP"></TD>
						</TR>
						</TABLE>
					</TD>
				</TR>
				
				<!--
				<jsp:useBean id="bnRegister" class="com.ibm.commerce.user.beans.UserRegistrationDataBean" scope="page">
				-->
				<% 
				com.ibm.commerce.beans.DataBeanManager.activate(bnRegister, request); 
				%>
				</jsp:useBean>
				<%
					
				String strOrgEntityId = bnRegister.getAttribute ("parentMemberId");
					
				//Get Organization Address
				AddressBookDataBean databeanAddressBook = new AddressBookDataBean ();
				if (strOrgEntityId != null) {
					databeanAddressBook.setUserId(strOrgEntityId);
				}
				com.ibm.commerce.beans.DataBeanManager.activate (databeanAddressBook, request);
				AddressDataBean[] AddrList = databeanAddressBook.getAddressDataBeansList();
				AddressDataBean abAddr;
					
				//Get Organization Name					
				OrgEntityDataBean dbOrgEntity = new OrgEntityDataBean ();
				if (strOrgEntityId != null) 
					{
					dbOrgEntity.setOrgEntityId(bnRegister.getParentMemberId());
					}
				com.ibm.commerce.beans.DataBeanManager.activate (dbOrgEntity, request);

				String strBuyerOrg = dbOrgEntity.getOrgEntityName();
				if (strBuyerOrg== null) strBuyerOrg = "";

				diffColour = 0; //reset colour count
					
				for (int k=0; k<AddrList.length; k++)
					{
						abAddr = AddrList[k];
						
						String strAddress1 = abAddr.getAddress1();
						String strAddress2 = abAddr.getAddress2();
						String strCity = abAddr.getCity();
						String strState = abAddr.getStateProvDisplayName();
						String strCountry = abAddr.getCountryDisplayName();
						String strZipCode = abAddr.getZipCode();
						String strNickName= abAddr.getNickName();
					
						if (strAddress1== null) strAddress1 = "";
						if (strAddress2 == null) strAddress2 = "";
						if (strCity == null) strCity = "";
						if (strState == null) strState = "";	
						if (strZipCode == null) strZipCode = "";
						if (strCountry == null) strCountry ="";
				
						if (diffColour == 0) 
							{
							%><TR bgcolor="#ffffff"><% 	diffColour++;
							} 
						else 
							{
							diffColour--;
							%><TR bgcolor="#BCCBDB"><% 
							} 
							%>
								<td>
									<p>
									<%=strBuyerOrg%><BR>
											
									<%	
									if (locale.toString().equals("ja_JP")||locale.toString().equals("ko_KR")||locale.toString().equals("zh_CN")||locale.toString().equals("zh_TW")) 
										{ 

										if (locale.toString().equals("ja_JP"))
											{
											// Format Address (Country, Zip, State/Region, City, Street Address) for Japan
											%>
											<font class="address">
												<%=strCountry%>&nbsp;<%=strZipCode%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strAddress1%>&nbsp;<%=strAddress2%><br>
											</font><br>											
											<%
											}
										else if (locale.toString().equals("ko_KR"))
											{
											// Format Address (Zip, Country, State/Region, City, Street Address) for Korea
											%>
											<font class="address">
												<%=strCountry%>&nbsp;<%=strZipCode%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strAddress1%><BR><%=strAddress2%><br>
											</font><br>												
											<%
											}
										else if (locale.toString().equals("zh_CN"))
											{
											// Format Address (Country, State/Region, City, Street Address, Zip) for China
											%>
											<font class="address">
												<%=strCountry%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strAddress1%>&nbsp;<%=strAddress2%><br>
												<%=strZipCode%><BR>
											</font><br>												
											<%
											}
										else if (locale.toString().equals("zh_TW"))
											{
											// Format Address (Country, State/Region, City, Zip, Street Address) for Taiwan	
											%>
											<font class="address">
												<%=strCountry%><BR>
												<%=strState%>&nbsp;<%=strCity%><BR>
												<%=strZipCode%><BR>
												<%=strAddress1%>&nbsp;<%=strAddress2%><br>
											</font><br>												
											<%
											}					

										} 
										else
											{									
											
											// Format Address : Single Byte Countries
											if (locale.toString().equals("fr_FR")||locale.toString().equals("de_DE")||locale.toString().equals("it_IT")||locale.toString().equals("es_ES"))
												{
												// Format Address(Zip,City,State/Region,Country) for France, Germany, Italy and Spain
												%>
												<font class="address">
													<%=strAddress1%>&nbsp;<%=strAddress2%><br>
													<%=strZipCode%>&nbsp;<%=strCity%><BR>
													<%=strState%>&nbsp;<%=strCountry%><BR>
												</font><br>													
												<%
												}
											else
												{
												// Format Address(City,State/Region,Country & Zip) for Brazil and English US and unhandled locales.
												%>
												<font class="address">
													<%=strAddress1%>&nbsp;<%=strAddress2%><br>
													<%=strCity%>&nbsp;<%=strState%><BR>
													<%=strCountry%>&nbsp;<%=strZipCode%><BR>
												</font><br>													
												<%
												}
											}							

											%>
									</p>
								</TD>
							</tr>
							<%
					
						} //end while
				
						%>
						<!-- end row 1 --> 
				</TABLE>
			</TD>
		</TR>
		</TABLE>
	</TD>
</TR>
</TABLE>
<!-- Main content end--> 

	</TD>
</TR>
</TABLE>

</BODY>
</HTML>