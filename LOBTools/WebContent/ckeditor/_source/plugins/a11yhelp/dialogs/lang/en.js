﻿/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "en",
{
	//do not translate anything with the form ${xxx} 
	
	title : "Help",
	contents : "Help Contents. To close this dialog press ESC.",
	legend :
	[
		{
			name : "Accessibility Instructions",
			items :
			[
				{
					name : "Editor Toolbar",
					legend: 
						"Press ${toolbarFocus} to navigate to the toolbar. " +
						"Move to the next and previous toolbar group with TAB and SHIFT-TAB. " +
						"Move to the next and previous toolbar button with RIGHT ARROW or LEFT ARROW. " +
						"Press SPACE or ENTER to activate the toolbar button."
				},

				{
					name : "Editor Dialog",
					legend :
						"Inside a dialog, press TAB to navigate to next dialog field, press SHIFT + TAB to move to previous field, press ENTER to submit dialog, press ESC to cancel dialog. " +
						"For dialogs that have multiple tab pages, press ALT + F10 to navigate to tab-list. " +
						"Then move to next tab with TAB OR RIGTH ARROW. " +
						"Move to previous tab with SHIFT + TAB or LEFT ARROW. " +
						"Press SPACE or ENTER to select the tab page."
				},

				{
					name : "Editor Context Menu",
					legend :
						"Press ${contextMenu} or APPLICATION KEY to open context-menu. " +
						"Then move to next menu option with TAB or DOWN ARROW. " +
						"Move to previous option with  SHIFT+TAB or UP ARROW. " +
						"Press SPACE or ENTER to select the menu option. " +
						"Open sub-menu of current option wtih SPACE or ENTER or RIGHT ARROW. " +
						"Go back to parent menu item with ESC or LEFT ARROW. " +
						"Close context menu with ESC."
				},

				{
					name : "Editor List Box",
					legend :
						"Inside a list-box, move to next list item with TAB OR DOWN ARROW. " +
						"Move to previous list item with SHIFT + TAB or UP ARROW. " +
						"Press SPACE or ENTER to select the list option. " +
						"Press ESC to close the list-box."
				},

				{
					name : "Editor Element Path Bar (if available*)",
					legend :
						"Press ${elementsPathFocus} to navigate to the elements path bar. " +
						"Move to next element button with TAB or RIGHT ARROW. " +
						"Move to previous button with  SHIFT+TAB or LEFT ARROW. " +
						"Press SPACE or ENTER to select the element in editor."
				}
			]
		},
		{
			name : "Commands",
			items :
			[
				{
					name : " Undo command",
					legend : "Press ${undo}"
				},
				{
					name : " Redo command",
					legend : "Press ${redo}"
				},
				{
					name : " Bold command",
					legend : "Press ${bold}"
				},
				{
					name : " Italic command",
					legend : "Press ${italic}"
				},
				{
					name : " Underline command",
					legend : "Press ${underline}"
				},
				{
					name : " Link command",
					legend : "Press ${link}"
				},
				{
					name : " Toolbar Collapse command (if available*)",
					legend : "Press ${toolbarCollapse}"
				},
				{
					name: ' Access previous focus space command',
					legend: 'Press ${accessPreviousSpace} to insert space in an unreachable focus space directly before the cursor. ' +
						'An unreachable focus space is a location in the editor where you cannot position the cursor ' + 
						'using the mouse or keyboard. For example: use this command to insert content between two adjacent table elements.'
				},
				{
					name: ' Access next focus space command',
					legend: 'Press ${accessNextSpace} to insert space in an unreachable focus space directly after the cursor. ' +
						'An unreachable focus space is a location in the editor where you cannot position the cursor ' +
						'using the mouse or keyboard. For example: use this command to insert content between two adjacent table elements.'
				},
				{
					name : " Increase Indent",
					legend : "Press ${indent}"
				},
				{
					name : " Decrease Indent",
					legend : "Press ${outdent}"
				},				
				{
					name : " Text direction from left to right",
					legend : "Press ${bidiltr}"
				},
				{
					name : " Text direction from right to left",
					legend : "Press ${bidirtl}"
				},
				{
					name : " Accessibility Help",
					legend : "Press ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Note",
			items :
			[
				{	
					name : "",
					legend : "* Some features can be disabled by your administrator."
				}
			]
		}
	],
	backspace: 'Backspace',
	tab: 'Tab',
	enter: 'Enter',
	shift: 'Shift',
	ctrl: 'Ctrl',
	alt: 'Alt',
	pause: 'Pause',
	capslock: 'Caps Lock',
	escape: 'Escape',
	pageUp: 'Page Up',
	pageDown: 'Page Down',
	end: 'End',
	home: 'Home',
	leftArrow: 'Left Arrow',
	upArrow: 'Up Arrow',
	rightArrow: 'Right Arrow',
	downArrow: 'Down Arrow',
	insert: 'Insert',
	'delete': 'Delete',
	leftWindowKey: 'Left Windows key',
	rightWindowKey: 'Right Windows key',
	selectKey: 'Select key',
	numpad0: 'Numpad 0',
	numpad1: 'Numpad 1',
	numpad2: 'Numpad 2',
	numpad3: 'Numpad 3',
	numpad4: 'Numpad 4',
	numpad5: 'Numpad 5',
	numpad6: 'Numpad 6',
	numpad7: 'Numpad 7',
	numpad8: 'Numpad 8',
	numpad9: 'Numpad 9',
	multiply: 'Multiply',
	add: 'Add',
	subtract: 'Subtract',
	decimalPoint: 'Decimal Point',
	divide: 'Divide',
	f1: 'F1',
	f2: 'F2',
	f3: 'F3',
	f4: 'F4',
	f5: 'F5',
	f6: 'F6',
	f7: 'F7',
	f8: 'F8',
	f9: 'F9',
	f10: 'F10',
	f11: 'F11',
	f12: 'F12',
	numLock: 'Num Lock',
	scrollLock: 'Scroll Lock',
	semiColon: 'Semicolon',
	equalSign: 'Equal Sign',
	comma: 'Comma',
	dash: 'Dash',
	period: 'Period',
	forwardSlash: 'Forward Slash',
	graveAccent: 'Grave Accent',
	openBracket: 'Open Bracket',
	backSlash: 'Backslash',
	closeBracket: 'Close Bracket',
	singleQuote: 'Single Quote',
	
	ibm :
	{
		helpLinkDescription : "Open more help topics in a new window",
		helpLink : "More Help Topics"
	}

});