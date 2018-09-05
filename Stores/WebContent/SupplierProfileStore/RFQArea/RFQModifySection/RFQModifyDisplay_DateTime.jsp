<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  *****
  * This JSP page displays RFQ end and start date fields for
  * the RFQModifyDisplay JSP page.
  *
  * Required parameters:
  * - offering_id
  * - pageSize
  * - initPos
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQModifyConstants.jspf" %>

                <tr>
                    <td id="WC_RFQModifyDisplay_TableCell_21"><fmt:message key="RFQModifyDisplay_StartDate" bundle="${storeText}"/></td>
                    <td nowrap="nowrap" id="WC_RFQModifyDisplay_TableCell_22">
                    <input type="hidden" name="<c:out value="${EC_OFFERING_STARTDATE}" />" value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_STARTDATE}" />_In_RFQModifyBasicForm_1"/>
                    <input type="hidden" name="<c:out value="${EC_OFFERING_ENDDATE}" />" value="" id="WC_RFQModifyDisplay_FormInput_<c:out value="${EC_OFFERING_ENDDATE}" />_In_RFQModifyBasicForm_1"/>
  

  
<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${rfqBean.startTimeInEJBType}" var="startTimeInEJBType" />        
<fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${rfqBean.endTimeInEJBType}" var="endTimeInEJBType" />        
 
  
  
<fmt:formatDate value="${startTimeInEJBType}" pattern="dd" var="rfq_startDay" />	
<fmt:formatDate value="${startTimeInEJBType}" pattern="MM" var="rfq_startMon" />			
<fmt:formatDate value="${startTimeInEJBType}" pattern="yyyy" var="rfq_startYr" />					
<fmt:formatDate value="${endTimeInEJBType}" pattern="dd" var="rfq_endDay" />	
<fmt:formatDate value="${endTimeInEJBType}" pattern="MM" var="rfq_endMon" />			
<fmt:formatDate value="${endTimeInEJBType}" pattern="yyyy" var="rfq_endYr" />					

<fmt:message key="RFQCompleteOrderDisplay_Jan" bundle="${storeText}" var="Jan"/>
<fmt:message key="RFQCompleteOrderDisplay_Feb" bundle="${storeText}" var="Feb"/>
<fmt:message key="RFQCompleteOrderDisplay_Mar" bundle="${storeText}" var="Mar"/>
<fmt:message key="RFQCompleteOrderDisplay_Apr" bundle="${storeText}" var="Apr"/>
<fmt:message key="RFQCompleteOrderDisplay_May" bundle="${storeText}" var="May"/>
<fmt:message key="RFQCompleteOrderDisplay_Jun" bundle="${storeText}" var="Jun"/>
<fmt:message key="RFQCompleteOrderDisplay_Jul" bundle="${storeText}" var="Jul"/>
<fmt:message key="RFQCompleteOrderDisplay_Aug" bundle="${storeText}" var="Aug"/>
<fmt:message key="RFQCompleteOrderDisplay_Sep" bundle="${storeText}" var="Sep"/>
<fmt:message key="RFQCompleteOrderDisplay_Oct" bundle="${storeText}" var="Oct"/>
<fmt:message key="RFQCompleteOrderDisplay_Nov" bundle="${storeText}" var="Nov"/>
<fmt:message key="RFQCompleteOrderDisplay_Dec" bundle="${storeText}" var="Dec"/>


<jsp:useBean id="now" class="java.util.Date"/>
<c:set var="expire_year" value="${now.year + 1900}"/>

<c:choose>
 	<c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
        
        <label for="WC_RFQModifyDisplay_DateTime_Select_1">
		<fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/></label>:
		<select name="beginDay" class="select" id="WC_RFQModifyDisplay_DateTime_Select_1">				 
             	<option value=""></option>                                   
				<c:forTokens var="day"
					items="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
					delims=","> 
					<OPTION value="<c:out value="${day}"/>" <c:if test="${rfq_startDay eq day}"><c:out value="selected='selected'" /></c:if>><c:out	value="${day}" /></OPTION>
				</c:forTokens>
		</select>  	
 	
 	</c:when>
 	<c:otherwise>
        <label for="WC_RFQModifyDisplay_DateTime_Select_2">
		<fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>:</label>
		
<SELECT name="beginYr" class="select" id="WC_RFQModifyDisplay_DateTime_Select_2">
	<option value=""></option>
	<c:forEach begin="0" end="10" varStatus="counter">
		<c:set var="year" value="${expire_year+counter.index}"/>
		<OPTION value="<c:out value="${year}"/>" <c:if test="${rfq_startYr eq year}"><c:out value="selected='selected'" /></c:if>><c:out value="${year}"/></OPTION>
	</c:forEach>
</SELECT>
		
        
	</c:otherwise>
