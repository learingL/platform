<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <%@ include file="/common/global.jsp" %>
    <meta charset="utf-8">
    <base href="<%=basePath%>">
    <title>企巴巴-找回密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="./css/base.css">
    <link rel="stylesheet" href="./plugins/layui/css/layui.css"  media="all">
    <script src="./plugins/layui/layui.js" charset="utf-8"></script>
    <script src="/plugins/yzm/gVerify.js" charset="utf-8"></script>
    <style>
        .reg_css{margin-bottom:35px;}
        .login_title{font-size: 16px;border-bottom: 1px solid #c2c2c2;padding:20px 10px;margin-bottom: 50px;}
        .login_left{width: 590px;border-right: 1px solid #e5e5e5;float: left;}
        .login_left_content{width: 440px;}
        .login_right{text-align: center;}
        .login_right_company{margin:25px 0px;}
        .yzm_but{position: absolute;
            right: 3px;
            top: 3px;
            width: 110px;
            height: 32px;
            border: none;
            background: #f2f2f2;
            color: #333;
            padding: 0;
            line-height: 32px;
            text-align: center;
            cursor: pointer;}
    </style>
</head>
<body>

<jsp:include page="../common/top.jsp"></jsp:include>
<div id="container">

    <div class="content login_title">
        找回密码
    </div>
    <div class="content reg_css">
        <div class="login_left">
            <div class="login_left_content">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">手机号：</label>
                        <div class="layui-input-block">
                            <input type="text" value="" id="phoneNumber" name="mobile" lay-verify="phone" autocomplete="off" placeholder="请输入手机号" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">验证码：</label>
                        <div class="layui-input-inline">
                            <input type="text" value="" id="yzmValue" name="username" lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
                        </div>
                        <div style="width: 129px;height: 35px;float: left;" id="yzm"></div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">短信验证：</label>
                        <div class="layui-input-block">
                            <input type="tel" id="verifyCode" name="msgCode" lay-verify="required" placeholder="请输入短信验证码" autocomplete="off" class="layui-input">
                            <%--<input type="button" id="sendSms" value="免费获取验证码" />--%>
                            <a id="sendSms" class="yzm_but">获取验证码</a>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button type="button" class="layui-btn" lay-submit="" lay-filter="demo1">下一步</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="login_right">
            <div style="height: 40px;"></div>
            <img src="./images/logo_h.png">
            <%--<div class="login_right_company"><span>我是一个企业顾问，我想为用户提供更多的服务</span></div>--%>
            <%--<button class="layui-btn layui-btn-big">商家入驻</button>--%>
        </div>
        <div class="clear"></div>

    </div>

</div>
<jsp:include page="../common/bottom.jsp"></jsp:include>

<script>
    $(function () {

        var verifyCode = new GVerify("yzm");
        layui.use(['form'], function(){
            var form = layui.form()
                    ,layer = layui.layer;

            //自定义验证规则
            form.verify({
                mobile: function(value){
                    if(value.length < 5){
                        return '请输入正确的手机号';
                    }
                }
                ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            });

            //监听提交
            form.on('submit(demo1)', function(data){
                var res = verifyCode.validate($("#yzmValue").val());
                if(!res){
                    layer.msg("验证码错误");
                    return;
                }
                verifySms();
                return false;
            });


            function verifySms() {
                var phoneNumber = $("#phoneNumber").val();
                $.ajax({
                    type: "POST",
                    url: "/retrieveAccount/checkVerifyCode.json",
                    data: {
                        verifyCode:$("#verifyCode").val(),
                        verifyPhone: phoneNumber
                    },
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        if (data.flag) {
                            location.href = "/retrieveAccount/toPassFindUpdate/"+phoneNumber+".html";
                        } else {
                            layer.msg(data.msg);
                        }
                    }
                });
            }

            function sendSmsCode() {
                $.ajax({
                    type: "POST",
                    url: "/retrieveAccount/sendVerificationCode.json",
                    data: {phoneNumber:$("#phoneNumber").val()},
                    dataType: "json",
                    success: function (data) {
                        if (!data.flag) {
                            layer.msg(data.msg);
                            countdown = 0;
                        }
                    }
                });
            }
            var smsClick = true;
            var time=60;//倒计时的秒数
            var countdown = time;
            function setTime($obj) {
                if(countdown == time) {
                    $obj.attr("disabled", true);
                    sendSmsCode();
                }
                if (countdown == 0) {
                    $obj.attr("disabled", false);
                    $obj.html("获取验证码");
                    countdown = time;
                    smsClick = true;
                    return;
                } else {
                    $obj.html("重新发送(" + countdown + ")");
                    countdown--;
                }
                setTimeout(function() {
                    setTime($obj);
                },1000)
            }


            $("#sendSms").click(function () {
                if(!smsClick) {
                    return;
                }
                var phoneNumber = $("#phoneNumber").val();
                if(!phoneNumber){
                    layer.msg("电话号码不能为空");
                    return;
                }
                if(!(/^1[34578]\d{9}$/.test(phoneNumber))){
                    layer.msg("手机号码有误，请重填");
                    return false;
                }
                var code = $("#yzmValue").val();
                if(!code) {
                    layer.msg("请先填写验证码!");
                    return;
                }
                var res = verifyCode.validate(code);
                if(!res){
                    layer.msg("验证码错误!");
                    return;
                }
                smsClick = false;
                setTime($(this));
            });
        });
    });
</script>
</body>
</html>