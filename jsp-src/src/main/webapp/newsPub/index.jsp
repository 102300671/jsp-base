<%@page language="java" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>新闻发布系统 V3</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
    </head>
    <body>
        <jsp:include page="common/top.jsp" />
        <div id="content">
            <aside>
                <jsp:include page="common/left.jsp" />
            </aside>
            <main>
                <!--main begin -->
                <section class="news_list">
                    <h1>新闻列表</h1>
                    <ul>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">人工智能产业发展再现新趋势</a>
                            </div>
                            <div class="dd_time">2021-09-06 16:03:53 </div>
                        </li>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">《数据安全法》带来新的千亿级市场</a>
                            </div>
                            <div class="dd_time">2021-09-06 16:06:23 </div>
                        </li>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">数字经济已成我国经济发展新引擎</a>
                            </div>
                            <div class="dd_time">2021-09-04 16:05:38 </div>
                        </li>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">我国新能源汽车产业发展加速</a>
                            </div>
                            <div class="dd_time">2021-09-06 16:05:14 </div>
                        </li>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">联合国提示未来极端天气可能更频繁</a>
                            </div>
                            <div class="dd_time">2021-09-06 16:07:32 </div>
                        </li>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">多地推进机动车不礼让斑马线治理</a>
                            </div>
                            <div class="dd_time">2021-09-03 16:07:10 </div>
                        </li>
                        <li><div class="dd_lm">[校内]</div>
                            <div class="dd_bt">
                                <a href="#">时尚礼仪专家做客我校</a>
                            </div>
                            <div class="dd_time">2021-09-05 16:17:51 </div>
                        </li>
                        <li><div class="dd_lm">[校内]</div>
                            <div class="dd_bt">
                                <a href="#">图书馆积极开展"微平台"建设</a>
                            </div>
                            <div class="dd_time">2021-09-04 16:18:52 </div>
                        </li>
                        <li><div class="dd_lm">[校内]</div>
                            <div class="dd_bt">
                                <a href="#">外交部原部长来我校作主题报告</a>
                            </div>
                            <div class="dd_time">2021-09-03 16:18:19 </div>
                        </li>
                        <li><div class="dd_lm">[社会]</div>
                            <div class="dd_bt">
                                <a href="#">文创雪糕走红,文物也可以很"美味"</a>
                            </div>
                            <div class="dd_time">2021-09-06 16:07:57 </div>
                        </li>
                    </ul>
                </section>
                <!--main end -->
            </main>
            <div class="blank20"></div>
            <div class="blank10"></div>
        </div>
        <%@ include file="common/bottom.txt"%>
    </body>
</html>