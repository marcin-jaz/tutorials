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
       
       function Add2ShopCart(form) { 
              if (!busy) {
                     busy = true;         
                     form.contractId.value=getRadioVal(form.copyof_contractId);
                     form.action='OrderItemAdd';
                     form.errorViewName.value = "CatalogItemAddErrorView";
                     form.URL.value='SetPendingOrder?URL=OrderCalculate?URL=OrderItemDisplay?contractId*=&orderId=.&updatePrices=1&calculationUsageId=-1';    
                     form.submit();
              } 
       }
        
       function getRadioVal(rb){
              var L=rb.length;var ret="";
              for (var i = 0 ; i< L ; i++)
               { if(rb[i].checked) { ret=rb[i].value; break; } }
              return(ret);
       }


       function Add2ReqList(form) {
              if (!busy) {
                     busy = true;
                     form.quantity.value = document.OrderItemAddForm.quantity.value;
                     if (form.Type[0].checked) {
                            form.action="RequisitionListCreateView";
                     } else        {
                            form.action="AddToExistReqListView";
                     }
                     form.submit();
              }
       }

       function Add2RFQ(form) {
              if (!busy) {
                     if (form.Type[0].checked) {
                            form.action="RFQCreateDisplay";
                     } else        {
                            form.action="AddToExistRFQListDisplay";
                     }
                     form.submit();
              }
       }
