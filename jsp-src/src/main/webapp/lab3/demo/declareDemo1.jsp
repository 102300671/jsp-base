<%@ page contentType="text/html;charset=utf-8" %>
<html>
  <head>
    <title>declareDemo1</title>
  </head>
  <body>
    <H3>
    <%! int number=0; %>
    <%
      int localNumber = 0;
      localNumber++;
      synchronized(this){
        number++;
      }
    %>
    您是第
    <% out.println(number); %>
    个访问本页面的客户，局部变量值是
    <% out.println(localNumber); %>
    </H3>
  </body>
</html>