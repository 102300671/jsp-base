<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<head>
  <title>信息</title>
</head>
<body>
  <h1>信息</h1>
  <%= "202407044130吕林涵" %><br>
  <%
    SimpleDateFormat df = new SimpleDateFormat("yyyy-M-d HH:mm:ss");
  %>
  <span id="myspan"><%= df.format(new Date()) %></span>
  <hr>
</body>
</html>
