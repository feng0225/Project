<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <link rel="stylesheet" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
 <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
 <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script type="text/javascript">
     $(document).ready(function(){
	  $('#table_id').DataTable({
		 "ajax": {
             "url": "showorder",
             //默認為data,這里定義為空，則只需要傳不帶屬性的數據
             "dataSrc": "",
         },
         "columns": [
             { "data": "orderNo" },
             { "data": "orderKey"},
             { "data": "orderOwner" },
             { "data": "orderQty" },
             { "data": "orderDate" },
             { "data": "orderPrice" },
             { "data": "orderStatus" },
             { 'data': null, 
                title: 'Action', 
                wrap: true, 
                "render": function (item) {
                 return '<button type="button" onclick="del(' + item.orderNo + ')" value="0" class="btn btn-warning" data-toggle="modal" data-target="#myModal">刪除</button>'} },
             
         ]
     } );

});
      function del(orderNo){
         $.ajax({
             url:"deleteorder/"+orderNo,
              success: function(data){
            	location.reload();
                     console.log("刪除成功");
                     }     
             });
         }
</script>

</head>
<body>
<div class="container">
<table id="table_id" class="display">  
 <thead>
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
</table>
</div>
</body>
</html>