//
//-------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (c) Copyright IBM Corp. 2006
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//-------------------------------------------------------------------
//

       var bRightBrowser = false;

       //The following checkBrowser function is for checking browser version when the Buyer
       //Approval Tool link is hit.  This is transferring the user Tools page which requires
       //the correct supported browser version.  Note that the link will not be visible for
       //user without Buyer Approver role.
       //
       //The same code is used in Left Nav Bar where the link to RFQ also requires this browser
       //version checking.

       function checkBrowser() {
          var platform = navigator.platform.toLowerCase();
          if (platform.indexOf("mac") != -1) {
          	//Mac platform does not support the oClientCaps object
          	var version = navigator.appVersion.toLowerCase();
          	if (version.indexOf("5.5") != -1) {
          		bRightBrowser = true
                        return true;
          	}
          } else {
              oClientCaps.style.behavior = "url(#default#clientCaps)";
              if ( navigator.appName == "Microsoft Internet Explorer") {
                     bInstalled = oClientCaps.isComponentInstalled("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
                     if ( bInstalled) {
                            IEversion = oClientCaps.getComponentVersion("{89820200-ECBD-11CF-8B85-00AA005B4383}", "ComponentID");
                            version = IEversion.substr(0,3);
                            versionNumber = parseInt(IEversion.substr(0,1));
                            revisionNumber = parseInt(IEversion.substr(2,1));
                            if ( (version == "5,5") || (versionNumber > 5) || (versionNumber == 5 && revisionNumber > 5) ) {
                                   bRightBrowser = true
                                   return true;
                            }
                     }
              }
          }
          return false;

       }
