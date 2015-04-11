
function getCookie(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    if(arr != null) { return unescape(arr[2]);} else{  return null; }
}

var curlang = getCookie("clientlanguage");

function loadScript(head, url){
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = url;
    if(head) {
    	document.getElementsByTagName("head")[0].appendChild(script);
    }else{ 
    	document.body.appendChild(script);
    }
}