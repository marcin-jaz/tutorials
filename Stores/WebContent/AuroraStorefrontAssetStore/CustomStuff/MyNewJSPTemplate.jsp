<%
//*
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2002, 2003, 2005
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons 
//* or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------
//**********************************************************************
%>

<%--  PREPARATION SECTION

<!-- SECTION 1A -->

<!-- END OF SECTION 1A -->


<title>MyNewJSPTemplate.jsp</title>
</head>

<!-- SECTION 2 -->

<!-- END OF SECTION 2 -->

<body>
<p>Hello World!.</p>


<!-- SECTION 3 -->

<!-- END OF SECTION 3 --> 



<!-- SECTION 4 -->

<!-- END OF SECTION 4 --> 

  

<!-- SECTION 5 -->

<!-- END OF SECTION 5 --> 


<!-- SECTION 6 -->
  
<!-- END OF SECTION 6 --> 


<!-- SECTION 7 -->
  
<!-- END OF SECTION 7 --> 


<!-- SECTION 8 -->

<!-- END OF SECTION 8 -->

<!-- SECTION 9 -->

<!-- END OF SECTION 9 -->


</body>
</html>

 END OF PREPARATION SECTION --%>


<%
//**************************************************************
//*------------------------------------------------------------*
//*                CODE BEGINS HERE                       *
//*------------------------------------------------------------*
//**************************************************************
%>
 
 
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

!!!SEE UPPER INCLUDES!!!<br/>
use this storeId for commands: 10651 (AssetStore) and not 10152 (ESITE) or vice versa, needs to be tested <br/>
storeId: ${storeId}<br/>
store specific path: /${sdb.directory}/Tutorial_ALL<br/>
general store path (parent): /${sdb.jspStoreDir}/storetext_v2<br/>

<!-- SECTION 2 -->

<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle basename="${sdb.jspStoreDir}/Tutorial_ALL" var="tutorial" />

<!-- END OF SECTION 2-->

 
 

<body>  


<!-- SECTION 3 -->
  
<h1><fmt:message key="WebSphereCommerceInformation" bundle="${tutorial}" /> </h1>
 
<h2><fmt:message key="Tutorial" bundle="${tutorial}" /> </h2>

<!-- END OF SECTION 3 --> 



<!-- SECTION 4 -->

<h3><fmt:message key="ParametersFromCmd" bundle="${tutorial}" /> </h3>

<fmt:message key="ControllerParm1" bundle="${tutorial}" />
<c:out value="${controllerParm1}"/> <br />
 
<fmt:message key="ControllerParm2" bundle="${tutorial}" />
<c:out value="${controllerParm2}"/> <br /> <br />
  
<!-- END OF SECTION 4 --> 



<!-- SECTION 5 -->

<c:if test="${mndbInstance.calledByControllerCmd}">
   <fmt:message key="Example" bundle="${tutorial}" /> <br />
   <fmt:message key="CalledByControllerCmd" bundle="${tutorial}" /> <br />
   <fmt:message key="CalledByWhichControllerCmd" bundle="${tutorial}" /> 
   <b><c:out value="${mndbInstance.callingCommandName}" /></b> <br /> <br />
</c:if>

<!-- END OF SECTION 5 -->



<!-- SECTION 6 -->

<fmt:message key="UserName" bundle="${tutorial}" />
<c:out value="${mndbInstance.userName}"/> <br />
 
<fmt:message key="Points" bundle="${tutorial}" /> 
<c:out value="${mndbInstance.points}"/> <br /> 
  
<!-- END OF SECTION 6 --> 



<!-- SECTION 7 -->

<fmt:message key="Greeting" bundle="${tutorial}" />
<c:out value="${taskOutputGreetings}"/> <br /> <br />
  
<!-- END OF SECTION 7 --> 



<!-- SECTION 8 -->

<c:if test="${!empty taskOutputUserId}">
   <fmt:message key="UserId" bundle="${tutorial}" />
   <c:out value="${taskOutputUserId}"/> <br />
   <fmt:message key="FirstInput" bundle="${tutorial}" />
   <b><c:out value="${userName}"/></b>
   <fmt:message key="RegisteredUser" bundle="${tutorial}" /> <br />
   <fmt:message key="ReferenceNumber" bundle="${tutorial}" /> 
   <b><c:out value="${taskOutputUserId}"/></b> <br /> <br />
</c:if>

<c:if test="${empty taskOutputUserId}">
   <fmt:message key="FirstInput" bundle="${tutorial}" />
   <b><c:out value="${userName}"/></b> 
   <fmt:message key="NotRegisteredUser" bundle="${tutorial}" /> <br />
</c:if>


<!-- END OF SECTION 8 -->



<!-- SECTION 9 -->

<h2><fmt:message key="BonusAdmin" bundle="${tutorial}" /> </h2>

<c:if test="${!empty taskOutputUserId}">
	<ul>
		<li> 
			<b>
			<fmt:message key="PointBeforeUpdate" bundle="${tutorial}" />
			<c:out value="${oldBonusPoints}"/>
			</b>
		</li>
		<li>
			<b>
			<fmt:message key="PointAfterUpdate" bundle="${tutorial}" /> 
	    	<c:out value="${bdbInstance.bonusPoint}" />
	    	</b>
	    </li>
	</ul>
</c:if>
 

<br />
<b><fmt:message key="EnterPoint" bundle="${tutorial}" /></b><p />

 
<form name="Bonus" action="MyNewControllerCmd">
<table>
	<tr>
		<td>
			<b>Logon ID </b>
		</td>
		<td>
			<input type="text" name="input1" value="<c:out value="${userName}"/>" />
		</td>
	</tr>
	<tr>
		<td>
			<b>Bonus Point</b>
		</td>
		<td>
			<input type="text" name="input2" />
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" />
		</td>
	</tr>
</table>
</form>
 
<!-- END OF SECTION 9 -->

 
</body>
</html>
