<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List,tw.designerfamily.model.CartItem"%>
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
<title>購物車</title>

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
vertical-align: middle; 
}
</style>
<body>
<div class="container">
		<h1 align="center">購物車</h1>
		<div style="text-align:center">
		<c:if test="${empty carts}">
		<p style="font-weight: 8; font-size: 40px; text-align: center; margin-top: 5%">購物車內已無商品</p>
		<br/>
	    <form action="buy" method="post">
	    <button type="submit" class="btn btn-outline-success">繼續購物</button>
	    </form>
		</c:if>
		<c:if test="${!empty carts}">
			<table class="table" style="margin-top: 20px">
				<thead class="table-light">
					<tr>
						<th>圖片</th>
						<th>名稱</th>
						<th>數量</th>
						<th>價格</th>
						<th>操作</th>
					</tr>
				</thead>
				<% int i=0, sum=0; 
			@SuppressWarnings("unchecked")
			List<CartItem> list = (List<CartItem>)session.getAttribute("carts");%>
				<tbody>
					<c:forEach var="va" items="${carts}">
						<tr>
							<td width="100px" align="right"><img
								src="${va.product.commImg}" width="100%"></td>
							<td width="400px">${va.product.commTitle}</td>
							<td>${va.qty}</td>
							<td>${va.totalprice}</td>
							<td>
								<form style="display: inline" action="removeCart" method="post">
									<input type="hidden" name="commNo" value="${va.product.commNo}">
									<button type="submit" class="btn btn-outline-danger">移除</button>
								</form>
							</td>
						</tr>
						<%
						sum += list.get(i).getTotalprice();
						i++;
						%>
						
					</c:forEach>
				</tbody>
			</table>
			<form action="checkout" method="post">
				<div align="right">
					商品總金額:<%=sum%>
					<input type="hidden" name="qty" value="<%=sum%>" id="qty" size="1">
					<button type="submit" style="width: 88px; height: 35px;" id="send"
						onclick="return check()" class="btn btn-outline-success">買單</button>
				</div>
			</form>
			</c:if>
		</div>
		</div>
	<!-- 
<script>
	var myModal = new bootstrap.Modal(document.getElementById('myModal'), {
		  keyboard: false
		})
	myModal.show()
</script>
 -->
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
function check(){
	let a = document.getElementById("qty").value;
	console.log(a);
	if(a<=0){
		alert("請購買商品再結帳!");
		return false;
	}else{
		return true;
	}
}
 </script>
</body>
</html>