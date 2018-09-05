<%
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
 *
 *-------------------------------------------------------------------
 */
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
<%@ include file="../../../include/EnvironmentSetup.jsp"%>
<%
// JSPHelper provides you with a easy way to retrieve URL parameters when they are encrypted
String userId = cmdcontext.getUserId().toString();
String orderRn = jhelper.getParameter("orderId");
if( (orderRn == null)||(orderRn.length()==0)) {
  orderRn = ".";
}

TypedProperty requestProperties = (TypedProperty)request.getAttribute(ECConstants.EC_REQUESTPROPERTIES) ;

//This is the user who is shopping in the channel store
UserRegistrationDataBean bnRegister = new UserRegistrationDataBean();
bnRegister.setDataBeanKeyMemberId(userId );
bnRegister.populate();

//This will be used to store the list of all distributor StoreIds
Integer[] distributorStoreIds = null;
//This will store a String[] of {distributor Store Id, userId, password} 
Vector attributes = new Vector();

StoreEntityDataBean stEntDataBean = null;
StoreEntityDescriptionAccessBean stEntDscAccessBean = null;

//Get all distributor stores
distributorStoreIds = cmdcontext.getStore().getRelatedStores("com.ibm.commerce.referral");

if (distributorStoreIds != null) {
  for (int i=0; i < distributorStoreIds.length; i++) {
    //Get the attributes of the user
    Vector uid = bnRegister.getAttribute("UserDistributorUserId", (distributorStoreIds[i]).toString()); 
    Vector pwd = bnRegister.getAttribute("UserDistributorPasswordEncrypted", (distributorStoreIds[i]).toString()); 
    if( uid == null) {
      uid = new Vector();
      uid.addElement("");
    }
    if (pwd == null) {
      pwd = new Vector();
      pwd.addElement("");
    }
    String[] values = {(distributorStoreIds[i]).toString(), (String) uid.elementAt(0), (String) pwd.elementAt(0)};
    //Store the attributes in the Vector
    attributes.addElement(values);
    }
}

int relatedStoreCount = attributes.size();

// check if there are any failed order quotations
Vector errorDistributorNames = new Vector();
String[] failOrderQuotationRelIds = jhelper.getParameterValues("failOrderQuotationRelId");   
if ((failOrderQuotationRelIds!= null) && (failOrderQuotationRelIds.length>0)) {
  for(int i=0;i<failOrderQuotationRelIds.length;i++) {
    StringTokenizer st = new StringTokenizer(failOrderQuotationRelIds[i], "_");
    String orderQuotRelId = st.nextToken();
    String errorCode = st.nextToken();
    if (errorCode!=null && errorCode.equals("1")) {
      OrderQuotationRelDataBean relBean = new OrderQuotationRelDataBean();
      relBean.setDataBeanKeyOrderQuotationRelId( orderQuotRelId );
      com.ibm.commerce.beans.DataBeanManager.activate(relBean, request);    
      StoreEntityDataBean storeEntity = new StoreEntityDataBean();
      storeEntity.setDataBeanKeyStoreEntityId( relBean.getChildStoreId() );
      com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
      // Get the appropriate description of the store entity - for the store display name       
      Integer iLangId = Integer.valueOf(languageId);  
      StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
      errorDistributorNames.addElement(storeDesc.getDisplayName());
    }
  }
}

