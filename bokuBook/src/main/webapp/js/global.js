
var bkyd = {};

//搜索
bkyd.search = {
    'keyword_input': null,
    'init': function () {
        //输入
        this.keyword_input = $('#keyWords');
        this.keyword_input.on({
            'blur focus click': this.change_input_status,
            'input propertychange': this.suggestion,
            'keypress': function (e) {
            	if (e.keyCode === 13) {
            		bkyd.search.submit();
            	}
            }
        });
        
        $(document).on('click', function () {
        	$('.suggestion-list').css('visibility', 'hidden');
        });
        
        $('.search-btn').on('click', this.submit);
        
    },
    'change_input_status': function (e) {
        if ((e.type == 'focus' || e.type == 'click') && bkyd.search.keyword_input.val() != '') {
            if ($('.suggestion-list li').length > 0) {
            	$('.suggestion-list').css('visibility', 'visible');
                e.stopPropagation();
            } else {
                bkyd.search.suggestion();
                e.stopPropagation();
            }
        }
    },
    'submit': function () {
        if (bkyd.search.keyword_input.val() != '') {
            window.location.href = '/book/search?keyword=' + bkyd.search.keyword_input.val();
        }
    },
    'suggestion': function () {
        var kw = bkyd.search.keyword_input.val();
        console.log(kw);
        if (kw == '') {
        	$('.suggestion-list').css('visibility', 'hidden');
            return;
        }
        
        // 异步获取suggestion
        $.ajax({
			url : 'getSuggestion',
			async : true,
			type : 'POST',
			dataType : 'json',
			data : {
				keyWords: kw
			},
			success : function(data) {
				console.log(data);
				$('.suggestion-list ul').html("");
				if (data.length > 0) {
					data.forEach(function (bookItem, index) {
						$('.suggestion-list ul').append("<li><a class='list-item' href='javascript:void(0)' " +
								"hidefocus='hidefocus'><span>" + bookItem.bookname + "</span></a></li>");
					});
					
					$('.suggestion-list').css('visibility', 'visible');
					$('.suggestion-list li').on('click', function () {
		                bkyd.search.keyword_input.val($(this).text());
		                bkyd.search.submit();
					});
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
        /*$.get(bkyd.search.suggestion_url(encodeURIComponent(kw)), function (ret) {
            if (ret.keywords) {
                if (bkyd.search.keyword_input.val() == kw) {
                    $("#search_suggestion_box").html(ret.keywords).show();
                    $("#search_suggestion_box li").on({
                        'click': function () {
                            bkyd.search.keyword_input.val($(this).text());
                            bkyd.search.form.submit();
                        }
                    });
                }
            }
        });*/
    }
};
//搜索end

bkyd.btn_back_top = {
	    'content_width': 1000,
	    'init': function () {
	        var btn = $('.scroll-top');
	        var self = this;
	        $(window).on({
	            'resize': function () {
	                btn.css('left', self.getLeft());
	            },
	            'scroll': function () {
	                var top = $(window).scrollTop();
	                if (top > 0) {
	                    btn.css('left', self.getLeft());
	                    self.btnShow();
	                } else {
	                    self.btnHide();
	                }
	            }
	        });
	        btn.on('click', function () {
	            $('body, html').animate({scrollTop: 0}, 200);
	        });
	    },
	    'getLeft': function () {
	        var b_width = $(window).width();
	        return (b_width + this.content_width)/2 + 20;
	    },
	    'btnHide': function () {
	        $('.scroll-top').stop(false, true).fadeOut(300);
	    },
	    'btnShow': function () {
	        $('.scroll-top').fadeIn(300);
	    }
};

function logout() {
	$.ajax({
		url : 'user/logout',
		async : true,
		type : 'POST',
		dataType : 'json',
		success : function(data) {
			if (data.result === 1) {
				window.location.href = "bookMain";
			} else if (data.result === 0) {
				layer.msg("服务器错误");
			} else {
				layer.msg("拜托..  你还没有登录 (￣□￣；)");
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
}

function getContextPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0,index+1);
    return result;
}

(function (bkyd){

    $(document).ready(function () {
    	layui.use('element', function(){
    		var element = layui.element;
    	});
    	
    	$('#currentUser').on({
    		'mouseover': function () {
        		$('.current-user-list').css('visibility', 'visible');
        	}
    	});
    	
    	$('.current-user-list').on({
    		'mouseover': function () {
        		$('.current-user-list').css('visibility', 'visible');
        	},
    		'mouseout': function () {
        		$('.current-user-list').css('visibility', 'hidden');
        	}
    	});
    	
    	$('#userLogout').on('click', function () {
    		logout();
    	});
    	
    	$('#editUserInfo').on('click', function () {
    		window.location.href= getContextPath() +"/user/editUserInfo";
    	});
    	

    	
        bkyd.search.init();
        
        bkyd.btn_back_top.init();
    });

})(bkyd);
