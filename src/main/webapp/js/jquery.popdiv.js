/*
项目：jQuery弹出层插件
版本：Ver 1.0
作者：袁维
感谢：飞舟提供的"层托动效果"代码
特性功能：
1:弹出显示时带遮罩效果,并可定义遮罩的颜色
2:可自定义是否带动画显示效果.
3:支持托动效果.
4:支持绑定方式关闭层或显示调用方式关闭层
5:兼容 HTML文档和 XHTML文档
6:对窗口大小或滚动条自适应。
例子：
<script type="text/javascript" src="jquery-1.4.2.js"></script>
<script type="text/javascript" src="jquery.popdiv.js"></script>
<script type="text/javascript">
	//弹出层,具体参数设置请看 "插件的设置数据" 部分的说明
	$('#div1').popShow({closeId:'close1,close2',titleId:'title1'});
	//关闭层(显示调用方式,可以通过以上绑定方式的)
	$('#div1').popHide();
</script>
详细效果:http://www.myquickphp.com/archives/163
*/

// 解决 $ 被其它框架所定义带来的影响
(function($){

$.fn.extend({

	// 参数设置
	Configs:{
		// 点击关闭当前层的DOM ID,多个ID用 "," 分隔,这个值是可选项
		closeId:'',
		// 托动层的DOM ID,这个值是可选项	
		titleId:'', 
		// 层弹出后的回调处理
		callBackFun:null,
		// 弹出层显示时是否有动画效果
		showAnimate:true, 
		// 遮罩层的ID,一般不在程序中设置
		backDivId:'pop__div__id',
		// 遮罩层的颜色	
		backDivColor:'#333'
	},

	// 显示弹出层
	popShow:function(option){

		
		// 读取用户的设置,注意：这个 this == jQuery 对象
		$.extend(this.Configs, option||{});


		/*
			层的托动效果 
		*/
		var divDragGable = function()
		{
			dragDiv = jq;
			titleDivid = jq.Configs.titleId;

			$('#'+titleDivid).css('cursor','move');

			$('#'+titleDivid).mousedown(function(e){
				var posX;
				var posY;  
				if(!e) e = window.event;
				posX = e.clientX - parseInt(dragDiv.css('left'));
				posY = e.clientY - parseInt(dragDiv.css('top'));
				var movefun = function(ev){
					if(ev==null) ev = window.event;
					dragDiv.css('left',(ev.clientX - posX));
					dragDiv.css('top',(ev.clientY - posY));
					return false;
				}
				$(document).mousemove(movefun);
				$(document).mouseup(function(){
					$(document).unbind('mousemove',movefun);
				});

			});

		}

		/*
			调整遮罩层和弹出层的位置
			jqBackDiv:遮罩层的jQuery对象
			jqPopDiv:弹出层的jQuery对象
		*/
		var setDivPox = function(jqBackDiv,jqPopDiv,isScrollEvent)
		{
			// 自动判断当前是否支持W3C标准的
			var bodyObj = document.documentElement;
			// 文档没有DOCTYPE声明，是 HTML文档,否则是XHTML文档
			if(document.compatMode == 'BackCompat'){
				bodyObj = document.body;
			}
			// 设置遮罩层为满屏
			jqBackDiv.width(Math.max(bodyObj.scrollWidth, document.documentElement.clientWidth));
			jqBackDiv.height(Math.max(bodyObj.scrollHeight, document.documentElement.clientHeight));
			// 调整要显示的DIV的位置
			var dleft = bodyObj.clientWidth/2 - jqPopDiv.width()/2;
			var dtop = bodyObj.clientHeight/2 - jqPopDiv.height()/2;
			// 如果是Scroll事件
			if(typeof(isScrollEvent)!= 'undefined' && isScrollEvent){
				dleft += bodyObj.scrollLeft;
				dtop += bodyObj.scrollTop;
			}
			jqPopDiv.css({left:dleft,top:dtop,position:'absolute',zIndex:1001});
		}


		// 弹出一个遮罩层
		var backDivId = this.Configs.backDivId;

		// 如果弹出层不存在则添加
		if($('#'+backDivId).length < 1){
			//--遮罩层追加到 body  //#333
			var divStr = '<div id="'+backDivId+'" style="background-color:'+this.Configs.backDivColor+';filter: Alpha(Opacity=40); -moz-opacity:.1; opacity:0.5;  position:absolute; left:0px;top:0px; z-index:1000"></div>';	
			$(divStr).appendTo('body');
		}

		// 设置位置
		setDivPox($('#'+backDivId),this);

		//将当前jQuery对象保存,在绑定事件中会用到
		var jq = this;
		
		// 动画效果显示出来,调用回调函数
		var callback = function(){
			if(typeof(jq.Configs.callBackFun) == 'function'){
				jq.Configs.callBackFun();
			}
		}
		$('#'+backDivId).show();
		this.Configs.showAnimate ? this.fadeIn("slow",callback) : this.show();


		//绑定关闭事件的DOM
		var ary = this.Configs.closeId.split(',');
		for(var i=0; i<ary.length; ++i){
			$('#'+ary[i]).click(function(){
				jq.popHide();
			});
			//鼠标显示手型
			$('#'+ary[i]).css({cursor:'pointer'});
		}

		//绑定弹出层的移动效果
		if(this.Configs.titleId != ''){
			divDragGable();
		}

		//绑定窗口缩放和滚动事件
		jq.data('resize',function(){
			setDivPox($('#'+backDivId),jq);
		});
		jq.data('scroll',function(){
			setDivPox($('#'+backDivId),jq,true);
		});
		
		$(window).resize(jq.data('resize')); 
		$(window).scroll(jq.data('scroll')); 

	},

	//关闭弹出层
	popHide:function(){
		// 隐藏层
		$('#'+this.Configs.backDivId).hide();
		this.Configs.showAnimate ? this.fadeOut("slow") : this.hide();

		// 取消绑定的事件
		$(window).unbind('resize',this.data('resize'));
		$(window).unbind('scroll',this.data('scroll'));
	}
});
})(jQuery);