</c:choose>   
		 
   		<label for="WC_RFQModifyDisplay_DateTime_Select_3"> 		
   		<fmt:message key="RFQCreateDisplay_Month" bundle="${storeText}"/>:</label>
		<select name="beginMon" class="select" id="WC_RFQModifyDisplay_DateTime_Select_3">
             <option value=""></option>         
         		<c:forTokens var="month" items="01,02,03,04,05,06,07,08,09,10,11,12" delims=",">
					<option value="<c:out value="${month}"/>"<c:if test="${rfq_startMon eq month}"> <c:out value="selected='selected'" /></c:if>>
					<c:choose>
					<c:when test="${month eq '01'}" ><c:out value="${Jan}" /></c:when>
					<c:when test="${month eq '02'}" ><c:out value="${Feb}" /></c:when>
					<c:when test="${month eq '03'}" ><c:out value="${Mar}" /></c:when>
					<c:when test="${month eq '04'}" ><c:out value="${Apr}" /></c:when>
					<c:when test="${month eq '05'}" ><c:out value="${May}" /></c:when>
					<c:when test="${month eq '06'}" ><c:out value="${Jun}" /></c:when>
					<c:when test="${month eq '07'}" ><c:out value="${Jul}" /></c:when>
					<c:when test="${month eq '08'}" ><c:out value="${Aug}" /></c:when>
					<c:when test="${month eq '09'}" ><c:out value="${Sep}" /></c:when>
					<c:when test="${month eq '10'}" ><c:out value="${Oct}" /></c:when>
					<c:when test="${month eq '11'}" ><c:out value="${Nov}" /></c:when>
					<c:when test="${month eq '12'}" ><c:out value="${Dec}" /></c:when>			
					<c:otherwise>				
					</c:otherwise>			
					</c:choose>							
					</option>
				</c:forTokens>    		   		
		</select>	
        
 
<c:choose>
 	<c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
  		<label for="WC_RFQModifyDisplay_DateTime_Select_4">
  		<fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>:</label>
		
		<SELECT name="beginYr" class="select" id="WC_RFQModifyDisplay_DateTime_Select_4">
			<option value=""></option>
			<c:forEach begin="0" end="10" varStatus="counter">
			<c:set var="year" value="${expire_year+counter.index}"/>
			<OPTION value="<c:out value="${year}"/>" <c:if test="${rfq_startYr eq year}"><c:out value="selected='selected'" /></c:if>><c:out value="${year}"/></OPTION>
			</c:forEach>
		</SELECT>
		  
  	
  	</c:when>
  	<c:otherwise>
  		<label for="WC_RFQModifyDisplay_DateTime_Select_5">
  		<fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/>:</label>
		<select name="beginDay" class="select" id="WC_RFQModifyDisplay_DateTime_Select_5">
             <option value=""></option>         
				<c:forTokens var="day"
					items="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
					delims=",">
					<OPTION value="<c:out value="${day}"/>" <c:if test="${rfq_startDay eq day}"><c:out value="selected='selected'" /></c:if>><c:out	value="${day}" /></OPTION>
				</c:forTokens>
		</select>
  	
  	</c:otherwise>
</c:choose> 
 
 
   			
   		&nbsp;&nbsp;
   		<fmt:formatDate value="${startTimeInEJBType}" pattern="HH:mm" timeStyle="short" var="rfq_start_time" />
		<label for="WC_RFQModifyDisplay_FormInt_<c:out value="${EC_OFFERING_STARTTIME}" />_In_RFQModifyBasicForm_1" /><fmt:message key="RFQCreateDisplay_Time" bundle="${storeText}"/>:</label>
   		
   		<input size="10" class="input" type="text" maxlength="5" name="<c:out value="${EC_OFFERING_STARTTIME}" />" value="<c:out value="${rfq_start_time}"/>" id="WC_RFQModifyDisplay_FormInt_<c:out value="${EC_OFFERING_STARTTIME}" />_In_RFQModifyBasicForm_1"/></td>

        </tr>                
              
              
        <tr>
              <td id="WC_RFQModifyDisplay_TableCell_23"> 
                  <c:if test="${! multiSeller}" ><span class="reqd">*</span></c:if>
              	  <fmt:message key="RFQModifyDisplay_EndDate" bundle="${storeText}"/>
              </td>
              <td nowrap="nowrap" id="WC_RFQModifyDisplay_TableCell_24">


<c:choose>
 <c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
 
		<label for="WC_RFQModifyDisplay_DateTime_Select_6">
		<fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/>:</label>
		<select name="endDay" class="select" id="WC_RFQModifyDisplay_DateTime_Select_6">
             <option value=""></option>         
				<c:forTokens var="day"
					items="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
					delims=",">
					<OPTION value="<c:out value="${day}"/>" <c:if test="${rfq_endDay eq day}"><c:out value="selected='selected'" /></c:if>><c:out	value="${day}" /></OPTION>
				</c:forTokens>
		</select>	
           
