﻿/*
 Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
CKEDITOR.plugins.add("format",{requires:"richcombo",lang:"af,ar,bg,bn,bs,ca,cs,cy,da,de,el,en,en-au,en-ca,en-gb,eo,es,et,eu,fa,fi,fo,fr,fr-ca,gl,gu,he,hi,hr,hu,id,is,it,ja,ka,km,ko,ku,lt,lv,mk,mn,ms,nb,nl,no,pl,pt,pt-br,ro,ru,si,sk,sl,sq,sr,sr-latn,sv,th,tr,ug,uk,vi,zh,zh-cn",init:function(a){if(!a.blockless){for(var f=a.config,c=a.lang.format,j=f.format_tags.split(";"),d={},k=0,l=[],g=0;g<j.length;g++){var h=j[g],i=new CKEDITOR.style(f["format_"+h]);if(!a.filter.customConfig||a.filter.check(i))k++,
d[h]=i,d[h]._.enterMode=a.config.enterMode,l.push(i)}0!==k&&a.ui.addRichCombo("Format",{label:c.label,title:c.panelTitle,toolbar:"styles,20",allowedContent:l,panel:{css:[CKEDITOR.skin.getPath("editor")].concat(f.contentsCss),multiSelect:!1,attributes:{"aria-label":c.panelTitle}},init:function(){this.startGroup(c.panelTitle);for(var b in d){var a=c["tag_"+b];this.add(b,d[b].buildPreview(a),a)}},onClick:function(b){a.focus();a.fire("saveSnapshot");var b=d[b],c=a.elementPath();a[b.checkActive(c)?"removeStyle":
"applyStyle"](b);setTimeout(function(){a.fire("saveSnapshot")},0)},onRender:function(){a.on("selectionChange",function(b){var c=this.getValue(),b=b.data.path;this.refresh();for(var e in d)if(d[e].checkActive(b)){e!=c&&this.setValue(e,a.lang.format["tag_"+e]);return}this.setValue("")},this)},onOpen:function(){this.showAll();for(var b in d)a.activeFilter.check(d[b])||this.hideItem(b)},refresh:function(){var b=a.elementPath();if(b){if(b.isContextFor("p"))for(var c in d)if(a.activeFilter.check(d[c]))return;
this.setState(CKEDITOR.TRISTATE_DISABLED)}}})}}});CKEDITOR.config.format_tags="p;h1;h2;h3;h4;h5;h6;pre;address;div";CKEDITOR.config.format_p={element:"p"};CKEDITOR.config.format_div={element:"div"};CKEDITOR.config.format_pre={element:"pre"};CKEDITOR.config.format_address={element:"address"};CKEDITOR.config.format_h1={element:"h1"};CKEDITOR.config.format_h2={element:"h2"};CKEDITOR.config.format_h3={element:"h3"};CKEDITOR.config.format_h4={element:"h4"};CKEDITOR.config.format_h5={element:"h5"};
CKEDITOR.config.format_h6={element:"h6"};