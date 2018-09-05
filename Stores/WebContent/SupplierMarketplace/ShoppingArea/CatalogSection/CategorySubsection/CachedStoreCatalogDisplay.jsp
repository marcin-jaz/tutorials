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

<% // All JSPs requires these packages for getResource.jsp which is used for multi language support %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@ page import="com.ibm.commerce.server.JSPHelper" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ include file="../../../include/EnvironmentSetup.jspf"%>

<%
    //Parameters may be encrypted. Use JSPHelper to get URL parameter instead of request.getParameter().
    JSPHelper jhelper   = new JSPHelper(request);
    String storeId      = jhelper.getParameter("storeId");
    String catalogId    = jhelper.getParameter("catalogId");
    String languageId   = jhelper.getParameter("langId");
%>

	<!-- Start Main JSP Content -->
	<%
	// This page should only appear to user under the following conditions
	// User State is Approved - show the regular catalog
	// OR
	// User State is null but user is registered - show the regular catalog
	%>
	<table cellpadding="8" cellspacing="0" width="580" border="0" align="left">
		<tr>
            <td align="left" valign="top" colspan="3" class="categoryspace">
                <H1><%=tooltechtext.getString("Header_Home")%></H1>
                <!-- PROMO CONTENT STARTS HERE -->
                <jsp:include page="../../../include/StoreCatalogProductESpot.jsp" flush="true">
                    <jsp:param name="emsName" value="StoreHomePage" />
                    <jsp:param name="catalogId" value="<%= catalogId %>" />
                </jsp:include>
                <!-- PROMO CONTENT ENDS HERE -->

				<TABLE border="0" cellspacing="0" cellpadding="0">
    				<tr>
    					<td><%=tooltechtext.getString ("Home_Message1")%><br><br></td>
    				</tr>

    				<tr>
    					<td>
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
    										<font color="#ffffff"><b>
    										<a class="catalog" href="TopCategoriesDisplay?langId=<%=languageId%>&catalogId=<%=catalogId%>&storeId=<%=storeId%>" style="color:#ffffff; text-decoration : none;">
    										<%=tooltechtext.getString ("Home_Button1")%>
    										</a>
    										</b></font>
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
    	  			</TR>
	  			</TABLE>
  		    </TD>
        </TR>
    </TABLE>
