<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2001, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page displays fields to search for a particular RFQ
  * based on the selected criteria.
  * 
  * Required parameters:
  * - catalogId
  * - storeId
  * - langId
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="RFQFindConstants.jspf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">

<html lang="en">
<head>
<title><fmt:message key="RFQFind_Title" bundle="${storeText}" /></title>
<link rel="stylesheet"	href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>"	type="text/css" />
<script language="javascript">
		//////////////////////////////////////////////////////////
		// This function will check whether or not the time has
		// a valid format. hh:mm:ss
		//
		// Input: time
		// Return code = "true", time has a right format
		// Return code = "false", time format is wrong
		//////////////////////////////////////////////////////////
		function validTime(time1) {
		   var delimiter = ":";
		   var tokens;
		   var hh, mm, ss;
		   var time1Length;
		   var hhlength;
		   var mmlength;
		   var sslength;
		
		   time1Length = time1.length;
		
		   if (time1 == "" || time1.indexOf(delimiter) == -1 || time1Length <= 0 || time1Length > 8 ) return false;
		
		   tokens = time1.split(delimiter);
		   if (tokens.length != 3) {
		   	return false;
		   }
		   hh = tokens[0];
		   mm = tokens[1];
		   ss = tokens[2];
		
		   hhlength = hh.length;
		   mmlength = mm.length;
		   sslength = ss.length;
		
		   if (hhlength <1 || hhlength >2 || mmlength <1 || mmlength >2 || sslength <1 || sslength >2) return false;
		   if (hh=="" || mm == "" || ss == "" ) return false;
		   if (isNaN(hh) || isNaN(mm) || isNaN(ss)) return false;
		
		   if ( parseInt(hh) > 23 || parseInt(hh) < 0 ) return false;
		   if ( parseInt(mm) > 59 || parseInt(mm) < 0 ) return false;
		   if ( parseInt(ss) > 59 || parseInt(ss) < 0 ) return false;
		
		   return true;
		}

		// accepts date in YYYY-MM-DD format and validates it if is within
		// the year range of 1900 to 9999
		// Returns true if date is a valid date
		//         false otherwise
		function validDate(inYear,inMonth,inDay)
		{
		   if (inDay.length > 0 && inDay.charAt(0) == "0")
		     {
		      inDay = inDay.substring(1, inDay.length);
		     }
		
		   if (inMonth.length > 0 && inMonth.charAt(0) == "0")
		     {
		      inMonth = inMonth.substring(1, inMonth.length);
		     }
		
		   if (inYear.length == 4 &&
		       (inMonth.length == 1 || inMonth.length == 2) &&
		       (inDay.length == 1 || inDay.length == 2))
		    {
		        var day = parseInt(inDay);
		        var month = parseInt(inMonth);
		        var year = parseInt(inYear);
		        var dayString = day.toString();
		        var monthString = month.toString();
		        var yearString = year.toString();
		
		        if ((year != NaN && yearString.length == 4 && year >= 1900 && year <= 9999 ) &&
		           (month != NaN && month >= 1 && month <= 12 && (monthString.length == inMonth.length)) && (day != NaN && (inDay.length == dayString.length)))
		        {
		
		            var daysMonth = getDaysInMonth(month, year);
		
		            if (day >= 1 && day <= daysMonth)
		            {
		                return true;
		            }
		        }
		        else
		        {
		            return false;
		        }
		
		     }
		    return false;
		}
		
		// CHECK TO SEE IF YEAR IS A LEAP YEAR
		function isLeapYear(Year)
		{
		        if (((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
		          return (true);
		        }
		        else {
		          return (false);
		        }
		}
		
		
		// GET NUMBER OF DAYS IN MONTH
		function getDaysInMonth(month, year)
		{
		        var days;
		
		        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
		          days = 31;
		        else if (month == 4 || month == 6 || month == 9 || month == 11)
		          days = 30;
		        else if (month == 2)
		        {
		          if (isLeapYear(year)) {
		            days = 29;
		          }
		          else {
		            days = 28;
		          }
		        }
		        return (days);
		}

		function getValueFromSelection(formObject) {
			var selectedIndex = formObject.selectedIndex;
			return formObject.options[selectedIndex].value;
		}

		function submitSearch(form) {
			if (form.searchType.value=='name' && form.name.value=='') {
				error("<fmt:message key="RFQFind_Err_1" bundle="${storeText}" />");

				return;
			}
			if (form.searchType.value=='createdate') {
				if (getValueFromSelection(form.createYear)=='' || getValueFromSelection(form.createMonth)=='' || getValueFromSelection(form.createDay)=='' || form.createtime.value=='') {
					error("<fmt:message key="RFQFind_Err_2" bundle="${storeText}" />");

					return;
				}
				if (!validDate(getValueFromSelection(form.createYear), getValueFromSelection(form.createMonth), getValueFromSelection(form.createDay))) {
					error("<fmt:message key="msgInvalidDate" bundle="${storeText}" />");

					return;
				}
				if (!validTime(form.createtime.value)) {
					error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");
				
					return;
				}
			}
			if (form.searchType.value=='activedate') {
				if (getValueFromSelection(form.activeYear)=='' || getValueFromSelection(form.activeMonth)=='' || getValueFromSelection(form.activeDay)=='' || form.activetime.value=='') {
					error("<fmt:message key="RFQFind_Err_3" bundle="${storeText}" />");

					return;
				}
				if (!validDate(getValueFromSelection(form.activeYear), getValueFromSelection(form.activeMonth), getValueFromSelection(form.activeDay))) {
					error("<fmt:message key="msgInvalidDate" bundle="${storeText}" />");

					return;
				}
				if (!validTime(form.activetime.value)) {
					error("<fmt:message key="RFQExtra_Error1" bundle="${storeText}" />");

					return;
				}
			}
			form.submit()
		}
		
		function error(errMsg)
		{
			alert(errMsg);
		}
</script>

<meta name="GENERATOR" content="IBM WebSphere Studio" />
</head>


<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<flow:ifEnabled feature="customerCare">
	<%-- Set header type needed for this JSP for LiveHelp.  This must
 	be set before HeaderDisplay.jsp 
 	--%>
	<c:set var="liveHelpPageType" value="personal" scope="request" />
</flow:ifEnabled>
<%@ include file="../../include/LayoutContainerTop.jspf" %>

<!-- Get current date -->
<jsp:useBean id="now" class="java.util.Date"/>

<!-- BEGIN RFQFindDisplay.jsp -->
<h1><fmt:message key="RFQFind_Adv_Find" bundle="${storeText}" /></h1>
<table id="WC_RFQFindDisplay_Table_1"> 
	<!-- Start Search Form -->
	<form method="get" action="RFQFindResultDisplay" name="RFQSearchForm" id="WC_RFQFindDisplay_Form_1">
		<input type="hidden" name="searchType" value="" /> 
		<input type="hidden" name="createdate" value="" /> 
		<input type="hidden" name="activedate" value="" /> 
		<input type="hidden" name="langId" value="<c:out value="${langId}"/>" /> 
		<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>" /> 
		<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>" />
	<tbody>
		<tr bgcolor="4c6178">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_1">
			<table bgcolor="#BCCBDB" width="100%" id="WC_RFQFindDisplay_Table_2">
				<tbody>
					<tr>
						<td id="WC_RFQFindDisplay_TableCell_2">
						<div ><font class="strongtext">
						<fmt:message key="RFQFind_Search_Name" bundle="${storeText}" /></font><br />
						<font class="text">&nbsp;<label for=""></label><input size="30" maxlength="254"
							type="text" class="input" name="name" id=""/></font></div>
						
						</td>
						<td id="WC_RFQFindDisplay_TableCell_3">
						<div align="right">
						<!-- Start display for Search GO button -->
						<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_3">
							<tr>
								<td  id="WC_RFQFindDisplay_TableCell_4"></td>
								<td  id="WC_RFQFindDisplay_TableCell_5"></td>
								<td  id="WC_RFQFindDisplay_TableCell_6"></td>
							</tr>
							<tr>
								<td bgcolor="#ff2d2d" id="WC_RFQFindDisplay_TableCell_7"></td>
								<td id="WC_RFQFindDisplay_TableCell_8">
								<table cellpadding="2" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_4">
									<tr>
										<td height="41" id="WC_RFQFindDisplay_TableCell_9"> <a class="button"
											href="javascript:document.RFQSearchForm.searchType.value='name';submitSearch(document.RFQSearchForm)"
											>
											<fmt:message key="RFQFind_Submit" bundle="${storeText}" /> </a> </td>
									</tr>
								</table>
								</td>
								<td bgcolor="#7a1616" id="WC_RFQFindDisplay_TableCell_10"></td>
							<tr>
								<td  id="WC_RFQFindDisplay_TableCell_11"></td>
								<td  valign="top" id="WC_RFQFindDisplay_TableCell_12"></td>
								<td  valign="top" id="WC_RFQFindDisplay_TableCell_13"></td>
							</tr>
						</table>
						<!-- End display for Search GO button -->
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_14">&nbsp;</td>
		</tr>
		<tr bgcolor="4c6178">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_15">
			<table bgcolor="#BCCBDB" width="100%" id="WC_RFQFindDisplay_Table_5">
				<tbody>
					<tr>
						<td id="WC_RFQFindDisplay_TableCell_16">
						<div ><font class="text"> 
						<label for="WC_RFQFindDisplay_Select_1"><fmt:message key="RFQFind_Search_Status" bundle="${storeText}" /></label><br>
						&nbsp;
						
						<select id="WC_RFQFindDisplay_Select_1" class="select" name="status"> 
						
						<option value="<c:out value="${EC_STATE_ACTIVE}" />"><fmt:message key="RFQFind_Active"
							bundle="${storeText}" /></option>
						<option value="<c:out value="${EC_STATE_DRAFT}" />"><fmt:message key="RFQFind_Draft"
							bundle="${storeText}" /></option>
						<option value="<c:out value="${EC_STATE_CANCELED}" />"><fmt:message key="RFQFind_Canceled"
							bundle="${storeText}" /></option>
						<option value="<c:out value="${EC_STATE_CLOSED}" />"><fmt:message key="RFQFind_Closed"
							bundle="${storeText}" /></option>
						<option value="<c:out value="${EC_STATE_COMPLETED}" />"><fmt:message key="RFQFind_Complete"
							bundle="${storeText}" /></option>
						<option value="<c:out value="${EC_STATE_FUTURE}" />"><fmt:message key="RFQFind_Future"
							bundle="${storeText}" /></option>
						<option value="<c:out value="${EC_STATE_NEXT_ROUND}" />"><fmt:message key="RFQFind_NextRound"
							bundle="${storeText}" /></option>
						</SELECT></font></div>
						</td>
						<td id="WC_RFQFindDisplay_TableCell_17">
						<div align="right"><!-- Start Submit Button -->
						<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_7">
							<tbody>
								<tr> 
									<td id="WC_RFQFindDisplay_TableCell_18"></td>
									<td id="WC_RFQFindDisplay_TableCell_19"></td>
									<td id="WC_RFQFindDisplay_TableCell_20"></td>
								</tr>
								<tr>
									<td  id="WC_RFQFindDisplay_TableCell_21"></td>
									<td  id="WC_RFQFindDisplay_TableCell_22">
									<table cellpadding="2" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_8">
										<tbody>
											<tr>
												<td height="41" id="WC_RFQFindDisplay_TableCell_23"> <A class="button"
													href="javascript:document.RFQSearchForm.searchType.value='state';submitSearch(document.RFQSearchForm)"
													>
													<fmt:message key="RFQFind_Submit" bundle="${storeText}" /></A> </td>
											</tr>
										</tbody>
									</table>
									</td>
									<td  id="WC_RFQFindDisplay_TableCell_24"></td>
								</tr>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_25"></td>
									<td valign="top" id="WC_RFQFindDisplay_TableCell_26"></td>
									<td valign="top" id="WC_RFQFindDisplay_TableCell_27"></td>
								</tr>
							</tbody>
						</table>

						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_28">&nbsp;</td>
		</tr>
		<tr bgcolor="4c6178">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_29">
			<table bgcolor="#BCCBDB" id="WC_RFQFindDisplay_Table_9">
				<tbody>
					<tr>
						<td id="WC_RFQFindDisplay_TableCell_30">
						<div ><font class="text">
						<fmt:message key="RFQFind_Search_Create" bundle="${storeText}" /><br>
						<c:set var="select_prefix" value="create" scope="page" />
							<c:choose>
							<c:when
								test="${locale == 'pt_BR' or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
								<%@ include file="RFQFindDisplay_SearchDates_pt_BR.jspf" %>
							</c:when>
							<c:otherwise>
								
								<%@ include file="RFQFindDisplay_SearchDates.jspf" %>
							</c:otherwise>
						</c:choose> 
						&nbsp;&nbsp;&nbsp;
						<label for=""><fmt:message key="RFQCreateDisplay_Time" bundle="${storeText}" /></label> <input size="10" maxlength="10"
							type="text" class="input" name="createtime" value="00:00:00" id=""></font></div>
						</td>
						<td id="WC_RFQFindDisplay_TableCell_31">
						<div ><font class="text"><br>
						</font> <!-- Start Submit Button -->
						<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_10">
							<tbody>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_32"></td>
									<td id="WC_RFQFindDisplay_TableCell_33"></td>
									<td id="WC_RFQFindDisplay_TableCell_34"></td>
								</tr>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_35"></td>
									<td id="WC_RFQFindDisplay_TableCell_36">
									<table cellpadding="2" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_11">
										<tbody>
											<tr>
												<td height="41" id="WC_RFQFindDisplay_TableCell_37"> <A class="button" 
													href="javascript:document.RFQSearchForm.searchType.value='createdate';document.RFQSearchForm.createdate.value=getValueFromSelection(document.RFQSearchForm.createYear)+'-'+getValueFromSelection(document.RFQSearchForm.createMonth)+'-'+getValueFromSelection(document.RFQSearchForm.createDay);submitSearch(document.RFQSearchForm)"
													>
													<fmt:message key="RFQFind_Submit" bundle="${storeText}" /></A> </td>
											</tr>
										</tbody>
									</table>
									</td>
									<td id="WC_RFQFindDisplay_TableCell_38"></td>
								</tr>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_39"></td>
									<td valign="top" id="WC_RFQFindDisplay_TableCell_40"></td>
									<td valign="top" id="WC_RFQFindDisplay_TableCell_41"></td>
								</tr>
							</tbody>
						</table>

						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_42">&nbsp;</td>
		</tr>
		<tr bgcolor="4c6178">
			<td colspan="2" id="WC_RFQFindDisplay_TableCell_43">
			<table bgcolor="#BCCBDB" id="WC_RFQFindDisplay_Table_13">
				<tbody>
					<tr>
						<td id="WC_RFQFindDisplay_TableCell_44">
						<div ><font class="text"> <fmt:message
							key="RFQFind_Search_Activate" bundle="${storeText}" /><br>
						<c:set var="select_prefix" value="active" scope="page" />
						<c:choose>
							<c:when
								test="${locale == 'pt_BR' or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
								<%@ include file="RFQFindDisplay_SearchDates_pt_BR.jspf" %>
							</c:when>
							<c:otherwise>
								<%@ include file="RFQFindDisplay_SearchDates.jspf" %>
							</c:otherwise>
						</c:choose> 
						&nbsp;&nbsp;&nbsp;
						<label for="">
						<fmt:message key="RFQCreateDisplay_Time" bundle="${storeText}" /></label>
						<input size="10" maxlength="10"
							type="text" class="input" name="activetime" value="00:00:00" id=""></font></div>
						</td>
						<td id="WC_RFQFindDisplay_TableCell_45">
						<div ><font class="text"><br>
						</font> <!-- Start Submit Button -->
						<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_14">
							<tbody>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_46"></td>
									<td id="WC_RFQFindDisplay_TableCell_47"></td>
									<td id="WC_RFQFindDisplay_TableCell_48"></td>
								</tr>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_49"></td>
									<td id="WC_RFQFindDisplay_TableCell_50">
									<table cellpadding="2" cellspacing="0" border="0" id="WC_RFQFindDisplay_Table_15">
										<tbody>
											<tr>
												<td height="41" id="WC_RFQFindDisplay_TableCell_51"> <A class="button" 
													href="javascript:document.RFQSearchForm.searchType.value='activedate';document.RFQSearchForm.activedate.value=getValueFromSelection(document.RFQSearchForm.activeYear)+'-'+getValueFromSelection(document.RFQSearchForm.activeMonth)+'-'+getValueFromSelection(document.RFQSearchForm.activeDay);submitSearch(document.RFQSearchForm)"
													>
													<fmt:message key="RFQFind_Submit" bundle="${storeText}" /> </A> </td>
											</tr>
										</tbody>
									</table>
									</td>
									<td id="WC_RFQFindDisplay_TableCell_52"></td>
								</tr>
								<tr>
									<td id="WC_RFQFindDisplay_TableCell_53"></td>
									<td valign="top" id="WC_RFQFindDisplay_TableCell_54"></td>
									<td valign="top" id="WC_RFQFindDisplay_TableCell_55"></td>
								</tr>
							</tbody>
						</table>

						</div>
						</td>
					</tr>
				</tbody>
			</table> 
			</td>
		</tr>
	</tbody>
	</form>
</table>


<!-- END RFQFindDisplay.jsp -->

<%@ include file="../../include/LayoutContainerBottom.jspf" %>
</body>
</html>
