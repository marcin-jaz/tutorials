/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "cs",
{
	//do not translate anything with the form ${xxx} 
	
	title : "Nápověda",
	contents : "Obsah nápovědy. Toto dialogové okno lze zavřít stisknutím klávesy ESC.",
	legend :
	[
		{
			name : "Pokyny k usnadnění přístupu",
			items :
			[
				{
					name : "Panel nástrojů editoru",
					legend: 
						"Panel nástrojů je možné aktivovat stiskem klávesy ${toolbarFocus}. " +
						"Mezi skupinami na panelu nástrojů je možné přepínat pomocí kláves TAB a SHIFT-TAB. " +
						"Mezi tlačítky je možné přepínat pomocí kláves šipka vpravo nebo šipka vlevo. " +
						"Tlačítko na panelu je možné aktivovat pomocí klávesy ENTER nebo mezerníku."
				},

				{
					name : "Dialogové okno editoru",
					legend :
						"V dialogovém okně lze stisknutím klávesy TAB přejít k dalšímu poli dialogového okna, stisknutím kombinace kláves SHIFT+TAB přejít k předchozímu poli, stisknutím klávesy ENTER odeslat obsah dialogového okna nebo stisknutím klávesy ESC dialogové okno zrušit. " +
						"Pro dialogová okna s více kartami je možné zobrazit seznam karet pomocí klávesové zkratky ALT + F10. " +
						"Na další kartu je možné se přesunout pomocí klávesy TAB nebo šipky vpravo. " +
						"Na předchozí kartu je možné se přesunout pomocí kláves SHIFT + TAB nebo šipky vlevo. " +
						"Kartu je možné vybrat stiskem klávesy ENTER nebo mezerník."
				},

				{
					name : "Kontextová nabídka editoru",
					legend :
						"Kontextovou nabídku je možné zobrazit pomocí klávesy ${contextMenu} nebo klávesy aplikace. " +
						"Mezi možnostmi nabídky můžete přepínat pomocí kláves TAB nebo šipky dolů. " +
						"Na předchozí možnost je možné přejít přejít pomocí klávesy SHIFT+TAB nebo šipky nahoru. " +
						"Možnost v nabídce je možné vybrat pomocí mezerníku nebo klávesy ENTER. " +
						"Podnabídku je možné otevřít pomocí mezerníku, klávesy ENTER nebo šipky vpravo. " +
						"Vrátit se k nadřízené položce nabídky je možné pomocí klávesy ESC nebo šipky vlevo. " +
						"Kontextovou nabídku lze zavřít pomocí klávesy ESC."
				},

				{
					name : "Pole se seznamem editoru",
					legend :
						"V okénku se seznamem se na další položku přesunete klávesami TAB nebo šipky dolů. " +
						"Na předchozí položku je možné přejít pomocí kláves SHIFT + TAB nebo šipky nahoru. " +
						"Možnost v seznamu je možné vybrat pomocí mezerníku nebo klávesy ENTER. " +
						"Okénko se seznamem je možné zavřít pomocí klávesy ESC."
				},

				{
					name : "Panel cesty prvku editoru (pokud je k dispozici*)",
					legend :
						"K panelu cesty prvku editoru je možné přejít stiskem klávesy ${elementsPathFocus}. " +
						"Přesunout se na další tlačítko prvku je možné pomocí kláves TAB nebo šipky vpravo. " +
						"Přesunout se na předchozí tlačítko je možné pomocí kláves SHIFT+TAB nebo šipky vlevo. " +
						"Prvek v editoru je možné vybrat stisknutím mezerníku nebo klávesy ENTER."
				}
			]
		},
		{
			name : "Příkazy",
			items :
			[
				{
					name : " Příkaz Zpět",
					legend : "Stiskněte kombinaci kláves ${undo}."
				},
				{
					name : " Příkaz Opakovat",
					legend : "Stiskněte kombinaci kláves ${redo}."
				},
				{
					name : " Příkaz Tučné",
					legend : "Stiskněte kombinaci kláves ${bold}."
				},
				{
					name : " Příkaz Kurzíva",
					legend : "Stiskněte kombinaci kláves ${italic}."
				},
				{
					name : " Příkaz Podtržené",
					legend : "Stiskněte kombinaci kláves ${underline}."
				},
				{
					name : " Příkaz Odkaz",
					legend : "Stiskněte kombinaci kláves ${link}."
				},
				{
					name : " Příkaz Sbalit panel nástrojů (pokud je k dispozici*)",
					legend : "Stiskněte kombinaci kláves ${toolbarCollapse}."
				},
				{
					name: ' Příkaz Přístup k předchozímu místu s fokusem',
					legend: 'Stiskněte ${accessPreviousSpace} a vložte mezeru do nedostupného místa s fokusem přímo před kurzor. ' +
						'Nedostupné místo s fokusem je umístění v editoru, kam nemůžete umístit kurzor ' + 
						'pomocí myš ani klávesnici. Příklad: Pomocí tohoto příkazu můžete vložit obsah mezi dva sousední prvky tabulky.'
				},
				{
					name: ' Příkaz Přístup k dalšímu místu s fokusem',
					legend: 'Stiskněte ${accessNextSpace} a vložte mezeru do nedostupného místa s fokusem přímo za kurzor. ' +
						'Nedostupné místo s fokusem je umístění v editoru, kam nemůžete umístit kurzor ' +
						'pomocí myš ani klávesnici. Příklad: Pomocí tohoto příkazu můžete vložit obsah mezi dva sousední prvky tabulky.'
				},
				{
					name : " Zvětšit odsazení",
					legend : "Stiskněte kombinaci kláves ${indent}."
				},
				{
					name : " Zmenšit odsazení",
					legend : "Stiskněte kombinaci kláves ${outdent}."
				},				
				{
					name : " Směr textu zleva doprava",
					legend : "Stiskněte kombinaci kláves ${bidiltr}."
				},
				{
					name : " Směr textu zprava doleva",
					legend : "Stiskněte kombinaci kláves ${bidirtl}."
				},
				{
					name : " Nápověda pro usnadnění přístupu",
					legend : "Stiskněte kombinaci kláves ${a11yHelp}."
				}
			]
		},
		
		{	//added by ibm
			name : "Poznámka",
			items :
			[
				{	
					name : "",
					legend : "* Některé funkce mohou být zakázány vaším administrátorem."
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
	leftArrow: 'Šipka vlevo',
	upArrow: 'Šipka nahoru',
	rightArrow: 'Šipka vpravo',
	downArrow: 'Šipka dolů',
	insert: 'Insert',
	'delete': 'Delete',
	leftWindowKey: 'Levá klávesa Windows',
	rightWindowKey: 'Pravá klávesa Windows',
	selectKey: 'Klávesa pro výběr',
	numpad0: 'Numerická 0',
	numpad1: 'Numerická 1',
	numpad2: 'Numerická 2',
	numpad3: 'Numerická 3',
	numpad4: 'Numerická 4',
	numpad5: 'Numerická 5',
	numpad6: 'Numerická 6',
	numpad7: 'Numerická 7',
	numpad8: 'Numerická 8',
	numpad9: 'Numerická 9',
	multiply: 'Násobení',
	add: 'Sčítání',
	subtract: 'Odčítání',
	decimalPoint: 'Desetinný oddělovač',
	divide: 'Dělení',
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
	semiColon: 'Středník',
	equalSign: 'Rovnítko',
	comma: 'Čárka',
	dash: 'Pomlčka',
	period: 'Tečka',
	forwardSlash: 'Lomítko',
	graveAccent: 'Zpětná čárka',
	openBracket: 'Otvírací závorka',
	backSlash: 'Zpětné lomítko',
	closeBracket: 'Zavírací závorka',
	singleQuote: 'Jednoduchá uvozovka',
	
	ibm :
	{
		helpLinkDescription : "Otevřít další témata nápovědy v novém okně",
		helpLink : "Další témata nápovědy"
	}

});
