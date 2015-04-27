	//ID返回对象
function getBid(s){
          return document.getElementById(s);
        }

//名称返回对象	 
function getBmcs(s){
          return document.getElementByName(s);
        }


//返回数组对象元素      
function getBAll(s){
          return document.all(s);
        }

//删除确认
function delcfm(str){
    if(str=="")str ="您确定要执行吗?\n该操作不可恢复!";
      return confirm(str);
    }
    
//返回是否超过指定长度
function chkMaxLen(s,lit){
    if(getLen(s)<lit+1)return true;
    return false;
}

 //返回是否达到指定长度
function chkMinLen(s,lit){
    if(getLen(s)>lit-1)return true;
    return false;
}

//检测长度
function  getLen( str) {
 var totallength=0;
 for (var i=0;i<str.length;i++)
 {
   var intCode=str.charCodeAt(i);

   if (intCode>=0&&intCode<=128) {
    totallength=totallength+1; //非中文单个字符长度加 1
   }
   else {
    totallength=totallength+2; //中文字符长度则加 2
   }
  } //end for

   return totallength;
}

//判断删除空格后的字符串长度
function LenStr(str){
   str = trim(str);
   return getLen(str);
}

//检测是否数字
function IsNum(NUM)
{
 var i,j,strTemp;
 strTemp="0123456789";
 if ( NUM.length== 0)
    return false;
 for (i=0;i<NUM.length;i++)
 {
  j=strTemp.indexOf(NUM.charAt(i)); 
  if (j==-1)
  {
   //说明有字符不是数字
    return false;
  }
 }
   //说明是数字
    return true;
}

//跳转到URL
function toUrl(str){
    location.href = str;
}

//返回字母数组
function CodeArray(){
    var ay = new Array("A","B","C","D","E","F","G","H","I","J");
    return ay;
}

//去左空格;
function ltrim(s){
    return s.replace( /^\\s*/, "");
}
//去右空格;
function rtrim(s){
    return s.replace( /\\s*$/, "");
}
//去左右空格;
function trim(s){
    return rtrim(ltrim(s));
}
//是否为空值;
function IsEmpty(_str){
    var tmp_str = trim(_str);
    return tmp_str.length == 0;
}
//是否有效的Email;
function IsMail(_str){
    var tmp_str = trim(_str);
    var pattern = /^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*$/;
    return pattern.test(tmp_str);
}
//是否有效的数字;
function IsNumber(_str){
    var tmp_str = trim(_str);
    var pattern = /^[0-9]/;
    return pattern.test(tmp_str);
}
//是否有效的颜色值;
function IsColor(color){
    var temp=color;
    if (temp=="") return true;
    if (temp.length!=7) return false;
    return (temp.search(/\\#[a-fA-F0-9]{6}/) != -1);
}
//是否有效的链接;
function IsURL(url){
    var sTemp;
    var b=true;
    sTemp=url.substring(0,7);
    sTemp=sTemp.toUpperCase();
    if ((sTemp!="HTTP://")||(url.length<10)){
        b=false;
    }
    return b;
}

//检测是否国内电话格式
function IsTel(phone){
   var p1 = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/;
   var me = false;
   return p1.test(phone);
}

//是否有效的手机号码;
function IsMobile(_str){
    var mobile = trim(_str);
    var reg0 = /^13\d{9}$/;
    var reg1 = /^15\d{9}$/;
    var reg2 = /^0\d{10,11}$/;
    var my = false;
    if (reg0.test(mobile))my=true;
    if (reg1.test(mobile))my=true;
    if (reg2.test(mobile))my=true;
    return my;
} 

//设置收藏
function setfav(){
        window.external.addFavorite('http://www.jukea.com','广州jukea家居网');//  
        }
//收藏///本页
function shoucang(){
        var web = window.location.href;
        window.external.AddFavorite(web,"唯美艺术人才网");
        return 0;
}

//增加到书签
function bookmarksite(title, url){
         if(document.all)
         window.external.AddFavorite(url, title);
         else if (window.sidebar)
         window.sidebar.addPanel(title, url, "")
        }

//返回当前页地址
function getLink(){
	     return window.location.href;
	    }

function setData(msg){
	     var txt = getLink();
         clipboardData.setData("Text",txt)
		 //设置剪切板内容
		 if(msg!="")alert(msg);
}
        
//复制对象的值
function copyme(obj){
         obj.select();
         js=obj.createTextRange();
         js.execCommand("Copy")
        }
        
//复制对象的值,提示信息
function copyok(obj,str){
		    copyme(getBid(obj));
		    var msg = "您已经复制本页路径，谢谢!";
		    if(str!="")msg = str;
		    alert(msg);
        }

//格式化数字输出

function chooeAll(s){
	     bx = getBAll(s);
         if(bx==undefined || bx==null){
			 //alert("不存在选择项!");
		 return;}
	     if(getBAll("chk").checked)
	     {   
            if(getBAll(s).length){
	          for (var i=0;i<bx.length;i++)
             {
                bx[i].checked = true;
             }	
			}else{
                 bx.checked = true;
			}
		 }
         else{
		    if(getBAll(s).length){
            for (var i=0;i<bx.length;i++)
            {
                bx[i].checked = false;
            }
			}else{
			    bx.checked = false;
			}
		 }
}


function BtnChooeAll(obj,s,tit1,tit2){
	     bx = getBAll(s);
         if(bx==undefined || bx==null){ return;}
	     if(obj.value == tit1)
	     {   
            if(getBAll(s).length){
	          for (var i=0;i<bx.length;i++)
             {
                bx[i].checked = true;
             }	
			}else{
                 bx.checked = true;
			}
            obj.value = tit2;
		 }
         else{
		    if(getBAll(s).length){
            for (var i=0;i<bx.length;i++)
            {
                bx[i].checked = false;
            }
			}else{
			    bx.checked = false;
			}
			obj.value = tit1;
		 }
}


//设为收藏
function addBookmark(url,title) { 
if (window.sidebar) { 
window.sidebar.addPanel(title, url,""); 
} else if( document.all ) { 
window.external.AddFavorite( url, title); 
} else if( window.opera && window.print ) { 
return true; 
} 
} 
// 页面使用：<a href=javascript:addBookmark('ijavascript','http://www.ijavascript.cn/')> 


function AddFavorite(sURL, sTitle)
    {
        try
        {
            window.external.addFavorite(sURL, sTitle);
        }
        catch (e)
        {
            try
            {
                window.sidebar.addPanel(sTitle, sURL, "");
            }
            catch (e)
            {
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }
    }



// 鼠标经过改变行的颜色
    if (!objbeforeItem)
    {
        var objbeforeItem=null;
        var objbeforeItembackgroundColor=null;
    }    
    function ItemOver(obj)
    {
        if(objbeforeItem)
        {
            objbeforeItem.style.backgroundColor = objbeforeItembackgroundColor;
        }
        objbeforeItembackgroundColor = obj.style.backgroundColor;
        objbeforeItem = obj;
        obj.style.backgroundColor = "#E8ECF6";     
    }