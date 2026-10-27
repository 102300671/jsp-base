<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>新闻发布系统</title>
    </head>
    <body>
        <h1>系统首页</h1>
        <%
            String name =request.getParameter("username");
            if (name ==null) {
        %>
            请单击<a href="login.jsp">登录</a>
        <%  }else{%>
            用户<%=name%>已登录
        <%  }%>
    </body>
</html>