<%-- 
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//* IBM Confidential
//* OCO Source Materials
//*
//* The source code for this program is not published or otherwise
//* divested of its trade secrets, irrespective of what has been
//* deposited with the US Copyright Office.
//*--------------------------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its reliability, 
//* serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands and products 
//* in order to illustrate concepts as completely as possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by actual persons 
//* or business enterprises is entirely coincidental.
//*--------------------------------------------------------------------------------------
//*
--%>
<%@ page import="java.util.*" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle" %>


<%     
	//response.setContentType("text/html;charset=UTF-8");
	
	Locale locale = null;
	
//	String filename = "AuctionSample";

	String storeDir = (String) request.getAttribute("jspStoreDir");
	ResourceBundle rb = ResourceBundle.getBundle(storeDir + "/AuctionMessageText" ); 
	JSPResourceBundle auctionMessageText = new JSPResourceBundle(rb);

%>

