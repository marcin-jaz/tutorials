<%
/*
 *---------------------------------------------------------------g----
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2004
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
  * This JSP page displays summary information input fields for the
  * Create RFQ page.  
  *
  * Imports:
  * - RFQCreateDisplay_Dates_pt_BR.jsp
  * - RFQCreateDisplay_Dates.jsp
  *
  *****
--%>

<%@ page language="java" %>

<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>


<%@ include file="RFQCreateConstants.jspf" %>

                   <tr>
                        <td width="10" rowspan="7" id="WC_RFQCreateDisplay_TableCell_3">&nbsp;</td>
                        <td id="WC_RFQCreateDisplay_TableCell_4">
                        <h1><fmt:message key="RFQCreateDisplay_Create_New" bundle="${storeText}" /></h1>
                    <c:if test="${strErrorMessage != null}">
					    <span class="warning"><c:out value="${strErrorMessage}" /></span><br /><br />
					</c:if>
                        <fmt:message key="RFQCreateDisplay_Info" bundle="${storeText}" /><br /><br />
                        <span class="reqd">*</span><fmt:message key="EditAdd_REQUIRED" bundle="${storeText}"/><br />
                        </td>
                    </tr>
                    <tr>
                        <td id="WC_RFQCreateDisplay_TableCell_5"><br />
					<c:if test="${!param.multiSeller}" >
						<input type="hidden" name="<c:out value="${EC_RFQ_ACCOUNT_ID}" />" value="<c:out value="${param.accountid}" />" id="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_RFQ_ACCOUNT_ID}" />_In_RFQForm_1"/>
					</c:if>

                        <input type="hidden" name="<c:out value="${EC_OFFERING_STARTDATE}" />" value="" id="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_STARTDATE}" />_In_RFQForm_1"/>
                        <input type="hidden" name="<c:out value="${EC_OFFERING_ENDDATE}" />" value="" id="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_ENDDATE}" />_In_RFQForm_1"/>
                        <span class="reqd">*</span><label for="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_NAME}" />_In_RFQForm_1"><fmt:message key="RFQCreateDisplay_Name" bundle="${storeText}" /></label><br />
                        <input size="53" class="input" type="text" maxlength="254" name="<c:out value="${EC_OFFERING_NAME}" />" value="<c:out value="${param.strRFQname}" />" id="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_NAME}" />_In_RFQForm_1"/><br />
                        <br />
                                         
                         <label for="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_SHORTDESC}" />_In_RFQForm_1">
                        <fmt:message key="RFQCreateDisplay_SD" bundle="${storeText}" /><br /></label> 
                       
                        <input size="53" class="input" type="text" maxlength="128" name="<c:out value="${EC_OFFERING_SHORTDESC}" />" value="<c:out value="${param.strShortDesc}" />" id="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_SHORTDESC}" />_In_RFQForm_1"/><br />
                        <br />
                       
                      
                        <label for="WC_RFQCreateDisplay_Info_textarea_1">
                        <fmt:message key="RFQCreateDisplay_LD" bundle="${storeText}" /></label><br />
                         <textarea cols="40" rows="6" id="WC_RFQCreateDisplay_Info_textarea_1" name="<c:out value="${EC_OFFERING_LONGDESC}" />"><c:out value="${param.strLongDesc}" /></textarea><br />
                        
                        </td>
                    </tr>
                    <tr>
                    
                    	
                    	
						
						
                        <td id="WC_RFQCreateDisplay_TableCell_6"><br />
                        
                        <fmt:message key="RFQCreateDisplay_Process" bundle="${storeText}" /><br />
                        <br />
                        <span class="reqd">*</span> 
                         <fmt:message key="RFQCreateDisplay_Result" bundle="${storeText}" />
                         <br />
                        <c:set var="checked" value=""/>
                        <c:if test="${isOrder eq '1'}" >  
                        	<c:set var="checked" value="checked='checked'"/> 
                        </c:if>
                                              
                        <input type="radio" class="radio" id="WC_RFQCreateDisplay_Info_FormInput_1" name="<c:out value="${EC_OFFERING_ENDRESULT}" />" value="<c:out value="${EC_UTF_ENDRESULT_ORDER}" />" <c:out value="${checked}" /> id="WC_RFQCreateDisplay_FormInput_<c:out value="${EC_OFFERING_ENDRESULT}" />_In_RFQForm_1"/>
                       
                            <label for="WC_RFQCreateDisplay_Info_FormInput_1" >
                        <fmt:message key="RFQCreateDisplay_Order" bundle="${storeText}" /></label><br />
                        <c:set var="checked" value=""/>
                        <c:if test="${isOrder eq '0'}" >  
                        	<c:set var="checked" value="checked='checked'"/> 
                        </c:if> 
                         <c:choose>
					<c:when test="${param.multiSeller}" >
                        
                        	<input type="radio" class="radio" id="WC_RFQCreateDisplay_Info_FormInput_2" name="<c:out value="${EC_OFFERING_ENDRESULT}" />" value="0"
                        		<c:out value="${checked}" /> /> 
                        			<label for="WC_RFQCreateDisplay_Info_FormInput_2"><fmt:message key="RFQCreateDisplay_Contract" bundle="${storeText}" /></label>
						</c:when>
						<c:otherwise>
                                     
                                <input type="radio" class="radio" id="WC_RFQCreateDisplay_Info_FormInput_3" name="<c:out value="${EC_OFFERING_ENDRESULT}" />" value="0"  
                            <c:out value="${checked}" /> onMouseDown="checkAccount(document.RFQForm);" onKeyDown="checkAccount(document.RFQForm);" />     
                            <label for="WC_RFQCreateDisplay_Info_FormInput_3"><fmt:message key="RFQCreateDisplay_Contract" bundle="${storeText}" /></label>
                      
						</c:otherwise>
					 </c:choose>
                              
                              </td>
                    </tr> 
                    <tr border="border">                                                            
                        <td id="WC_RFQCreateDisplay_Info_TableCell_1">
                        <c:choose>
							<c:when test="${multiSeller}">
				                        			                              
								<br /><fmt:message key="RFQCreateDisplay_CloseDesc" bundle="${storeText}" /><br /><br />
							</c:when>
							<c:otherwise>
							<br /><fmt:message key="RFQCreateDisplay_Dates" bundle="${storeText}" /><br /><br />
							</c:otherwise>
						</c:choose>
                        <table border="0" width="860" id="WC_RFQCreateDisplay_Info_Table_1">
                            <tbody>
                        <c:choose>
							<c:when test="${param.multiSeller}">
								 <tr>
                                    <td id="WC_RFQCreateDisplay_Info_TableCell_2"><span class="reqd">*</span> <label for="WC_RFQCreateDisplay_Info_FormSelect_1" >
                                    <fmt:message key="RFQCreateDisplay_ClosingRule" bundle="${storeText}" /></label></td>
                                    <td id="WC_RFQCreateDisplay_Info_TableCell_3">
                                       
                                        <select name="<c:out value="${EC_OFFERING_RULETYPE}" />" class="select" id="WC_RFQCreateDisplay_Info_FormSelect_1"  >
                                        <option value="" selected="selected">-- <fmt:message key="RFQCreateDisplay_SelectRule" bundle="${storeText}" />--</option>
                                        <option value="<c:out value="${EC_CLOSE_RULE1}" />"><fmt:message key="RFQCreateDisplay_Rule1" bundle="${storeText}" /></option>
                                        <option value="<c:out value="${EC_CLOSE_RULE2}" />"><fmt:message key="RFQCreateDisplay_Rule2" bundle="${storeText}" /></option>
                                        <option value="<c:out value="${EC_CLOSE_RULE3}" />"><fmt:message key="RFQCreateDisplay_Rule3" bundle="${storeText}" /></option>
                                        <option value="<c:out value="${EC_CLOSE_RULE4}" />"><fmt:message key="RFQCreateDisplay_Rule4" bundle="${storeText}" /></option>
                                    </select>
                                    </td>
                                </tr>
							</c:when>
							<c:otherwise>
								<label for="<c:out value="${EC_OFFERING_RULETYPE}" />">
								<input type="hidden" name="<c:out value="${EC_OFFERING_RULETYPE}" />" value="<c:out value="${EC_CLOSE_RULE1}" />" />
							        </label>
							</c:otherwise>
						</c:choose>
						
                               <tr>
                                    <td id="WC_RFQCreateDisplay_Info_TableCell_5"><fmt:message key="RFQCreateDisplay_Active" bundle="${storeText}" />:</td>
                                    <td id="WC_RFQCreateDisplay_Info_TableCell_6">
				                        <c:choose>
											<c:when
												test="${locale == 'pt_BR' or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
												<!--START CALENDAR SELECTION-->
												<% out.flush(); %>
												<c:import url="RFQCreateDisplay_Dates_pt_BR.jsp">
													<c:param name="strDisplayMon" value="${param.strBeginMon}" />
													<c:param name="strDisplayYr" value="${param.strBeginYr}" />
													<c:param name="strDisplayDay" value="${param.strBeginDay}" />
													<c:param name="selectNamePrefix" value="begin" />
												</c:import>
												<% out.flush(); %>		
												<!--END CALENDAR SELECTION-->
											</c:when>
											<c:otherwise>
											<!--START CALENDAR SELECTION-->
												<% out.flush(); %>
												<c:import url="RFQCreateDisplay_Dates.jsp">
													<c:param name="strDisplayMon" value="${param.strBeginMon}" />
													<c:param name="strDisplayYr" value="${param.strBeginYr}" />
													<c:param name="strDisplayDay" value="${param.strBeginDay}" />
													<c:param name="selectNamePrefix" value="begin" />
												</c:import>	
												<% out.flush(); %>
											<!--END CALENDAR SELECTION-->
											</c:otherwise>
										</c:choose> 
				                                              &nbsp;&nbsp;  <label for="WC_RFQCreateDisplay_Info_FormInput_4"><fmt:message key="RFQCreateDisplay_Time" bundle="${storeText}" /></label>:<input size="5" class="input" type="text" maxlength="5" id="WC_RFQCreateDisplay_Info_FormInput_4" name="starttime" value="<c:out value="${param.strBeginTime}" />" />
                                    
                                    </td>
                                </tr>                                
                                
                                <tr>
                                    <td id="WC_RFQCreateDisplay_Info_TableCell_7"><c:if test="${!param.multiSeller}" > <span class="reqd">*</span> </c:if> <fmt:message key="RFQCreateDisplay_Due" bundle="${storeText}" />: </td>
                                    <td id="WC_RFQCreateDisplay_Info_TableCell_8">
				                        <c:choose>
											<c:when	test="${locale == 'pt_BR' or locale == 'fr_FR' or locale == 'de_DE' or locale == 'it_IT' or locale == 'es_ES'}">
												<!--START CALENDAR SELECTION-->
												<% out.flush(); %>
												<c:import url="RFQCreateDisplay_Dates_pt_BR.jsp">
													<c:param name="strDisplayMon" value="${param.strEndMon}" />
													<c:param name="strDisplayYr" value="${param.strEndYr}" />
													<c:param name="strDisplayDay" value="${param.strEndDay}" />
													<c:param name="selectNamePrefix" value="end" />
												</c:import>
												<% out.flush(); %>	
												<!--END CALENDAR SELECTION-->
												
											</c:when>
											<c:otherwise>
												<!-- YEAR -->
												<!--START CALENDAR SELECTION-->
												<% out.flush(); %>
												<c:import url="RFQCreateDisplay_Dates.jsp">
													<c:param name="strDisplayMon" value="${param.strEndMon}" />
													<c:param name="strDisplayYr" value="${param.strEndYr}" />
													<c:param name="strDisplayDay" value="${param.strEndDay}" />
													<c:param name="selectNamePrefix" value="end" />
												</c:import>
												<% out.flush(); %>	
												<!--END CALENDAR SELECTION-->
																							</c:otherwise>
										</c:choose> 
                                       
                                       &nbsp;&nbsp;<label for="WC_RFQCreateDisplay_Info_FormInput_5"><fmt:message key="RFQCreateDisplay_Time" bundle="${storeText}" /></label>:<input size="5" class="input" type="text" maxlength="5" id="WC_RFQCreateDisplay_Info_FormInput_5" name="endtime" value="<c:out value="${param.strEndTime}" />" />
                                                                          
                                    </td> 
                                </tr>
                                <c:if test="${param.multiSeller}" >
	                                <tr> 
	                                    <td id="WC_RFQCreateDisplay_Info_TableCell_10">
	                                    
                                          <label for="WC_RFQCreateDisplay_Info_FormInput_6">
                                            <fmt:message key="RFQCreateDisplay_MinResponse" bundle="${storeText}" /> 
	                                    </label></td>
	                                    <td id="WC_RFQCreateDisplay_Info_TableCell_11">
	                                    <input size="6" class="input" type="text" maxlength="6" id="WC_RFQCreateDisplay_Info_FormInput_6" name="<c:out value="${EC_OFFERING_NUMRESPONSES}" />" />
	                                    
	                                    </td>
	                                </tr>
								</c:if>
                             
                                <input type="hidden" name="<c:out value="${EC_OFFERING_ACCESSTYPE}" />" value="0" />
                             

					
