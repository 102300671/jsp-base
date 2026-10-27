<%@page contentType="text/html;charset=utf-8" %>
<html>
    <head>
        <title>includeAction</title>
    </head>
    <body>
        <%
            String str=request.getParameter("computer");        //获取值
            int n=Integer.parseInt(str);
            int sum=0;
            for(int i=1;i<=n;i++){
                sum=sum+i;
            }
        %>
        从 1 到<%=n%>的连续和是：<%=sum%>
    </body>
</html>