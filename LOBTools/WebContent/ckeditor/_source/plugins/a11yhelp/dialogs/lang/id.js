/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
								
				Portions Copyright IBM Corp., 2009-2014.
 */

CKEDITOR.plugins.setLang( "a11yhelp", "id",
{
	//do not translate anything with the form ${xxx} 
	
	title : "Bantuan",
	contents : "Konten Bantuan. Untuk menutup dialog ini tekan ESC.",
	legend :
	[
		{
			name : "Petunjuk Aksesibilitas",
			items :
			[
				{
					name : "Toolbar Editor",
					legend: 
						"Tekan ${toolbarFocus} untuk menavigasi ke toolbar. " +
						"Berpindah ke grup toolbar berikutnya dan sebelumnya dengan TAB dan SHIFT-TAB. " +
						"Berpindah ke tombol toolbar berikutnya dan sebelumnya dengan PANAH KANAN atau PANAH KIRI. " +
						"Tekan SPASI atau ENTER untuk mengaktifkan tombol toolbar."
				},

				{
					name : "Dialog Editor",
					legend :
						"Dalam sebuah dialog, tekan TAB untuk menavigasi kolom dialog berikutnya, tekan SHIFT + TAB untuk berpindah ke kolom sebelumnya, tekan ENTER memasukkan dialog, tekan ESC untuk membatalkan dialog. " +
						"Untuk dialog yang memiliki beberapa halaman tab, tekan ALT + F10 untuk menavigasi ke daftar tab. " +
						"Lalu berpindah ke tab berikutnya dengan TAB atau PANAH KANAN. " +
						"Berpindah ke tab sebelumnya dengan SHIFT + TAB atau PANAH KIRI. " +
						"Tekan SPASI atau ENTER untuk memilih halaman tab."
				},

				{
					name : "Menu Konteks Editor",
					legend :
						"Tekan  ${contextMenu} atau TOMBOL APLIKASI untuk membuka menu-konteks. " +
						"Lalu berpindah ke opsi menu berikutnya dengan TAB atau PANAH BAWAH. " +
						"Berpindah ke opsi sebelumnya dengan  SHIFT+TAB atau PANAH ATAS. " +
						"Tekan SPASI atau ENTER untuk memilih opsi menu. " +
						"Buka sub-menu dari opsi saat ini dengan SPASI atau ENTER atau PANAH KANAN. " +
						"Kembali ke item menu induk dengan ESC atau PANAH KIRI. " +
						"Tutup menu konteks dengan ESC."
				},

				{
					name : "Kotak Daftar Editor",
					legend :
						"Dalam sebuah kotak daftar, berpindah ke item daftar berikutnya dengan TAB atau PANAH BAWAH. " +
						"Berpindah ke item daftar sebelumnya dengan SHIFT + TAB atau PANAH ATAS. " +
						"Tekan SPASI atau ENTER untuk memilih opsi daftar. " +
						"Tekan ESC untuk menutup kotak daftar."
				},

				{
					name : "Bar Element Path Editor (jika ada*)",
					legend :
						"Tekan ${elementsPathFocus} untuk menavigasi ke bar elements path. " +
						"Berpindah ke tombol elemen berikutnya dengan TAB atau PANAH KANAN. " +
						"Berpindah ke tombol sebelumnya dengan SHIFT+TAB atau PANAH KIRI. " +
						"Tekan SPASI atau ENTER untuk memilih elemen dalam editor."
				}
			]
		},
		{
			name : "Perintah",
			items :
			[
				{
					name : " Perintah Batalkan",
					legend : "Tekan ${undo}"
				},
				{
					name : " Perintah Ulangi",
					legend : "Tekan ${redo}"
				},
				{
					name : " Perintah Tebal",
					legend : "Tekan ${bold}"
				},
				{
					name : " Perintah Miring",
					legend : "Tekan ${italic}"
				},
				{
					name : " Perintah Garis Bawah",
					legend : "Tekan ${underline}"
				},
				{
					name : " Perintah Tautan",
					legend : "Tekan ${link}"
				},
				{
					name : " Perintah Lipat Toolbar (jika tersedia*)",
					legend : "Tekan ${toolbarCollapse}"
				},
				{
					name: ' Perintah akses ruang fokus sebelumnya',
					legend: 'Tekan ${accessPreviousSpace} untuk memasukkan spasi dalam suatu ruang fokus yang tak terjangkau langsung sebelum kursor. ' +
						'Ruang fokus tak terjangkau adalah suatu lokasi dalam editor di mana Anda tidak dapat memosisikan kursor ' + 
						'menggunakan mouse atau keyboard. Contoh: gunakan perintah ini untuk menyisipkan konten di antara dua elemen yang berdekatan.'
				},
				{
					name: ' Perintah akses ruang fokus sebelumnya',
					legend: 'Tekan ${accessNextSpace} untuk memasukkan spasi dalam suatu ruang fokus yang tak terjangkau langsung sebelum kursor. ' +
						'Ruang fokus tak terjangkau adalah suatu lokasi dalam editor di mana Anda tidak dapat memosisikan kursor ' +
						'menggunakan mouse atau keyboard. Contoh: gunakan perintah ini untuk menyisipkan konten di antara dua elemen yang berdekatan.'
				},
				{
					name : " Tambah Inden",
					legend : "Tekan ${indent}"
				},
				{
					name : " Kurangi Inden",
					legend : "Tekan ${outdent}"
				},				
				{
					name : " Arah teks dari kiri ke kanan",
					legend : "Tekan ${bidiltr}"
				},
				{
					name : " Arah teks dari kanan ke kiri",
					legend : "Tekan ${bidirtl}"
				},
				{
					name : " Bantuan Aksesibilitas",
					legend : "Tekan ${a11yHelp}"
				}
			]
		},
		
		{	//added by ibm
			name : "Catatan",
			items :
			[
				{	
					name : "",
					legend : "* Beberapa fitur dapat dinonaktifkan oleh administrator Anda."
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
	end: 'Akhir',
	home: 'Beranda',
	leftArrow: 'Panah Kiri',
	upArrow: 'Panah Atas',
	rightArrow: 'Panah Kanan',
	downArrow: 'Panah Bawah',
	insert: 'Masukkan',
	'delete': 'Hapus',
	leftWindowKey: 'Tombol Windows kiri',
	rightWindowKey: 'Tombol Windows kanan',
	selectKey: 'Tombol Select',
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
	multiply: 'Kali',
	add: 'Tambah',
	subtract: 'Kurang',
	decimalPoint: 'Titik Desimal',
	divide: 'Bagi',
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
	semiColon: 'Titik Koma',
	equalSign: 'Tanda Sama Dengan',
	comma: 'Koma',
	dash: 'Garis',
	period: 'Titik',
	forwardSlash: 'Garis Miring',
	graveAccent: 'Aksen Grave',
	openBracket: 'Kurung Buka',
	backSlash: 'Garis Miring Terbalik',
	closeBracket: 'Kurung Tutup',
	singleQuote: 'Tanda petik tunggal',
	
	ibm :
	{
		helpLinkDescription : "Buka lebih banyak topik bantuan di jendela baru",
		helpLink : "Lebih Banyak Topik Bantuan"
	}

});
