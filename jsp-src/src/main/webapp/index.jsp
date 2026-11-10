<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>课程作业导航</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 720px; margin: 3rem auto; padding: 0 1rem; }
    h1 { border-bottom: 2px solid #eee; padding-bottom: .5rem; }
    ul { list-style: none; padding: 0; }
    li { margin: .75rem 0; padding: 1rem; background: #f7f7f7; border-radius: 6px; }
    a { font-size: 1.1rem; text-decoration: none; color: #0366d6; }
    .desc { color: #666; font-size: .9rem; margin-top: .25rem; }
  </style>
</head>
<body>
  <h1>📚 课程作业导航</h1>
  <ul>
    <li data-chapter="01">
      <a href="/jsp-base/lab1/info/">第 01 章 · 信息</a>
      <div class="desc">第 01 章 · 输出</div>
    </li>
    <li data-chapter="02">
      <a href="/jsp-base/lab2/">第 02 章 · 电话继承</a>
      <div class="desc">第 02 章 · Java 继承/接口/多态 · 交互演示</div>
    </li>
    <li data-chapter="03">
      <a href="/jsp-base/lab3/">第 03 章 · JSP 语法</a>
      <div class="desc">第 03 章 · 声明/表达式/注释/include 指令</div>
    </li>
    <li data-chapter="04">
      <a href="/jsp-base/lab4/">第 04 章 · JSP 动作</a>
      <div class="desc">第 04 章 · include/forward 动作 · 新闻发布系统骨架</div>
    </li>
    <li data-chapter="05">
      <a href="/jsp-base/lab5/">第 05 章 · request/response</a>
      <div class="desc">第 05 章 · request/response 内置对象 · session 登录状态</div>
    </li>
    <li data-chapter="06">
      <a href="/jsp-base/lab6/">第 06 章 · Cookie 与 Session</a>
      <div class="desc">第 06 章 · Cookie 读写 · Session 猜数游戏</div>
    </li>
    <!-- NEW_HW_HERE -->
  </ul>
</body>
</html>
