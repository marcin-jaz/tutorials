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

var busy = false;
function Add2ShopCart(form)
{
       if (!busy) {
                           
              busy = true;
              form.action='OrderItemAdd';
              form.errorViewName.value='CatalogItemAddErrorView';
              form.URL.value='SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?contractId*=&orderId=.&updatePrices=1&calculationUsageId=-1';              
                            
              form.submit();                         
              
       }
}

function Add2ReqList(form, orderform) {
	if (!busy) {
		busy = true;
		// if orderform is passed in then we should use that form to submit to the requisition list page because this form has
		// all the attribute selections made by the shopper if the bundle has defining attributes
		if (orderform) {
			if (form.Type[0].checked) {
				orderform.action="RequisitionListCreateView";
			} else {
				orderform.action="AddToExistReqListView";
			}
			orderform.submit();
		} else {
			if (form.Type[0].checked) {
				form.action="RequisitionListCreateView";
			} else {
				form.action="AddToExistReqListView";
			}
			form.submit();
		}
	}
}

function Add2RFQ(form) {
	if (!busy) {
		if (form.Type[0].checked) {
			form.action="RFQCreateDisplay";
		} else {
			form.action="AddToExistRFQListDisplay";
		}
		form.submit();
	}
}
