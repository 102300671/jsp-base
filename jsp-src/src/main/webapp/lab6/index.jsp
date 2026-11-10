<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Lab6 Demo 索引</title>
    <style>
        body { font-family: "Microsoft YaHei", Arial, sans-serif; margin: 40px auto; max-width: 720px; line-height: 1.8; }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        ol > li { margin: 14px 0; font-weight: bold; color: #2c3e50; }
        ul { list-style: none; padding-left: 24px; font-weight: normal; }
        li a { color: #3498db; text-decoration: none; }
        li a:hover { text-decoration: underline; }
        .desc { color: #7f8c8d; margin-left: 8px; font-size: 0.9em; }
        .back { color: #3498db; text-decoration: none; font-size: 0.9em; }
        .note { background: #fdf6e3; border-left: 3px solid #e2b93b; padding: 8px 12px; font-size: 0.9em; color: #6b5b2e; }
    </style>
</head>
<body>
    <p><a class="back" href="/jsp-base/">← 返回课程导航</a></p>
    <h1>Lab6 Cookie 与 Session Demo 索引</h1>
    <p>本页为 lab6/demo 目录下各 JSP 演示文件的索引：Cookie 的写与读、Session 的猜数游戏。</p>
    <ol>
        <li>Cookie 演示（demo/cookieDemo/）
            <ul>
                <li><a href="demo/cookieDemo/bgset.jsp">bgset.jsp</a><span class="desc">— 表单提交背景色，用 response.addCookie 写入 Cookie（bg）<b>← 从这里进入</b></span></li>
                <li>bgshow.jsp<span class="desc">— 用 request.getCookies 遍历全部 Cookie，并用 bg 的值设置页面背景色；请从 bgset.jsp 点链接进入</span></li>
            </ul>
        </li>
        <li>Session 演示 · 猜数游戏（demo/sessionDemo/）
            <ul>
                <li><a href="demo/sessionDemo/guess.jsp">guess.jsp</a><span class="desc">— 随机生成 1~100，存入 session 的 save，次数 count 清零<b>← 从这里进入</b></span></li>
                <li>result.jsp<span class="desc">— 比较所猜数：count+1，相等转 success，大转 large，小转 small</span></li>
                <li>success.jsp<span class="desc">— 猜中：显示次数与用时（getCreationTime / getLastAccessedTime）</span></li>
                <li><a href="demo/sessionDemo/large.jsp">large.jsp</a><span class="desc">— 猜大了，重新提供表单</span></li>
                <li><a href="demo/sessionDemo/small.jsp">small.jsp</a><span class="desc">— 猜小了，重新提供表单</span></li>
            </ul>
        </li>
    </ol>
    <p class="note">代码与教材【程序 4.12–4.18】保持一致。其中 bgshow.jsp 依赖 Cookie、result.jsp / success.jsp
        依赖 guess.jsp 建立的 Session，单独访问会因取不到数据而报错，因此只标注为流程内页面，不提供直接入口。</p>
</body>
</html>