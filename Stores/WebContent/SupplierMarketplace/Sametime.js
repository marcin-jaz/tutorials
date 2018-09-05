//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* (c) Copyright IBM Corp. 2001, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//The attribute names and assigned constants
//DO NOT EDIT THESE PREDEFINED VALUES
var ATTR_CUSTOMER_ID    	= "1";
var ATTR_CUSTOMER_NAME     	= "2";
var ATTR_PAGE_URL    		= "4";
var ATTR_SHOPPING_CART 		= "6";
var ATTR_STORE_ID	    	= "14";
var ATTR_LANG_ID	    	= "15";
var ATTR_REQ_QUEUE 		= "3020";

// For new attributes, please use value start from "8000"
// for example:
// var ATTR_MY_ATTRIBUTE	="8001";





//Variables
// set the default WCS Guest Id
var WCSGUESTID = -1002;
var CurrPageURL = null;
var CurrPageDscr = null;
// set it to guest userId first
var WcsCustomerId = WCSGUESTID;
var CustomerName = null;
var LastTotalSum = 0;
var TotalSum = 0;
var WcsStoreID = null;
var WcsLangID = null;
var TotalItems = 0;      
var CustomerAppletIsUp = false;

var params = location.search.substring(1, location.search.length);
var reqQueue="";

var BlankURL="";
var ReadyURL="";
var storeLocale="";

function isLoad()
{ return;}

function browserInfo()
{
  var agent = navigator.userAgent.toLowerCase();
  this.ns = ((agent.indexOf('mozilla')!=-1) && ((agent.indexOf('spoofer')==-1) && (agent.indexOf('compatible') == -1)));
  this.ie = (agent.indexOf("msie") != -1);
}

var browserType = new browserInfo();

/**
 * updateStInfo() // use StUpdate frame to update Sametime attributes 
 */
function updateStInfo()
{
	if (StUpdate !=null) {
		if (typeof StUpdate.isLoad == 'function') // make sure the frame has been loaded
		{
			StUpdate.location.reload(true); 
		}
		else {
			setTimeout("updateStInfo()",3000);  // wait for 3 sec and try again
		}
	}
}

/**
 * changeSTAttributes() // let applet to send attributes to Sametime server
 */
function changeSTAttributes()
{
     
     if (CustomerAppletIsUp) {
	  sametime.document.applets["InteractivePresenceApplet"].setWcsLanguage(WcsLangID);
	  sametime.document.applets["InteractivePresenceApplet"].setWcsStore(WcsStoreID);
	  sametime.document.applets["InteractivePresenceApplet"].setWcsCustomer(WcsCustomerId,CustomerName);
	  sametime.document.applets["InteractivePresenceApplet"].setWcsPage(CurrPageURL,CurrPageDscr);
	  sametime.document.applets["InteractivePresenceApplet"].setWcsCart(TotalItems);
	  sametime.document.applets["InteractivePresenceApplet"].setWcsLocale(storeLocale);
	  sametime.document.applets["InteractivePresenceApplet"].changeWCSAttrs();
	}
     else
     	   setTimeout("changeSTAttributes()",3000);  // wait for 3 sec and try again
}


function extractArgument(name)
{
   var ix = -1;
   var iy = -1;
   if (params.length != 0) {
      args = params.toLowerCase();
      arg = name.toLowerCase() + "=";
      ix = args.indexOf(arg);
      if (ix != -1) {
         ix += arg.length;
         iy = args.substring(ix, args.length).indexOf(";");
         if (iy == -1)
            iy = args.length;
         else
            iy += ix;
      }
   }
   return ix != -1 ? (ix < iy ? unescape(params.substring(ix, iy)) : "") : null;
}

function setCustomerName (newCustId, newCustName)
{
   var newId;

   if (newCustId==WCSGUESTID && WcsCustomerId==WCSGUESTID+"" + CustomerName)
   {  //same guest shopper, may need change name
      newCustId=WcsCustomerId;
      if (newCustName==null || newCustName=="")
      {
      	newCustName=CustomerName;
      	}
   }
       
   if (newCustId != WcsCustomerId)
   {  
     if (newCustId==WCSGUESTID && (newCustName==null || newCustName==""))
     {	//log out
        WcsCustomerId=WCSGUESTID;
        CustomerName="";
     }
     else
     	WcsCustomerId = newCustId;
   }

   //Handle the Wsc CustomerName
   if (newCustName=="") newCustName=CustomerName;

   if (newCustName != CustomerName || newCustName == null || newCustName == "")
   {
     if (newCustName == null || newCustName == "")
     {
           newId = Math.round(Math.random() * 1000000);
           CustomerName = "" + newId;
           if (newCustId == WCSGUESTID)
             WcsCustomerId = WCSGUESTID + "" + newId
     }
     else
     {
           CustomerName = newCustName;
     }
   }
}

function setCustomerNameOnly (newCustName)
{
  CustomerName = newCustName;
}

function setCustomerNameFirstTime (newCustId, newCustName)
{
     WcsCustomerId = newCustId;
     CustomerName = newCustName;
}

function updatePage()
{
   StUpdate.document.location.reload();
}


function setPageParams(pCurrPageURL, pCurrPageDscr)
{  
   MainPageURL=main.document.location.href;
   CurrPageURL = pCurrPageURL;
   CurrPageDscr = pCurrPageDscr;
   updateStInfo();
}
function setWcsStoreId(newStoreID)
{
   WcsStoreID = newStoreID;   
}
function setWcsLangId(newLangID)
{
   WcsLangID = newLangID;   
}
   

function setShoppingCartItems(inTotalItems)
{
  TotalItems = inTotalItems;
}

function setStoreLocale(sLocale)
{
   storeLocale = sLocale;
}

/*
* Create Interaction window/applet.
* This function is called from the Store
* when the Customer presses an "Live Help" button
*/

function interact()
{
   if (CustomerAppletIsUp) 
   {
   	sametime.document.applets["InteractivePresenceApplet"].callCSR(reqQueue);
   	}
}

function InteractivePresenceAppletIsUp()
{
   var name = CustomerName;
   var newId;
   JSFrame.location=BlankURL; //defect 33146

   // set attributes for the first time
   CustomerAppletIsUp = true;
   if (CurrPageURL != null)
   {
      setPageParams(CurrPageURL, CurrPageDscr);
   }
   if(name == null || name == "")
   {
      newId = Math.round(Math.random() * 1000000);
      name = "" + newId;

      if (WcsCustomerId == top.WCSGUESTID)
      {
         newId = WCSGUESTID + "" + newId;
         setCustomerNameFirstTime(newId, name);
      }
      else
      {
         setCustomerNameFirstTime(WcsCustomerId, name);
      }
   }
   else
   {
      setCustomerNameFirstTime(WcsCustomerId, name);
   }

   if (TotalItems > 0)
      setShoppingCartItems(TotalItems);

   setWcsStoreId(WcsStoreID);
   setWcsLangId(WcsLangID);
}
