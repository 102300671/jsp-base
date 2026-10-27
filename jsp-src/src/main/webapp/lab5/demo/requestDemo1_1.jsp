<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>requestDemo</title>
    </head>
    <body>
        <form method="post" action="requestDemo1_2.jsp">
            用户名：<input type="text" name="username"><br>
            密码：<input type="password" name="up">
            <p>居住地：
            <select name="City" >
                <option value="BeiJing">北京市</option>
                <option value="ShangHai">上海市</option>
                <option value="TianJin">天津市</option>
            </select></p>
            <p>就业方式：
            <input type="checkbox" name="JOB" value="training">通过培训
            <input type="checkbox" name="JOB" value="recommend">通过推荐
            <input type="checkbox" name="JOB" value="selfstudy">通过自学<br>
            <p>性别：
            <input Type="Radio" Name="sex" Value="male" Checked>男
            <input Type="Radio" Name="sex" Value="female">女
            </p>
            <p>留言：</p>
            <p><textarea name="msg" rows="4" cols="60"></textarea></p>
            <input type="submit" name="submit" value="提交">
        </form>
    </body>
</html>