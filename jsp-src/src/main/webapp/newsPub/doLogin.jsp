<%@page language="java" contentType="text/html;charset=utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
    String name =request.getParameter("username");
    String pwd =request.getParameter("password");
    if("tom".equals(name) && "123".equals(pwd)) {
        session.setAttribute("username",name);
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("userLogin.jsp");
    }
%>
