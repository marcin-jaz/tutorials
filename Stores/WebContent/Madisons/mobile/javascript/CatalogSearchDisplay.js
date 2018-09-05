//<%--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp.  2008, 2009 All Rights Reserved.
//* All Rights Reserved
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
//--%>
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	// CatalogSearchDisplayJS contains all the global variables and javascript functions 
	// necessary for this page to work.
	//
	////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   
	 
	CatalogSearchDisplayJS={	
	
				
						
		submitAdvancedSearch:function(formId){
		
		// summary: This function submit the advanced search form by using render.updateContext
		// Description: This function submit the advanced search form by using render.updateContext			
		
		// form: html formId
		//		this is the advanced search form to be submitted.
			
			var methodName = "submitAdvancedSearch";
			
			form = document.getElementById(formId);
			
			//set the result catEntryType, which is checked on CatalogSearchResultDisplay.jsp: 
			// 1 = list items, packages, and bundles
			// 2 = list products, packages, and bundles
				
			if(form.searchTerm !== null && form.searchTerm != 'undefined')
				form.searchTerm.value = form.searchTerm.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
			if(form.filterTerm !== null && form.filterTerm != 'undefined')
				form.searchTerm.value = form.searchTerm.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
		
			if(form.minPrice !== null && form.minPrice != 'undefined')
				form.minPrice.value = form.minPrice.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
		
			if(form.maxPrice !== null && form.maxPrice != 'undefined')
				form.maxPrice.value = form.maxPrice.value.replace(/^\s+/g, '').replace(/\s+$/g, '');
		
		
			if ((form.minPrice.value == "") && (form.maxPrice.value == ""))
			{
				form.currency.value="";
			}
			form.resultCatEntryType.value = "2";
			
			
			form.submit();
			 			
			
			
		}	
	
	
	
	
	}//end of CatalogSearchDisplayJS   
	

	
