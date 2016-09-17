function popWin(options) {

	$('#popDiv').remove();
	// $(".pop-upLine").remove();
	if ($('#popDiv').length == 0) {

		var width = options.width - 14;// 386

		var height = options.height - 38;// 262
		$("#messageContext").empty();
		$("#messageContext").append(
				'<div id="popDiv"><iframe id="popIframe" frameborder="0" style="width:'
						+ width + 'px;height:' + height
						+ 'px;" ></iframe></div>')
	}

	if (options['top']) {
		$('#popDiv').css('position', options.top)
	}
	
	$('#messageModal').css("z-index", "1500");
	$("#messageModal .modal-title").html(options.title);

	$('#popIframe').attr("src", options.href);

	// options.href = null;
	$('#popDiv').data('onPopClose', options.onPopClose);
	// $('#popDiv').window(options)
	//showWait($("body"));
	$('#messageModal').modal({
		backdrop : "static",
	});
	$('#messageModal').on('hidden.bs.modal', function() {
		$("#messageContext").empty();
	});
}

function closePop(param) {
	$('#popDiv').data('onPopClose')(param);
	// $("#popDiv").find("#closeBtn").trigger("click");
	$("#messageModal").find(".close").trigger("click");
	// $('#popDiv').window('close');
}

openCourtTree = function(path, id, name) {
	var url = path + "/bq/court";
	if (id) {
		url = url + "?id=" + id;
	}
	  
	popWin({
		title:'选择受理法院',
		href:url,
		width:450,
		height:350,
		draggable: false,
		maximizable:false,
		minimizable:false,
		collapsible:false,
		onPopClose:function(param){
			document.getElementById("appellateCourt").value = param.id;
			document.getElementById("appellateCourt1").value = param.name;
			$("#popDiv").find("#closeBtn").trigger("click");

		}
	});
}

/**
 * 普通model 浮动框
 */
function normalModal(modelId, contentId, url, title, style) {
	showWait($("body"));
	if (style) {
		$("#" + modelId).addClass(style);
	}
	if (title) {
		$("#" + modelId + " .modal-title").html(title);
	}
	$("#" + contentId).load(url, function() {
		closeWait($("body"));
	});

	$("#" + modelId).modal({
		backdrop : "static"
	});
	$("#" + modelId).on('hidden.bs.modal', function() {
		$("#" + contentId).empty();
	});
}

/**
 * 
 * @param modelId
 * @param contentId
 * @param url
 * @param title
 */
function errorModal(context) {

	$("#errorContext").html(context);

	$("#errorModal").modal({
		backdrop : "static"
	});
	$("#errorModal").on('hidden.bs.modal', function() {
		$("#errorContext").empty();
	});
}



/**
 * 浮出等待条
 * @param it_ele
 * @param mes
 */
function showWait(it_ele, mes) {
	if (!mes) {
		mes = "努力加载中...";
	}

	if (it_ele) {
		$(it_ele).mask(mes);
	} else {
		$("body").mask(mes);
	}

}

/**
 * 关闭等待条
 * @param it_ele
 */
function closeWait(it_ele) {
	if (it_ele) {
		$(it_ele).unmask();
	} else {
		$("body").unmask();
	}
}

//将form中的值转换为键值对。
function getFormJson(formId) {
    var o = {};
    var a = $("#"+formId).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
}

/**
 * 验证是否是符合标准的手机号码格式
 * @param ele_value
 * @returns {Boolean}
 */
function checkPhone(ele_value) {
	var re = /^((13|15|18|17)\d{9})$/;
	if(re.test(ele_value)) {
		return true;
	} else {
		re = /^([0]\d{2,3})?[-]\d{7,8}([-]\d+)?$/;
		return re.test(ele_value) ;
	}
}



/**
 * 通用保存方法
 * @param url 保存的URL
 * @param form 保存的对象保单元素form
 * @param formId 原查询页面的formId
 */
function goSave(url, form, formId, modalId, cbox) {
	if (modalId) {
		modalId = "#" + modalId;
	} else {
		modalId = "#editModal";
	}
	if (confirm("确认提交吗?")) {
		var ret = true;
		showWait($(modalId));

		$("input,select", $(form)).each(function(i) {
			if ($(this).attr("notnull") && $(this).attr("notnull") == "true") {
				if ($(this).val() == null || $(this).val() == "") {
					alert("*标记不能为空！");
					$(this).focus();
					ret = false;
					closeWait($(modalId));
					return false;
				}
				if (!checkFileType(this)) {
					ret = false;
					closeWait($(modalId));
					return false;
				}
			}
			if (!checkDataType(this)) {
				ret = false;
				closeWait($(modalId));
				return false;
			}
		});

		if(cbox) {
			var arr = cbox.split(":");
			for(i = 0; i < arr.length; i++) {
				if($("input:checked:checkbox[name='" + arr[i] + "']", form).length == 0) {
					alert("*标记不能为空！");
					ret = false;
					closeWait($(modalId));
					return false;
				}
			}
			
		}
		if (ret) {
			/**
			 * 走jquery的ajax提交方式
			 */
			$.ajax({
				url : url,
				data : $(form).serialize(),
				dataType : 'json',
				type : 'post',
				success : function(data, textStatus) {
					if (data.flag) {
						alert("保存成功！");
						$(modalId +" .modal-header .close").click();
						$("#" + formId).find("#search_btn").trigger("click");
					} else {
						if(data.msg != "")
							errorModal(data.msg);
						else
							errorModal("系统卖力响应，但是发生意外。。。");

					}
				},
				error : function(errors, textStatus) {
					if ("timeout" == textStatus) {
						alert("系统请求超时，请联系管理员！");
					} else {
						errorModal("系统发生未知异常！");
					}

				},
				complete : function(XMLHttpRequest, textStatus) {
					closeWait($(modalId));
					this;
				}
			});
		}
	}
}

