<%@page contentType="text/html;charset=utf-8" %>
<HTML>
<BODY bgcolor=cyan>
    <FONT Size=4>
    <BR>
    <%
        String str=request.getParameter("boy");
        if(str==null){
            str="0";
        }
        int guessNumber=Integer.parseInt(str);
        Integer integer=(Integer)session.getAttribute("save");
        int realnumber=integer.intValue();
        int n=((Integer)session.getAttribute("count")).intValue();
        n=n+1;
        session.setAttribute("count",new Integer(n));
        if(guessNumber==realnumber){
            response.sendRedirect("success.jsp");
        }
        else if(guessNumber>realnumber){
            response.sendRedirect("large.jsp");
        }
        else if(guessNumber<realnumber){
            response.sendRedirect("small.jsp");
        }
    %>
    </FONT>
</BODY>
</HTML>