//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/** 
 * @fileOverview This javascript provides the functions needed for the B2B organization tooltip help on the registration page.
 * @version 1.1
 */

dojo.require("dojox.collections.ArrayList");

B2BOrgTooltip={

   //       formattedRequestDate:"",
   langId: "-1",
   storeId: "",
   catalogId: "",   
   errorMessages:{},
       
   /***********************************************************************
	 * The following functions are used to set/reset Dijit tooltip on a page
	 ***********************************************************************/
	
   // summary	: Reset the tooltip template
   // description	: Reset the master template - tooltip will use default master template from dojo
   // assumptions	: Dojo, Dijit installed
   // dojo API	: Dijit
   // returns	: void
   resetTooltip: function() {
      dijit._masterTT = new dijit._MasterTooltip();
   },
	
   // summary	: Set the tooltip template
   // description	: Set master template to use Madisons style template (no bubbles)
   // assumptions	: Dojo, Dijit installed
   // dojo API	: Dijit
   // returns	: void
   setTooltip: function() {
      dijit._masterTT = new dijit._MasterTooltip({
         templateString:"<div class=\"dijitTooltip dijitTooltipLeft\" id=\"dojoTooltip\">\n\t<div dojoAttachPoint=\"containerNode\" waiRole='alert'></div></div>\n",
         duration:10
      });
   },
	
   // summary	: Map tooltip handling to events for an element
   // description	: When onFocus or onMouseOver event occurs on the tooltip, set the tooltip template to Madisons style template (no bubble).
   //			When onBlur or onMouseOut event occurs on the tooltip, set the tooltip template to default dojo style template (with bubble)
   // parameters	: elementName -> the name of the element that will be associated with tooltip handling
   // assumptions	: Dojo installed
   // dojo API	: dojo.byId, dojo.connect
   // returns	: void
   tooltipInit: function(elementName) {
      tooltip = dojo.byId(elementName);
      dojo.connect(tooltip, 'onfocus', this.setTooltip);
      dojo.connect(tooltip, 'onmouseover', this.setTooltip);
      dojo.connect(tooltip, 'onblur', this.resetTooltip);
      dojo.connect(tooltip, 'onmouseout', this.resetTooltip);
   }
	
   /***********************************************************************
	 * End Dijit tooltip set/reset functions
	 ***********************************************************************/
        
        


}
