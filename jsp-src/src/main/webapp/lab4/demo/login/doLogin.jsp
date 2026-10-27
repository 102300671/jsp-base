<%@page language="java" contentType="text/html;charset=utf-8"%>
<%
    String name =request.getParameter("username");
    String pwd =request.getParameter("password");

    if ("tom".equals(name) && "123".equals(pwd)) {
%>
    <jsp:forward page="index.jsp">
        <jsp:param name="username" value="<%=name%>"/>
    </jsp:forward>
<%}else{%>
    <jsp:forward page="login.jsp"/>
<%}%>