/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "ko",
{
	//do not translate anything with the form ${xxx} 
	
	title : "도움말",
	contents : "도움말 목차입니다. 이 대화 상자를 닫으려면 ESC를 누르십시오.",
	legend :
	[
		{
			name : "내게 필요한 옵션 지시사항",
			items :
			[
				{
					name : "편집기 도구 모음",
					legend: 
						"도구 모음으로 이동하려면 ${toolbarFocus}을(를) 누르십시오. " +
						"TAB 및 SHIFT-TAB을 사용하여 다음 및 이전 도구 모음 그룹으로 이동하십시오. " +
						"오른쪽 화살표 또는 왼쪽 화살표를 사용하여 다음 및 이전 도구 모음으로 이동하십시오. " +
						"SPACE 또는 ENTER를 눌러 도구 모음 단추를 활성화하십시오."
				},

				{
					name : "편집기 대화 상자",
					legend :
						"대화 상자 내에서 Tab을 누르면 다음 대화 상자 필드로 이동할 수 있습니다. 이전 필드로 이동하려면 Shift+Tab을 누르고 대화 상자를 제출하려면 Enter를 누르고 대화 상자를 취소하려면 Esc를 누르십시오." +
						"다중 탭 페이지가 있는 대화 상자의 경우, ALT + F10을 눌러 탭 목록으로 이동하십시오. " +
						"그런 다음 TAB 또는 오른쪽 화살표를 사용하여 다음 탭으로 이동하십시오. " +
						"SHIFT + TAB 또는 왼쪽 화살표를 사용하여 이전 탭으로 이동하십시오. " +
						"탭 페이지를 선택하려면 SPACE 또는 ENTER를 누르십시오."
				},

				{
					name : "편집기 컨텍스트 메뉴",
					legend :
						"컨텍스트 메뉴를 열려면 ${contextMenu} 또는 애플리케이션 키를 누르십시오. " +
						"그런 다음 TAB 또는 아래로 화살표를 사용하여 다음 메뉴 옵션으로 이동하십시오. " +
						"SHIFT+TAB 또는 위로 화살표를 사용하여 이전 옵션으로 이동하십시오. " +
						"메뉴 옵션을 선택하려면 SPACE 또는 ENTER를 누르십시오. " +
						"SPACE 또는 ENTER 또는 오른쪽 화살표를 사용하여 현재 옵션의 하위 메뉴를 여십시오. " +
						"ESC 또는 왼쪽 화살표를 사용하여 상위 메뉴 항목으로 다시 이동하십시오. " +
						"Esc를 사용하여 컨텍스트 메뉴를 닫을 수 있습니다."
				},

				{
					name : "편집기 목록 상자",
					legend :
						"목록 상자 내에서 Tab 또는 아래로 화살표를 사용하여 다음 목록 항목으로 이동하십시오. " +
						"SHIFT+TAB 또는 위로 화살표를 사용하여 이전 목록 항목으로 이동하십시오. " +
						"목록 옵션을 선택하려면 SPACE 또는 ENTER를 누르십시오. " +
						"목록 상자를 닫으려면 ESC를 누르십시오."
				},

				{
					name : "편집기 요소 경로 모음(사용 가능한 경우*)",
					legend :
						"요소 경로 모음으로 이동하려면 ${elementsPathFocus}를 누르십시오. " +
						"TAB 또는 오른쪽 화살표를 사용하여 다음 요소 단추로 이동하십시오. " +
						"SHIFT+TAB 또는 왼쪽 화살표를 사용하여 이전 단추로 이동하십시오. " +
						"편집기에서 요소를 선택하려면 SPACE 또는 ENTER를 누르십시오. "
				}
			]
		},
		{
			name : "명령",
			items :
			[
				{
					name : "  실행 취소 명령",
					legend : "${undo} 누르기"
				},
				{
					name : "  다시 실행 명령",
					legend : "${redo} 누르기"
				},
				{
					name : "  굵게 명령",
					legend : "${bold} 누르기"
				},
				{
					name : "  기울임꼴 명령",
					legend : "${italic} 누르기"
				},
				{
					name : " 밑줄 명령",
					legend : "${underline} 누르기"
				},
				{
					name : "  링크 명령",
					legend : "${link} 누르기"
				},
				{
					name : " 도구 모음 접기 명령(사용 가능한 경우*)",
					legend : "${toolbarCollapse} 누르기"
				},
				{
					name: ' 이전 초점 공간에 액세스 명령',
					legend: '${accessPreviousSpace}을(를) 눌러 커서 앞에 도달할 수 없는 초점 공간에 직접 공간을 삽입하십시오.' +
						'도달할 수 없는 초점 공간은 커서를 위치할 수 없는 편집기의 위치임' + 
						'마우스 또는 키보드를 사용합니다. 예를 들어, 이 명령을 사용하여 두 개의 인접 테이블 요소 간에 컨텐츠를 삽입하십시오.'
				},
				{
					name: ' 다음 초점 공간에 액세스 명령',
					legend: '${accessNextSpace}을(를) 눌러 커서 뒤에 도달할 수 없는 초점 공간에 직접 공간을 삽입하십시오.' +
						'도달할 수 없는 초점 공간은 커서를 위치할 수 없는 편집기의 위치임' +
						'마우스 또는 키보드를 사용합니다. 예를 들어, 이 명령을 사용하여 두 개의 인접 테이블 요소 간에 컨텐츠를 삽입하십시오.'
				},
				{
					name : " 들여쓰기 늘리기",
					legend : "${indent} 누르기"
				},
				{
					name : " 들여쓰기 줄이기",
					legend : "${outdent} 누르기"
				},				
				{
					name : " 왼쪽에서 오른쪽 텍스트 방향",
					legend : "${bidiltr} 누르기"
				},
				{
					name : " 오른쪽에서 왼쪽 텍스트 방향",
					legend : "${bidirtl} 누르기"
				},
				{
					name : " 내게 필요한 옵션 도움말",
					legend : "${a11yHelp} 누르기"
				}
			]
		},
		
		{	//added by ibm
			name : "참고",
			items :
			[
				{	
					name : "",
					legend : "* 관리자가 일부 기능을 사용 안함으로 설정할 수 있습니다."
				}
			]
		}
	],
	backspace: '백스페이스',
	tab: 'Tab',
	enter: 'Enter',
	shift: 'Shift',
	ctrl: 'Ctrl',
	alt: 'Alt',
	pause: 'Pause',
	capslock: 'Caps Lock',
	escape: 'ESC',
	pageUp: '이전 페이지',
	pageDown: '다음 페이지',
	end: 'End',
	home: 'Home',
	leftArrow: '왼쪽 화살표',
	upArrow: '위쪽 화살표',
	rightArrow: '오른쪽 화살표',
	downArrow: '아래로 화살표',
	insert: '삽입',
	'delete': '삭제',
	leftWindowKey: '왼쪽 Windows 키',
	rightWindowKey: '오른쪽 Windows 키',
	selectKey: '키 선택',
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
	multiply: '곱하기',
	add: '추가',
	subtract: '빼기',
	decimalPoint: '소수점',
	divide: '나누기',
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
	semiColon: '세미콜론',
	equalSign: '등호',
	comma: '쉼표',
	dash: '파선',
	period: '마침표',
	forwardSlash: '슬래시',
	graveAccent: '억음 부호',
	openBracket: '왼쪽 대괄호',
	backSlash: '백슬래시',
	closeBracket: '오른쪽 대괄호',
	singleQuote: '작은따옴표',
	
	ibm :
	{
		helpLinkDescription : "새 창에서 도움말 항목 추가로 열기",
		helpLink : "추가 도움말 항목"
	}

});
