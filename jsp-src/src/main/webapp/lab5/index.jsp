<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Lab5 Demo 索引</title>
    <style>
        body { font-family: "Microsoft YaHei", Arial, sans-serif; margin: 40px auto; max-width: 720px; line-height: 1.8; }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        ol > li { margin: 14px 0; font-weight: bold; color: #2c3e50; }
        ul { list-style: none; padding-left: 24px; font-weight: normal; }
        li a { color: #3498db; text-decoration: none; }
        li a:hover { text-decoration: underline; }
        .desc { color: #7f8c8d; margin-left: 8px; font-size: 0.9em; }
        .back { color: #3498db; text-decoration: none; font-size: 0.9em; }
    </style>
</head>
<body>
    <p><a class="back" href="/jsp-base/">← 返回课程导航</a></p>
    <h1>Lab5 request/response Demo 索引</h1>
    <p>本页为 lab5/demo 目录下各 JSP 演示文件的索引，按实验顺序排列；综合实例的登录状态部分见 newsPub 目录。</p>
    <ol>
        <li>request 对象 Demo
            <ul>
                <li><a href="demo/requestDemo1_1.jsp">requestDemo1_1.jsp</a><span class="desc">— 表单：text/password/select/checkbox/radio/textarea</span></li>
                <li><a href="demo/requestDemo1_2.jsp">requestDemo1_2.jsp</a><span class="desc">— getParameter / getParameterValues 接收各类控件</span></li>
                <li><a href="demo/requestDemo2.jsp">requestDemo2.jsp</a><span class="desc">— 请求报文头与请求信息（协议/方法/IP/URI 等）</span></li>
            </ul>
        </li>
        <li>response 对象 Demo
            <ul>
                <li><a href="demo/responseDemo1.jsp">responseDemo1.jsp</a><span class="desc">— setContentType 按选项改变输出文档格式</span></li>
                <li><a href="demo/responseDemo2.jsp">responseDemo2.jsp</a><span class="desc">— setHeader("refresh") 5 秒自动跳转</span></li>
            </ul>
        </li>
        <li>综合实例 · 新闻发布系统登录状态（newsPub/）
            <ul>
                <li><a href="/jsp-base/newsPub/userLogin.jsp">newsPub/userLogin.jsp</a><span class="desc">— 登录入口：doLogin.jsp 校验后写 session，top.jsp 显示"当前用户/退出登录"</span></li>
            </ul>
        </li>
    </ol>
</body>
</html>
