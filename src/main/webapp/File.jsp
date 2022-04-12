<!DOCTYPE html>
<%@ page contentType="text/html;charset=utf-8" language="java" import="java.io.*,java.util.*,java.sql.*" %>
<%
    // === 接收電子地圖回傳值 ===
    String s_processID = request.getParameter("processID")==null?"":request.getParameter("processID");
    String s_stCate = request.getParameter("stCate")==null?"":request.getParameter("stCate");
    String s_stCode = request.getParameter("stCode")==null?"":request.getParameter("stCode");
    String s_stName = request.getParameter("stName")==null?"":request.getParameter("stName");
    String s_stAddr = request.getParameter("stAddr")==null?"":request.getParameter("stAddr");
    String s_stTel = request.getParameter("stTel")==null?"":request.getParameter("stTel");
    String s_webPara = request.getParameter("webPara")==null?"":request.getParameter("webPara");

    s_stName = new String(s_stName.getBytes("ISO8859_1"),"UTF-8");
    s_stAddr = new String(s_stAddr.getBytes("ISO8859_1"),"UTF-8");
%>
<html>
  <head>
    <title>電子地圖連接模擬</title>
  </head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <body>
  <p align="center"><b>電子地圖連接模擬</b></p>
  <%
    if(!s_processID.equals("")){
      out.println("<hr>");
      out.println("<<電子地圖回傳資料>><br>");
      out.println("processID = "+s_processID+"<br>");
	  out.println("stCate = "+s_stCate+"<br>");
	  out.println("stCode = "+s_stCode+"<br>");
	  out.println("stName = "+s_stName+"<br>");
	  out.println("stAddr = "+s_stAddr+"<br>");
	  out.println("stTel = "+s_stTel+"<br>");
	  out.println("webPara = "+s_webPara+"<br>");
	}
  %>
  <hr>
  <!--使用 FORM SUBMIT 轉頁到電子地圖-->
  <form method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web.jsp">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
      <tr>
        <td align="center">
          <input name="Submit2" type="submit" value="選擇門市"></center>
          <input type="hidden" name="suID"  value="buyer@myweb.com.tw"> <!-- 賣家登入ezShip的帳號，需開通網站串接服務 -->
          <input type="hidden" name="processID" value="155922"> <!-- 處理序號或訂單編號，由購物網站自行提供的編號 -->
          <input type="hidden" name="stCate" value="<%=s_stCate%>"> <!-- 取件門市通路代號。可帶空值 -->
          <input type="hidden" name="stCode" value="<%=s_stCode%>"> <!-- 取件門市代號。可帶空值 -->
          <input type="hidden" name="rtURL"  value="https://www.ezship.com.tw/emap/ezship_simulation_mappg.jsp"><!-- 回傳網址路徑及程式名稱。請輸入完整網站路徑網址。如  -->
          <input type="hidden" name="webPara" value="simulationpage"> <!-- 網站所需額外判別資料。由開通網站自行提供，ezShip 將原值回傳。可帶空值 -->
        </td>
      </tr>
    </table>
  </form>
  <hr>
  </body>
</html>
