﻿/*
 Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
(function(){function p(e){function d(a){!(0<b.length)&&(a.type==CKEDITOR.NODE_ELEMENT&&y.test(a.getName())&&!a.getCustomData("selected_cell"))&&(CKEDITOR.dom.element.setMarker(c,a,"selected_cell",!0),b.push(a))}for(var e=e.getRanges(),b=[],c={},a=0;a<e.length;a++){var f=e[a];if(f.collapsed)f=f.getCommonAncestor(),(f=f.getAscendant("td",!0)||f.getAscendant("th",!0))&&b.push(f);else{var f=new CKEDITOR.dom.walker(f),g;for(f.guard=d;g=f.next();)if(g.type!=CKEDITOR.NODE_ELEMENT||!g.is(CKEDITOR.dtd.table))if((g=
g.getAscendant("td",!0)||g.getAscendant("th",!0))&&!g.getCustomData("selected_cell"))CKEDITOR.dom.element.setMarker(c,g,"selected_cell",!0),b.push(g)}}CKEDITOR.dom.element.clearAllMarkers(c);return b}function o(e,d){for(var b=p(e),c=b[0],a=c.getAscendant("table"),c=c.getDocument(),f=b[0].getParent(),g=f.$.rowIndex,b=b[b.length-1],h=b.getParent().$.rowIndex+b.$.rowSpan-1,b=new CKEDITOR.dom.element(a.$.rows[h]),g=d?g:h,f=d?f:b,b=CKEDITOR.tools.buildTableMap(a),a=b[g],g=d?b[g-1]:b[g+1],b=b[0].length,
c=c.createElement("tr"),h=0;a[h]&&h<b;h++){var i;1<a[h].rowSpan&&g&&a[h]==g[h]?(i=a[h],i.rowSpan+=1):(i=(new CKEDITOR.dom.element(a[h])).clone(),i.removeAttribute("rowSpan"),i.appendBogus(),c.append(i),i=i.$);h+=i.colSpan-1}d?c.insertBefore(f):c.insertAfter(f)}function q(e){if(e instanceof CKEDITOR.dom.selection){for(var d=p(e),b=d[0].getAscendant("table"),c=CKEDITOR.tools.buildTableMap(b),e=d[0].getParent().$.rowIndex,d=d[d.length-1],a=d.getParent().$.rowIndex+d.$.rowSpan-1,d=[],f=e;f<=a;f++){for(var g=
c[f],h=new CKEDITOR.dom.element(b.$.rows[f]),i=0;i<g.length;i++){var j=new CKEDITOR.dom.element(g[i]),l=j.getParent().$.rowIndex;1==j.$.rowSpan?j.remove():(j.$.rowSpan-=1,l==f&&(l=c[f+1],l[i-1]?j.insertAfter(new CKEDITOR.dom.element(l[i-1])):(new CKEDITOR.dom.element(b.$.rows[f+1])).append(j,1)));i+=j.$.colSpan-1}d.push(h)}c=b.$.rows;b=new CKEDITOR.dom.element(c[a+1]||(0<e?c[e-1]:null)||b.$.parentNode);for(f=d.length;0<=f;f--)q(d[f]);return b}e instanceof CKEDITOR.dom.element&&(b=e.getAscendant("table"),
1==b.$.rows.length?b.remove():e.remove());return null}function r(e,d){for(var b=d?Infinity:0,c=0;c<e.length;c++){var a;a=e[c];for(var f=d,g=a.getParent().$.cells,h=0,i=0;i<g.length;i++){var j=g[i],h=h+(f?1:j.colSpan);if(j==a.$)break}a=h-1;if(d?a<b:a>b)b=a}return b}function k(e,d){for(var b=p(e),c=b[0].getAscendant("table"),a=r(b,1),b=r(b),a=d?a:b,f=CKEDITOR.tools.buildTableMap(c),c=[],b=[],g=f.length,h=0;h<g;h++)c.push(f[h][a]),b.push(d?f[h][a-1]:f[h][a+1]);for(h=0;h<g;h++)c[h]&&(1<c[h].colSpan&&
b[h]==c[h]?(a=c[h],a.colSpan+=1):(a=(new CKEDITOR.dom.element(c[h])).clone(),a.removeAttribute("colSpan"),a.appendBogus(),a[d?"insertBefore":"insertAfter"].call(a,new CKEDITOR.dom.element(c[h])),a=a.$),h+=a.rowSpan-1)}function u(e,d){var b=e.getStartElement();if(b=b.getAscendant("td",1)||b.getAscendant("th",1)){var c=b.clone();c.appendBogus();d?c.insertBefore(b):c.insertAfter(b)}}function t(e){if(e instanceof CKEDITOR.dom.selection){var e=p(e),d=e[0]&&e[0].getAscendant("table"),b;a:{var c=0;b=e.length-
1;for(var a={},f,g;f=e[c++];)CKEDITOR.dom.element.setMarker(a,f,"delete_cell",!0);for(c=0;f=e[c++];)if((g=f.getPrevious())&&!g.getCustomData("delete_cell")||(g=f.getNext())&&!g.getCustomData("delete_cell")){CKEDITOR.dom.element.clearAllMarkers(a);b=g;break a}CKEDITOR.dom.element.clearAllMarkers(a);g=e[0].getParent();(g=g.getPrevious())?b=g.getLast():(g=e[b].getParent(),b=(g=g.getNext())?g.getChild(0):null)}for(g=e.length-1;0<=g;g--)t(e[g]);b?m(b,!0):d&&d.remove()}else e instanceof CKEDITOR.dom.element&&
(d=e.getParent(),1==d.getChildCount()?d.remove():e.remove())}function m(e,d){var b=e.getDocument(),c=CKEDITOR.document;CKEDITOR.env.ie&&11>CKEDITOR.env.version&&(c.focus(),b.focus());b=new CKEDITOR.dom.range(b);if(!b["moveToElementEdit"+(d?"End":"Start")](e))b.selectNodeContents(e),b.collapse(d?!1:!0);b.select(!0)}function v(e,d,b){e=e[d];if("undefined"==typeof b)return e;for(d=0;e&&d<e.length;d++){if(b.is&&e[d]==b.$)return d;if(d==b)return new CKEDITOR.dom.element(e[d])}return b.is?-1:null}function s(e,
d,b){var c=p(e),a;if((d?1!=c.length:2>c.length)||(a=e.getCommonAncestor())&&a.type==CKEDITOR.NODE_ELEMENT&&a.is("table"))return!1;var f,e=c[0];a=e.getAscendant("table");var g=CKEDITOR.tools.buildTableMap(a),h=g.length,i=g[0].length,j=e.getParent().$.rowIndex,l=v(g,j,e);if(d){var n;try{var m=parseInt(e.getAttribute("rowspan"),10)||1;f=parseInt(e.getAttribute("colspan"),10)||1;n=g["up"==d?j-m:"down"==d?j+m:j]["left"==d?l-f:"right"==d?l+f:l]}catch(z){return!1}if(!n||e.$==n)return!1;c["up"==d||"left"==
d?"unshift":"push"](new CKEDITOR.dom.element(n))}for(var d=e.getDocument(),o=j,m=n=0,q=!b&&new CKEDITOR.dom.documentFragment(d),s=0,d=0;d<c.length;d++){f=c[d];var k=f.getParent(),t=f.getFirst(),r=f.$.colSpan,u=f.$.rowSpan,k=k.$.rowIndex,w=v(g,k,f),s=s+r*u,m=Math.max(m,w-l+r);n=Math.max(n,k-j+u);if(!b){r=f;(u=r.getBogus())&&u.remove();r.trim();if(f.getChildren().count()){if(k!=o&&t&&(!t.isBlockBoundary||!t.isBlockBoundary({br:1})))(o=q.getLast(CKEDITOR.dom.walker.whitespaces(!0)))&&(!o.is||!o.is("br"))&&
q.append("br");f.moveChildren(q)}d?f.remove():f.setHtml("")}o=k}if(b)return n*m==s;q.moveChildren(e);e.appendBogus();m>=i?e.removeAttribute("rowSpan"):e.$.rowSpan=n;n>=h?e.removeAttribute("colSpan"):e.$.colSpan=m;b=new CKEDITOR.dom.nodeList(a.$.rows);c=b.count();for(d=c-1;0<=d;d--)a=b.getItem(d),a.$.cells.length||(a.remove(),c++);return e}function w(e,d){var b=p(e);if(1<b.length)return!1;if(d)return!0;var b=b[0],c=b.getParent(),a=c.getAscendant("table"),f=CKEDITOR.tools.buildTableMap(a),g=c.$.rowIndex,
h=v(f,g,b),i=b.$.rowSpan,j;if(1<i){j=Math.ceil(i/2);for(var i=Math.floor(i/2),c=g+j,a=new CKEDITOR.dom.element(a.$.rows[c]),f=v(f,c),l,c=b.clone(),g=0;g<f.length;g++)if(l=f[g],l.parentNode==a.$&&g>h){c.insertBefore(new CKEDITOR.dom.element(l));break}else l=null;l||a.append(c,!0)}else{i=j=1;a=c.clone();a.insertAfter(c);a.append(c=b.clone());l=v(f,g);for(h=0;h<l.length;h++)l[h].rowSpan++}c.appendBogus();b.$.rowSpan=j;c.$.rowSpan=i;1==j&&b.removeAttribute("rowSpan");1==i&&c.removeAttribute("rowSpan");
return c}function x(e,d){var b=p(e);if(1<b.length)return!1;if(d)return!0;var b=b[0],c=b.getParent(),a=c.getAscendant("table"),a=CKEDITOR.tools.buildTableMap(a),f=v(a,c.$.rowIndex,b),g=b.$.colSpan;if(1<g)c=Math.ceil(g/2),g=Math.floor(g/2);else{for(var g=c=1,h=[],i=0;i<a.length;i++){var j=a[i];h.push(j[f]);1<j[f].rowSpan&&(i+=j[f].rowSpan-1)}for(a=0;a<h.length;a++)h[a].colSpan++}a=b.clone();a.insertAfter(b);a.appendBogus();b.$.colSpan=c;a.$.colSpan=g;1==c&&b.removeAttribute("colSpan");1==g&&a.removeAttribute("colSpan");
return a}var y=/^(?:td|th)$/;CKEDITOR.plugins.tabletools={requires:"table,dialog,contextmenu",init:function(e){function d(a){return CKEDITOR.tools.extend(a||{},{contextSensitive:1,refresh:function(a,b){this.setState(b.contains({td:1,th:1},1)?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED)}})}function b(a,b){var c=e.addCommand(a,b);e.addFeature(c)}var c=e.lang.table;b("cellProperties",new CKEDITOR.dialogCommand("cellProperties",d({allowedContent:"td th{width,height,border-color,background-color,white-space,vertical-align,text-align}[colspan,rowspan]",
requiredContent:"table"})));CKEDITOR.dialog.add("cellProperties",this.path+"dialogs/tableCell.js");b("rowDelete",d({requiredContent:"table",exec:function(a){a=a.getSelection();m(q(a))}}));b("rowInsertBefore",d({requiredContent:"table",exec:function(a){a=a.getSelection();o(a,!0)}}));b("rowInsertAfter",d({requiredContent:"table",exec:function(a){a=a.getSelection();o(a)}}));b("columnDelete",d({requiredContent:"table",exec:function(a){for(var a=a.getSelection(),a=p(a),b=a[0],c=a[a.length-1],a=b.getAscendant("table"),
d=CKEDITOR.tools.buildTableMap(a),e,j,l=[],n=0,o=d.length;n<o;n++)for(var k=0,q=d[n].length;k<q;k++)d[n][k]==b.$&&(e=k),d[n][k]==c.$&&(j=k);for(n=e;n<=j;n++)for(k=0;k<d.length;k++)c=d[k],b=new CKEDITOR.dom.element(a.$.rows[k]),c=new CKEDITOR.dom.element(c[n]),c.$&&(1==c.$.colSpan?c.remove():c.$.colSpan-=1,k+=c.$.rowSpan-1,b.$.cells.length||l.push(b));j=a.$.rows[0]&&a.$.rows[0].cells;e=new CKEDITOR.dom.element(j[e]||(e?j[e-1]:a.$.parentNode));l.length==o&&a.remove();e&&m(e,!0)}}));b("columnInsertBefore",
d({requiredContent:"table",exec:function(a){a=a.getSelection();k(a,!0)}}));b("columnInsertAfter",d({requiredContent:"table",exec:function(a){a=a.getSelection();k(a)}}));b("cellDelete",d({requiredContent:"table",exec:function(a){a=a.getSelection();t(a)}}));b("cellMerge",d({allowedContent:"td[colspan,rowspan]",requiredContent:"td[colspan,rowspan]",exec:function(a){m(s(a.getSelection()),!0)}}));b("cellMergeRight",d({allowedContent:"td[colspan]",requiredContent:"td[colspan]",exec:function(a){m(s(a.getSelection(),
"right"),!0)}}));b("cellMergeDown",d({allowedContent:"td[rowspan]",requiredContent:"td[rowspan]",exec:function(a){m(s(a.getSelection(),"down"),!0)}}));b("cellVerticalSplit",d({allowedContent:"td[rowspan]",requiredContent:"td[rowspan]",exec:function(a){m(w(a.getSelection()))}}));b("cellHorizontalSplit",d({allowedContent:"td[colspan]",requiredContent:"td[colspan]",exec:function(a){m(x(a.getSelection()))}}));b("cellInsertBefore",d({requiredContent:"table",exec:function(a){a=a.getSelection();u(a,!0)}}));
b("cellInsertAfter",d({requiredContent:"table",exec:function(a){a=a.getSelection();u(a)}}));e.addMenuItems&&e.addMenuItems({tablecell:{label:c.cell.menu,group:"tablecell",order:1,getItems:function(){var a=e.getSelection(),b=p(a);return{tablecell_insertBefore:CKEDITOR.TRISTATE_OFF,tablecell_insertAfter:CKEDITOR.TRISTATE_OFF,tablecell_delete:CKEDITOR.TRISTATE_OFF,tablecell_merge:s(a,null,!0)?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED,tablecell_merge_right:s(a,"right",!0)?CKEDITOR.TRISTATE_OFF:
CKEDITOR.TRISTATE_DISABLED,tablecell_merge_down:s(a,"down",!0)?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED,tablecell_split_vertical:w(a,!0)?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED,tablecell_split_horizontal:x(a,!0)?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED,tablecell_properties:0<b.length?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED}}},tablecell_insertBefore:{label:c.cell.insertBefore,group:"tablecell",command:"cellInsertBefore",order:5},tablecell_insertAfter:{label:c.cell.insertAfter,
group:"tablecell",command:"cellInsertAfter",order:10},tablecell_delete:{label:c.cell.deleteCell,group:"tablecell",command:"cellDelete",order:15},tablecell_merge:{label:c.cell.merge,group:"tablecell",command:"cellMerge",order:16},tablecell_merge_right:{label:c.cell.mergeRight,group:"tablecell",command:"cellMergeRight",order:17},tablecell_merge_down:{label:c.cell.mergeDown,group:"tablecell",command:"cellMergeDown",order:18},tablecell_split_horizontal:{label:c.cell.splitHorizontal,group:"tablecell",
command:"cellHorizontalSplit",order:19},tablecell_split_vertical:{label:c.cell.splitVertical,group:"tablecell",command:"cellVerticalSplit",order:20},tablecell_properties:{label:c.cell.title,group:"tablecellproperties",command:"cellProperties",order:21},tablerow:{label:c.row.menu,group:"tablerow",order:1,getItems:function(){return{tablerow_insertBefore:CKEDITOR.TRISTATE_OFF,tablerow_insertAfter:CKEDITOR.TRISTATE_OFF,tablerow_delete:CKEDITOR.TRISTATE_OFF}}},tablerow_insertBefore:{label:c.row.insertBefore,
group:"tablerow",command:"rowInsertBefore",order:5},tablerow_insertAfter:{label:c.row.insertAfter,group:"tablerow",command:"rowInsertAfter",order:10},tablerow_delete:{label:c.row.deleteRow,group:"tablerow",command:"rowDelete",order:15},tablecolumn:{label:c.column.menu,group:"tablecolumn",order:1,getItems:function(){return{tablecolumn_insertBefore:CKEDITOR.TRISTATE_OFF,tablecolumn_insertAfter:CKEDITOR.TRISTATE_OFF,tablecolumn_delete:CKEDITOR.TRISTATE_OFF}}},tablecolumn_insertBefore:{label:c.column.insertBefore,
group:"tablecolumn",command:"columnInsertBefore",order:5},tablecolumn_insertAfter:{label:c.column.insertAfter,group:"tablecolumn",command:"columnInsertAfter",order:10},tablecolumn_delete:{label:c.column.deleteColumn,group:"tablecolumn",command:"columnDelete",order:15}});e.contextMenu&&e.contextMenu.addListener(function(a,b,c){return(a=c.contains({td:1,th:1},1))&&!a.isReadOnly()?{tablecell:CKEDITOR.TRISTATE_OFF,tablerow:CKEDITOR.TRISTATE_OFF,tablecolumn:CKEDITOR.TRISTATE_OFF}:null})},getSelectedCells:p};
CKEDITOR.plugins.add("tabletools",CKEDITOR.plugins.tabletools)})();CKEDITOR.tools.buildTableMap=function(p){for(var p=p.$.rows,o=-1,q=[],r=0;r<p.length;r++){o++;!q[o]&&(q[o]=[]);for(var k=-1,u=0;u<p[r].cells.length;u++){var t=p[r].cells[u];for(k++;q[o][k];)k++;for(var m=isNaN(t.colSpan)?1:t.colSpan,t=isNaN(t.rowSpan)?1:t.rowSpan,v=0;v<t;v++){q[o+v]||(q[o+v]=[]);for(var s=0;s<m;s++)q[o+v][k+s]=p[r].cells[u]}k+=m-1}}return q};