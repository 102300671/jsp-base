<%@page language="java" contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*" %>
<html>
    <head>
        <title>requestDemo2</title>
    </head>
    <body>
        <%
            String cur_name="";
            Enumeration params=request.getHeaderNames();
            out.println("请求报文头:<br>");
            while(params.hasMoreElements()){
                cur_name=(String)params.nextElement();
                out.println(cur_name+"="+request.getHeader(cur_name)
                +"<br>");
            }

            out.println("请求协议:" +request.getProtocol()+"<br>");
            out.println("请求方法:" +request.getMethod()+"<br>");
            out.println("客户端提交信息的页面:" +request.getServletPath()
                +"<br>");
            out.println("客户端的 IP 地址:" +request.getRemoteAddr()+"<br>");
            out.println("客户端的名称:" +request.getRemoteHost()+"<br>");
            out.println("服务器的名称:" +request.getServerName()+"<br>");
            out.println("服务器的端口:" +request.getServerPort()+"<br>");
            out.println("上下文路径:" +request.getContextPath()+"<br>");
            out.println("请求 URI:" +request.getRequestURI()+"<br>");
        %>
    </body>
</html>