<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="GENERATOR" content="IBM Software Development Platform" />
 
<!-- SECTION 1A -->
 
<%@ include file="../Common/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../Common/EnvironmentSetup.jspf"%>  

<!-- END OF SECTION 1A -->


<title>MyNewJSPTemplate.jsp</title>
</head>

<!-- SECTION 2 -->

<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle basename="${sdb.jspStoreDir}/Tutorial_ALL" var="tutorial" />

<!-- END OF SECTION 2-->

 
 

<body>  


<!-- SECTION 3 -->
  
<h1><fmt:message key="WebSphereCommerceInformation" bundle="${tutorial}" /> </h1>
 
<h2><fmt:message key="Tutorial" bundle="${tutorial}" /> </h2>



 
</body>
</html>
