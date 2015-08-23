
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


function checkMoney(id){
	 var obj = $("#"+id);
	 var val = $.trim(obj.val());
		if(val==''){
			obj.val(0.00);
		}else{
			val = val.replace(new RegExp(/(,)/g),'');
			obj.val(val);
		}
}

function showImg(obj, event) {
	    var pImg = document.getElementById("productImg");
	    var src = obj.src;
	    var leftPx = getOffsetLeft(obj) + 38;
	    var topPx = getOffsetTop(obj) - 40;
	    if (topPx > 300) {
	        topPx = 300;
	    }
	    event = event || window.event;
	    pImg.style.display = "block";
	    pImg.innerHTML = '<img src="' + src + '" />';
	    pImg.style.top = topPx + "px";
	    pImg.style.left = leftPx + "px";
	}
	function hideImg() {
	    var pImg = document.getElementById("productImg");
	    pImg.innerHTML = "";
	    pImg.style.display = "none";
	}

	function getOffsetLeft(o) {
	    var left = 0;
	    while (o != null && o != document.body) {
	        left += o.offsetLeft;
	        o = o.offsetParent;
	    }
	    return left;
	}

	function getOffsetTop(o) {
	    var top = 0;
	    while (o != null && o != document.body) {
	        top += o.offsetTop;
	        o = o.offsetParent;
	    }
	    return top;
	}
	
	
	var cusObj;
	//显示客户、员工对话框
	function showDialog(obj, title, src, top, left, attr) {
		cusObj = obj
	    createEmpEntDialog(title, src, top, left, attr)
	    $('#DialogDIV').Draggable({
	        zIndex: 20,
	        ghosting: false,
	        opacity: 0.5,
	        handle: '#dialogBar'
	    });

	    $('#closeDialog').click(function () {
	        $("#DialogDIV").remove();
	        //ScreenClean();
	    });
	   // ScreenCover();
	    window.focus();
	}
	
	function createEmpEntDialog(title, src, top, left, attr) {
	    $("<div  id='DialogDIV' style='z-index: 100;top:" + top + "px; left:" + left + "px;position: absolute;'></div>").append(
	    "<div class=\"topheader\">"
	    + "<span class=\"boxTitle\" id=\"dialogBar\">" + title + "</span>"
	     + "<span class=\"closeBox2\" id=\"closeDialog\"><a href=\"javascript:void(0);\"></a></span>"
	      + "</div>"
	       + "<div style=\"padding:0px; \">"
	        + "<div id='loadImg' style='text-align:center;height:250px;'><img src='"+ "../../images/loading2.gif?id=" + new Date() + "' style='border:none;margin-top:100px;'  /></div>"
	        + "<iframe frameborder=\"0\" scrolling=\"auto\"  src=\"" + src + "?attr=" + attr + "&id=" + new Date() + "\" id=\"dialogFrame\"  style='display:none;'></iframe>"
	        + "</div>"
	    ).appendTo("body")
	}
	function selectItem(inputId,id,code,name){
		$("#"+inputId).val(name);
		$("#"+inputId).prev().val(id);
		$("#DialogDIV").remove();
	}
	
	function selectGoodsItem(inputId,id,code,name,type){
		$("#"+inputId).val(name);
		$("#"+inputId).prev().val(id);
		$("#"+inputId).attr("title",type);
		$("#DialogDIV").remove();
		
		if($("#goods_rate").val()=="test"){
			getGoodsRate(id);
		}
		
		getPayNo($("#"+inputId));
	}
	
	function getGoodsRate(goodsId){
		 $.ajax({
             type: "GET",
             url: "../rate/json.do",
             data: {goodsId:goodsId},
             dataType: "json",
             success: function(data){
                 $('#rateId').empty();   //清空rateId里面的所有内容
                 var html = ''; 
                 $.each(data, function(i, v){
                       html += '<option value="'+v['id']+'">' + v['discount']+'--'+v['rate']+'</option>'
                 });
                 $('#rateId').html(html);
              }
         });
	}
	
	function selectCustomerItem(inputId,id,code,name){
		$(cusObj).val(code+"#"+name);
		$(cusObj).prev().val(id);
		$(cusObj).prev().prev().val(id);
		$("#DialogDIV").remove();
	}
	
	function loadingHide(hideID, showID) {
	    $("#" + hideID).hide();
	    $("#" + showID).show();
	}