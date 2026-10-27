<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>新闻发布系统</title>
    </head>
    <body>
        <h1>用户登录</h1>
        <form method="post" action="doLogin.jsp">
            用户名：<input type="text" name="username"><br>
            密码：<input type="password" name="password"><br>
            <input type="submit" name="submit" value="登录">
        </form>
    </body>
</html>