<%
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
<%@ page import="javax.servlet.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.ibm.commerce.beans.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.*" %>

<%@ page import="com.ibm.commerce.order.beans.*" %>
<%@ page import="com.ibm.commerce.order.objects.*" %>
<%@ page import="com.ibm.commerce.contract.beans.*" %>
<%@ page import="com.ibm.commerce.contract.objects.*" %>

<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.usermanagement.commands.ECUserConstants" %>
<%@ page import="com.ibm.commerce.security.commands.ECSecurityConstants" %>
<%@ page import="com.ibm.commerce.price.utils.*" %>
<%@ page import="com.ibm.commerce.common.objects.*" %>
<%@ page import="com.ibm.commerce.common.beans.*" %>
<%@ page import="com.ibm.commerce.user.beans.*" %>
<%@ page import="com.ibm.commerce.user.objects.*" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.ibm.commerce.ras.ECMessageHelper" %>
<%@ page import="com.ibm.commerce.datatype.TypedProperty"%>

<%@ include file="../../../include/EnvironmentSetup.jsp"%>

<%
// Command DataBean used to invoke OrderQuotationRequest controller command from JSP

String userId = cmdcontext.getUserId().toString();

//This is the user who is shopping in the channel store
UserRegistrationDataBean bnRegister = new UserRegistrationDataBean();
bnRegister.setDataBeanKeyMemberId(userId );
bnRegister.populate();

//This will be used to store the list of all distributor StoreIds
Integer[] distributorStoreIds = null;
//This will store a String[] of {distributor Store Id, userId, password} 
Vector attributes = new Vector();

//Get all distributor stores
distributorStoreIds = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

if (distributorStoreIds != null) {
  for (int i=0; i < distributorStoreIds.length; i++) {
    //Get the attributes of the user
    Vector uid = bnRegister.getAttribute("UserDistributorUserId", (distributorStoreIds[i]).toString()); 
    Vector pwd = bnRegister.getAttribute("UserDistributorPasswordEncrypted", (distributorStoreIds[i]).toString()); 
    if (uid != null) {
      if (pwd == null) {
        pwd = new Vector();
        pwd.addElement("");
      }
      String[] values = {(distributorStoreIds[i]).toString(), (String) uid.elementAt(0), (String) pwd.elementAt(0)};
      //Store the attributes in the Vector
      attributes.addElement(values);
    }
  }
}

int relatedStoreCount = attributes.size();

CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);

StringBuffer url = new StringBuffer();

try {
  if (!attributes.isEmpty()) {

	// Now begin code to call OrderQuotationRequest
	// call OrderCopy to save the quotationStoreId, quotationUserId, and quotationPassword
	url.append("OrderCopy?storeId=");
	url.append(storeId);
	url.append("&catalogId=");
	url.append(catalogId);
	url.append("&toOrderId=**&copyOrderItemId_1=**&partNumber_1=");
	url.append(jhelper.getParameter("partNumber"));
	url.append("&quantity_1=");
	url.append(jhelper.getParameter("quantity"));
	url.append("&description=");
	url.append(java.net.URLEncoder.encode(storeText.getString("QuickLinks_ReqPriceAvail") + " " + cmdcontext.getTimestamp()));
	url.append("&URL=");
	url.append(java.net.URLEncoder.encode("OrderQuotationRequest?URL=OrderQuotationWaitDisplayView"));
	url.append("&errorViewName=");
	url.append(jhelper.getParameter("errorViewName"));
	url.append("&errorType=");
	url.append(jhelper.getParameter("errorType"));
	url.append("&quotationType=initial&outOrderQuotationRelIdName=orderQuotationIDs");
	
	for (int i=1; i<=attributes.size(); i++) { 
		String[] val = (String[])(attributes.elementAt(i-1));
		//Get the attributes of the user
		String distId = val[0]; 
		String uId = val[1];
		String pwd = val[2];
		String distName = cmdcontext.getStore(Integer.valueOf(distId)).getIdentifier();
		
		url.append("&quotationStoreId_");
		url.append(i);
		url.append("=");
		url.append(distId);
		url.append("&quotationUserId_");
		url.append(i);
		url.append("=");
		url.append(uId);
		url.append("&quotationPassword_");
		url.append(i);
		url.append("=");
		url.append(pwd);
		url.append("&pay_quotationStoreId_");
		url.append(i);
		url.append("=");
		url.append(distId);
		url.append("&pay_quotationUserId_");
		url.append(i);
		url.append("=");
		url.append(uId);
		url.append("&pay_quotationPassword_");
		url.append(i);
		url.append("=");
		url.append(pwd);
	}           
	
  } else {
	// go to Distributor Selection page
	url.append("DistributorSelectionDisplayView?storeId=");
	url.append(storeId);
	url.append("&catalogId=");
	url.append(catalogId);
  }	
//Execute error views if an exception occurs
} catch (Exception e){}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Refresh" content="0;URL=<%=url%>"/>
</head>
</html>
