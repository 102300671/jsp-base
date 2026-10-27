<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>responseDemo</title>
    </head>
    <body>
        <table border="1">
            <tr bgcolor="#E6E6E6">
                <th width="364" height="27">图书名称</th>
                <th width="150">出版社</th>
                <th width="140">定价</th>
            </tr>
            <tr align="center" height="25">
                <td>ASP.NET 网络编程</td>
                <td>清华大学出版社</td>
                <td>￥128 元</td>
            </tr>
            <tr align="center" height="25">
                <td>JavaWeb 应用开发</td>
                <td>清华大学出版社</td>
                <td>￥142 元</td>
            </tr>
            <tr align="center" height="25">
                <td>C++ 基础教程</td>
                <td>清华大学出版社</td>
                <td>￥162 元</td>
            </tr>
        </table>
        <h3>最近浏览过的图书</h3>
        <form action="responseDemo1.jsp" method="get" name="form1">
            【选项】将文档保存为以下哪个格式？<br>
            <input name="t" type="radio" value="text/plain"
                ID="Radio1">文本文件
            <input name="t" type="radio" value="application/x-msexcel"
                ID="Radio2">Office Excel 文件
            <input name="t" type="radio" value="application/msword"
                ID="Radio3">Office Word 文件
            <input type="submit" name="Submit" value="保存" ID="Submit1">
        </form>
        <%
            String doctype=request.getParameter("t");
            if (doctype !=null){
                response.setContentType(doctype);
            }
        %>
    </body>
</html>