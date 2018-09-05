//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2009 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/** 
 * @fileOverview This javascript defines all the render contexts needed for the Requisition List pages.
 * @version 1.2
 */

dojo.require("wc.service.common");
dojo.require("wc.render.common");

/**
 * Declares a new render context for the Requisition List display.
 */
wc.render.declareContext("RequisitionListDisplay_Context",{'beginIndex':0},""),

/**
 * Declares a new render context for creating a new requisition list.
 */
wc.render.declareContext("RequisitionListAdd_Context",null,""),

/**
* Declares a new render context for the requisition list item table paging display.
*/
wc.render.declareContext("RequisitionListDetailTableDisplay_Context",{beginIndex: "0"},"")
