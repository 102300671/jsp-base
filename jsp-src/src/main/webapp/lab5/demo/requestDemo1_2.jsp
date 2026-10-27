<%@page language="java" contentType="text/html;charset=utf-8"%>
<html>
    <head>
        <title>requestDemo</title>
    </head>
    <body>
        <%
            //接收 text 和 password 类信息
            String name =request.getParameter("username");
            String pwd =request.getParameter("up");
            out.println("用户名： " +name +"<br>");
            out.println("密码： " +pwd +"<br>");

            //接收 select 信息
            out.println("居住地： ");
            out.println(request.getParameter("City"));
            out.println("<br>");

            //接收 checkbox 类信息
            out.println("就业方式：<br>");
            String job[] =request.getParameterValues("JOB");
            if(job !=null) {
                for(int i=0; i<job.length; i++)
                    out.println(job[i] +"<br>");
            }

            //接收 radio 类信息
            out.println("性别： ");
            out.println(request.getParameter("sex"));
            out.println("<br>");

            //处理 textarea 中的信息
            String str=request.getParameter("msg");
            out.println("您的留言是：<br>");
            out.println(str);
        %>
    </body>
</html>