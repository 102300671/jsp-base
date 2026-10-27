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
                <form action="doLogin.jsp" method="post" >
                <input type="text" name="username" placeholder="用户名"
                required="required" /><br><br>
                <input type="password" name="password" placeholder="登录密码">
                <br><br>
                <input type="submit" value="登录"></input>
                <a href="userRegister.jsp">用户注册</a><br>
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