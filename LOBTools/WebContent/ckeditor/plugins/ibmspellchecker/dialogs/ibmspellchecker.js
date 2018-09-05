/*Copyright IBM Corp. 2009-2014  All Rights Reserved.*/(function(){function j(a){var b=a.config.ibmSpellChecker;"XTAF"==b.service?(this.service=b.service,this.restUrl=b.restUrl+"/"+b.lang+"?suggestions="+b.suggestions+"&autoCorrect=false"+(b.usePost?"":"&text="),this.wordSeparator=" ",b.preventCache=!1,this.originalWordKey="word"):(this.restUrl=b.restUrl+"?delimiter=,&format="+b.format+"&language="+b.lang+"&suggestions="+b.suggestions+"&searchString=",this.wordSeparator=",",this.originalWordKey="originalWord");this._getCacheParam=function(){return b.preventCache?
function(){return"&timestamp="+(new Date).getTime()}:function(){return""}}();this.maxLength=b.maxLength?b.maxLength:900;this.usePost=b.usePost;this.ignoreWords=this.words="";this.misspellings=[];this.lastWord=null}function h(a,b){this.editor=a;this.reset(b);this.nonLetterRegex=/[\^\$\.\*\+\?\=\!\:\|\\\/\(\)\[\]\{\}@#~"£%&_<>0-9]/}function i(a,b,d){this.editor=a;this.searchWords=b.join(",");this.walker=new h(a,d);this.range=this.walker.walker.range;a=a.config.ibmSpellChecker;"undefined"===typeof a.highlight&&
(a.highlight={element:"span",styles:{"background-color":"yellow",color:"black"}});this.highlightStyle=new CKEDITOR.style(CKEDITOR.tools.extend({fullMatch:!0,childRule:function(){return false}},a.highlight))}j.prototype={getFindWordRegExpPattern:function(a){return"(?:^|"+this.wordSeparator+")"+a+"(?="+this.wordSeparator+"|$)"},addWord:function(a){if(this.words.length>=this.maxLength)return this.lastWord=a,!1;RegExp(this.getFindWordRegExpPattern(a)).test(this.words)||(this.lastWord&&this.lastWord!=
a&&(this.words=this.lastWord+this.wordSeparator,this.lastWord=null),this.words+=a+this.wordSeparator);return!0},addIgnoreWord:function(a){RegExp(this.getFindWordRegExpPattern(a)).test(this.ignoreWords)||(this.ignoreWords+=a+this.wordSeparator)},removeWords:function(){this.words="";this.misspellings=[];delete this.misspeltWords},check:function(){if(0<this.words.length){0<this.ignoreWords.length&&(this.words=this.words.replace(RegExp(this.getFindWordRegExpPattern(this.ignoreWords.replace(/\s*(,| )\s*/g,
"|")),"g"),""));if("  "!=this.words)var a=this.restUrl+(this.usePost?"":this.words)+this._getCacheParam();if(a)try{var b=this.usePost?CKEDITOR.ibmajax.post(a,"text="+this.words):CKEDITOR.ajax.load(a);if(null===b)return-1;if((this.misspellings="undefined"!==typeof JSON&&JSON.parse?JSON.parse(b):eval("("+b+")"))&&this.misspellings.result)this.misspellings=this.misspellings.result;this.misspellings&&this.misspellings.items&&(this.misspellings=this.misspellings.items)}catch(d){return-1}}return this.misspellings.length},
getMisspeltWords:function(){if("undefined"===typeof this.misspeltWords){this.misspeltWords=[];for(var a=0,b=this.misspellings.length;a<b;a++)this.misspeltWords.push(this.misspellings[a][this.originalWordKey])}return this.misspeltWords},getSuggestions:function(a){for(var b=0,d=this.misspellings.length;b<d;b++)if(this.misspellings[b][this.originalWordKey]===a)return this.misspellings[b];return[]}};h.prototype={hasText:function(a){return a.type==CKEDITOR.NODE_TEXT&&-1!=a.getText().search(/\b/)},getContentRange:function(){var a=
this.editor.editable(),b=new CKEDITOR.dom.range(this.editor.document);b.setStartAt(a,CKEDITOR.POSITION_AFTER_START);b.setEndAt(a,CKEDITOR.POSITION_AFTER_END);return b},isWord:function(a){return!this.nonLetterRegex.test(a)},hasNodeMoreWords:function(){return this.textNode?this.end!==this.lastIndex&&-1!==this.textNode.getText().substr(this.end).search(/\b/):!1},moveToNextWord:function(){if(!this.hasNodeMoreWords())return!1;var a=this.textNode.getText();this.start=a.substr(this.end).search(/\b/)+this.end;
this.end=a.substr(this.start).search(/[\!'"£#\$%&\(\)\*\+,-\.\/\:;<\=>\?@\[\]\^\_\{\|\}~]*(?=\s)/);this.end=-1===this.end?this.lastIndex:this.end+this.start;return this.isWord(this.getWord())?!0:this.next()},next:function(){if(null===this.textNode)return!1;if(!this.moveToNextWord()){this.textNode=this.walker.next.call(this.walker);if(!this.textNode||this.walker._.end)return!1;this.lastIndex=this.textNode.getText().search(/\w\W*$/)+1;this.end=this.firstIndex=this.textNode.getText().search(/\b/);return this.moveToNextWord()}return!0},
getWord:function(){return this.textNode?this.textNode.getText().substring(this.start,this.end):null},getCursor:function(){return{textNode:this.textNode,start:this.start,end:this.end,word:this.getWord()}},getTraversedRange:function(a){var b=new CKEDITOR.dom.range(this.editor.document);b.setStart(this.walker.range.startContainer,this.walker.range.startOffset);this.textNode?b.setEnd(this.textNode,a?this.end:this.start):b.setEnd(this.walker.range.endContainer,this.walker.range.endOffset);return b},reset:function(a){"undefined"===
typeof a&&(a=this.getContentRange());this.walker=new CKEDITOR.dom.walker(a);this.walker.evaluator=this.hasText;this.walker.breakOnFalse=!0;this.textNode&&delete this.textNode}};i.prototype={getWordRange:function(){var a=this.walker.getCursor(),b=new CKEDITOR.dom.range(this.editor.document);b.setStart(a.textNode,a.start);b.setEnd(a.textNode,a.end);return b},updateWalker:function(a){this.walker.reset(a);this.walker.next()},next:function(){for(;this.walker.next();)if(-1!==this.searchWords.search(RegExp("(?:^|,)"+
this.walker.getWord()+"(?=,|$)")))return!0;return!1},getWord:function(){return this.walker.getWord()},setEndOffset:function(){if(this.range.endContainer.type==CKEDITOR.NODE_TEXT){var a=this.range.endContainer.getLength();if(this.range.endOffset>a){var b=null;this.range.endContainer.hasNext()?b=this.range.endContainer:!this.range.endContainer.hasNext()&&(!this.range.endContainer.hasPrevious()&&"span"==this.range.endContainer.getParent().getName())&&(b=this.range.endContainer.getParent());if(b)for(;b.hasNext()&&
b.getNext().type==CKEDITOR.NODE_TEXT&&this.range.endOffset>a;)b=b.getNext(),this.range.endContainer=b,this.range.endOffset-=a,a=this.range.endContainer.getLength()}}else if(this.range.endContainer.getChildCount)for(a=0;a<this.range.endContainer.getChildCount();a++)if(this.range.endContainer.getChild(a).equals(this.origEndNode)){this.range.endOffset=a;break}},getEndNode:function(a){a&&this.setEndOffset();if(this.range.endContainer.type==CKEDITOR.NODE_TEXT)return this.range.endContainer;if(this.range.endContainer.getChildCount()>
this.range.endOffset)return this.range.endContainer.getChild(this.range.endOffset);a=this.range.endContainer.getLast();0<a.getChildCount()&&(a=a.getLast());return a},getOriginalEndNode:function(){this.origEndNode=this.getEndNode(!1)},highlight:function(){this.removeHighlight();var a=this.getEndNode(!0),b=this.getWordRange();this.highlightStyle.applyToRange(b);this.highlightRange=b;var d=b.startContainer;d.type!=CKEDITOR.NODE_ELEMENT&&(d=d.getParent());d.scrollIntoView();d=new CKEDITOR.dom.range(this.editor.document);
d.setStartBefore(b.startContainer.getChild(b.startOffset));d.setEndAfter(a);this.updateWalker(d)},removeHighlight:function(){this.highlightRange&&(this.highlightStyle.removeFromRange(this.highlightRange),this.highlightRange=null)},updateWord:function(a){var b=this.getWordRange();this.getEndNode(!0);var d=b.endContainer.getText().length,c=a.length;this.origEndNode.getText();var f=this.editor.document.createText(a);b.deleteContents();b.insertNode(f);b=!1;if(this.range.endContainer.getText().length<
this.range.endOffset)if(-1==this.range.endContainer.getText().indexOf(a))for(var e=this.range.endContainer;e&&e.hasNext()&&e.getNext().getText().length<this.range.endOffset;){if(-1==e.getText().indexOf(a)){b=!0;break}e=e.getNext()}else b=!0;d!=c&&(this.range.endContainer.type==CKEDITOR.NODE_TEXT&&b)&&(this.range.endOffset=d>c?this.range.endOffset<d-c?this.range.endOffset:this.range.endOffset-(d-c):this.range.endOffset+(c-d));a=new CKEDITOR.dom.range(this.editor.document);a.setStartBefore(f);a.setEndAt(this.editor.editable(),
CKEDITOR.POSITION_BEFORE_END);this.updateWalker(a)},updateAll:function(a,b){var d=this.getWordRange();this.getEndNode(!0);for(var c=new i(this.editor,[a]);c.next();)c.getOriginalEndNode(),c.updateWord(b);c=new CKEDITOR.dom.range(this.editor.document);c.setStart(d.startContainer,d.startOffset);c.setEndAt(this.editor.editable(),CKEDITOR.POSITION_BEFORE_END);this.walker.reset(c)}};CKEDITOR.dialog.add("ibmspellchecker",function(a){var b=null,d=null,c=null;return{title:a.lang.ibmspellchecker.title,minWidth:375,
minHeight:160,onLoad:function(){var f=this,e=function(){var e;a:{for(;b.next();)if(!d.addWord(b.getWord()))if(e=d.check(),0===e)d.removeWords();else break a;e=d.check()}0<e?(c=new i(a,d.getMisspeltWords(),b.getTraversedRange(!1)),c.next()&&(c.getOriginalEndNode(),f.setupContent(d.getSuggestions(c.getWord())))):-1===e?alert(a.lang.ibmspellchecker.problem):(alert(a.lang.ibmspellchecker.complete),f.getButton("cancel").click(),spellchecker=b=c=null)};this.moveToNextMisspeltWord=function(){c.removeHighlight();
if(c.next())this.setupContent(d.getSuggestions(c.getWord()));else{var f=new CKEDITOR.dom.range(a.document),g=c.getEndNode(!0);g.type==CKEDITOR.NODE_TEXT?(c.range.endOffset>=g.getLength()||g.split(c.range.endOffset),f.setStartAt(g,CKEDITOR.POSITION_AFTER_END)):f.setStartAt(g,CKEDITOR.POSITION_BEFORE_START);f.setEndAt(a.editable(),CKEDITOR.POSITION_BEFORE_END);b.reset(f);d.removeWords();e()}};this.initialize=function(){b=new h(a);d=new j(a);c=null;e()}},onCancel:function(){c&&c.removeHighlight()},onHide:function(){this.getContentElement("info",
"selSuggestion").clear();a.config.disableNativeSpellChecker||a.editable().setAttribute("spellcheck","true");a.fire("saveSnapshot")},onShow:function(){a.config.disableNativeSpellChecker||a.editable().setAttribute("spellcheck","false");a.getData();a.fire("saveSnapshot");var b=a.editable(),e=new CKEDITOR.dom.range(a.document);e.setStartAt(b,CKEDITOR.POSITION_AFTER_START);e.setEndAt(b,CKEDITOR.POSITION_AFTER_END);(b=a.getSelection())&&b.unlock();e=new CKEDITOR.dom.walker(e,a.document);e.evaluator=function(a){return a.type===
CKEDITOR.NODE_TEXT};for(e.breakOnFalse=!1;e.next();)e.current.getPrevious()&&e.current.getPrevious().type===CKEDITOR.NODE_TEXT&&(e.current.$.nodeValue=e.current.getPrevious().getText()+e.current.getText(),e.current.getPrevious().remove());this.initialize()},contents:[{id:"info",title:"Spell Check",padding:0,elements:[{type:"hbox",padding:0,widths:["80%","20%"],children:[{type:"vbox",padding:0,style:"ltr"===a.lang.dir?"margin-right: 10px":"margin-left: 10px",children:[{type:"text",id:"replaceItem",
label:a.lang.ibmspellchecker.replace,isChanged:!1,tabIndex:1,setup:function(a){c.highlight();this.setValue(a[d.originalWordKey]);this.focus()}},{type:"text",id:"withItem",label:a.lang.ibmspellchecker.withLabel,"default":"",isChanged:!1,tabIndex:1,onKeyUp:function(){var a=this.getDialog().getContentElement("info","replaceButton"),b=this.getDialog().getContentElement("info","replaceallButton");""==this.getValue()?(a.disable(),b.disable(),0<a.getElement().getChildCount()&&"span"==a.getElement().getChild(0).getName()&&
a.getElement().getChild(0).addClass("cke_disabled"),0<b.getElement().getChildCount()&&"span"==b.getElement().getChild(0).getName()&&b.getElement().getChild(0).addClass("cke_disabled")):(a.enable(),b.enable(),0<a.getElement().getChildCount()&&"span"==a.getElement().getChild(0).getName()&&a.getElement().getChild(0).removeClass("cke_disabled"),0<b.getElement().getChildCount()&&"span"==b.getElement().getChild(0).getName()&&b.getElement().getChild(0).removeClass("cke_disabled"))},setup:function(a){a&&
a.suggestions&&0<a.suggestions.length?this.setValue(a.suggestions[0]):this.setValue("")},onChange:function(){var a=this.getDialog().getContentElement("info","replaceButton"),b=this.getDialog().getContentElement("info","replaceallButton");""==this.getValue()?(a.disable(),b.disable(),0<a.getElement().getChildCount()&&"span"==a.getElement().getChild(0).getName()&&a.getElement().getChild(0).addClass("cke_disabled"),0<b.getElement().getChildCount()&&"span"==b.getElement().getChild(0).getName()&&b.getElement().getChild(0).addClass("cke_disabled")):
(a.enable(),b.enable(),0<a.getElement().getChildCount()&&"span"==a.getElement().getChild(0).getName()&&a.getElement().getChild(0).removeClass("cke_disabled"),0<b.getElement().getChildCount()&&"span"==b.getElement().getChild(0).getName()&&b.getElement().getChild(0).removeClass("cke_disabled"))}},{type:"select",id:"selSuggestion",items:[],label:a.lang.ibmspellchecker.suggesstion,isChanged:!1,tabIndex:1,size:a.config.ibmSpellChecker.suggestions,style:"width : 100%; height: 100px;",onLoad:function(){if(CKEDITOR.env.ie&&
CKEDITOR.env.ie7Compat){var a=parseInt(this.getElement().getStyle("height"),10);this.getElement().getParent().setStyle("height",a+20+"px")}},onChange:function(){0<this.getValue().length&&this.getDialog().setValueOf("info","withItem",this.getValue())},setup:function(a){this.clear();if(!a||!a.suggestions||0===a.suggestions.length)this.disable();else{this.enable();for(var a=a.suggestions,b=0,c=a.length;b<c;b++)this.add(a[b]);this.getInputElement().$.options[0].selected="selected"}}}]},{type:"vbox",style:"margin-top: 3px",
children:[{type:"button",align:"left",style:"display:block;",id:"replaceButton",label:a.lang.ibmspellchecker.replaceButton,onClick:function(){!this.getElement().hasClass("cke_disabled")&&c&&(c.updateWord(this.getDialog().getValueOf("info","withItem")),this.getDialog().moveToNextMisspeltWord())}},{type:"button",align:"left",style:"margin-top:10px;display: block;",id:"replaceallButton",label:a.lang.ibmspellchecker.replaceallButton,onClick:function(){if(!this.getElement().hasClass("cke_disabled")&&c){var a=
this.getDialog();c.updateAll(a.getValueOf("info","replaceItem"),a.getValueOf("info","withItem"));a.moveToNextMisspeltWord()}}},{type:"button",align:"left",style:"margin-top:10px;display:block;",id:"skipButton",label:a.lang.ibmspellchecker.skipButton,onClick:function(){c&&this.getDialog().moveToNextMisspeltWord()}},{type:"button",align:"left",style:"margin-top:10px;display:block;",id:"skipallButton",label:a.lang.ibmspellchecker.skipallButton,onClick:function(){if(c){var a=this.getDialog(),b=c.getWord();
d.addIgnoreWord(b);c.searchWords=c.searchWords.replace(RegExp("(?:^|,)(?:"+b+")(?=,|$)","g"),"");a.moveToNextMisspeltWord()}}}]}]}]}],buttons:[CKEDITOR.dialog.cancelButton.override({label:a.lang.common.close})]}})})();