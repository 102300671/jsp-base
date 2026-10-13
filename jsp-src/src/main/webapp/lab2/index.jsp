<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="place.run.jianying.lab2.Phone.*" %>
<%!
  String esc(String s) {
    if (s == null) return "";
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
  }
%>
<%
  String ptype = request.getParameter("phoneType");
  if (ptype == null) ptype = "mobile";
  String number = request.getParameter("number");
  if (number == null || number.isEmpty()) number = "13800000001";
  String to = request.getParameter("to");
  if (to == null || to.isEmpty()) to = "110";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>上机2 · 电话继承体系</title>
  <style>
    body { font-family: system-ui, sans-serif; max-width: 780px; margin: 2rem auto; padding: 0 1rem; line-height: 1.7; color: #333; }
    h1 { border-bottom: 2px solid #2e7d32; padding-bottom: .5rem; }
    a.back { color: #0366d6; text-decoration: none; font-size: .9rem; }
    .structure { background: #f4f8f4; border: 1px solid #cfe3cf; border-radius: 8px; padding: .8rem 1rem; margin: 1rem 0; }
    .structure pre { margin: .3rem 0; font-family: ui-monospace, Consolas, monospace; }
    form { margin: 1rem 0; }
    fieldset { border: 1px solid #ddd; border-radius: 8px; margin-bottom: 1rem; padding: .8rem 1rem; }
    legend { font-weight: bold; color: #2e7d32; padding: 0 .4rem; }
    .row { margin: .5rem 0; }
    label { margin-right: 1rem; white-space: nowrap; }
    input[type=text], input[type=number] { padding: .3rem .5rem; border: 1px solid #bbb; border-radius: 4px; }
    .group { margin: .4rem 0; }
    .fields, .acts { display: block; }
    button { background: #2e7d32; color: #fff; border: none; padding: .55rem 1.4rem; border-radius: 6px; font-size: 1rem; cursor: pointer; }
    button:hover { background: #256528; }
    .result { background: #f7f7f7; border: 1px solid #ddd; border-radius: 8px; padding: .8rem 1rem; margin-top: 1rem; }
    .result h2 { margin: 0 0 .5rem; font-size: 1.1rem; }
    .result pre { margin: 0; white-space: pre-wrap; font-family: ui-monospace, Consolas, monospace; }
    .hint { color: #888; font-size: .85rem; }
  </style>
</head>
<body>
  <p><a class="back" href="/jsp-base/">← 返回课程导航</a></p>
  <h1>📞 上机2 · 电话继承体系（交互演示）</h1>

  <div class="structure">
    <b>继承结构：</b>
    <pre>
Phone（基类：号码 / 拨打 / 接听 / 挂断）
 ├── Fixedphone（固定电话：位置 / 线路号 / 拿起放下话筒）
 │    └── Cordlessphone（无绳电话：有效距离 / 听筒离座才能拨打）
 └── Mobilephone（移动电话：电量 / 位置 / 移动 / 短信 / 充电）  implements Moveable
Moveable（接口：move()）
    </pre>
    <div class="hint">表单提交后，页面调用真实 Java 类执行所选动作并捕获其输出，效果等同命令行运行 Test.java。</div>
  </div>

  <form method="post" action="index.jsp">
    <fieldset>
      <legend>电话类型</legend>
      <div class="row">
        <label><input type="radio" name="phoneType" value="mobile" onchange="switchType()" <%= "mobile".equals(ptype) ? "checked" : "" %>> 移动电话</label>
        <label><input type="radio" name="phoneType" value="fixed" onchange="switchType()" <%= "fixed".equals(ptype) ? "checked" : "" %>> 固定电话</label>
        <label><input type="radio" name="phoneType" value="cordless" onchange="switchType()" <%= "cordless".equals(ptype) ? "checked" : "" %>> 无绳电话</label>
      </div>
      <div class="row">
        <label>本机号码 <input type="text" name="number" value="<%= esc(request.getParameter("number") != null ? request.getParameter("number") : number) %>"></label>
        <label>拨打号码 <input type="text" name="to" value="<%= esc(request.getParameter("to") != null ? request.getParameter("to") : to) %>"></label>
      </div>
    </fieldset>

    <fieldset>
      <legend>类型参数</legend>
      <div id="field-mobile" class="fields">
        <div class="row">
          <label>电量(%) <input type="number" name="battery" min="0" max="100" value="<%= esc(request.getParameter("battery") != null ? request.getParameter("battery") : "50") %>"></label>
          <label>当前位置 <input type="text" name="mobileLoc" value="<%= esc(request.getParameter("mobileLoc") != null ? request.getParameter("mobileLoc") : "公司") %>"></label>
        </div>
      </div>
      <div id="field-fixed" class="fields">
        <div class="row">
          <label>所在位置 <input type="text" name="fixedLoc" value="<%= esc(request.getParameter("fixedLoc") != null ? request.getParameter("fixedLoc") : "客厅") %>"></label>
          <label>线路号 <input type="text" name="lineId" value="<%= esc(request.getParameter("lineId") != null ? request.getParameter("lineId") : "L01") %>"></label>
        </div>
      </div>
      <div id="field-cordless" class="fields">
        <div class="row">
          <label>所在位置 <input type="text" name="cordlessLoc" value="<%= esc(request.getParameter("cordlessLoc") != null ? request.getParameter("cordlessLoc") : "卧室") %>"></label>
          <label>线路号 <input type="text" name="cordlessLine" value="<%= esc(request.getParameter("cordlessLine") != null ? request.getParameter("cordlessLine") : "L02") %>"></label>
        </div>
        <div class="row">
          <label>有效距离(米) <input type="number" name="distance" min="1" max="200" value="<%= esc(request.getParameter("distance") != null ? request.getParameter("distance") : "50") %>"></label>
          <label><input type="checkbox" name="offBase" value="on" <%= "on".equals(request.getParameter("offBase")) ? "checked" : "" %>> 初始时听筒离开座机</label>
        </div>
      </div>
    </fieldset>

    <fieldset>
      <legend>执行动作（可多选，按勾选顺序执行）</legend>
      <div id="act-common" class="acts">
        <div class="group">
          <label><input type="checkbox" name="action" value="makeCall"> 拨打</label>
          <label><input type="checkbox" name="action" value="answer"> 接听</label>
          <label><input type="checkbox" name="action" value="hangup"> 挂断</label>
          <label><input type="checkbox" name="action" value="tostring"> 显示信息</label>
        </div>
      </div>
      <div id="act-mobile" class="acts">
        <div class="group">
          <label><input type="checkbox" name="action" value="move"> 移动</label>
          <label><input type="checkbox" name="action" value="sms"> 发短信</label>
          <label><input type="checkbox" name="action" value="charge"> 充电</label>
          <label>短信内容 <input type="text" name="smsText" value="<%= esc(request.getParameter("smsText") != null ? request.getParameter("smsText") : "你好") %>"></label>
        </div>
      </div>
      <div id="act-fixed" class="acts">
        <div class="group">
          <label><input type="checkbox" name="action" value="pickup"> 拿起话筒</label>
          <label><input type="checkbox" name="action" value="putdown"> 放下话筒</label>
        </div>
      </div>
      <div id="act-cordless" class="acts">
        <div class="group">
          <label><input type="checkbox" name="action" value="leave"> 听筒离开座机</label>
          <label><input type="checkbox" name="action" value="ret"> 听筒放回座机</label>
        </div>
      </div>
    </fieldset>

    <button type="submit">运行</button>
  </form>

  <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
      ByteArrayOutputStream baos = new ByteArrayOutputStream();
      PrintStream original = System.out;
      try {
        PrintStream capture = new PrintStream(baos, true, "UTF-8");
        System.setOut(capture);

        Phone phone = null;
        if ("fixed".equals(ptype)) {
          String loc = request.getParameter("fixedLoc");
          if (loc == null || loc.isEmpty()) loc = "客厅";
          String line = request.getParameter("lineId");
          if (line == null || line.isEmpty()) line = "L01";
          phone = new Fixedphone(number, loc, line);
        } else if ("cordless".equals(ptype)) {
          String loc = request.getParameter("cordlessLoc");
          if (loc == null || loc.isEmpty()) loc = "卧室";
          String line = request.getParameter("cordlessLine");
          if (line == null || line.isEmpty()) line = "L02";
          int dist = 50;
          try { dist = Integer.parseInt(request.getParameter("distance")); } catch (Exception e) {}
          Cordlessphone c = new Cordlessphone(number, loc, line, dist);
          if ("on".equals(request.getParameter("offBase"))) c.leaveBase();
          phone = c;
        } else {
          int batt = 50;
          try { batt = Integer.parseInt(request.getParameter("battery")); } catch (Exception e) {}
          String loc = request.getParameter("mobileLoc");
          if (loc == null || loc.isEmpty()) loc = "公司";
          phone = new Mobilephone(number, batt, loc);
        }

        String smsText = request.getParameter("smsText");
        if (smsText == null || smsText.isEmpty()) smsText = "你好";
        String[] actions = request.getParameterValues("action");
        if (actions != null) {
          for (String a : actions) {
            if ("makeCall".equals(a))            phone.makeCall(to);
            else if ("answer".equals(a))         phone.answerCall();
            else if ("hangup".equals(a))         phone.hangUp();
            else if ("tostring".equals(a))       System.out.println(phone);
            else if ("move".equals(a) && phone instanceof Moveable)   ((Moveable) phone).move();
            else if ("sms".equals(a) && phone instanceof Mobilephone) ((Mobilephone) phone).sendSMS(to, smsText);
            else if ("charge".equals(a) && phone instanceof Mobilephone) ((Mobilephone) phone).charge();
            else if ("pickup".equals(a) && phone instanceof Fixedphone)   ((Fixedphone) phone).pickUpHandset();
            else if ("putdown".equals(a) && phone instanceof Fixedphone)  ((Fixedphone) phone).putDownHandset();
            else if ("leave".equals(a) && phone instanceof Cordlessphone) ((Cordlessphone) phone).leaveBase();
            else if ("ret".equals(a) && phone instanceof Cordlessphone)   ((Cordlessphone) phone).returnBase();
          }
        }
      } finally {
        System.setOut(original);
      }
      String output = baos.toString("UTF-8");
  %>
  <div class="result">
    <h2>运行结果</h2>
    <pre><%= esc(output) %></pre>
  </div>
  <%
    }
  %>

  <script>
    function switchType() {
      var t = document.querySelector('input[name=phoneType]:checked').value;
      ['mobile', 'fixed', 'cordless'].forEach(function (k) {
        var f = document.getElementById('field-' + k);
        var a = document.getElementById('act-' + k);
        if (f) f.style.display = (k === t) ? 'block' : 'none';
        if (a) a.style.display = (k === t) ? 'block' : 'none';
      });
    }
    switchType();
  </script>
</body>
</html>
