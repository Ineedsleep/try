/*
jquery.flash v1.3.2 -  18/02/10
(c)2009 Stephen Belanger - MIT/GPL.
http://docs.jquery.com/License
*/
isie=function(){var p=navigator.plugins;return(p&&p.length)?false:true;};if(isie()){Array.prototype.indexOf=function(o,i){for(var j=this.length,i=i<0?i+j<0?0:i+j:i||0;i<j&&this[i]!==o;i++);return j<=i?-1:i;};}flashversion=function(){if(isie()){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");}catch(e){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");return[6,0,21];}catch(e){};try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");}catch(e){};}if(axo!=null){return axo.GetVariable("$version").split(" ")[1].split(",");}}else{var p=navigator.plugins;var f=p['Shockwave Flash'];if(f&&f.description)return f.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split(".");else if(p['Shockwave Flash 2.0'])return'2.0.0.11';}};hasflash=function(){return(flashversion())?true:false;};$.fn.extend({flash:function(opt){if(hasflash()){function attr(a,b){return' '+a+'="'+b+'"';}function param(a,b){return'<param name="'+a+'" value="'+b+'" />';}var cv=flashversion();$(this).each(function(){var e=$(this);var s=$.extend({'id':e.attr('id'),'class':e.attr('class'),'width':e.width(),'height':e.height(),'src':e.attr('href'),'classid':'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000','pluginspace':'http://get.adobe.com/flashplayer','availattrs':['id','class','width','height','src'],'availparams':['src','bgcolor','quality','allowscriptaccess','allowfullscreen','flashvars','wmode'],'version':'9.0.24'},opt);var a=s.availattrs;var p=s.availparams;var rv=s.version.split('.');var o='<object';if(!s.codebase){s.codebase=(("https:"==document.location.protocol)?'https://':'http://')+'download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version='+rv.join(',');}if(s.express){for(var i in cv){if(parseInt(cv[i])>parseInt(rv[i])){break;}if(parseInt(cv[i])<parseInt(rv[i])){s.src=s.express;}}}if(s.flashvars){s.flashvars=unescape($.param(s.flashvars));}a=isie()?a.concat(['classid','codebase']):a.concat(['pluginspage']);for(k in a){var n=(k==a.indexOf('src'))?'data':a[k];o+=s[a[k]]?attr(n,s[a[k]]):'';};o+='>';for(k in p){var n=(k==p.indexOf('src'))?'movie':p[k];o+=s[p[k]]?param(n,s[p[k]]):'';};o+='</object>';e.replaceWith(o);});}return this;}});