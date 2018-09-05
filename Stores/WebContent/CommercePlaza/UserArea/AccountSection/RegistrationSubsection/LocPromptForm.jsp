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
 

<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title><%=storeText.getString("OrgReg_Title1")%></title>
		<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
		<meta name="GENERATOR" content="IBM WebSphere Studio" />
	</head>

	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<%@ include file="../../../include/HeaderDisplay.jspf"%>
		<table border="0" cellpadding="0" cellspacing="0" width="750">
			<tbody><tr>
				<td valign="top" class="dbg" width="150">
					<%
     					String incfile = includeDir + "SidebarDisplay.jsp";
     					%>
     					<jsp:include page="<%=incfile%>" flush="true"></jsp:include>
     				</td>
				<td width="10"><a name="mainContent"></a><spacer type="horizontal" size="10" /><br />
				</td>
				<td valign="top">
					<form name="LocPrompt" method="post" action="ResellerRegistrationFormView">
						<input type="hidden" name="storeId" value="<%=storeId%>" /> <input type="hidden" name="catalogId" value="<%=catalogId%>" /> <input type="hidden" name="langId" value="<%=languageId%>" />
						<img src="<%=fileDir%>images/c.gif" height="20" width="20" />
						<table width="590" border="0" cellspacing="0" cellpadding="0" border="0">
							<tbody><tr valign="top">
								<td>
									<table border="0" cellpadding="0" cellspacing="0" width="100%">
										<tbody><tr>
											<td valign="top">
												<img src="<%=fileDir%>images/c.gif" height="11" width="11" /><br />
												<span class="title"><%=storeText.getString("Loc_Title1")%></span>
											</td>
											<td>
												<div align="right">
													<img src="<%=fileDir%>images/hdr_account.gif" alt='<%=storeText.getString("Loc_Title1")%>' /></div>
											</td>
										</tr>
									</tbody></table>
									<table width="100%" border="0">
										<!-- Selection control. -->
										<tbody>
										<tr>
											<%
											// Substitute the store name into the text string Loc_Remark1
											Object[] arguments = {storeName};
											String locationIDText = MessageFormat.format(ECMessageHelper.doubleTheApostrophy(storeText.getString("Loc_Remark1")), arguments);
											%>
											<td class="bodytxt1" colspan="2" align="left" valign="bottom" width="50%"><b><label for="numbertext"><%=locationIDText%></label></b></td>
										</tr>
										<tr>
											<td class="bodytxt1" colspan="2" align="left" valign="top"><select name="numberLoc" id="numbertext" class="iform">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
													<option value="13">13</option>
													<option value="14">14</option>
													<option value="15">15</option>
													<option value="16">16</option>
													<option value="17">17</option>
													<option value="18">18</option>
													<option value="19">19</option>
													<option value="20">20</option>
													<option value="21">21</option>
													<option value="22">22</option>
													<option value="23">23</option>
													<option value="24">24</option>
													<option value="25">25</option>
													<option value="26">26</option>
													<option value="27">27</option>
													<option value="28">28</option>
													<option value="29">29</option>
													<option value="30">30</option>
													<option value="31">31</option>
													<option value="32">32</option>
													<option value="33">33</option>
													<option value="34">34</option>
													<option value="35">35</option>
													<option value="36">36</option>
													<option value="37">37</option>
													<option value="38">38</option>
													<option value="39">39</option>
													<option value="40">40</option>
													<option value="41">41</option>
													<option value="42">42</option>
													<option value="43">43</option>
													<option value="44">44</option>
													<option value="45">45</option>
													<option value="46">46</option>
													<option value="47">47</option>
													<option value="48">48</option>
													<option value="49">49</option>
													<option value="50">50</option>
													<option value="51">51</option>
													<option value="52">52</option>
													<option value="53">53</option>
													<option value="54">54</option>
													<option value="55">55</option>
													<option value="56">56</option>
													<option value="57">57</option>
													<option value="58">58</option>
													<option value="59">59</option>
													<option value="60">60 </option>
												</select><br />
											</td>
										</tr>
										<tr>
											<td align="left" valign="top" colspan="2" height="24"><spacer type="block" width="24" height="24" /></td>
										</tr>
										<tr>
											<td colspan="2" align="left" valign="top"><a href="javascript:document.LocPrompt.submit()"><img src="<%=fileDir%><%=locale.toString()%>/images/continue.gif" alt='<%=storeText.getString("Loc_Button1")%>' border="0" /></a><br /><br /></td>
										</tr>
									</tbody></table>
								</td>
							</tr>
						</tbody></table>
					</form>
				</td>
			</tr>
		</tbody></table>
		<%@ include file="../../../include/FooterDisplay.jspf"%>
	</body>

</html>