/**
 * 通用的删除 url 操作的链接 data 参数 message 信息提醒 formId 操作的回调函数的fromId
 */
function goDel(url, data, message, formId) {
	if(message || message == "")
		message = "确认提交吗?";
	if (confirm(message)) {
		showWait($("body"));
		$.ajax({
			url : url,
			data : data,
			dataType : 'json',
			type : 'get',
			success : function(data, textStatus) {
				if (data.flag) {
					alert("删除成功！");
					if (formId) {
						$("#" + formId).find("#search_btn").trigger("click");
	
					} else {
						$("#search_btn").trigger("click");
					}
				} else {
					if(data.msg != "")
						errorModal(data.msg);
					else
						errorModal("系统卖力响应，但是发生意外。。。");
				}
			},
			error : function(errors, textStatus) {
				if ("timeout" == textStatus) {
					alert("系统请求超时，请联系管理员！");
				}
	
			},
			complete : function(XMLHttpRequest, textStatus) {
				closeWait($("body"));
				this;
			}
		});
	}
}

/**
 * 通用的删除 url 操作的链接 data 参数 message 信息提醒 formId 操作的回调函数的fromId
 */
function goDelPost(url, data, message, formId) {
	if(message || message == "")
		message = "确认提交吗?";
	if (confirm(message)) {
		showWait($("body"));
		$.ajax({
			url : url,
			data : data,
			dataType : 'json',
			type : 'post',
			success : function(data, textStatus) {
				if (data.flag) {
					alert("删除成功！");
					if (formId) {
						$("#" + formId).find("#search_btn").trigger("click");
	
					} else {
						$("#search_btn").trigger("click");
					}
				} else {
					if(data.msg != "")
						errorModal(data.msg);
					else
						errorModal("系统卖力响应，但是发生意外。。。");
				}
			},
			error : function(errors, textStatus) {
				if ("timeout" == textStatus) {
					alert("系统请求超时，请联系管理员！");
				}
	
			},
			complete : function(XMLHttpRequest, textStatus) {
				closeWait($("body"));
				this;
			}
		});
	}
}

checkDataType = function(ele) {
	var dataType = $(ele).attr("dataType");
	if (!dataType)
		return true;
	var re;
	if (dataType.toUpperCase() == "EMAIL") {
		re = /^[a-zA-Z_0-9]+@[a-zA-Z_0-9.\-]+$/;
		if (!re.test($(ele).val())) {
			alert("该输入正确的Email地址!");
			$(ele).focus();
			return false;
		} else {
			return true;
		}
	}

	if (dataType.toUpperCase() == "MOBILEPHONE") {
		re = /^((13|15|18)\d{9})$/;
		if (!re.test($(ele).val())) {
			alert("该输入正确的11位移动手机号码!");
			$(ele).focus();
			return false;
		} else {
			return true;
		}
	}

	if (dataType.toUpperCase() == "PHONE") {
		re = /^([0]?\d{2,3})?[-]?\d{5,8}([-]\d+)?$/;
		if (!re.test($(ele).val())) {
			alert("该输入正确的固定电话号码!");
			$(ele).focus();
			return false;
		} else {
			return true;
		}
	}

	if (dataType.toUpperCase() == "ICCID") {
		re = /^((898601)\d{13})$/;
		if (!re.test($(ele).val())) {
			alert("该输入正确的ICCID!");
			$(ele).focus();
			return false;
		} else {
			return true;
		}
	}

	// 数字型
	if (dataType.toUpperCase() == "NUMBER") {
		re = /^(\d+((\.\d+)|(\d*)))$/;
		if (!re.test($(ele).val())) {
			alert("请输入正确的数值(如:1.23)!");
			$(ele).focus();
			return false;
		} else {
			return true;
		}
	}
	// 数字型
	if (dataType.toUpperCase() == "PNUMBER") {
		re = /^[1-9]*[1-9][0-9]*$/;
		if (!re.test($(ele).val())) {
			alert("请输入正确的正整数(如:100)!");
			$(ele).focus();
			return false;
		}
		 else {
				return true;
			}
	}


	if (dataType.toUpperCase() == "FLOAT") {
		re = /^(\d+((\.\d+)|(\d*)))$/;
		if (!re.test($(ele).val())) {
			alert("该输入正确的数值!");
			$(ele).focus();
			return false;
		} else {
			return true;
		}
	}
}

