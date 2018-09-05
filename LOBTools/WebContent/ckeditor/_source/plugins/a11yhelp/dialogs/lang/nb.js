/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "nb",
{
	//do not translate anything with the form ${xxx} 
	
	title : "Hjelp",
	contents : "Innhold i hjelpen. Du lukker denne dialogboksen ved å trykke på ESC.",
	legend :
	[
		{
			name : "Instruksjoner for tilgjengelighet",
			items :
			[
				{
					name : "Verktøylinje for redigering",
					legend: 
						"Trykk på ${toolbarFocus} for å gå til verktøylinjen. " +
						"Gå til neste eller forrige verktøylinjegruppe med TAB og SKIFT-TAB. " +
						"Gå til neste eller forrige verktøylinjeknapp med HØYREPIL eller VENSTREPIL. " +
						"Trykk på MELLOMROMSTASTEN eller ENTER for å aktivere verktøylinjeknappen."
				},

				{
					name : "Dialogboks i redigeringsprogram",
					legend :
						"Trykk på TAB for å navigere til neste felt i en dialogboks, trykk på SKIFT + TAB for å gå til forrige felt, trykk på ENTER for å sende innholdet i dialogboksen, og trykk på ESC for å lukke dialogboksen. " +
						"For dialogbokser med flere kategorisider trykker du på ALT + F10 for å navigere til kategorilisten. " +
						"Gå deretter til neste kategori med TAB eller HØYREPIL. " +
						"Gå til forrige kategori med SKIFT + TAB eller VENSTREPIL. " +
						"Trykk på MELLOMROMSTASTEN eller ENTER for å velge kategorisiden."
				},

				{
					name : "Hurtigmeny i redigeringsprogram",
					legend :
						"Trykk på ${contextMenu} eller APPLIKASJONSTASTEN for å åpne hurtigmenyen. " +
						"Gå deretter til det neste menyalternativet med TAB eller PIL NED. " +
						"Gå til forrige alternativ med SKIFT+TAB eller PIL OPP. " +
						"Trykk på MELLOMROMSTASTEN eller ENTER for å velge menyalternativet. " +
						"Åpne undermenyen for det gjeldende alternativet med MELLOMROMSTASTEN, ENTER eller HØYREPIL. " +
						"Gå tilbake til det overordnede menypunktet med ESC eller VENSTREPIL. " +
						"Lukk hurtigmenyen med ESC."
				},

				{
					name : "Listeboks i redigeringsprogram",
					legend :
						"I en listeboks går du til neste listepunkt med TAB eller PIL NED. " +
						"Gå til forrige listepunkt med SKIFT + TAB eller PIL OPP. " +
						"Trykk på MELLOMROMSTASTEN eller ENTER for å velge listepunktet. " +
						"Trykk på ESC for å lukke listeboksen."
				},

				{
					name : "Elementbanelinje i redigeringsprogram (hvis tilgjengelig*)",
					legend :
						"Trykk på ${elementsPathFocus} for å gå til elementbanelinjen. " +
						"Gå til neste elementknapp med TAB eller HØYREPIL. " +
						"Gå til forrige knapp med SKIFT+TAB eller VENSTREPIL. " +
						"Trykk på MELLOMROMSTASTEN eller ENTER for å velge elementet i redigeringsprogrammet."
				}
			]
		},
		{
			name : "Kommandoer",
			items :
			[
				{
					name : "  Angre",
					legend : "Trykk på ${undo}"
				},
				{
					name : "  Gjør om",
					legend : "Trykk på ${redo}"
				},
				{
					name : "  Fet",
					legend : "Trykk på ${bold}"
				},
				{
					name : "  Kursiv",
					legend : "Trykk på ${italic}"
				},
				{
					name : "  Understreking",
					legend : "Trykk på ${underline}"
				},
				{
					name : "  Link",
					legend : "Trykk på ${link}"
				},
				{
					name : "  Komprimer verktøylinje-kommando (hvis tilgjengelig*)",
					legend : "Trykk på ${toolbarCollapse}"
				},
				{
					name: '  Kommando for å gå til forrige fokusområde',
					legend: 'Trykk på ${accessPreviousSpace} for å sette inn et fokusområde som ikke kan nås, rett foran markøren. ' +
						'Et fokusområde som ikke kan nås, er en plassering i redigereren der du ikke kan plassere markøren ' + 
						'ved hjelp av mus eller tastatur. For eksempel: Bruk denne kommandoen til å sette inn innhold mellom to tilstøtende tabellelementer.'
				},
				{
					name: '  Kommando for å gå til neste fokusområde',
					legend: 'Trykk på ${accessNextSpace} for å sette inn et unåelig fokusområde rett etter markøren. ' +
						'Et fokusområde som ikke kan nås, er en plassering i redigereren der du ikke kan plassere markøren ' +
						'ved hjelp av mus eller tastatur. For eksempel: Bruk denne kommandoen til å sette inn innhold mellom to tilstøtende tabellelementer.'
				},
				{
					name : " Øk innrykk",
					legend : "Trykk på ${indent} (gjelder bare amerikansk tastatur)"
				},
				{
					name : " Reduser innrykk",
					legend : "Trykk på ${outdent} (gjelder bare amerikansk tastatur)"
				},				
				{
					name : " Tekstretning fra venstre mot høyre",
					legend : "Trykk på ${bidiltr} (gjelder bare amerikansk tastatur)"
				},
				{
					name : " Tekstretning fra høyre mot venstre",
					legend : "Trykk på ${bidirtl} (gjelder bare amerikansk tastatur)"
				},
				{
					name : "  Hjelp til Tilgjengelighet",
					legend : "Trykk på ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Merknad",
			items :
			[
				{	
					name : "",
					legend : "* Noen funksjoner kan være deaktivert av administratoren."
				}
			]
		}
	],
	backspace: 'Tilbaketast',
	tab: 'Tabulatortast',
	enter: 'Enter',
	shift: 'Skift',
	ctrl: 'Ctrl',
	alt: 'Alt',
	pause: 'Pause',
	capslock: 'Caps Lock',
	escape: 'Escape',
	pageUp: 'Page Up',
	pageDown: 'Page Down',
	end: 'End',
	home: 'Home',
	leftArrow: 'Pil venstre',
	upArrow: 'Pil opp',
	rightArrow: 'Pil høyre',
	downArrow: 'Pil ned',
	insert: 'Insert',
	'delete': 'Delete',
	leftWindowKey: 'Venstre Windows-tast',
	rightWindowKey: 'Høyre Windows-tast',
	selectKey: 'Velg tast',
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
	multiply: 'Multipliser',
	add: 'Adder',
	subtract: 'Subtraher',
	decimalPoint: 'Desimaltegn',
	divide: 'Divider',
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
	semiColon: 'Semikolon',
	equalSign: 'Likhetstegn',
	comma: 'Komma',
	dash: 'Strek',
	period: 'Punktum',
	forwardSlash: 'Skråstrek',
	graveAccent: 'Gravistegn',
	openBracket: 'Venstre hakeparentes',
	backSlash: 'Omvendt skråstrek',
	closeBracket: 'Høyre hakeparentes',
	singleQuote: 'Enkeltanførselstegn',
	
	ibm :
	{
		helpLinkDescription : "Åpne flere hjelpeemner i et nytt vindu",
		helpLink : "Flere hjelpeemner"
	}

});
