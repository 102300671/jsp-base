<%@page language="java" contentType="text/html;charset=utf-8" %>
<html>
    <head>
        <title>expressionDemo</title>
    </head>
    <body>
    <h1>九九乘法表</h1>
    <table>
    <% for (int i=1;i<=9;i++) { %>
        <tr>
        <% for (int j=1;j<=i;j++) { %>
            <td><%=i%> * <%=j%>=<%=i * j%></td>
        <% } %>
        </tr>
    <% } %>
    </table>
    </body>
</html>