// check if there are any failed order transfers
Vector transferErrorDistributorNames = new Vector();
Vector vFailedOrderIds = new Vector();
String[] failedOrderIds = jhelper.getParameterValues("failOrderId");   
if ((failedOrderIds!= null) && (failedOrderIds.length>0)) {
  for(int i=0;i<failedOrderIds.length;i++) {
    StringTokenizer st = new StringTokenizer(failedOrderIds[i], "_");
    String failOrderId = st.nextToken();
    String errorCode = st.nextToken();
    if (errorCode!=null && errorCode.equals("1")) {
      OrderDataBean childOrderBean = new OrderDataBean();
      childOrderBean.setOrderId(failOrderId);
      com.ibm.commerce.beans.DataBeanManager.activate(childOrderBean, request);    
      StoreEntityDataBean storeEntity = new StoreEntityDataBean();
      storeEntity.setDataBeanKeyStoreEntityId( childOrderBean.getStoreEntityId() );
      com.ibm.commerce.beans.DataBeanManager.activate(storeEntity, request);
      // Get the appropriate description of the store entity - for the store display name       
      Integer iLangId = Integer.valueOf(languageId);  
      StoreEntityDescriptionAccessBean storeDesc = storeEntity.getDescription(iLangId);        
      transferErrorDistributorNames.addElement(storeDesc.getDisplayName());
      vFailedOrderIds.addElement(failOrderId);
    }
  }
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title><%=storeText.getString("DistributorSelectionDisplay_Title")%></title>
  <link rel=stylesheet href="<%=fileDir%>PCDMarket.css" type="text/css">
</head>
<script language="javascript">
  var busy=false;

  function submitForm(form)
  {
    if( !busy ) {
      busy = true;
      var initialInputs = new Array(<%=relatedStoreCount%>);
      var finalInputs = new Array(<%=relatedStoreCount%>);
      var initalInputCount = <%=relatedStoreCount%>;
      var finalInputCount = 0;
      
      <% for (int dists=0; dists<relatedStoreCount; dists++) { 
                String[] val = (String[])(attributes.elementAt(dists));
                //Get the attributes of the user
                String distId = val[0];
                String uId = val[1];
                String pwd = val[2];       
        /* if the checkbox is checked, the values in the input box will be saved as the attributes of the user
         *  Otherwise, the values in the input box will not be saved.
         */
      %>
        if (form.quotationPassword_<%=(dists+1)%>.value == "******")
          form.quotationPassword_<%=(dists+1)%>.value = "";

        if (form.quotationStore_<%=(dists+1)%>.checked) {
          form.pay_quotationStoreId_<%=(dists+1)%>.value = form.quotationStoreId_<%=(dists+1)%>.value;
          form.pay_quotationUserId_<%=(dists+1)%>.value = form.quotationUserId_<%=(dists+1)%>.value;
          form.pay_quotationPassword_<%=(dists+1)%>.value = form.quotationPassword_<%=(dists+1)%>.value;

          form.UserDistributorUserId_<%=distId%>_r_<%=(dists)%>.value = form.quotationUserId_<%=(dists+1)%>.value;
          form.UserDistributorPasswordEncrypted_<%=distId%>_r_<%=(dists)%>.value = form.quotationPassword_<%=(dists+1)%>.value;

          finalInputCount++;
        } else {
          form.quotationStoreId_<%=(dists+1)%>.value="";
          form.quotationUserId_<%=(dists+1)%>.value="";
          form.quotationPassword_<%=(dists+1)%>.value="";
          form.UserDistributorUserId_<%=distId%>_r_<%=(dists)%>.value = "<%=uId%>";
          form.UserDistributorPasswordEncrypted_<%=distId%>_r_<%=(dists)%>.value = "<%=pwd%>";
        }
          
        if (form.quotationPassword_<%=(dists+1)%>.value == "******")
          form.quotationPassword_<%=(dists+1)%>.value = "";
          
      <% } %>
      
      if(finalInputCount > 0 ) {
        form.submit();
      } else {
        alert("<%=storeText.getString("DistributorSelectionDisplay_JSError")%>");
        busy = false;
      }
    }
  }
</script>
<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<!-- Start Header -->
<%@ include file="../../../include/HeaderDisplay.jspf"%>
<!-- End Header -->
<!-- Start Main Table - Consists of TD for Left Bar, gutter, TD for Content -->
<table border="0" cellpadding="0" cellspacing="0" width="750">
  <tr>
    <td valign="top" class="mbg" width="150"> 
      <% String incfile = includeDir + "SidebarDisplay.jsp"; %>
      <jsp:include page="<%=incfile%>" flush="true"/></TD>
    <td><a name="mainContent"></a><img height="1" width="10" src="<%=fileDir%>images/c.gif" /></td>
    <td valign="top" width="590">
    <!--START MAIN CONTENT-->
      <table width="590" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table width="590" border="0" cellspacing="0" cellpadding="0">
        <%    
        if (transferErrorDistributorNames.size() == 0) 
        {
          /* In this case, this page is displayed not because of error
           * UserRegistrationUpdate is first called to update the user's attributes with the values of the userId/password specified in these input boxes
           * OrderCopy is used to copy the userId/password to the order for future quotation
           * OrderQuotationRequest is called to request for quotation
           */
        %>
              <form name="DistributorSelectionForm" action="UserRegistrationUpdate" method="POST">
              <input type="hidden" name="quotationType" value="initial">
              <input type="hidden" name="orderId" value="<%=orderRn%>">  
              <input type="hidden" name="toOrderId" value="<%=orderRn%>">
              <input type="hidden" name="toOrderId" value="<%=orderRn%>">
              <input type="hidden" name="langId" value="<%=languageId%>">
              <input type="hidden" name="URL" value="OrderCopy?URL=OrderQuotationRequest%3FURL%3DOrderQuotationWaitDisplayView">
              <input type="hidden" name="outOrderQuotationRelIdName" value="orderQuotationIDs">
              <input type="hidden" name="deleteOrderQuotationRelId" value="*parent.">
              <input type="hidden" name="orderQuotationRelId" value="*initial*parent<%= orderRn %>">      
              <input type="hidden" name="authToken" value="${authToken}" id="WC_DistributorSelectionDisplay_FormInput_authToken_1"/>   
        <%
        }
        else
        {
          // if this page is displayed due to order transfer error, UserRegistrationUpdate is called followed by OrderProcess
          String channelOrder = jhelper.getParameter("channelOrderId");
          String multipleShopcart = jhelper.getParameter("multipleShopcart");
          String autoOpen = jhelper.getParameter("autoOpen");
          String openAllWindows = jhelper.getParameter("openAllWindows");
        %>
              <form name="DistributorSelectionForm" method="POST" action="UserRegistrationUpdate">
              <INPUT type=hidden name="URL" value="OrderProcess?URL=DistributorShopcartReviewDisplayView" >
          <% 
              for (int i=1; i<=vFailedOrderIds.size(); i++) { 
          %>
              <INPUT type=hidden name="orderId" value="<%=vFailedOrderIds.elementAt(i-1)%>">  
          <%
              }
          %>	              
              <input type="hidden" name="toOrderId" value="<%=orderRn%>">
              <INPUT type=hidden name="parentOrderId" value="<%=channelOrder%>">    
              <INPUT type=hidden name="policyId" value="-9900">
              <INPUT type=hidden name="reduceParentQuantities" value="1">
              <INPUT type=hidden name="quotationSubmission" value="1">
              <INPUT type=hidden name="multipleShopcart" value="<%=multipleShopcart%>">
              <INPUT type=hidden name="autoOpen" value="<%=autoOpen%>">
              <input type=hidden name="openAllWindows" value="<%=openAllWindows%>">              
              <INPUT type=hidden name="processOrderWithStatusH" value="yes">
              <input type="hidden" name="authToken" value="${authToken}" id="WC_DistributorSelectionDisplay_FormInput_authToken_2"/>
        <%
        }
        %>
              <tr>
                <td>
                  <table width="590" border="0" cellspacing="0" cellpadding="0">        
                    <tr>
       			<td colspan=2><span class="bct">&nbsp;&nbsp;&nbsp;</span>
       			<a class="bctl" href="StoreCatalogDisplay?storeId=<%=storeId%>&catalogId=<%=catalogId%>&langId=<%=languageId%>"><%=storeText.getString("Breadcrumb_CommercePlaza")%></a><span class="bct">&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;</span>
       			<span class="bct"><%=storeText.getString("Breadcrumb_RequestPriceAvail")%></span>
                      </td>
                    </tr>
                    <tr>
                      <td valign="top" width="310">
                        <div align="left"><span class="title"><%=storeText.getString("DistributorSelectionDisplay_Heading")%></span></div>
                        <div><span class="subtitle"><%=storeText.getString("DistributorSelectionDisplay_Step")%></span></div>
                      </td>
                      <td valign="top" width="280">
                        <div align="right"><img src="<%=fileDir%>images/hdr_cart.gif" width="280" height="72" alt="<%=storeText.getString("DistributorSelectionDisplay_Heading")%>"></div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr valign="top">
                <td>
                  <table cellpadding="2" border="0" cellspacing="1">
                    <tr>
                      <td valign="top" colspan="4"><%=storeText.getString("DistributorSelectionDisplay_Instruction")%></td>
                    </tr>
                    <tr>
                      <td colspan=4><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
                    </tr>          

        <%
        // display an error message and the distributor names if there are failed order transfers
        if (transferErrorDistributorNames.size() > 0) {
        %>
        <tr>
          <td colspan=4><font class="error">
          <%
          if (transferErrorDistributorNames.size() > 1) {
          // more than 1 authentication errors
          %>
            <%=storeText.getString("ErrorStatus_Text10")%><br />
          <% 
              for (int i=1; i<=transferErrorDistributorNames.size(); i++) { 
          %>
                <%=transferErrorDistributorNames.elementAt(i-1)%><br />
          <%
              }
          }
          else {
          // only 1 authentication error
          %>
            <%=storeText.getString("ErrorStatus_Text7", (String) transferErrorDistributorNames.elementAt(0) )%><br />
          <%
          }
          %>
          </font></td>
        </tr>
        <tr>
          <td colspan=4><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
        </tr>
        <%
        }
        // display an error message and the distributor names if there are failed order quotations
        if (errorDistributorNames.size() > 0) {
        %>
        <tr>
          <td colspan=4><font class="error">
          <%
          if (errorDistributorNames.size() > 1) {
          // more than 1 authentication errors
          %>
            <%=storeText.getString("ErrorStatus_Text3")%><br />
          <% 
              for (int i=1; i<=errorDistributorNames.size(); i++) { 
          %>
                <%=errorDistributorNames.elementAt(i-1)%><br />
          <%
              }
          }
          else {
          // only 1 authentication error
          %>
            <%=storeText.getString("ErrorStatus_Text4", (String) errorDistributorNames.elementAt(0) )%><br />
          <%
          }
          %>
          </font></td>
        </tr>
        <tr>
          <td colspan=4><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
        </tr>
        <%
        }
        if (!attributes.isEmpty()) { %>         
                    <tr class=tdblue>
                      <th colspan="2" align="left" id="th1" class="tdblue"><%=storeText.getString("DistributorSelectionDisplay_DistributorColumn")%></th>
                      <th align="left" id="th2" class="tdblue"><%=storeText.getString("DistributorSelectionDisplay_UserIdColumn")%></th>
                      <th align="left" id="th3" class="tdblue"><%=storeText.getString("DistributorSelectionDisplay_PasswordColumn")%></th>
                    </tr>
                    <span class=small style="FONT-WEIGHT: bold">
           <% for (int i=1; i<=attributes.size(); i++) { 
                String[] val = (String[])(attributes.elementAt(i-1));
                //Get the attributes of the user
                String distId = val[0]; 
                String uId = val[1];
                String pwd = val[2];
                String checkedVal;
                if ((uId==null)||(uId.length()==0)) {
                  checkedVal = " ";
                } else {
                  checkedVal = "checked";
                } 
            		stEntDataBean = new StoreEntityDataBean();
            		stEntDataBean.setDataBeanKeyStoreEntityId(distId);
            		com.ibm.commerce.beans.DataBeanManager.activate(stEntDataBean, request);
            		stEntDscAccessBean = stEntDataBean.getDescription(new Integer(languageId));
		
                String distName = stEntDscAccessBean.getDisplayName();                  
                //String distName = cmdcontext.getStore(Integer.valueOf(distId)).getIdentifier();
           %>
                    <input type="hidden" name="UserDistributorUserId_<%=distId%>_r_<%=i-1%>" value="test1">
                    <input type="hidden" name="UserDistributorPasswordEncrypted_<%=distId%>_r_<%=i-1%>" value="testpwd1">
           
                    <input type="hidden" name="toOrderId" value="<%=orderRn%>">
                    <input type="hidden" name="pay_quotationStoreId_<%=i%>" value="">
                    <input type="hidden" name="pay_quotationUserId_<%=i%>" value="">
                    <input type="hidden" name="pay_quotationPassword_<%=i%>" value="">
                    <input type="hidden" name="quotationStoreId_<%=i%>" value="<%=distId%>">
                    <tr class="mbg" valign="middle">
                      <td headers="th1"><input type=checkbox name="quotationStore_<%=i%>" id="quotationStore_<%=i%>" value="<%=distId%>" <%=checkedVal%>></td>
                      <td headers="th1"><label for="quotationStore_<%=i%>"><%=distName%></label></td>
                      <td headers="th2_<%=i%>">
                      <label for="th2_<%=i%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("DistributorSelectionDisplay_UserIdColumn")%>"/></label>
                      <input type="text" size="10" name="quotationUserId_<%=i%>" id="th2_<%=i%>" value="<%=uId%>" class="iform" /></td>
                      <label for="th3_<%=i%>"><img src="<%=fileDir%>images/trans.gif" height="1" width="1" border="0" alt="<%=storeText.getString("DistributorSelectionDisplay_PasswordColumn")%>"/></label>
              <% if ((uId==null)||(uId.length()==0)) { %>              
                      <td headers="th3_<%=i%>"><input type="password" size="10" name="quotationPassword_<%=i%>" id="th3_<%=i%>" value="" class="iform" /></td>
              <% } else { %>
                      <td headers="th3_<%=i%>"><input type="password" size="10" name="quotationPassword_<%=i%>" id="th3_<%=i%>" value="******" class="iform" /></td>
              <% } %>           
                    </tr>
           <% } %>
                    </span>
                    <tr>
                      <td colspan=4><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
                    </tr>          
                    <tr>
                      <td colspan=4><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
                    </tr>          
                    <tr>
                      <td colspan="3">&nbsp;</td>
                      <td align="left"><a href="javascript:submitForm( document.DistributorSelectionForm )"><img src="<%=fileDir%><%=locale.toString()%>/images/continue.gif" width="120" height="21" border=0 alt="<%=storeText.getString("Alt_Continue")%>"></a>
                    </tr>
        <% } else { %>
                    <tr>
                      <td colspan="4"><%=storeText.getString("DistributorSelectionDisplay_Error")%></td>
                    </tr>
        <% } %>           
                  </table>
                </td>
              </tr>
              </form>
            </table>
          </td>
        </tr>
        <tr>
          <td><img height="10" width="1" alt="" src="<%=fileDir%>images/c.gif" /></td>
        </tr>
      </table>
    <!--END MAIN CONTENT-->
    </td>
    <!-- End of Main Content TD -->
  </tr>
</table>
<!-- End Main Table -->
<!-- Start Footer -->
<%@ include file="../../../include/FooterDisplay.jspf"%>
<!-- End Footer -->
</body>
</html>