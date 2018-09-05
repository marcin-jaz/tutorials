<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<script language="javascript">
var PageName="";
var PersonalPage=false;
<%
	String pname = request.getRequestURI();
	int indpn = pname.lastIndexOf('/');
	indpn = pname.lastIndexOf('/', indpn-1);
	
	if(indpn != -1)
        	pname = pname.substring(indpn+1);

	String headerType = (String) request.getAttribute("liveHelpPageType");
	if (headerType==null) headerType="";
    
	// Determine if this is a personal page or not
	if (headerType.equals("personal"))
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