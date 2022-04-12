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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<title>結帳</title>

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
	<h1 align="center">結帳</h1>
	<form action="mycart" method="post" style="float:left">
		<button type="submit" class="btn btn-outline-success">
			 <span class="bi bi-cart3" style="color:black;font-size:25px;"></span>
			</button>
	</form>
	<div>
	<form action="generatedorder" method="post">
		<table class="table" style="margin-top:20px">
		<thead class="table-light">
		    <tr>
		    	<th>圖片</th>
		    	<th>名稱</th>
		    	<th>數量</th>
		    	<th>價格</th>
		    </tr>
		</thead>
		<% int i=0, sum=0, count=0, j=0; 
			@SuppressWarnings("unchecked")
			List<CartItem> list = (List<CartItem>)session.getAttribute("carts");
			%>
				<tbody>
					<c:forEach var="va" items="${check}">
						<tr>
							<td width="100px" align="right"><img src="${va.product.commImg}"
								width="100%">
								</td>
							<td width="400px">${va.product.commTitle}</td>
							<td>${va.qty}</td>
							<td>${va.totalprice}</td>
						</tr>
						<%
						sum += list.get(i).getTotalprice();
						i++;
						%>
						<% 	count += list.get(j).getQty(); j++; %>
				<input type="hidden" name="name" value="${va.product.commTitle}">
					</c:forEach>
				</tbody>
			</table>
			<div align="right">
				商品總金額:<%=sum%>
				<input type="hidden" name="price" value="<%=sum%>">
				<input type="hidden" name="qty" value="<%=count%>">
				<input type="hidden" name="user" value="${sessionScope.login.account}">
				<button type="submit" class="btn btn-outline-success" style="width:88px;height:35px;">結帳</button>
			</div>
			</form>
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

</body>
</html>