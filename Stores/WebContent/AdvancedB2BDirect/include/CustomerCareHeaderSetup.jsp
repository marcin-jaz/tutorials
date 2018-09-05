<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2001, 2004
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%>
<%-- 
  *****
  * This JSP page sets up Live Help through JavaScript if Customer Care is enabled.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="JSTLEnvironmentSetup.jspf"%>

<% String headerType = ""; %>

<flow:ifEnabled feature="customerCare">
	<% headerType = (String) request.getAttribute("liveHelpPageType"); // "personal"; %>
</flow:ifEnabled> 
<script language="javascript">
var PageName="";
var PersonalPage=false;
<%
	String pname = request.getRequestURI();
	int indpn = pname.lastIndexOf('/');
	indpn = pname.lastIndexOf('/', indpn-1);
	
	if(indpn != -1)
        	pname = pname.substring(indpn+1);

	// Determine if this is a personal page or not
	if (headerType!=null && headerType.equals("personal"))
	{
		%>
  		if (typeof parent.setPageParams == 'function') {
  			PersonalPage=true;
    			parent.setPageParams('PERSONAL_URL', '<%=pname%>');
    			}
		<% 
	} 
	else 
	{ 
		%>
  		if (typeof parent.setPageParams == 'function')
    		parent.setPageParams(location.href, '<%=pname%>');
		<% 
	} 
	%>
	Pagename="<%=pname%>";

</script>