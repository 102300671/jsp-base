<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Lab3 Demo 索引</title>
    <style>
        body { font-family: "Microsoft YaHei", Arial, sans-serif; margin: 40px auto; max-width: 720px; line-height: 1.8; }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        ol > li { margin: 14px 0; font-weight: bold; color: #2c3e50; }
        ul { list-style: none; padding-left: 24px; font-weight: normal; }
        li a { color: #3498db; text-decoration: none; }
        li a:hover { text-decoration: underline; }
        .desc { color: #7f8c8d; margin-left: 8px; font-size: 0.9em; }
    </style>
</head>
<body>
    <h1>Lab3 JSP Demo 索引</h1>
    <p>本页为 lab3/demo 目录下各 JSP 演示文件的索引，按实验顺序排列：</p>
    <ol>
        <li>声明（Declaration）Demo
            <ul>
                <li><a href="demo/declareDemo1.jsp">declareDemo1.jsp</a><span class="desc">— 成员变量与局部变量自增计数</span></li>
                <li><a href="demo/declareDemo2.jsp">declareDemo2.jsp</a><span class="desc">— synchronized 方法计数</span></li>
                <li><a href="demo/declareDemo3.jsp">declareDemo3.jsp</a><span class="desc">— 声明内部类 Counter</span></li>
            </ul>
        </li>
        <li>表达式（Expression）Demo
            <ul>
                <li><a href="demo/expressionDemo.jsp">expressionDemo.jsp</a><span class="desc">— 九九乘法表</span></li>
            </ul>
        </li>
        <li>注释（Comment）Demo
            <ul>
                <li><a href="demo/commentDemo.jsp">commentDemo.jsp</a><span class="desc">— JSP / Java / HTML 注释对比</span></li>
            </ul>
        </li>
        <li>include 指令 Demo
            <ul>
                <li><a href="demo/includeDemo1_1.jsp">includeDemo1_1.jsp</a><span class="desc">— include 指令包含 hello.txt</span></li>
                <li><a href="demo/includeDemo1_2.jsp">includeDemo1_2.jsp</a><span class="desc">— 直接输出 Hello,Everyone!</span></li>
            </ul>
        </li>
    </ol>
</body>
</html>
