<%@page contentType="text/html;charset=utf-8" %>
<HTML>
<BODY bgcolor=cyan>
    <FONT Size=4>
    <P>随机生成一个 1～100 的数,请猜!
    <%
        int number=(int)(Math.random()*100)+1;
        session.setAttribute("count",new Integer(0));
        session.setAttribute("save",new Integer(number));
    %>
    <BR>
    <P>输入你所猜的数
    <FORM action="result.jsp" method="post">
        <INPUT type="text" name="boy" >
        <INPUT TYPE="submit" value="送出" name="submit">
    </FORM>
    </FONT>
</BODY>
</HTML>