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


<% // All JSPs requires the first 4 packages for EnvironmentSetup.jsp which is used for multi language support %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.ibm.commerce.datatype.*" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ include file="../include/EnvironmentSetup.jsp"%>

<%
//Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
String forwardURL = jhelper.getParameter("forwardURL");
%>

<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<head>
  <link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css">
  <script language="javascript">
  function redirect()
  {
    location.href='<%=forwardURL%>';
  }
  </script>
</head>

<body marginheight="0" marginwidth="0" onLoad="setTimeout(redirect, <%=storeText.getString("OrderQuotationWaitDisplay_Timeout")%>)">

<table cellspacing="0" cellpadding="0" width="750" border="0">
  <tbody>
    <tr>
      <td>
	&nbsp;
      </td>
    </tr>

    <tr>
      <td>
      		<font class="subtitle"><%=storeText.getString("ExitToDistributorSiteDisplay_text")%></font>
      </td>
    </tr>
  </tbody>
</table>


</body>
</html>
