<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
response.setHeader("Cache-Control","no-cache"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", -1); // Prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<title >後台管理-訂單</title>

<!-- 從這裡(第一段) -->
        <!-- Site favicon -->
        <link rel="apple-touch-icon" sizes="180x180" href="vendors/images/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="vendors/images/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="vendors/images/favicon-16x16.png">

        <!-- Mobile Specific Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="vendors/styles/core.css">
        <link rel="stylesheet" type="text/css" href="vendors/styles/icon-font.min.css">
        <link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/responsive.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="vendors/styles/style.css">

        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() { dataLayer.push(arguments); }
            gtag('js', new Date());

            gtag('config', 'UA-119386393-1');
        </script>
        <!-- 到這裡(第一段結束) -->
        
</head>
<style>
td,th,tr{
text-align:center;
}
</style>
<body>
<%@ include file="header.jsp" %>
 <div class="main-container">
<div class="pd-ltr-20">
	<h2>訂單</h2>
	<div id="test">
		<table class="table" style="margin-top:20px">
		<thead class="table-light">
		    <tr>
		    	<th>NO.</th>
		    	<th>訂單編號</th>
		    	<th>數量</th>
		    	<th>下單日期</th>
		    	<th>訂單價格</th>
		    	<th>訂購者</th>	    	
		    	<th>訂單狀態</th>	    	
		    	<th>操作</th>
		    </tr>
		</thead>
		<tbody>
			<% int rCount=0 ;%>
			<c:forEach var="va" items="${list}">
				<tr>
					<td>${va.orderNo}</td>
					<td>${va.orderKey}</td>
					<td>${va.orderQty}</td>
					<td>${va.orderDate}</td>
					<td>${va.orderPrice}</td>
					<td>${va.orderOwner}</td>
					<td>${va.orderStatus}</td>	
					<td>
						<form style="display:inline" action="reviseorder" method="post">
							<input type="hidden" name="orderNo" value="${va.orderNo}">
							<button type="submit" class="btn btn-outline-success">修改</button>
						</form>
						<form style="display:inline" action="showDetail" method="post">
							<input type="hidden" name="detailNo" value="${va.orderNo}">
							<button type="submit" class="btn btn-outline-success">詳細</button>
						</form>

						<!-- Button trigger modal -->
						<button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal${va.orderNo}">刪除</button>
						
						<!-- Modal -->
						<form style="display:inline" action="deleteorder" method="post">
							<input type="hidden" name="orderNo" value="${va.orderNo}">
							<div class="modal fade" id="exampleModal${va.orderNo}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel"></h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							        請確認是否刪除此筆資料。
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
							        <button type="submit" class="btn btn-primary">確認</button>
							      </div>
							    </div>
							  </div>
							</div>
						</form>
					</td>
				</tr>
				<%rCount++; %>
			</c:forEach>
		   
		</tbody>
		</table>
	</div>
</div>
</div>
   <!-- 從這裡(第二段) -->
        <!-- js -->
        <script src="vendors/scripts/core.js"></script>
        <script src="vendors/scripts/script.min.js"></script>
        <script src="vendors/scripts/process.js"></script>
        <script src="vendors/scripts/layout-settings.js"></script>
        <script src="src/plugins/apexcharts/apexcharts.min.js"></script>
        <script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
        <script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
        <script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
        <script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
        <script src="vendors/scripts/dashboard.js"></script>
        <!-- 到這裡(第二段結束) -->
        
 <script>
$("#select").attr("action", "searchorder");
</script>

</body>
</html>