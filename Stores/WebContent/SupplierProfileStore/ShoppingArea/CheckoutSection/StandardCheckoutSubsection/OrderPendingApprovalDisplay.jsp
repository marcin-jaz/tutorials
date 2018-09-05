<%
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
%>
<%-- 
  *****
  * This page shows a message indicating the submitted order requires approval and a link to TopCategories page.
  *****
--%>
<% // All JSPs requires these packages for EnvironmentSetup.jsp which is used for multi language support %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- BEGIN OrderPendingApprovalDisplay.jsp -->
<head>
<title><fmt:message key="YourOrder_Title" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}"/><c:out value="${vfileStylesheet}"/>" type="text/css"/>
</head>
<body class="noMargin">



<%@ include file="../../../include/LayoutContainerTop.jspf"%>

<!--content start-->
        <table cellpadding="5" id="WC_OrderPendingApprovalDisplay_Table_2">
          <tbody>
            <tr>
              <td id="WC_OrderPendingApprovalDisplay_TableCell_3"> <br /> <p><fmt:message key="Order_Approval_Waiting" bundle="${storeText}"/></p>
                <p></p>
                <p> <a href="TopCategoriesDisplay?langId=<c:out value="${WCParam.langId}"/>&amp;catalogId=<c:out value="${WCParam.catalogId}"/>&amp;storeId=<c:out value="${WCParam.storeId}"/>" class="button" id="WC_OrderPendingApprovalDisplay_Link_1">
                  <fmt:message key="Home_Button1" bundle="${storeText}"/> </a></p></td>
            </tr>
          </tbody>
        </table>
        <!--content end-->

<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
      
</body>
<!-- END OrderPendingApprovalDisplay.jsp -->
</html>
