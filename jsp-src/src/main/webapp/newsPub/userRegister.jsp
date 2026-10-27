<%@page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>新闻发布系统 V3</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
    <jsp:include page="common/top.jsp" />
    <div id="content">
        <aside>
            <jsp:include page="common/left.jsp" />
        </aside>
        <main>
        <!--main begin -->
            <section class="inputform">
                <div class="top-bar">
                    <h1>用户注册</h1>
                </div>
                <br/>
                <form action="userVeriRegister.jsp" method="post">
                    用户名：<input type="text" name="username"></input><br/>
                    密码：<input type="password" name="password"></input><br/>
                    <br/>
                    性别：男<input type="radio" value="male" name="gender">
                    女<input type="radio" value="female" name="gender"><br/>
                    个人简介<textarea name="resume" cols="12" rows="6"></textarea>
                    <br/><input type="submit" value="提交"></input><br/>
                </form>
            </section>
        <!--main end -->
        </main>
        <div class="blank20"></div>
        <div class="blank10"></div>
    </div>
    <%@ include file="common/bottom.txt"%>
</body>
</html>