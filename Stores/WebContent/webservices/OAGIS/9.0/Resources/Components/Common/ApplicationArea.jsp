<%--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================--%>
<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	String dateTime = sdf.format(new java.util.Date());
%>
<oa:ApplicationArea>
	<oa:CreationDateTime>
		<%= dateTime %>
	</oa:CreationDateTime>
	<oa:BODID>
		<%=com.ibm.ldap.apptools.EntryUuidGenerator.newEntryUuid()%>
	</oa:BODID>
</oa:ApplicationArea>