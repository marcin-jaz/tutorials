﻿/*
 Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
CKEDITOR.plugins.add("menu",{requires:"floatpanel",beforeInit:function(g){for(var h=g.config.menu_groups.split(","),m=g._.menuGroups={},l=g._.menuItems={},a=0;a<h.length;a++)m[h[a]]=a+1;g.addMenuGroup=function(b,a){m[b]=a||100};g.addMenuItem=function(a,c){m[c.group]&&(l[a]=new CKEDITOR.menuItem(this,a,c))};g.addMenuItems=function(a){for(var c in a)this.addMenuItem(c,a[c])};g.getMenuItem=function(a){return l[a]};g.removeMenuItem=function(a){delete l[a]}}});
(function(){function g(a){a.sort(function(a,c){return a.group<c.group?-1:a.group>c.group?1:a.order<c.order?-1:a.order>c.order?1:0})}var h='<span class="cke_menuitem"><a id="{id}" class="cke_menubutton cke_menubutton__{name} cke_menubutton_{state} {cls}" href="{href}" title="{title}" tabindex="-1"_cke_focus=1 hidefocus="true" role="{role}" aria-haspopup="{hasPopup}" aria-disabled="{disabled}" {ariaChecked}';if(CKEDITOR.env.opera||CKEDITOR.env.gecko&&CKEDITOR.env.mac)h+=' onkeypress="return false;"';
CKEDITOR.env.gecko&&(h+=' onblur="this.style.cssText = this.style.cssText;"');var h=h+(' onmouseover="CKEDITOR.tools.callFunction({hoverFn},{index});" onmouseout="CKEDITOR.tools.callFunction({moveOutFn},{index});" '+(CKEDITOR.env.ie?'onclick="return false;" onmouseup':"onclick")+'="CKEDITOR.tools.callFunction({clickFn},{index}); return false;">'),m=CKEDITOR.addTemplate("menuItem",h+'<span class="cke_menubutton_inner"><span class="cke_menubutton_icon"><span class="cke_button_icon cke_button__{iconName}_icon" style="{iconStyle}"></span></span><span class="cke_menubutton_label">{label}</span>{arrowHtml}</span></a></span>'),
l=CKEDITOR.addTemplate("menuArrow",'<span class="cke_menuarrow"><span>{label}</span></span>');CKEDITOR.menu=CKEDITOR.tools.createClass({$:function(a,b){b=this._.definition=b||{};this.id=CKEDITOR.tools.getNextId();this.editor=a;this.items=[];this._.listeners=[];this._.level=b.level||1;var c=CKEDITOR.tools.extend({},b.panel,{css:[CKEDITOR.skin.getPath("editor")],level:this._.level-1,block:{}}),k=c.block.attributes=c.attributes||{};!k.role&&(k.role="menu");this._.panelDefinition=c},_:{onShow:function(){var a=
this.editor.getSelection(),b=a&&a.getStartElement(),c=this.editor.elementPath(),k=this._.listeners;this.removeAll();for(var e=0;e<k.length;e++){var j=k[e](b,a,c);if(j)for(var i in j){var f=this.editor.getMenuItem(i);if(f&&(!f.command||this.editor.getCommand(f.command).state))f.state=j[i],this.add(f)}}},onClick:function(a){this.hide();if(a.onClick)a.onClick();else a.command&&this.editor.execCommand(a.command)},onEscape:function(a){var b=this.parent;b?b._.panel.hideChild(1):27==a&&this.hide(1);return!1},
onHide:function(){this.onHide&&this.onHide()},showSubMenu:function(a){var b=this._.subMenu,c=this.items[a];if(c=c.getItems&&c.getItems()){b?b.removeAll():(b=this._.subMenu=new CKEDITOR.menu(this.editor,CKEDITOR.tools.extend({},this._.definition,{level:this._.level+1},!0)),b.parent=this,b._.onClick=CKEDITOR.tools.bind(this._.onClick,this));for(var k in c){var e=this.editor.getMenuItem(k);e&&(e.state=c[k],b.add(e))}var j=this._.panel.getBlock(this.id).element.getDocument().getById(this.id+(""+a));setTimeout(function(){b.show(j,
2)},0)}else this._.panel.hideChild(1)}},proto:{add:function(a){a.order||(a.order=this.items.length);this.items.push(a)},removeAll:function(){this.items=[]},show:function(a,b,c,k){if(!this.parent&&(this._.onShow(),!this.items.length))return;var b=b||("rtl"==this.editor.lang.dir?2:1),e=this.items,j=this.editor,i=this._.panel,f=this._.element;if(!i){i=this._.panel=new CKEDITOR.ui.floatPanel(this.editor,CKEDITOR.document.getBody(),this._.panelDefinition,this._.level);i.onEscape=CKEDITOR.tools.bind(function(a){if(!1===
this._.onEscape(a))return!1},this);i.onShow=function(){i._.panel.getHolderElement().getParent().addClass("cke cke_reset_all")};i.onHide=CKEDITOR.tools.bind(function(){this._.onHide&&this._.onHide()},this);f=i.addBlock(this.id,this._.panelDefinition.block);f.autoSize=!0;var d=f.keys;d[40]="next";d[9]="next";d[38]="prev";d[CKEDITOR.SHIFT+9]="prev";d["rtl"==j.lang.dir?37:39]=CKEDITOR.env.ie?"mouseup":"click";d[32]=CKEDITOR.env.ie?"mouseup":"click";CKEDITOR.env.ie&&(d[13]="mouseup");f=this._.element=
f.element;d=f.getDocument();d.getBody().setStyle("overflow","hidden");d.getElementsByTag("html").getItem(0).setStyle("overflow","hidden");this._.itemOverFn=CKEDITOR.tools.addFunction(function(a){clearTimeout(this._.showSubTimeout);this._.showSubTimeout=CKEDITOR.tools.setTimeout(this._.showSubMenu,j.config.menu_subMenuDelay||400,this,[a])},this);this._.itemOutFn=CKEDITOR.tools.addFunction(function(){clearTimeout(this._.showSubTimeout)},this);this._.itemClickFn=CKEDITOR.tools.addFunction(function(a){var b=
this.items[a];if(b.state==CKEDITOR.TRISTATE_DISABLED)this.hide(1);else if(b.getItems)this._.showSubMenu(a);else this._.onClick(b)},this)}g(e);for(var d=j.elementPath(),d=['<div class="cke_menu'+(d&&d.direction()!=j.lang.dir?" cke_mixed_dir_content":"")+'" role="presentation">'],h=e.length,m=h&&e[0].group,l=0;l<h;l++){var n=e[l];m!=n.group&&(d.push('<div class="cke_menuseparator" role="separator"></div>'),m=n.group);n.render(this,l,d)}d.push("</div>");f.setHtml(d.join(""));CKEDITOR.ui.fire("ready",
this);this.parent?this.parent._.panel.showAsChild(i,this.id,a,b,c,k):i.showBlock(this.id,a,b,c,k);j.fire("menuShow",[i])},addListener:function(a){this._.listeners.push(a)},hide:function(a){this._.onHide&&this._.onHide();this._.panel&&this._.panel.hide(a)}}});CKEDITOR.menuItem=CKEDITOR.tools.createClass({$:function(a,b,c){CKEDITOR.tools.extend(this,c,{order:0,className:"cke_menubutton__"+b});this.group=a._.menuGroups[this.group];this.editor=a;this.name=b},proto:{render:function(a,b,c){var h=a.id+(""+
b),e="undefined"==typeof this.state?CKEDITOR.TRISTATE_OFF:this.state,j="",i=e==CKEDITOR.TRISTATE_ON?"on":e==CKEDITOR.TRISTATE_DISABLED?"disabled":"off";this.role in{menuitemcheckbox:1,menuitemradio:1}&&(j=' aria-checked="'+(e==CKEDITOR.TRISTATE_ON?"true":"false")+'"');var f=this.getItems,d="&#"+("rtl"==this.editor.lang.dir?"9668":"9658")+";",g=this.name;this.icon&&!/\./.test(this.icon)&&(g=this.icon);a={id:h,name:this.name,iconName:g,label:this.label,cls:this.className||"",state:i,hasPopup:f?"true":
"false",disabled:e==CKEDITOR.TRISTATE_DISABLED,title:this.label,href:"javascript:void('"+(this.label||"").replace("'")+"')",hoverFn:a._.itemOverFn,moveOutFn:a._.itemOutFn,clickFn:a._.itemClickFn,index:b,iconStyle:CKEDITOR.skin.getIconStyle(g,"rtl"==this.editor.lang.dir,g==this.icon?null:this.icon,this.iconOffset),arrowHtml:f?l.output({label:d}):"",role:this.role?this.role:"menuitem",ariaChecked:j};m.output(a,c)}}})})();CKEDITOR.config.menu_groups="clipboard,form,tablecell,tablecellproperties,tablerow,tablecolumn,table,anchor,link,image,flash,checkbox,radio,textfield,hiddenfield,imagebutton,button,select,textarea,div";