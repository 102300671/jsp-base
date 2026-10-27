<%@page contentType="text/html;charset=utf-8" %>
<html>
    <head>
        <title>includeAction</title>
    </head>
    <body>
        <P>
            加载文件效果：
            <jsp:include page="includeDemo2_2.jsp">
                <jsp:param name="computer" value="300" />
            </jsp:include>
        </P>
    </body>
</html>