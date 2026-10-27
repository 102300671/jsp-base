<%@page language="java" contentType="text/html;charset=utf-8"%>
<header>
    <div id="logo_main"></div>
</header>
<div id="menu">
    <div id="user">
        <%
            String username = (String) session.getAttribute("username");
            if (username ==null) {
        %>
            <a href="userLogin.jsp">用户登录</a>
        <%} else {%>
            当前用户：<%=username%>|
            <a href="doLogout.jsp">退出登录</a>
        <%}%>
    </div>
    
    <nav>
        <ul>
            <li><a href="#">新闻管理</a></li>|
            <li><a href="#">评论管理</a></li>|
            <li><a href="#">用户管理</a></li>|
            <li><a href="index.jsp">首 页</a></li>
        </ul>
    </nav>
</div>
