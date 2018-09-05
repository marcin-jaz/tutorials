<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.payment.beans.PaymentTCInfo" %>

<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%
try {
%>
<!-- snipplet starts -->	
<%
PaymentTCInfo selectedPaymentTCInfo = (PaymentTCInfo) request.getAttribute("PaymentTCInfo");
TypedProperty paymentAttr = selectedPaymentTCInfo.getPaymentAttributes();
if (paymentAttr == null) {
	paymentAttr = new TypedProperty();
}
%>
							<tr>
								<td align="left" valign="middle"><font style="font-family : Verdana;" size="2" color="#EA2B2B">*</font><font class="p"><%=tooltechtext.getString("OrderSum_Text1")%></font></td>
								<td align="left" valign="middle"></td>
								<td align="left" valign="middle"><%=selectedPaymentTCInfo.getShortDescription()%></td>
							</tr>
<%
String strCardBrand = (String) paymentAttr.get("cardBrand", null);
if (strCardBrand == null || strCardBrand.equals("")) {
%>
							<tr>
								<td align="left" valign="middle"><font style="font-family : Verdana;" size="2" color="#EA2B2B">*</font><font class="p"><label for="WC_StandardCreditCardDisplay_FormInput_cardBrand_1"><%=tooltechtext.getString("OrderSum_Text9")%></label></font></td>
								<td align="left" valign="middle"></td>
								<td align="left" valign="middle">
									<select name="cardBrand" size="1" id="WC_StandardCreditCardDisplay_FormInput_cardBrand_1">
										<option value="AMEX">American Express</option>
										<option value="MAST">MasterCard</option>
										<option selected value="VISA">VISA</option>
									</select>
								</td>
							</tr>
<%
} else {
%>
							<input type=hidden name="cardBrand" value="<%=selectedPaymentTCInfo.getBrand()%>">
<%
}
%>							
							<tr>
								<td align="left" valign="middle"><font style="font-family : Verdana;" size="2" color="#EA2B2B">*</font><font class="p"><label for="WC_StandardCreditCardDisplay_FormInput_cardNumber_1"><%=tooltechtext.getString("OrderSum_Text2")%></label></font></td>
								<td align="left" valign="middle"></td>
<%
String strCardNumber = (String) paymentAttr.get("cardNumber", null);
if (strCardNumber == null || strCardNumber.equals("")) {
%>
								<td align="left" valign="middle"><input type="text" size="20" name="cardNumber" id="WC_StandardCreditCardDisplay_FormInput_cardNumber_1"></td>
<%
} else {
%>
								<td align="left" valign="middle"><%=strCardNumber%><input type="hidden" size="20" name="cardNumber" value="<%=strCardNumber%>"></td>
<%
}
%>
							</tr>
							<tr>
								<td align="left" valign="middle"><font style="font-family : Verdana;" size="2" color="#EA2B2B">*</font><font class="p"><label for="WC_StandardCreditCardDisplay_FormInput_cardExpiryMonth_1"><%=tooltechtext.getString("OrderSum_Text3")%></label></font></td>
								<td align="left" valign="middle"></td>
<%
String strCardExpiryMonth = (String) paymentAttr.get("cardExpiryMonth", null);
if (strCardExpiryMonth == null || strCardExpiryMonth.equals(""))
{
%>

								<td align="left" valign="middle"><select name="cardExpiryMonth" size="1" id="WC_StandardCreditCardDisplay_FormInput_cardExpiryMonth_1">
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option selected value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select></td>
<%
} else 
{
%>
								<!-- td align="left" valign="middle"><%=strCardExpiryMonth%><input type="hidden" size="20" name="cardExpiryMonth" value="<%=strCardExpiryMonth%>"></td -->

								<td align="left" valign="middle"><select name="cardExpiryMonth" size="1" id="WC_StandardCreditCardDisplay_FormInput_cardExpiryMonth_1">
										<option selected value="<%=strCardExpiryMonth%>"><%=strCardExpiryMonth%></option>
									</select></td>
<%
}
%>
									
							</tr>
							<tr>
								<td align="left" valign="middle"><font style="font-family : Verdana;" size="2" color="#EA2B2B">*</font><font class="p"><label for="WC_StandardCreditCardDisplay_FormInput_cardExpiryYear_1"><%=tooltechtext.getString("OrderSum_Text4")%></label></font></td>
								<td align="left" valign="middle"></td>
<%
String strCardExpiryYear = (String) paymentAttr.get("cardExpiryYear", null);
if (strCardExpiryYear == null || strCardExpiryYear.equals(""))
{
%>

								<td align="left" valign="middle"><select name="cardExpiryYear" size="1" id="WC_StandardCreditCardDisplay_FormInput_cardExpiryYear_1">
										<option value="2002">2002</option>
										<option value="2003">2003</option>
										<option selected value="2004">2004</option>
										<option value="2005">2005</option>
										<option value="2006">2006</option>
	 									<option value="2007">2007</option>
									</select></td>
<%
} else 
{
%>
								<!-- td align="left" valign="middle"><%=strCardExpiryYear%><input type="hidden" size="20" name="cardExpiryYear" value="<%=strCardExpiryYear%>"></td -->

								<td align="left" valign="middle"><select name="cardExpiryYear" size="1" id="WC_StandardCreditCardDisplay_FormInput_cardExpiryYear_1">
										<option selected value="<%=strCardExpiryYear%>"><%=strCardExpiryYear%></option>
									</select></td>
<%
}
%>

							</tr>
<!-- snipplet ends -->
<%
} catch (Exception e) {
	System.out.println ("Exception:");
	e.printStackTrace();
}
%>
