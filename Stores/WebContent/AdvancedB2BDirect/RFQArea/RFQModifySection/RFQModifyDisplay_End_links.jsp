<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2000, 2004
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
  * This JSP page displays buttons at the bottom of the 
  * RFQModifyDisplay JSP page.
  *
  * Required parameters:
  * - offering_id
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
<%@ include file="RFQModifyConstants.jspf" %>
 
		<tr>
   			<td id="WC_RFQModifyDisplay_TableCell_105">
        		<table id="WC_RFQModifyDisplay_Table_29" >
              		<tbody>
              
		<c:choose>              
			<c:when test="${param.numProd > 0}" >               
             			<tr>
					<!-- Start display for Search "Save Changes" button -->
					<td height="41" id="WC_RFQModifyDisplay_TableCell_106">
						<a class="button" href="javascript:submitUpdateProd(document.RFQModifyProductForm)" id="WC_RFQModifyDisplay_Link_17"> 
							&nbsp; <fmt:message key="RFQ_SAVE_CHANGES" bundle="${storeText}" /> &nbsp; 
						</a>
					</td>
					<!-- End display for Search "Save Changes" button -->
             			</tr>
			</c:when>
			<c:otherwise>
				<tr><td height="41" id="WC_RFQModifyDisplay_TableCell_106">&nbsp;</td></tr>
			</c:otherwise>
		</c:choose>
            
    				<tr>
					<!-- Start display for Search "Add product from catalog" button -->
					<td height="41" id="WC_RFQModifyDisplay_TableCell_107">
						<a class="button" href="TopCategoriesDisplay?langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_18"> 
							&nbsp; <fmt:message key="RFQModifyDisplay_AddProdFromCat" bundle="${storeText}" /> &nbsp; 
						</a>
					</td>
					<!-- End display for Search "Add product from catalog" button -->

                			<td id="WC_RFQModifyDisplay_TableCell_108">&nbsp;</td>

              	<flow:ifEnabled feature="RequisitionList">
					<!-- Start display for Search "Add product from requisition list" button -->
					<td height="41" id="WC_RFQModifyDisplay_TableCell_109">
						<a class="button" href="RFQAllRequisitionListsDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_19"> 
							&nbsp; <fmt:message key="RFQModifyDisplay_AddProdFromReq" bundle="${storeText}" /> &nbsp; 
						</a>
					</td>
					<!-- End display for Search "Add product from requisition list" button -->
   		</flow:ifEnabled> 
   		
                                 	<td id="WC_RFQModifyDisplay_TableCell_110">&nbsp;</td>
                                   
					<!-- Start display for Search "?? Add made-to-order product" button -->
					<td height="41" id="WC_RFQModifyDisplay_TableCell_111">
						<a class="button" href="RFQMadeToOrderDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_20"> 
							&nbsp; <fmt:message key="RFQModifyDisplay_AddNewItem" bundle="${storeText}" /> &nbsp; 
						</a>
					</td>
					<!-- End display for Search "Add made-to-order product" button -->

                               		<td id="WC_RFQModifyDisplay_TableCell_112">&nbsp;</td>

		<c:choose>              
			<c:when test="${param.numProd > 0}" >   
					<!-- Start display for Search "Add new category" button -->
					<td height="41" id="WC_RFQModifyDisplay_TableCell_113">
						<a class="button" href="RFQAddNewCategoryDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;URL=RFQModifyDisplay" id="WC_RFQModifyDisplay_Link_21"> 
							&nbsp; <fmt:message key="RFQModifyDisplay_AddNewCategory" bundle="${storeText}" /> &nbsp; 
						</a>
					</td> 
					<!-- End display for Search "Add new category" button -->
				</tr>
			</c:when>
			<c:otherwise>
				</tr>

				<tr>
					<!-- Start display for Search "Add new category" button -->
					<td height="41" id="WC_RFQModifyDisplay_TableCell_113">
						<a class="button" href="RFQAddNewCategoryDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;URL=RFQModifyDisplay" id="WC_RFQModifyDisplay_Link_21"> 
							&nbsp; <fmt:message key="RFQModifyDisplay_AddNewCategory" bundle="${storeText}" /> &nbsp; 
						</a>
					</td>
				</tr>
			</c:otherwise>
		</c:choose>
                               
		<!-- Multiseller section -->                                
		<c:if test="${multiSeller}" >      
				<tr>
        				<td colspan="7" id="WC_RFQModifyDisplay_TableCell_112">
        				<table id="WC_RFQModifyDisplay_Table_10">	
        					<tr>
            						<td  valign="top" width="400" class="topspace" id="WC_RFQModifyDisplay_TableCell_114" ><br />

 							<table cellpadding="0" cellspacing="0" border="0" id="WC_RFQModifyDisplay_Table_30">
							<tbody>
								<tr>
								    	<td class="header" background="<c:out value="${jspStoreImgDir}" />images/header_back.gif" id="WC_RFQModifyDisplay_TableCell_115"><fmt:message key="RFQModifyDisplay_RFQTarget" bundle="${storeText}" /></td>
								</tr>
								<tr>
								    	<td id="WC_RFQModifyDisplay_TableCell_116"><img src="<c:out value="${jspStoreImgDir}" />images/strip.gif" alt="" width="630" height="2" border="0"/></td>
								</tr>
							</tbody>
							</table>
							<br />

                        				<table cellpadding="0" cellspacing="0" border="0" width="630" class="bgColor" id="WC_RFQModifyDisplay_Table_31">
                            				<tbody>
                                				<tr>
                                    					<td id="WC_RFQModifyDisplay_TableCell_117">
                                    					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="bgColor" id="WC_RFQModifyDisplay_Table_32">
                                        				<tbody>
                                            					<tr>
                                                            				<th class="colHeader_last" id="WC_RFQModifyDisplay_TableCell_119"> <fmt:message key="RFQModifyDisplay_Store" bundle="${storeText}" /> </th>
                                            					</tr>

			<c:forEach var="targets" items="${targetDBs}"  begin="0"  varStatus="iter">
				<c:set var="targetStoreId" value="${targets.storeIdInEJBType}"  />  
				<c:set var="index" value="${iter.index}" />  
                                            					<tr class="cellBG_1">
                                                					<td headers="WC_RFQModifyDisplay_TableCell_119" class="t_td" id="WC_RFQModifyDisplay_TableCell_120_<c:out value="${index + 1}" />">
                                                						<c:out value="${targets.storeDisplayName }" />
                                                					</td>

                                <c:if test="${empty targetedStoreFromProds}" >
                                           						<td headers="WC_RFQModifyDisplay_TableCell_119" class="t_td" id="WC_RFQModifyDisplay_TableCell_121_<c:out value="${index + 1}" />">
                                           							<a href="RFQTargetListRemove?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;<c:out value="${EC_TARGETSTORE_ID}" />=<c:out value="${targetStoreId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;URL=RFQModifyDisplay" id="WC_RFQModifyDisplay_Link_22_<c:out value="${index + 1}" />">
                                           								<fmt:message key="RFQModifyDisplay_Remove" bundle="${storeText}" />
                                           							</a>
                                           						</td>
								</c:if>

					                                      	</tr>
			</c:forEach>

			<c:if test="${empty targetDBs}" >
                                            					<tr class="cellBG_1">
                                                					<td  valign="top" colspan="1" class="categoryspace t_td" id="WC_RFQModifyDisplay_TableCell_122"><fmt:message key="RFQModifyDisplay_TargetAll" bundle="${storeText}" /></td>
                                            					</tr>
			</c:if>
                                        				</tbody>
                                    					</table>
                                    					</td>
                                				</tr>
                            				</tbody>
                        				</table>

                        				</td>
                    				</tr>
			<c:if test="${empty targetedStoreFromProds}" >  
                    				<tr>
                        				<td id="WC_RFQModifyDisplay_TableCell_123">
                        				<table id="WC_RFQModifyDisplay_Table_34">
                            				<tbody>
                                				<tr>                                
									<!-- Start display for "Add stores in organization" button -->
									<td height="41" id="WC_RFQModifyDisplay_TableCell_124">
										<a class="button" href="RFQTargetListOrgDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_23"> 
											&nbsp; <fmt:message key="RFQModifyDisplay_AddFromOrgs" bundle="${storeText}" /> &nbsp; 
										</a>
									</td>
									<!-- End display for "Add stores in organization" button -->

									<td id="WC_RFQModifyDisplay_TableCell_125">&nbsp;</td>

									<!-- Start display for "Add from stores" button -->
									<td height="41" id="WC_RFQModifyDisplay_TableCell_126">
										<a class="button" href="RFQTargetListStoreDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_24"> 
											&nbsp; <fmt:message key="RFQModifyDisplay_AddFromStores" bundle="${storeText}" /> &nbsp; 
										</a>
									</td>
									<!-- End display for "Add from stores" button -->
                                				</tr>                             
                            				</tbody>
                        				</table>
                        				</td> 
                    				</tr>
			</c:if>  
                    			</table>
                    			</td>
                    		</tr>
		</c:if>                                                            
		<!-- End Multiseller section -->                               
                                
                                <tr>
				  	<td colspan="7" id="WC_RFQModifyDisplay_TableCell_129"><img src="<c:out value="${jspStoreImgDir}" />images/button_divider.gif" alt="" width="630" height="2" border="0"/></td>
				</tr>
                                
                                <tr>
                                	<td colspan="7" id="WC_RFQModifyDisplay_TableCell_113">
                                	<table id="WC_RFQModifyDisplay_Table_11">                                 
                                		<tr>                                
                                			<!-- Start display for Search "9 Return to RFQ Summary" button -->
							<td height="41" id="WC_RFQModifyDisplay_TableCell_132">
								<a class="button" href="RFQDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />" id="WC_RFQModifyDisplay_Link_25"> 
									&nbsp; <fmt:message key="RFQModifyDisplay_Return" bundle="${storeText}" /> &nbsp; 
								</a>
							</td>
								
							<td id="WC_RFQModifyDisplay_TableCell_127">&nbsp;</td>
							 
							<td height="41" id="WC_RFQModifyDisplay_TableCell_135">
								<a class="button" href="javascript:submitForm(document.RFQModifyProductForm)"  id="WC_RFQModifyDisplay_Link_26"> 
									&nbsp; <fmt:message key="RFQDisplay_Button_Submit" bundle="${storeText}" /> &nbsp; 
								</a>
							</td> 
								 
							<td id="WC_RFQModifyDisplay_TableCell_133">&nbsp;</td>
								
							<!-- Start display for Search "11 Cancel RFQ" button -->
							<td height="41" id="WC_RFQModifyDisplay_TableCell_138">
								<a class="button" href="RFQCancel?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;URL=RFQListDisplay" id="WC_RFQModifyDisplay_Link_27"> 
									&nbsp; <fmt:message key="RFQDisplay_Button_Cancel" bundle="${storeText}" /> &nbsp; 
								</a>
							</td>
								 
							<td id="WC_RFQModifyDisplay_TableCell_134">&nbsp;</td>
								
							<!-- Start display for Search "12 Duplicate RFQ" button -->
							<td height="41" id="WC_RFQModifyDisplay_TableCell_141">
								<a class="button" href="RFQDuplicateDisplay?<c:out value="${EC_OFFERING_ID}" />=<c:out value="${rfqId}" />&amp;langId=<c:out value="${langId}" />&amp;storeId=<c:out value="${storeId}" />&amp;catalogId=<c:out value="${catalogId}" />&amp;URL=RFQListDisplay" id="WC_RFQModifyDisplay_Link_28"> 
									&nbsp; <fmt:message key="RFQDisplay_Button_Duplicate" bundle="${storeText}" /> &nbsp; 
								</a>
							</td>                                
                                		</tr>                          
                               		</table>
                                	</td>
                        	</tr>
                        </tbody>
                        </table>
                        </td>
              	</tr>
                