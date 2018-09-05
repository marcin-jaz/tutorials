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
<% //This JSP is used by the tools such as the Create Store tool to integrate into this site  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="EnvironmentSetup.jsp"%>
<%
String actionName = jhelper.getParameter("actionName");

//  Highlight the correct selection on the sidebar
if (actionName != null && actionName.equals("createstore"))
{
	request.setAttribute("pageName", "RequestHostedStore");
}else if (actionName != null && actionName.equals("managestore"))
{
	request.setAttribute("pageName", "adminConsole");
}else if (actionName != null && actionName.equals("organization"))
{
	request.setAttribute("pageName", "MyOrganization");
}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="stylesheet" href="<%=fileDir%>PCDMarket.css" type="text/css" />
</head>
	
                    
<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" class="dbg">
<table border="0" cellpadding="0" cellspacing="0" width="150">
  <tbody><tr>
    <td valign="top" class="dbg" width="150"> 
      <%
      String incfile = includeDir + "SidebarDisplay.jsp";
      %>
      <jsp:include page="<%=incfile%>" flush="true">
      	<jsp:param name="switchTheLanguage" value="no" />
      </jsp:include>
	</td>
 	</tr>
	</tbody>
</table>
</body>
</html>
