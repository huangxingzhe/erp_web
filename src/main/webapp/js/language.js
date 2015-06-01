
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

function isPriceNumber(th){  
	var _keyword = th.value;
    if(_keyword == "0" || _keyword == "0." || _keyword == "0.0" || _keyword == "0.00"){  
        th.value = "0.00"; 
    }else{  
        var index = _keyword.indexOf("0");  
        var length = _keyword.length;  
        if(index == 0 && length>1){/*0开头的数字串*/  
            var reg = /^[0]{1}[.]{1}[0-9]{1,2}$/;  
            if(!reg.test(_keyword)){  
            	th.value = "0.00"; 
            }  
        }else{/*非0开头的数字*/  
            var reg = /^[1-9]{1}[0-9]{0,10}[.]{0,1}[0-9]{0,2}$/;  
            if(!reg.test(_keyword)){  
            	th.value = "0.00";
            }  
        }             
    }  
}  

function formatMoney(th){  
	var _keyword = th.value;
	_keyword = _keyword.replace(new RegExp(/(,)/g),'');
    if(_keyword == "0" || _keyword == "0." || _keyword == "0.0" || _keyword == "0.00"){  
        th.value = "0.00"; 
    }else{  
        var index = _keyword.indexOf("0");  
        var length = _keyword.length;  
        if(index == 0 && length>1){/*0开头的数字串*/  
            var reg = /^[0]{1}[.]{1}[0-9]{1,2}$/;  
            if(!reg.test(_keyword)){  
            	th.value = "0.00"; 
            }  
        }else{/*非0开头的数字*/  
            var reg = /^[1-9]{1}[0-9]{0,10}[.]{0,1}[0-9]{0,2}$/;  
            if(!reg.test(_keyword)){  
            	th.value = "0.00";
            }else{
            	 var re=/(?=(?!\b)(\d{3})+$)/g; //分割数字 1,000
            	 th.value = formatCurrency(_keyword);
            	 
            }  
        }             
    }  
}  

function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num))
    num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents<10)
    cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    num = num.substring(0,num.length-(4*i+3))+','+
    num.substring(num.length-(4*i+3));
    return (((sign)?'':'-') + num + '.' + cents);
}
function checknum(th) { 
	if (isNaN(th.value)) { 
		th.value="";
		th.focus();
	} 
}