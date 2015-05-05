 function queryKuaidi(id){
	 var no = $("#"+id).val();
	 if(no=="" ||no.length==0){
		 return ;
	 }
		 $.ajax({ 
	         url:"queryKuaidi.do?no="+no, 
	         type:'GET', 
	         dataType:'JSON', 
	         success: function(data){ 
	        	 var resultJson = eval("(" + data + ")");
	             gResultJson = resultJson;
	             gQueryResult = resultJson.status;
	             if (resultJson.status == 200) {
	                 var resultData = resultJson.data;
	                 gResultData = resultData;
	                 gIsCheck = resultJson.ischeck;
	                 var resultTable2 = $("#queryResult2");
	                 resultTable2.empty();
	                 for (var i = resultData.length - 1; i >= 0; i--) {
	                     var className = "";
	                     if (resultData.length == 1 && gIsCheck == 0) {
	                         className = "status status-wait"
	                     } else {
	                         if (resultData.length == 1 && gIsCheck == 1) {
	                             className = "status status-check"
	                         } else {
	                             if (i == 0 && gIsCheck == 0) {
	                                 className = "status status-wait"
	                             } else {
	                                 if (i == 0 && gIsCheck == 1) {
	                                     className = "status status-check"
	                                 } else {
	                                     if (i == resultData.length - 1) {
	                                         className = "status status-first"
	                                     } else {
	                                         className = "status"
	                                     }
	                                 }
	                             }
	                         }
	                     }
	                     var context = resultData[i].context;
	                     //context = getJumpNetContext(context, gCompanyCode, "fonter1");
	                    // context = getTelContext(context);
	                     if (i == 0) {
	                         resultTable2.append('<tr class="last"><td class="row1">' + resultData[i].ftime + '</td><td class="' + className + '">&nbsp;</td><td>' + context + "</td></tr>")
	                     } else {
	                         resultTable2.append('<tr><td class="row1">' + resultData[i].ftime + '</td><td class="' + className + '">&nbsp;</td><td>' + context + "</td></tr>")
	                     }
	                 }
	                var psDialog = $("#queryContext");
	     	        var dialogOpts = {
	     	            autoOpen: false,
	     	            width: 650,
	     	            height: 500,
	     	            modal: true,
	     	            overlay: {
	     	                backgroundColor: '#000',
	     	                opacity: 0.5
	     	            }
	     	        };
	     	        $("#queryContext").dialog(dialogOpts);
	  	            psDialog.dialog('open');
	             } 
	         }
	     }); 
	 }