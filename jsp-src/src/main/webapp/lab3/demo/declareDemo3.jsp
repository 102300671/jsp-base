<%@page contentType="text/html;charset=utf-8" %>
<html>
    <head>
        <title>declareDemo3</title>
    </head>
    <body>
        <H3>
        <%!
            class Counter {
                int number=0;
                void countPeople() {
                    number++;
                }
            }
            Counter c1 =new Counter();
        %>
        <%
            Counter c2 =new Counter();
            c1.countPeople();
            c2.countPeople();
        %>
        您是第
        <%out.println(c1.number); %>
        个访问本页面的客户。局部变量值是
        <%out.println(c2.number);%>
        </H3>
    </body>
</html>