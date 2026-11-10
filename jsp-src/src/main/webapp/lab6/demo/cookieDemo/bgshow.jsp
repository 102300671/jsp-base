<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>cookieDemo</title>
    </head>
<%
    String bgcolor="";
    StringBuffer str =new StringBuffer();
    Cookie[] cookies=request.getCookies();
    if(cookies!=null){
        for(int i=0;i<cookies.length;i++)
        {
            str.append("<br>cookie"+i+" name:"+cookies[i].getName()
                +", value:" +cookies[i].getValue());
            if("bg".equals(cookies[i].getName()))
            {
                bgcolor=cookies[i].getValue();
            }
        }
    }
%>
<body bgcolor="<%=bgcolor%>">
    <%=str%>
</body>
</html>