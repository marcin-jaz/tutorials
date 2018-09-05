/* Copyright IBM Corp. 2011-2014 All Rights Reserved.                    */

CKEDITOR.dialog.add('tablesort', function(editor) {

	var columnNumber, data;
	
	var getColumnData = function(columnNumber, order, sortType) {
		var selectedElement = editor.getSelection().getSelectedElement();	
		var tableColumn;
		var table;
		
		if (selectedElement && selectedElement.getName() == 'table') {// selected element should be a table
			for(var i = 0; i < selectedElement.getChildCount(); i++) {
				if(selectedElement.getChild(i).getName() == 'tbody') {//get only table body, ignore thead/th
					table = selectedElement.getChild(i);
					break;
				}
			}
		}
		var columns = table.getChildren();//tr
		var invalidColNumber = false;
		var data = new Array();//array to store column's data 
		for(var i = 0; i < table.getChildCount(); i++) {
			tableColumn = columns.getItem(i);
			if(tableColumn.getChildCount() < columnNumber){//make sure that column number is not greater than num of columns in the current table
				invalidColNumber = true;
				break;
			}	
			var cell = tableColumn.getChild(columnNumber-1);//get all cells for selected column number
		 	data[i] = cell.getHtml();//save data to sort
		}
		
		function parse( value ) {
		    value = parseInt( value );
		    value = isNaN( value ) ? Infinity : value;
		    return value;
	  	}
		
		function sortNumber(a,b){
		   return parse(a) - parse(b);
		}
		if(!invalidColNumber) {
			//check the sort type
			if(sortType == 'alphanum')
				data.sort();//alphanumeric sort in ascending order
			else 
				data.sort(sortNumber);	//numeric sort in ascending order
				
			if(order == 'desc')
				data.reverse();//sort in descending order
				
			for(var i = 0; i < table.getChildCount(); i++) {//fill in all cells with sorted data
				tableColumn = columns.getItem(i);
				var cell = tableColumn.getChild(columnNumber-1);
			 	cell.setHtml(data[i]);
			}
		}	
	}
	
	return {

		title : editor.lang.ibmtabletools.sortTable,
		minWidth : 220,
		minHeight : 50,

		onShow : function()
		{
			this.getParentEditor().execCommand('selectTable');// select the whole table with content
		},

		onOk : function()
		{
			var columnNumber = this.getValueOf('info', 'column');
			var order = this.getValueOf( 'info', 'order' );
			var sortType = this.getValueOf('info', 'type');
			if(columnNumber && columnNumber > 0)//make sure that column number is presented
				getColumnData(columnNumber, order, sortType);
		},

       contents:
		[
			{
			    id: 'info',
			    style: 'width: 100%',
			    elements:
				[
					{
						type : 'hbox',
						children :	
						[
							{
								label : editor.lang.ibmtabletools.colNumber,
								type : 'text',
								id : 'column',
								setup : function( data )
								{
									if ( data && data[1])
										this.setValue(data[1]);
								},
								validate : CKEDITOR.dialog.validate[ 'number' ]( editor.lang.ibmtabletools.invalidColumnNumber ),
								validate: CKEDITOR.dialog.validate.notEmpty( editor.lang.ibmtabletools.noColumnNumber )
							},
							{
								type : 'select',
								id : 'type',
								label : editor.lang.ibmtabletools.sortType,
								'default' : 'alphanum',
								items :
								[
									[ editor.lang.ibmtabletools.alphanumericType, 'alphanum' ],
									[ editor.lang.ibmtabletools.numericType, 'num' ]
								],
								setup : function( data )
								{
									if ( data && data[2])
										this.setValue(data[2]);
								}
							},
							{
								type : 'select',
								id : 'order',
								label : editor.lang.ibmtabletools.sortOrder,
								'default' : 'asc',
								items :
								[
									[ editor.lang.ibmtabletools.sortOrderAsc, 'asc' ],
									[ editor.lang.ibmtabletools.sortOrderDesc, 'desc' ]
								],
								setup : function( data )
								{
									if ( data && data[3])
										this.setValue(data[3]);
								}
							}
						]
					}
				]
			}
		]
    };
});