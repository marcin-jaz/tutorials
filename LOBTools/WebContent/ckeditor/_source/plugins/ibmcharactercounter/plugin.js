/* Copyright IBM Corp. 2010-2014 All Rights Reserved.                    */

/**
 * @fileOverview Character Counter (IBM).
 */
(function()
{
	function getCharactersCount(editor) {
		if(editor){
        	if(editor.elementMode == CKEDITOR.ELEMENT_MODE_INLINE){
        		return editor.container.getText().length;
        	}
        	else{
        		return editor.document.getBody().getText().length;
        	}
        }
    }
	
	CKEDITOR.plugins.add( 'ibmcharactercounter',
	{
		getCharactersCount : getCharactersCount
	});
})();
