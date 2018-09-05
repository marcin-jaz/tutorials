/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "ru",
{
	//do not translate anything with the form ${xxx} 
	
	title : "Справка",
	contents : "Оглавление справки. Нажмите ESC, чтобы закрыть это окно.",
	legend :
	[
		{
			name : "Инструкции по работе со специальными возможностями",
			items :
			[
				{
					name : "Панель инструментов редактора",
					legend: 
						"Нажмите ${toolbarFocus} для перехода в панель инструментов. " +
						"Для перехода к следующей и предыдущей группе панели инструментов нажмите TAB и SHIFT-TAB. " +
						"Для перехода к следующей и предыдущей кнопке панели инструментов нажмите стрелку Вправо и стрелку Влево. " +
						"Нажмите SPACE или ENTER для активации кнопки панели инструментов."
				},

				{
					name : "Окно редактора",
					legend :
						"В открытом окне нажмите TAB для перехода к следующему полю, SHIFT + TAB для перехода к предыдущему полю, ENTER для отправки данных или ESC для закрытия окна. " +
						"Если окно содержит несколько страниц, нажмите ALT + F10 для перехода к списку вкладок. " +
						"Затем для перехода к следующей вкладке нажмите TAB или стрелку Вправо. " +
						"Для перехода к предыдущей вкладке нажмите SHIFT + TAB или стрелку Влево. " +
						"Нажмите SPACE или ENTER для выбора страницы вкладки."
				},

				{
					name : "Контекстное меню редактора",
					legend :
						"Нажмите ${contextMenu} или APPLICATION KEY для открытия контекстного меню. " +
						"Затем перейдите к следующей опции меню с помощью TAB или стрелки Вниз. " +
						"Перейдите к предыдущей опции с помощью SHIFT+TAB или стрелки Вправо. " +
						"Нажмите SPACE или ENTER для выбора опции меню. " +
						"Для того чтобы открыть вложенное меню выбранного пункта основного меню нажмите Пробел, ENTER или стрелку Вправо. " +
						"Для того чтобы вернуться к пункту основного меню, нажмите ESC или стрелку Влево. " +
						"Нажмите ESC, чтобы закрыть контекстное меню."
				},

				{
					name : "Список в редакторе",
					legend :
						"Для перехода к следующему элементу внутри списка нажмите TAB или клавишу Вниз " +
						"Для перехода к предыдущему элементу списка нажмите SHIFT + TAB или клавишу Вверх. " +
						"Для выбора пункта списка нажмите Пробел или ENTER. " +
						"Для того чтобы закрыть список, нажмите ESC."
				},

				{
					name : "Строка пути элементов редактора (если доступна*)",
					legend :
						"Нажмите ${elementsPathFocus} для перехода в панель пути элементов. " +
						"Для перехода к кнопке следующего элемента нажмите TAB или стрелку Вправо. " +
						"Перейдите к предыдущей кнопке с помощью SHIFT+TAB или стрелки Влево. " +
						"Нажмите SPACE или ENTER для выбора элемента в редакторе."
				}
			]
		},
		{
			name : "Команды",
			items :
			[
				{
					name : " Команда Отменить",
					legend : "Нажмите ${undo}"
				},
				{
					name : " Команда Повторить",
					legend : "Нажмите ${redo}"
				},
				{
					name : " Команда Полужирный",
					legend : "Нажмите ${bold}"
				},
				{
					name : " Команда Курсив",
					legend : "Нажмите ${italic}"
				},
				{
					name : " Команда Подчеркнутый",
					legend : "Нажмите ${underline}"
				},
				{
					name : " Команда Ссылка",
					legend : "Нажмите ${link}"
				},
				{
					name : " Команда Свернуть панель инструментов (если доступна*)",
					legend : "Нажмите ${toolbarCollapse}"
				},
				{
					name: ' Команда Доступ к предыдущей области фокуса',
					legend: 'Нажмите ${accessPreviousSpace}, чтобы вставить пробел в недоступную область фокуса прямо перед курсором.' +
						'Недоступная область фокуса - это место в редакторе, куда нельзя поместить курсор' + 
						'с помощью мыши или клавиатуры. Например, эта команда применяется для вставки информации между двумя соседними элементами таблицы.'
				},
				{
					name: ' Команда Доступ к следующей области фокуса',
					legend: 'Нажмите ${accessNextSpace}, чтобы вставить пробел в недоступную область фокуса прямо за курсором. ' +
						'Недоступная область фокуса - это место в редакторе, куда нельзя поместить курсор ' +
						'с помощью мыши или клавиатуры. Например, эта команда применяется для вставки информации между двумя соседними элементами таблицы.'
				},
				{
					name : " Увеличить отступ",
					legend : "Нажмите ${indent}"
				},
				{
					name : " Уменьшить отступ",
					legend : "Нажмите ${outdent}"
				},				
				{
					name : " Направление текста слева направо",
					legend : "Нажмите ${bidiltr}"
				},
				{
					name : " Направление текста справа налево",
					legend : "Нажмите ${bidirtl}"
				},
				{
					name : " Справка по специальным возможностям",
					legend : "Нажмите ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Примечание",
			items :
			[
				{	
					name : "",
					legend : "* Некоторые функции могут быть выключены администратором."
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
	leftArrow: 'Стрелка влево',
	upArrow: 'Стрелка Вверх',
	rightArrow: 'Стрелка вправо',
	downArrow: 'Стрелка вниз',
	insert: 'Insert',
	'delete': 'Delete',
	leftWindowKey: 'Левая клавиша Windows',
	rightWindowKey: 'Правая клавиша Windows',
	selectKey: 'Клавиша выбора',
	numpad0: 'Клавиша 0 (цифровая клавиатура) ',
	numpad1: 'Клавиша 1 (цифровая клавиатура)',
	numpad2: 'Клавиша 2 (цифровая клавиатура)',
	numpad3: 'Клавиша 3 (цифровая клавиатура)',
	numpad4: 'Клавиша 4 (цифровая клавиатура)',
	numpad5: 'Клавиша 5 (цифровая клавиатура)',
	numpad6: 'Клавиша 6 (цифровая клавиатура)',
	numpad7: 'Клавиша 7 (цифровая клавиатура)',
	numpad8: 'Клавиша 8 (цифровая клавиатура)',
	numpad9: 'Клавиша 9 (цифровая клавиатура)',
	multiply: 'Клавиша *',
	add: 'Клавиша +',
	subtract: 'Клавиша -',
	decimalPoint: 'Клавиша .',
	divide: 'Клавиша /',
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
	semiColon: 'Клавиша ;',
	equalSign: 'Клавиша =',
	comma: 'Клавиша ,',
	dash: 'Клавиша -',
	period: 'Клавиша .',
	forwardSlash: 'Клавиша /',
	graveAccent: 'Клавиша `',
	openBracket: 'Клавиша [',
	backSlash: 'Клавиша обратной косой черты',
	closeBracket: 'Клавиша ]',
	singleQuote: 'Клавиша одинарной кавычки',
	
	ibm :
	{
		helpLinkDescription : "Открыть дополнительные разделы справки в новом окне",
		helpLink : "Дополнительные разделы справки"
	}

});
