/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "kk",
{
	//do not translate anything with the form ${xxx} 
	
	title : "Анықтама",
	contents : "Анықтама мазмұндары. Осы тілқатысу терезесін жабу үшін, ESC пернесін басыңыз.",
	legend :
	[
		{
			name : "Арнайы мүмкіндіктер туралы нұсқаулар",
			items :
			[
				{
					name : "Өңдегіш құралдар тақтасы",
					legend: 
						"Құралдар тақтасын шарлау үшін ${toolbarFocus} басыңыз. " +
						"TAB және SHIFT-TAB пернелерімен келесі және алдыңғы құралдар тақтасына жылжыңыз. " +
						"RIGHT ARROW немесе LEFT ARROW пернелерін пайдалана отырып келесі және алдыңғы құралдар тақтасын жылжытыңыз. " +
						"Құралдар тақтасы батырмасын белсендіру үшін SPACE немесе ENTER пернелерін басыңыз."
				},

				{
					name : "Өңдегіштің тілқатысу терезесі",
					legend :
						"Тілқатысу терезесінде келесі өріске жылжу үшін, TAB пернесін, алдыңғы өріске жылжу үшін, SHIFT + TAB пернелер тіркесімін, тілқатысу терезесін жіберу үшін, Енгізу пернесін, ал тілқатысу терезесін жабу үшін, ESC пернесін басыңыз. " +
						"Көп қойындылы беттері бар тілқатысу терезелерін ашу үшін, қойындылар тізімін шарлау мақсатында, ALT + F10 пернелер тіркесімін басыңыз. " +
						"Одан кейін, TAB немесе RIGTH ARROW пернелері арқылы келесіге өтіңіз. " +
						"SHIFT + TAB немесе LEFT ARROW пернелерін басу арқылы алдыңғы қойындыға өтіңіз. " +
						"Қойынды бетін таңдау үшін SPACE немесе ENTER пернелерін басыңыз."
				},

				{
					name : "Өңдегіштің мәтінмәндік мәзірі",
					legend :
						"Мазмұн мәзірін ашу үшін ${contextMenu} немесе APPLICATION KEY пернелерін басыңыз. " +
						"Кейін TAB немесе DOWN ARROW пернелері арқылы келесі мәзір опциясына өтіңіз. " +
						"SHIFT+TAB немесе UP ARROW пернелерін пайдалану арқылы алдыңғы опцияға өтіңіз. " +
						"Мәзір опциясын таңдаң үшін SPACE немесе ENTER пернелерін басыңыз. " +
						"SPACE немесе ENTER немесе RIGHT ARROW пернелерін пайдалану арқылы ағымдағы опцияның ішкі мәзірін ашыңыз. " +
						"ESC немесе LEFT ARROW пернелерін пайдалану арқылы тектік мәзір элементіне қайтыңыз. " +
						"Мәтінмәндік мәзірді ESC пернесін басып жабыңыз."
				},

				{
					name : "Өңдегіштің тізімді жолағы",
					legend :
						"Тізімді жолақ ішінде, TAB немесе ТӨМЕНГІ КӨРСЕТКІ пернесінің көмегімен келесі тізім элементіне жылжыңыз. " +
						"SHIFT + TAB немесе UP ARROW пернелерін басу арқылы алдыңғы тізім элементіне өтіңіз. " +
						"Тізім опциясын таңдаң үшін SPACE немесе ENTER пернелерін басыңыз. " +
						"Тізім жәшігін жабу үшін ESC пернесін басыңыз."
				},

				{
					name : "Өңдегіш элементінің жолағы (егер қол жетімді болса*)",
					legend :
						"Элементтер жолағын шарлау үшін Press ${elementsPathFocus} басыңыз. " +
						"TAB немесе RIGHT ARROW пайдалана отырып келесі элемент батырмасына өтіңіз. " +
						"SHIFT+TAB немесе LEFT ARROW пернелерін пайдалану арқылы алдыңғы батырмаға өтіңіз. " +
						"Өңдегіш элементіг таңдау үшін SPACE немесе ENTER пернелерін басыңыз."
				}
			]
		},
		{
			name : "Пәрмендер",
			items :
			[
				{
					name : " Болдырмау пәрмені",
					legend : "${undo} түймешігін басыңыз"
				},
				{
					name : " Қайтару пәрмені",
					legend : "${redo} түймешігін басыңыз"
				},
				{
					name : " Қалыңдату пәрмені",
					legend : "${bold} түймешігін басыңыз"
				},
				{
					name : " Көлбеулету пәрмені",
					legend : "${italic} түймешігін басыңыз"
				},
				{
					name : " Астын сызу пәрмені",
					legend : "${underline} түймешігін басыңыз"
				},
				{
					name : " Байланыстыру пәрмені",
					legend : "${link} түймешігін басыңыз"
				},
				{
					name : " Құралдар тақтасын жиыру пәрмені (егер қол жетімді болса)",
					legend : "${toolbarCollapse} түймешігін басыңыз"
				},
				{
					name: ' Алдыңғы фокус кеңістігінің пәрменін ашу',
					legend: 'Курсордың дәл алдындағы қол жетпейтін фокус орнына бос орын қосу үшін ${accessPreviousSpace} түймешігін басыңыз. ' +
						'Қол жетпейтін фокус орны дегеніміз өңдегіштегі корсор ' + 
						'тінтуірмен немесе пернетақтамен қойылмайтын орын. Мысалы: бұл пәрменді екі іргелес кесте элементтің арасына мазмұн енгізу үшін пайдаланыңыз.'
				},
				{
					name: ' Келесі фокус кеңістігінің пәрменін ашу',
					legend: 'Курсордың дәл артындағы қол жетпейтін фокус орнына бос орын қосу үшін ${accessNextSpace} түймешігін басыңыз. ' +
						'Қол жетпейтін фокус орны дегеніміз өңдегіштегі корсор ' +
						'тінтуірмен немесе пернетақтамен қойылмайтын орын. Мысалы: бұл пәрменді екі іргелес кесте элементтің арасына мазмұн енгізу үшін пайдаланыңыз.'
				},
				{
					name : " Жол шегінісін көбейту",
					legend : "${indent} түймешігін басыңыз"
				},
				{
					name : " Жол шегінісін азайту",
					legend : "${outdent} түймешігін басыңыз"
				},				
				{
					name : " Солдан оңға қарайғы мәтін бағыты",
					legend : "${bidiltr} түймешігін басыңыз"
				},
				{
					name : " Оңнан солға қарайғы мәтін бағыты",
					legend : "${bidirtl} түймешігін басыңыз"
				},
				{
					name : " Арнайы мүмкіндік туралы анықтама",
					legend : "${a11yHelp} түймешігін басыңыз"
				}
			]
		},
		
		{	//added by ibm
			name : "Ескертпе",
			items :
			[
				{	
					name : "",
					legend : "* кейбір функциялар әкімшіңіз тарапынан көрсетіледі."
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
	leftArrow: 'Сол жақ көрсеткі',
	upArrow: 'Жоғары көрсеткі',
	rightArrow: 'Оң жақ көрсеткі',
	downArrow: 'Төменгі көрсеткі',
	insert: 'Insert',
	'delete': 'Delete',
	leftWindowKey: 'Сол жақ Windows пернесі',
	rightWindowKey: 'Оң жақ Windows пернесі',
	selectKey: 'Таңдау пернесі',
	numpad0: 'Сан пернесі 0',
	numpad1: 'Сан пернесі 1',
	numpad2: 'Сан пернесі 2',
	numpad3: 'Сан пернесі 3',
	numpad4: 'Сан пернесі 4',
	numpad5: 'Сан пернесі 5',
	numpad6: 'Сан пернесі 6',
	numpad7: 'Сан пернесі 7',
	numpad8: 'Сан пернесі 8',
	numpad9: 'Сан пернесі 9',
	multiply: 'Көбейту',
	add: 'Қосу',
	subtract: 'Алу',
	decimalPoint: 'Ондық бөлгіш',
	divide: 'Бөлу',
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
	semiColon: 'Үтірлі нүкте',
	equalSign: 'Тедік белгісі',
	comma: 'Үтір',
	dash: 'Сызықша',
	period: 'Нүкте',
	forwardSlash: 'Ілгері қиғаш сызық',
	graveAccent: 'Грав екпіні',
	openBracket: 'Ашу жақшасы',
	backSlash: 'Кері қиғаш сызық',
	closeBracket: 'Жабу жақшасы',
	singleQuote: 'Бір тырнақша',
	
	ibm :
	{
		helpLinkDescription : "Жаңа терезеде бірнеше анықтама бөлімдерін ашу",
		helpLink : "Қосымша анықтама бөлімдері"
	}

});
