<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*" %>
<html>
    <head>
        <title>responseDemo</title>
    </head>
    <body>
        <h1>5 秒后自动跳转到 responseDemo1 页面</h1>
        <%response.setHeader("refresh","5;url=responseDemo1.jsp");%>
    </body>
</html>