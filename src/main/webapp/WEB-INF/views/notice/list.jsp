<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header2.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
<!-- Google web font "Open Sans" -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<!-- Bootstrap style -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="/resources/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="/resources/slick/slick-theme.css" />
<link rel="stylesheet" href="/resources/css/templatemo-style.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/resources/css/searchbar.css">
<title>게시판</title>
<style>
h2 {
	font-weight: border;
}

.hr1 {
	border: 0;
	height: 2px;
	background: #d3d3d3;
}

.grey {
	color: #727272;
}

#strong {
	font-weight: 900;
}

table {
	width: 100%;
	border: none;
	border-collapse: collapse;
}

th {
	background-color: #FFC107;
	border-top: 3px solid #727272;
}

th, td {
	border-bottom: 1px solid #d3d3d3;
	padding: 10px;
}

tr:hover {
	background-color: #F5F5F5;
}

body {
	width: 65%;
	margin: 0 auto;
	margin-top : 180px;
}

.greylist {
	width: 50px;
	height: 30px;
	font-weight: 900;
	color: white;
	text-align: center;
	background: grey;
	border: solid 2px white;
	border-radius: 5px;
}

.gradient {
	width: 80px;
	height: 30px;
	font-weight: 900;
	color: white;
	text-align: center;
	background: #FFC107;
	border: solid 2px white;
	border-radius: 5px;
}

.left {
	text-align: left;
}

.right {
	float: right;
}

.center {
	text-align: center;
}

a {
	color: black;
	text-decoration-line: none;
}
</style>
</head>
<body>
	<h2>고객센터 게시판</h2>

	<hr class="hr1" noshade>

	<br>

	<table id="listTable">
		<tr>
			<th width=10%>글번호</th>
			<th width=40%>제목</th>
			<th width=20%>작성일자</th>
			<th width=20%>작성자</th>
			<th width=10%>조회수</th>
		</tr>
		<c:forEach var="item" items="${list}">
			<tr>	
				<td>${item.boardnum}</td>
				<td><a class="move" href="<c:out value='${item.boardnum }' />">${item.boardsubject }</a></td>
				<td>${item.regidate }</td>
				<td>${item.boardwriter}</td>
				<td>${item.readcount}</td>
			</tr>
		</c:forEach>
	</table>
	<br>


	<div class="container" style="color: black;">
			<ul class="pagination justify-content-center">
			<c:if test="${page.prev}">
				<li class="page-item"><a class="page-link"
					href="${page.startPage-1}">Previous</a></li>
			</c:if>
			<c:forEach begin="${page.startPage}" end="${page.endPage}"
				var="num">
				<li
					class="page-item  ${page.cri.pageNum == num ? 'active' : ''}">
					<a class="page-link" href="${num}">${num}</a>
				</li>
			</c:forEach>
			<c:if test="${page.next}">
				<li class="page-item"><a class="page-link"
					href="${page.endPage+1}">Next</a></li>
			</c:if>
		</ul>
	</div>

	<form action="/notice/list" method="get" id="actionForm">
		<input type="hidden" name="pageNum" value="${page.cri.pageNum }">
		<input type="hidden" name="amount" value="${page.cri.amount }">
	</form>
	
					<%-- <c:if test="${!empty user.admin}"> --%>
						<button data-oper="register" class="btn btn-secondary mr-2" type="submit">글쓰기</button>
					<%-- </c:if> --%>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var actionForm = $("#actionForm");
			$(".pagination a").on("click", function(e){
				e.preventDefault();
				
				console.log('click');
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			
			$("#regBtn").on("click", function() {
				self.location = "/notice/register";
			});
			
			
			$(".move").on("click", function(e){
			
				e.preventDefault();
				actionForm.append("<input type='hidden' name='boardnum' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action", "/notice/read");
				actionForm.submit();
				
			});
			
			
		});
	</script>
	<%@ include file="../includes/footer.jsp"%>
</body>
</html>