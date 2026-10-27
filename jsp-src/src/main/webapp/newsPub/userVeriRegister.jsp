<%@page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>新闻发布系统 V3</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
    <jsp:include page="common/top.jsp" />
    <div id="content">
        <aside>
            <jsp:include page="common/left.jsp" />
        </aside>
        <main>
        <!--main begin -->
            <section class="inputform">
                <div class="top-bar">
                    <h1>注册确认</h1>
                </div>
                <%
                    request.setCharacterEncoding("utf-8");
                    String uName =request.getParameter("username");
                    String uPwd =request.getParameter("password");
                    String uGender =request.getParameter("gender");
                    String uResume =request.getParameter("resume");
                %>
                <table>
                    <tr>
                        <td>用户名：</td><td><%=uName %></td>
                    </tr>
                    <tr>
                        <td>密码：</td><td><%=uPwd %></td>
                    </tr>
                    <tr>
                        <td>性别：</td><td><%=uGender %></td>
                    </tr>
                    <tr>
                        <td>个人简介：</td><td><%=uResume %></td>
                    </tr>
                </table>
            </section>
        <!--main end -->
        </main>
        <div class="blank20"></div>
        <div class="blank10"></div>
    </div>
    <%@ include file="common/bottom.txt"%>
</body>
</html>