<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>cookieDemo</title>
    </head>
    <body><h3>
        <form action="bgset.jsp" method="post" >
            背景色<input type="text" name="bgcolor" >
            <input type="submit" value="提交">
        </form>
        <%
            String str=request.getParameter("bgcolor");
            if(!"".equals(str)){
                Cookie c=new Cookie("bg",str);
                response.addCookie(c);
            }
        %>
        <a href="bgshow.jsp">cookieshow.jsp</a>
    </body>
</html>