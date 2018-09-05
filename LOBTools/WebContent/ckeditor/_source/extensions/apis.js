/* Copyright IBM Corp. 2010-2014  All Rights Reserved.                    */

if (CKEDITOR) {
	// Set up CKEDITOR.ibm namespace for all things IBM
	if (CKEDITOR.ibm === undefined) {
		CKEDITOR.ibm = {};
	}
	
	// Add api namespace to CKEDITOR.ibm
	CKEDITOR.ibm.api = {};
	
	// Wrap CKEDITOR.dom.range for cross window invocations in IE
	CKEDITOR.ibm.api.newDomRange = function (document) {
		return new CKEDITOR.dom.range(document);
	};
	
	//Wrap CKEDITOR.dom.element for cross window invocations in IE
	CKEDITOR.ibm.api.newDomElement = function (element) {
		return new CKEDITOR.dom.element(element);
	};
	
	//Wrap CKEDITOR.dom.walker for cross window invocations in IE
	CKEDITOR.ibm.api.newDomWalker = function (range) {
		return new CKEDITOR.dom.walker(range);
	};
}