<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Lab4 Demo 索引</title>
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
    <h1>Lab4 JSP 动作 Demo 索引</h1>
    <p>本页为 lab4/demo 目录下各 JSP 演示文件的索引，按实验顺序排列；综合实例见 newsPub 目录。</p>
    <ol>
        <li>include 动作 Demo
            <ul>
                <li><a href="demo/includeDemo2_1.jsp">includeDemo2_1.jsp</a><span class="desc">— 动态包含 includeDemo2_2.jsp，jsp:param 传参 computer=300，求 1~300 连续和（演示入口）</span></li>
                <li>includeDemo2_2.jsp<span class="desc">— 被包含页：接收 computer 参数求连续和；请经 includeDemo2_1.jsp 访问（直连需带 ?computer=300）</span></li>
            </ul>
        </li>
        <li>forward 动作 Demo（demo/login/）
            <ul>
                <li><a href="demo/login/login.jsp">login.jsp</a><span class="desc">— 登录表单（post 到 doLogin.jsp）</span></li>
                <li><a href="demo/login/doLogin.jsp">doLogin.jsp</a><span class="desc">— 校验后 jsp:forward 转发并传参</span></li>
                <li><a href="demo/login/index.jsp">index.jsp</a><span class="desc">— 接收转发参数，显示登录结果</span></li>
            </ul>
        </li>
        <li>综合实例 · 新闻发布系统（newsPub/）
            <ul>
                <li><a href="/jsp-base/newsPub/index.jsp">newsPub/index.jsp</a><span class="desc">— 系统首页：jsp:include 动态包含页头/侧栏，include 指令静态包含页脚</span></li>
                <li><a href="/jsp-base/newsPub/userLogin.jsp">newsPub/userLogin.jsp</a><span class="desc">— 登录页（本阶段 top.jsp 为静态初版）</span></li>
            </ul>
        </li>
    </ol>
</body>
</html>
