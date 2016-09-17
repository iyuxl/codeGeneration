/*
 * select组件
 * url:默认提交到后台的地址
 * dict：要查询的关键字
 * init: 是否使用ajax初始化select的options
 * nullText:一个空值option的显示名称
 * requestText:加载时显示的字符串
 * linkSelect：下级select的jquery对象
 * filter：字典查询条件       未实现
 * exculdeCode：要排除的code    未实现
 * defaultValue：默认的value，优先级低于exculdeCode和limitCode   未实现
 * limitCode：如果定义，则只显示这其中的code，优先级低于exculdeCode    未实现
 * 
 * url 可以不填写，当获取的源非VIEW_CACHE时，可以人工传入，但是JSON返回属性需要类似ViewCache.JAVA;
 * 当需要级联时，子下拉框初始化时，parentValue传入brysj,如下
 *$("#userStatus").selectBDX({dict:'X', linkSelect:'userStatus2'}); 
 *$("#userStatus2").selectBDX({url:'$CONTEXT_PATH/cache.json',
 *							dict:'XX', parentValue:'brysj'}); 
 *<select name="userStatus" id="userStatus" class="d_input" ></select><select name="userStatus2" dict="XX" id="userStatus2" class="d_input"></select>
 *$("#userStatus").selectBDX({dict:'X', linkSelect:'userStatus2'}); $("#userStatus2").selectBDX({url:'$CONTEXT_PATH/cache.json',dict:'XX', parentValue:'brysj'}); 
 */

(function(factory) {
	if (typeof define === 'function' && define.amd) {
		define([ 'jquery' ], factory);
	} else {
		factory(jQuery);
	}
	;
}
		(function($) {
			
			$.fn.selectBDX = function(options) {
		        var opts = $.extend({}, $.fn.selectBDX.defaults, options);

				this.each(function(i) {
					$.bdxSelect($(this), opts);
				});
				return this;
			};
			
			$.fn.selectBDX.defaults = {
			        url: base + "/cache.json",
			        dict: "",
			        init: true,
			        nullText: "请选择",
					requestText: "加载中...",
					linkSelect: "",
					linkSubSelect: "",
					parentValue: "",
					filter: "",
					exculdeCode: "",
					defaultValue: ""   
			};
			
			$.bdxSelect = function(element, settings) {
				if (settings.init) {
					element.html('<option value="">' + settings.requestText + '</option>');
					$.getJSON(settings.url, {dict:settings.dict, pValue:settings.parentValue}, function(json){
						var _html = $.buildContent(json);
						if (settings.nullText != null) {
							_html = '<option value="">' + settings.nullText + '</option>' + _html;
						} 
						element.html(_html);
						if (settings.defaultValue != "") {
							$(element).val(settings.defaultValue);
						}
						settings.init = false;
						if(settings.linkSelect != "") {
							$(element).bind('change', function(event) {
								$.nextSelect(element, settings);
							});
						}
					});
					
				}
			};
					
			$.nextSelect = function(element, settings) {
				var nextElement;
				if(settings.linkSelect != "") {
					//settings.linkSelect
					nextElement = $("#" + $(element).attr("linkSelect"));
				}
				if($(element).val() == "") {
					if(nextElement) {
						if ($(nextElement).attr("nullText") != null) {
							$(nextElement).html('<option value="">' + $(nextElement).attr("nullText") + '</option>');
						} else {
							$(nextElement).html('<option value="">请选择</option>');
						}
					}
				} else {
					//$(nextElement).trigger("change");
					var jsonUrl = $(element).attr("url");
					if(!jsonUrl) {
						jsonUrl = settings.url;
					}
					$.getJSON(jsonUrl, {dict:$(nextElement).attr("dict"), pValue:$(element).val()}, function(json){
						var _html = $.buildContent(json);
						if ($(nextElement).attr("nullText") != null) {
							_html = '<option value="">' + $(nextElement).attr("nullText") + '</option>' + _html;
						} else {
							_html = '<option value="">请选择</option>' + _html;

						}
						nextElement.html(_html);
					});
				}
			};
			
			
			
			$.buildContent = function(data) {
				var _html = '';
				$.each(data, function(i, v){
					_html += '<option value="'+v.vvalue+'">' + v.vdesc + '</option>';
				});
				return _html;
			};
			
		}));