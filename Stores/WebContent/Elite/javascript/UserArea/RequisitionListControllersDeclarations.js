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
 * @fileOverview This javascript is used by the Requisition List pages to control the refresh areas.
 * @version 1.2
 */

dojo.require("wc.service.common");
dojo.require("wc.render.common");

/** 
 * Declares a new refresh controller for Requisition List display.
 */
wc.render.declareRefreshController({
       id: "RequisitionListDisplay_Controller",
       renderContext: wc.render.getContextById("RequisitionListDisplay_Context"),
       url: "",
       formId: ""

       /** 
        * Displays the previous/next page of requisition lists on the Requisition List page.
        * This function is called when a render context changed event is detected. 
        * 
        * @param {string} message The render context changed event message
        * @param {object} widget The registered refresh area
        */
       ,renderContextChangedHandler: function(message, widget) {			
			var controller = this;
			var renderContext = this.renderContext;
			MessageHelper.hideAndClearMessage();
			widget.refresh(renderContext.properties);
			cursor_clear();
       }  

		/** 
		 * Refreshes the requisition list display if a requisition list is removed via an Ajax call.
		 * This function is called when a modelChanged event is detected. 
		 * 
		 * @param {string} message The model changed event message
		 * @param {object} widget The registered refresh area
		 */
		,modelChangedHandler: function(message, widget) {
			var renderContext = this.renderContext;
			if (message.actionId =='AjaxRequisitionListDelete') {
				//Resetting the beginIndex after deleting a requisition list
				renderContext.properties["beginIndex"] = 0;
				widget.refresh(renderContext.properties);
			}
		}
		 
		/** 
		 * Clears the progress bar
		 * 
		 * @param {object} widget The registered refresh area
		 */
		,postRefreshHandler: function(widget) {
			 cursor_clear();
		}		 
}),


/**
 * Declares a new refresh controller for creating a new Requisition List.
 */
wc.render.declareRefreshController({
       id: "RequisitionListAdd_Controller",
       renderContext: wc.render.getContextById("RequisitionListAdd_Context"),
       url: "",
       formId: ""

   		/** 
   		 * Refreshes the requisition list item display if an item is updated.
   		 * This function is called when a modelChanged event is detected. 
   		 * 
   		 * @param {string} message The model changed event message
   		 * @param {object} widget The registered refresh area
   		 */    	   
       ,modelChangedHandler: function(message, widget) {
			var controller = this;
			var renderContext = this.renderContext;
			if (message.actionId =='requisitionListAdd' || message.actionId=='requisitionListAddItem'
				|| message.actionId == 'requisitionListCopy') {
				renderContext.properties["requisitionListId"] = message.requisitionListId;
				renderContext.properties["editable"] = message.editable;
				widget.refresh(renderContext.properties);
			}
       }

		/** 
		 * Clears the progress bar
		 * 
		 * @param {object} widget The registered refresh area
		 */
		,postRefreshHandler: function(widget) {
			 cursor_clear();
			 //After adding/deleting/updating an item
			 //Need to set the paging table begin index back to 0 as it will always return to the 1st page 
			 wc.render.updateContext('RequisitionListDetailTableDisplay_Context',{'beginIndex':0});
		}
}),

/** 
* Declares a new refresh controller for the requisition list item table paging display.
*/
wc.render.declareRefreshController({
      id: "RequisitionListDetailTableDisplay_Controller",
      renderContext: wc.render.getContextById("RequisitionListDetailTableDisplay_Context"),
      url: "",
      formId: ""

      /** 
       * Displays the previous/next page of requisition list items on the Requisition List Detail page.
       * This function is called when a render context changed event is detected. 
       * 
       * @param {string} message The render context changed event message.
       * @param {object} widget The registered refresh area.
       */
      ,renderContextChangedHandler: function(message, widget) {
			var controller = this;
			var renderContext = this.renderContext;
			if(controller.testForChangedRC(["beginIndex"]) ){
				MessageHelper.hideAndClearMessage();
				widget.refresh(renderContext.properties);
			}
      }  

		/** 
		 * Clears the progress bar
		 * 
		 * @param {object} widget The registered refresh area
		 */
		,postRefreshHandler: function(widget) {
			 cursor_clear();
		}	
})