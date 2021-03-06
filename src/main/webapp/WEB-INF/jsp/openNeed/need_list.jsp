<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>企巴巴-一站式商业服务平台</title>
    <link rel="stylesheet" type="text/css" href="css/base.css">
    <link rel="stylesheet" href="./plugins/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <style>
        .search-select{border:1px solid #eee;}
        .search-select li{margin: 15px;border-bottom: 1px solid #eee;padding-bottom: 20px;}
        .search-select h3{width:100px;height: 30px;line-height: 30px;display:block;float: left;}
        .allSelect{background-color:#ee4134;color: #FFF;display:block;}
        .selectSpan span{float: left;display: inline-block;min-width: 60px;height: 30px;line-height:30px;text-align: center;margin-right: 10px;}
        .adviser-list-info span{font-size:22px;margin-right: 20px;}
        .adviser-list-info p{line-height: 35px;height: 35px;}
        .adviser-list-href a{border: 2px solid #ee4134;padding: 10px 30px;color:#ee4134;}

        .need_mainli{margin-top: 10px;}
        .need_mainli tr{height:80px;}
        .layui-table[lay-skin=line] td, .layui-table[lay-skin=line] th{border-bottom:1px dashed #e2e2e2;}
        .adviser_right_tj{width:90px;height:90px;border-radius: 50%;border: 7px solid rgba(255,255,255,.2);overflow: hidden;float: left;}
        .adviser_right_tj img{width:90px;}
        .adviser_right_tjperson{float:left;height: 90px;line-height: 90px;}
        .adviser_right_tjperson p{height:30px;line-height: 30px;}
        .adviser_right_tj_personwork{text-align: left;border-bottom: 1px solid #eee;margin-bottom: 20px;}
        .adviser_right_tj_personwork p{height:30px;line-height: 30px;padding-left:10px;}
        .adviser_tj_title{height: 35px;line-height: 35px;}
        .head-update-img img{width: 100%;border: 0 none;vertical-align: middle;max-width: 100%;}
        .head-update-ewm>i{display: inline-block;
            width: 17px;
            height: 17px;
            background: url(../images/counselor-details/update/update-icon.png) no-repeat 0 0;}
        .head-update-ewm .ewm{position: absolute;
            width: 92px;
            height: 92px;
            top: -94px;
            left: 49px;
            display: none;}
        .head-update-middle .til{margin-bottom: 20px;}
        .head-update-middle>div {
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            font-size: 12px;
            margin-bottom: 14px;
            line-height: 1;
        }
        .recently-handled p{font-size: 12px;    padding-bottom: 5px;}
        .head-update-middle .recently-banli>p{    color: #999;
            margin-bottom: 8px;}
        .head-update-middle .til .c-name {
            font-size: 24px;
            font-weight: bold;
        }
        .head-update-middle .sub-til {
            color: white;
            font-size: 12px;
        }
        .head-update-middle ul li.li-border {
            border-left: 1px dashed rgba(255,255,255,.2);
            width: 0;
            height: 35px;
            margin: 0 30px;
        }
        .head-update-middle ul li {
            display: inline-block;
            vertical-align: middle;
            text-align: center;
        }
        .head-update-middle ul li p {
            color: white;
            font-size: 24px;
            margin-bottom: 5px;
            line-height: 1;
        }
        .head-update-right .tel-num {
            color: #3fbff0;
            font-size: 28px;
            font-weight: bold;
            padding: 5px 0;
        }
        .head-update-right a.btn-free {
            background-color: #3fbff0;
            border: 1px solid #3fbff0;
        }
        .head-update-right a.btn-online {
            border: 1px solid white;
        }
        .head-update-right a {
            display: block;
            width: 208px;
            height: 38px;
            border-radius: 2px;
            color: white;
            text-align: center;
            line-height: 38px;
            margin-bottom: 20px;
        }
        .head-update-middle ul li b {
            color: #999;
            font-size: 12px;
        }

        .adviser_left{width: 935px;margin-right:5px;float: left;}
        .adviser_right{width:240px; text-align: center; float: left;background: url("images/order-adviser.jpg") no-repeat;}
        .order-form{border:1px solid #eee;border-top:0px;text-align: center;margin-top: 105px;}
    </style>
</head>
<body>
<jsp:include page="../common/top.jsp"></jsp:include>

<div id="container">
    <div class="position2">
        您当前位置：<a href="/index.html">企巴巴</a> &gt;&gt;
        <a href="javascript:void(0);" class="defaultCursor">找需求</a>
    </div>


    <div class="content">

        <div class="adviser_left">

            <div class="search-select">
                <ul id="searchUl">
                    <li>
                        <h3>服务区域：</h3>
                        <div class="selectSpan" id="areaSearch">
                            <span><a class="allSelect" href="javascript:void(0);">全部</a></span>
                            <span><a href="javascript:void(0);" code="4-" >上海</a></span>
                            <span><a href="javascript:void(0);" code="1-">北京</a></span>
                            <span><a href="javascript:void(0);" code="8-">天津</a></span>
                            <input type="hidden" id="areaVal">
                        </div>
                        <div class="clear"></div>
                    </li>
                    <div id="categorySearch">
                        <input type="hidden" id="categoryVal" value="${categoryCode}">
                        <div id="oneLevelCategory">
                            <li  style="border: 0px;">
                                <h3>业务类别：</h3>
                                <div class="selectSpan">
                                    <span><a class="allSelect" href="javascript:void(0);">全部</a></span>
                                    <c:forEach items="${oneLevelCategories}" var="category">
                                        <span><a href="javascript:void(0);" level="${category.level}"  categoryId ="${category.id}" code="${category.code}">${category.name}</a></span>
                                    </c:forEach>
                                </div>
                                <div class="clear"></div>
                            </li>
                        </div>
                        <div id="twoLevelCategory">
                            <li  style="border: 0px;">
                                <h3></h3>
                                <div class="selectSpan">
                                    <c:forEach items="${twoLevelCategories}" var="category">
                                        <span><a href="javascript:void(0);"  level="${category.level}"   categoryId ="${category.id}" code="${category.code}">${category.name}</a></span>
                                    </c:forEach>
                                </div>
                                <div class="clear"></div>
                            </li>
                        </div>
                        <div id="threeLevelCategory">
                            <li  style="border: 0px;">
                                <h3></h3>
                                <div class="selectSpan">
                                    <c:forEach items="${threeLevelCategories}" var="category">
                                        <span><a href="javascript:void(0);" level="${category.level}"    categoryId ="${category.id}" code="${category.code}">${category.name}</a></span>
                                    </c:forEach>
                                </div>
                                <div class="clear"></div>
                            </li>
                        </div>
                    </div>
                </ul>
            </div>

            <div class="need_mainli">
                <div class="layui-form" id="dataMsg">



                </div>
                <div id="pager"></div>
            </div>

        </div>
        <div class="adviser_right">

            <jsp:include page="need_form.jsp"></jsp:include>
            <%--plate 顾问推荐板块 101首页，201列表，1通用--%>
            <jsp:include page="/adviserRecommend/recommend.html">
                <jsp:param value="201" name="plate"/>
                <jsp:param value="1" name="currentPage"/>
                <jsp:param value="3" name="pageSize"/>
            </jsp:include>
        </div>
        <div class="clear"></div>
    </div>
</div>

<jsp:include page="../common/bottom.jsp"></jsp:include>


<script>

    $(function () {
        //搜索框设置---------------------
        var keyword = "${keyword}";
        $("#keyword").val(keyword);
        var searchType = $("a[name='searchType']");
        searchType.removeClass("selectType");
        searchType.eq(1).addClass("selectType");
        //分页--------------------
        layui.use(['laypage', 'layer'], function(){
            var laypage = layui.laypage
                ,layer = layui.layer;
            //以下将以jquery.ajax为例，演示一个异步分页
            var pageSize = 5;
            function paging(curr){
                $.ajax({
                    type: "POST",
                    url: "/need/page.html",
                    data: {
                        keyword:$("#keyword").val(),
                        areaCode:$("#areaVal").val(),
                        classCode:$("#categoryVal").val(),
                        currentPage :curr || 1,
                        pageSize : pageSize
                    },
                    success: function(data){
                        $("#dataMsg").html(data);
                        var totalPages = $("#totalPages").val();
                        //显示分页
                        laypage({
                            cont: 'pager', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
                            pages: totalPages, //通过后台拿到的总页数
                            curr: curr || 1, //当前页
                            groups: 5 ,//连续显示分页数
                            jump: function(obj, first){ //触发分页后的回调
                                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
                                    paging(obj.curr);
                                }
                            }
                        });
                    }
                });
            };
            //运行
            paging();
            function selectStyle(thisObj) {
                thisObj.parents("div").eq(1).find("a").removeClass("allSelect");
                thisObj.addClass("allSelect");
            }
            $("#categorySearch").on("click","a",function () {
                var thisObj = $(this);
                selectStyle(thisObj);
                $("#categoryVal").val(thisObj.attr("code"));
                var categoryId = thisObj.attr("categoryId");
                getSonCategory(categoryId);
                paging();
            });
            function getSonCategory(categoryId) {
                var $twoLevelCategory = $("#twoLevelCategory");
                var $threeLevelCategory = $("#threeLevelCategory");
                if(categoryId) {
                    $.ajax({
                        type: "POST",
                        url: "/category/getSonCategory.json",
                        data: {
                            parentId:categoryId
                        },
                        success: function(data){
                            if(data && data.categorys  && data.categorys.length) {
                                var categorys = data.categorys;
                                var _li = '<li style="border: none;"><h3></h3><div class="selectSpan">';
                                categorys.forEach(function (item) {
                                    _li += '<span><a href="javascript:void(0);" categoryId = "'+item.id+'" code = "'+item.code+'"> '+item.name+'</a></span>';
                                });
                                _li += '<div class="clear"></div></div></li>';

                                if(categorys[0].level == 2) {
                                    $twoLevelCategory.html(_li);
                                    $threeLevelCategory.html("");
                                }
                                if(categorys[0].level == 3) {
                                    $threeLevelCategory.html(_li);
                                }
                            }else{
                                var level = $("a[categoryId='" + categoryId + "']").attr("level");
                                if(level == 1) {
                                    $twoLevelCategory.html("");
                                    $threeLevelCategory.html("");
                                }
                                if(level == 2) {
                                    $threeLevelCategory.html("");
                                }
                            }
                        }
                    });
                }else{
                    $twoLevelCategory.html("");
                    $threeLevelCategory.html("");
                }
            }

            $("#areaSearch a").click(function () {
                var thisObj = $(this);
                $("#areaSearch a").removeClass("allSelect");
                thisObj.addClass("allSelect");
                $("#areaVal").val(thisObj.attr("code"));
                paging();
            });



            //类目选中定位-----------------
            var categoryCode = "${categoryCode}";
            if(categoryCode) {
                $("#categorySearch a").removeClass("allSelect");
                var codes = categoryCode.split("-");
                var code;
                if(codes.length > 1 ) {
                    selectStyle($("#categorySearch a[code='" + codes[0] + "-']"));
                }
                if(codes.length > 2) {
                    code =  codes[0] + "-" + codes[1];
                    selectStyle($("#categorySearch a[code='" + code + "-']"));
                }
                if(codes.length > 3) {
                    code =  codes[0] + "-" + codes[1]+ "-" + codes[2];
                    selectStyle($("#categorySearch a[code='" + code + "-']"));
                }
            }
        });

    });


</script>
</body>
</html>