</c:when>
<c:otherwise>		
		<label for="WC_RFQModifyDisplay_DateTime_Select_7"><fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>:</label>
		
		<SELECT name="endYr" class="select" id="WC_RFQModifyDisplay_DateTime_Select_7">
			<option value=""></option>
			<c:forEach begin="0" end="10" varStatus="counter">
			<c:set var="year" value="${expire_year+counter.index}"/>
			<OPTION value="<c:out value="${year}"/>" <c:if test="${rfq_endYr eq year}"><c:out value="selected='selected'" /></c:if>><c:out value="${year}"/></OPTION>
			</c:forEach>
		</SELECT>
		

</c:otherwise>
</c:choose> 
		
   		
   		<label for="WC_RFQModifyDisplay_DateTime_Select_8"><fmt:message key="RFQCreateDisplay_Month" bundle="${storeText}"/>:</label>
		<select name="endMon" class="select" id="WC_RFQModifyDisplay_DateTime_Select_8">
             <option value=""></option>         
         		<c:forTokens var="month" items="01,02,03,04,05,06,07,08,09,10,11,12" delims=",">
					<option value="<c:out value="${month}"/>"<c:if test="${rfq_endMon eq month}"> <c:out value="selected='selected'" /></c:if>>
					<c:choose>
					<c:when test="${month eq '01'}" ><c:out value="${Jan}" /></c:when>
					<c:when test="${month eq '02'}" ><c:out value="${Feb}" /></c:when>
					<c:when test="${month eq '03'}" ><c:out value="${Mar}" /></c:when>
					<c:when test="${month eq '04'}" ><c:out value="${Apr}" /></c:when>
					<c:when test="${month eq '05'}" ><c:out value="${May}" /></c:when>
					<c:when test="${month eq '06'}" ><c:out value="${Jun}" /></c:when>
					<c:when test="${month eq '07'}" ><c:out value="${Jul}" /></c:when>
					<c:when test="${month eq '08'}" ><c:out value="${Aug}" /></c:when>
					<c:when test="${month eq '09'}" ><c:out value="${Sep}" /></c:when>
					<c:when test="${month eq '10'}" ><c:out value="${Oct}" /></c:when>
					<c:when test="${month eq '11'}" ><c:out value="${Nov}" /></c:when>
					<c:when test="${month eq '12'}" ><c:out value="${Dec}" /></c:when>			
					<c:otherwise>				
					</c:otherwise>		 	
					</c:choose>						
					</option>
				</c:forTokens>    		   		
		</select>
		
<c:choose>
 <c:when test="${locale == 'pt_BR'  or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
 
		<label for="WC_RFQModifyDisplay_DateTime_Select_9">
		<fmt:message key="RFQCreateDisplay_Year" bundle="${storeText}"/>:</label>
		
		<SELECT name="endYr" class="select" id="WC_RFQModifyDisplay_DateTime_Select_9">
			<option value=""></option>
			<c:forEach begin="0" end="10" varStatus="counter">
			<c:set var="year" value="${expire_year+counter.index}"/>
			<OPTION value="<c:out value="${year}"/>" <c:if test="${rfq_endYr eq year}"><c:out value="selected='selected'" /></c:if>><c:out value="${year}"/></OPTION>
			</c:forEach>
		</SELECT>
				
  
  </c:when>
  <c:otherwise>		
		<label for="WC_RFQModifyDisplay_DateTime_Select_10">
		<fmt:message key="RFQCreateDisplay_Day" bundle="${storeText}"/></label>:
		<select name="endDay" class="select" id="WC_RFQModifyDisplay_DateTime_Select_10">
             <option value=""></option>         
				<c:forTokens var="day"
					items="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31"
					delims=",">
					<OPTION value="<c:out value="${day}"/>" <c:if test="${rfq_endDay eq day}"><c:out value="selected='selected'" /></c:if>><c:out	value="${day}" /></OPTION>
				</c:forTokens>
		</select>

</c:otherwise>
</c:choose>		
		
			  
   			
   		&nbsp;&nbsp;
   		<fmt:formatDate value="${endTimeInEJBType}" pattern="HH:mm" timeStyle="short" var="rfq_end_time" />
   		
   		<label for="WC_RFQModifyDisplay_FormInt_<c:out value="${EC_OFFERING_ENDTIME}" />_In_RFQModifyBasicForm_1"><fmt:message key="RFQCreateDisplay_Time" bundle="${storeText}"/>:</label>
   		
   		<input size="10" class="input" type="text" maxlength="5" name="<c:out value="${EC_OFFERING_ENDTIME}" />" value="<c:out value="${rfq_end_time}"/>" id="WC_RFQModifyDisplay_FormInt_<c:out value="${EC_OFFERING_ENDTIME}" />_In_RFQModifyBasicForm_1"/>
   	
   		</td>

        </tr>
