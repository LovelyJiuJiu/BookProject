
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
        
        $('.suggestion-list li').on('click', function () {
                bkyd.search.keyword_input.val($(this).text());
                bkyd.search.submit();
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
            window.location.href = 'search?keyword=' + bkyd.search.keyword_input.val();
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
				
				// TODO 操作DOM元素
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



(function (bkyd){

    $(document).ready(function () {
        bkyd.search.init();
    });

})(bkyd);
