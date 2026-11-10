<%@page contentType="text/html;charset=utf-8" %>
<HTML>
<BODY bgcolor=cyan>
    <FONT Size=4>
    <%
        int count=((Integer)session.getAttribute("count")).intValue();
        int num=((Integer)session.getAttribute("save")).intValue();
        long startTime=session.getCreationTime();
        long endTime=session.getLastAccessedTime();
    %>
    <P>恭喜你,猜对了<BR>
    <P>您共猜了<%=count%>次
    <P>用时<%=(endTime-startTime)/1000%>秒。
    <P>这个数字就是<%=num%>
    <P>您必须关掉浏览器才能获得新的数。
    </FONT>
</BODY>
</HTML>