checkFileType = function(ele) {
	var allowFileTypes = $(ele).attr("fileType");
	if (!allowFileTypes)
		return true;
	allowFileTypes = allowFileTypes + ',';
	var fileType = $(ele).val().substr($(ele).val().lastIndexOf('.') + 1,
			$(ele).val().length)
			+ ',';
	if (allowFileTypes.indexOf(fileType) == -1) {
		alert("附件格式不正确！支持的上传格式为：" + allowFileTypes);
		$(ele).focus();
		return false;
	} else {
		return true;
	}
}

switchKeyBoxes = function(eleId, checked, eleName) {
	var theForm = $("#" + eleId);
	$("input:checkbox[name='" + eleName + "']", theForm).attr("checked",
			checked);
}

checkSelect = function(eleName, theFormId) {
	return $("input:checked", $("#" + theFormId)).length;
}

/**
 * 
 * @param url
 * @param form
 * @param formId 处罚的事件ID
 * @param modalId
 * @param cbox
 * @returns {Boolean}
 */
function goSaveComplete(url, form, formId, modalId, cbox) {
	if (modalId) {
		modalId = "#" + modalId;
	} else {
		modalId = "#editModal";
	}
	if (confirm("确认提交吗?")) {
		var ret = true;
		showWait($(modalId));

		$("input,select,textarea", $(form)).each(function(i) {
			if ($(this).attr("notnull") && $(this).attr("notnull") == "true") {
				if ($(this).val() == null || $(this).val() == "") {
					alert("*标记不能为空！");
					$(this).focus();
					ret = false;
					closeWait($(modalId));
					return false;
				}
				if (!checkFileType(this)) {
					ret = false;
					closeWait($(modalId));
					return false;
				}
			}
			if (!checkDataType(this)) {
				ret = false;
				closeWait($(modalId));
				return false;
			}
		});

		if(cbox) {
			var arr = cbox.split(":");
			for(i = 0; i < arr.length; i++) {
				if($("input:checked:checkbox[name='" + arr[i] + "']", form).length == 0) {
					alert("*标记不能为空！");
					ret = false;
					closeWait($(modalId));
					return false;
				}
			}
			
		}
		if (ret) {
			/**
			 * 走jquery的ajax提交方式
			 */
			$.ajax({
				url : url,
				data : $(form).serialize(),
				dataType : 'json',
				type : 'post',
				success : function(data, textStatus) {
					if (data.flag) {
						alert("保存成功！");
						$(modalId +" .modal-header .close").click();
						$("#" + formId).trigger("click");
					} else {
						if(data.msg != "")
							errorModal(data.msg);
						else
							errorModal("系统卖力响应，但是发生意外。。。");

					}
				},
				error : function(errors, textStatus) {
					if ("timeout" == textStatus) {
						errorModal("系统请求超时，请联系管理员！");
					} else {
						errorModal("系统发生未知异常！");
					}

				},
				complete : function(XMLHttpRequest, textStatus) {
					closeWait($(modalId));
					this;
				}
			});
		}
	}
}

function goNormal(url, data, message, formId) {
	if(message) {
		if (confirm(message)) {
			showWait($("body"));
			$.ajax({
				url : url,
				data : data,
				dataType : 'json',
				type : 'get',
				success : function(data, textStatus) {
					if (data.flag) {
						if (formId) {
							$("#" + formId).find("#search_btn").trigger("click");
		
						} else {
							$("#search_btn").trigger("click");
						}
					} else {
						if(data.msg != "")
							errorModal(data.msg);
						else
							errorModal("系统卖力响应，但是发生意外。。。");
					}
				},
				error : function(errors, textStatus) {
					if ("timeout" == textStatus) {
						alert("系统请求超时，请联系管理员！");
					}
		
				},
				complete : function(XMLHttpRequest, textStatus) {
					closeWait($("body"));
					this;
				}
			});
		}
	} else {
		showWait($("body"));
		$.ajax({
			url : url,
			data : data,
			dataType : 'json',
			type : 'get',
			success : function(data, textStatus) {
				if (data.flag) {
					if (formId) {
						$("#" + formId).find("#search_btn").trigger("click");
	
					} else {
						$("#search_btn").trigger("click");
					}
				} else {
					if(data.msg != "")
						errorModal(data.msg);
					else
						errorModal("系统卖力响应，但是发生意外。。。");
				}
			},
			error : function(errors, textStatus) {
				if ("timeout" == textStatus) {
					alert("系统请求超时，请联系管理员！");
				}
	
			},
			complete : function(XMLHttpRequest, textStatus) {
				closeWait($("body"));
				this;
			}
		});
	}
}