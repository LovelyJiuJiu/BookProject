
var bkyd = {};

//搜索
bkyd.search = {
    'form': null,
    'keyword_input': null,
    'suggestion_url': function (kw) {
        return 'getSuggestion?keyword=' + kw;
    },
    'init': function () {
        //输入
        this.keyword_input = $('#keyWords');
        this.keyword_input.on({
            'blur focus click': this.change_input_status,
            'input propertychange': this.suggestion
        });
        
        //空白处点击隐藏suggestion
        $(document).on('click', function () {
            $('.suggestion-list').css('visibility', 'hidden');
        });
    },
    'change_input_status': function (e) {
        if ((e.type == 'focus' || e.type == 'click') && bkyd.search.keyword_input.val() != '') {
        	console.log($('.suggestion-list li').length);
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
            window.location.href = bkyd.search.form.attr('action') + '&keyword=' + bkyd.search.keyword_input.val();
        }
    },
    'suggestion': function () {
        var kw = bkyd.search.keyword_input.val();
        console.log(kw);
        if (kw == '') {
        	$('.suggestion-list').css('visibility', 'hidden');
            return;
        }
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
