/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( 'a11yhelp', 'pt-br',
{
	//do not translate anything with the form ${xxx} 
	
	title : "Ajuda",
	contents : "Conteúdo de Ajuda. Para fechar este diálogo pressione ESC.",
	legend :
	[
		{
			name : "Instruções de Acessibilidade",
			items :
			[
				{
					name : "Barra de Ferramentas do Editor",
					legend: 
						"Pressione ${toolbarFocus} para navegar para a barra de ferramentas. " +
						"Mover para o grupo de barra de ferramentas seguinte e anterior com TAB e SHIFT-TAB. " +
						"Mover para o botão da barra de ferramentas seguinte e anterior com SETA PARA A DIREITA ou SETA PARA A ESQUERDA. " +
						"Pressione ESPAÇO ou ENTER para ativar o botão da barra de ferramentas."
				},

				{
					name : "Diálogo do Editor",
					legend :
						"Dentro de um diálogo, pressione TAB para navegar para o próximo campo de diálogo, pressione SHIFT + TAB para mover para o campo anterior, pressione ENTER para enviar o diálogo, pressione ESC para cancelar o diálogo. " +
						"Para diálogos com diversas páginas tabuladas, pressione ALT + F10 para navegar para a lista de guias. " +
						"Em seguida, mova para a próxima guia com TAB ou SETA PARA A ESQUERDA. " +
						"Mova para a guia anterior com SHIFT + TAB ou SETA PARA A ESQUERDA. " +
						"Pressione ESPAÇO ou ENTER para selecionar a página tabulada."
				},

				{
					name : "Menu de Contexto do Editor",
					legend :
						"Pressione ${contextMenu} ou TECLA DO APLICATIVO para abrir o menu de contexto. " +
						"Em seguida, mova para a próxima opção de menu com TAB ou SETA PARA BAIXO. " +
						"Mova para a opção anterior com SHIFT+TAB ou SETA PARA CIMA. " +
						"Pressione ESPAÇO ou ENTER para selecionar a opção de menu. " +
						"Abra o submenu da opção atual com ESPAÇO ou ENTER ou SETA PARA A DIREITA. " +
						"Volte para o item de menu pai com ESC ou SETA PARA A ESQUERDA. " +
						"Feche o menu de contexto usando ESC."
				},

				{
					name : "Caixa de Listagem do Editor",
					legend :
						"Em uma caixa de listagem, mova para o próximo item da lista com TAB ou SETA PARA BAIXO. " +
						"Mova para o item da lista anterior com SHIFT + TAB ou SETA PARA CIMA. " +
						"Pressione ESPAÇO ou ENTER para selecionar a opção da lista. " +
						"Pressione ESC para fechar a caixa de listagem."
				},

				{
					name : "Barra de Caminho do Elemento do Editor (se disponível*)",
					legend :
						"Pressione ${elementsPathFocus} para navegar para a barra de caminho de elementos. " +
						"Mova para o próximo botão de elemento com TAB ou SETA PARA A DIREITA. " +
						"Mova para o botão anterior com SHIFT+TAB ou SETA PARA A ESQUERDA. " +
						"Pressione ESPAÇO ou ENTER para selecionar o elemento no editor."
				}
			]
		},
		{
			name : "Comandos",
			items :
			[
				{
					name : " Desfazer comando",
					legend : "Pressione ${undo}"
				},
				{
					name : " Refazer comando",
					legend : "Pressione ${redo}"
				},
				{
					name : " Comando para negrito",
					legend : "Pressione ${bold}"
				},
				{
					name : " Comando para itálico",
					legend : "Pressione ${italic}"
				},
				{
					name : " Comando sublinhar",
					legend : "Pressione ${underline}"
				},
				{
					name : " Comando de link",
					legend : "Pressione ${link}"
				},
				{
					name : " Comando de Redução da Barra de Ferramentas (se disponível*)",
					legend : "Pressione ${toolbarCollapse}"
				},
				{
					name: ' Comando Acessar espaço de foco anterior',
					legend: 'Pressione ${accessPreviousSpace} para inserir espaço em um espaço de foco não atingível diretamente antes do cursor. ' +
						'Um espaço de foco não atingível é um local no editor onde não é possível posicionar o cursor ' + 
						'usando o mouse ou o teclado. Por exemplo: use este comando para inserir conteúdo entre dois elementos de tabela adjacentes.'
				},
				{
					name: ' Comando Acessar próximo espaço de foco',
					legend: 'Pressione ${accessNextSpace} para inserir espaço em um foco não atingível diretamente após o cursor. ' +
						'Um espaço de foco não atingível é um local no editor onde não é possível posicionar o cursor ' +
						'usando o mouse ou o teclado. Por exemplo: use este comando para inserir conteúdo entre dois elementos de tabela adjacentes.'
				},
				{
					name : " Aumentar Recuo",
					legend : "Pressione ${indent}"
				},
				{
					name : " Reduzir Recuo",
					legend : "Pressione ${outdent}"
				},				
				{
					name : " Direção do texto da esquerda para a direita",
					legend : "Pressione ${bidiltr}"
				},
				{
					name : " Direção do texto da direita para a esquerda",
					legend : "Pressione ${bidirtl}"
				},
				{
					name : " Ajuda de Acessibilidade",
					legend : "Pressione ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Nota",
			items :
			[
				{	
					name : "",
					legend : "* Alguns recursos podem ser desativados pelo administrador."
				}
			]
		}
	],
	backspace: 'Backspace',
	tab: 'Guia',
	enter: 'Inserir',
	shift: 'Turno',
	ctrl: 'Ctrl',
	alt: 'Alt',
	pause: 'Pausar',
	capslock: 'Caps Lock',
	escape: 'Escape',
	pageUp: 'Page Up',
	pageDown: 'Page Down',
	end: 'Terminar',
	home: 'Início',
	leftArrow: 'Seta para a esquerda',
	upArrow: 'Seta para Cima',
	rightArrow: 'Seta para a direita',
	downArrow: 'Seta para Baixo',
	insert: 'Inserir',
	'delete': 'Excluir',
	leftWindowKey: 'Tecla Esquerda do Windows',
	rightWindowKey: 'Tecla Direita do Windows',
	selectKey: 'Selecionar tecla',
	numpad0: '0 do teclado numérico',
	numpad1: '1 do teclado numérico',
	numpad2: '2 do teclado numérico',
	numpad3: '3 do teclado numérico',
	numpad4: '4 do teclado numérico',
	numpad5: '5 do teclado numérico',
	numpad6: '6 do teclado numérico',
	numpad7: '7 do teclado numérico',
	numpad8: '8 do teclado numérico',
	numpad9: '9 do teclado numérico',
	multiply: 'Multiplicar',
	add: 'Incluir',
	subtract: 'Subtrair',
	decimalPoint: 'Ponto Decimal',
	divide: 'Dividir',
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
	semiColon: 'Ponto e Vírgula',
	equalSign: 'Sinal de Igual',
	comma: 'Vírgula',
	dash: 'Hífen',
	period: 'Ponto Final',
	forwardSlash: 'Barra',
	graveAccent: 'Acento Grave',
	openBracket: 'Abrir Colchete',
	backSlash: 'Barra Invertida',
	closeBracket: 'Fechar Colchete',
	singleQuote: 'Aspas simples',
	
	ibm :
	{
		helpLinkDescription : "Abra mais tópicos da ajuda em uma nova janela",
		helpLink : "Mais Tópicos da Ajuda"
	}

});
