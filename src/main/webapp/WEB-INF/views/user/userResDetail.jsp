<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ include file="../includes/header2.jsp"%>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
<!-- Google web font "Open Sans" -->
<link rel="stylesheet"
	href="../resources/font-awesome-4.7.0/css/font-awesome.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
<!-- Bootstrap style -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="../resources/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="../resources/slick/slick-theme.css" />
<link rel="stylesheet" href="../resources/css/templatemo-style.css">
<!-- Templatemo style -->
<!-- 
<script src="../resources/js/vendor/modernizr.custom.min.js"></script>
<link rel="stylesheet" href="../resources/css/normalize.css"> -->
<style>

</style>

<div class="tm-page-wrap mx-auto" style="margin-top: 180px">

	<section class="p-5 tm-container-outer tm-bg-gray">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 mx-auto tm-about-text-wrap text-center">
					<h2 class="text-uppercase mb-4">항공권 예약 확인 및 취소</h2>
					<p class="mb-2">구매하신 항공권 내역 확인 및 취소가 가능합니다.</p>
					<p class="mb-2">*취소한 항공권은 영업일 기준 3일 이내 취소처리됩니다.</p>
					<p class="mb-2">*체크인이 완료 된 항공권은 취소가 불가합니다.</p>
				</div>
			</div>

			<form action="/flight/search" method="get"
				class="tm-search-form tm-section-pad-1">
				<div class="form-row tm-search-form-row">
					<div
						class="form-group tm-form-group tm-form-group-pad tm-form-group-2">
<%-- 						<label for="dep">총 구매횟수 &nbsp;:&nbsp; ${count}번</label> 
						<label for="dep">/ 총 구매금액 &nbsp;:&nbsp; <fmt:formatNumber
								value="${totalPrice}" pattern="#,###" />원</label> --%>
						<p class="mb-2">총 구매횟수 &nbsp;:&nbsp; <strong>${count-1}</strong>번</p>
						<p class="mb-2">총 구매금액 &nbsp;:&nbsp; <strong><fmt:formatNumber
								value="${totalPrice}" pattern="#,###" /></strong>원</p>
					</div>

				</div>
				<!-- form-row -->
				<div class="form-row tm-search-form-row"></div>
			</form>

			<div class="container">
				<table class="table table-hover">
					<thead style="background: #ffc107">
						<tr>
							<th style="width: 20%">예약번호</th>
							<th>구매일자</th>
							<th>출발지</th>
							<th>출발시간</th>
							<th>도착지</th>
							<th>도착시간</th>
							<th style="width: 5%">취소여부</th>
							<th style="width: 6%">체크인여부</th>
							<th>취소</th>
							<th>체크인</th>
						</tr>
					</thead>
					<c:forEach items="${vo}" var="list">
						<tbody>
							<tr class="flight">
								<td>${list.resno}</td>
								<%-- <td><fmt:formatDate value="${list.purchasetime}" pattern="yyyy-MM-dd HH:mm" /></td> --%>
								<td>${list.purchasetime}</td>
								<td>${list.departure}</td>
								<td>${list.deptime}</td>
								<td>${list.arrival}</td>
								<td>${list.arrtime}</td>
								<%-- <td>${list.isCancel}</td>
								<td>${list.isCheckin}</td> --%>

								 <c:choose>
									<c:when test="${list.isCancel==0}">
										<td>false</td>
									</c:when>
									<c:otherwise>
										<td>true</td>
									</c:otherwise>
								</c:choose> 
								<c:choose>
									<c:when test="${list.isCheckin==0}">
										<td>false</td>
									</c:when>
									<c:otherwise>
										<td>true</td>
									</c:otherwise>
								</c:choose> 
								<td>
								<button type="button" class="btn btn-primary btn-sm btn-block btn-custom" onclick="cancelTicket('${list.resno}',${list.isCheckin},'${list.isCancel}')">취소</button></td>
								<td><button type="button"
										class="btn btn-primary btn-sm btn-block btn-custom"
										onclick="checkin('${list.resno}','${list.isCheckin}','${list.isCancel}')">체크인</button></td>
							</tr>
						</tbody>
					</c:forEach>
				</table>
				<!-- 페이징  -->
				<ul class="pagination justify-content-center">
							<c:if test="${paging.prev}">
					<li class="page-item">
							<c:if test="${paging.cri.pageNum>=1}">
								<a class="page-link" href="?pageNum=${paging.cri.pageNum-1}&amount=${paging.cri.amount}">Previous</a>
							</c:if>
					</li>
				</c:if> 
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
					<c:choose>
				        <c:when test="${num eq paging.cri.pageNum}">
				            <li class="page-item active">
				                <span class="page-link">${num}</span>
				            </li>
				        </c:when>
				        <c:otherwise>
				            <li class="page-item">
				                <a class="page-link" href="?pageNum=${num}&amount=${paging.cri.amount}">${num}</a>
				            </li>
				        </c:otherwise>
					 </c:choose>       
				</c:forEach>
				 <c:if test="${paging.next}">
					<li class="page-item">
					<a class="page-link" href="?pageNum=${paging.cri.pageNum+1}&amount=${paging.cri.amount}">Next</a></li>
				</c:if> 
				</ul>
			</div>
		</div>
	</section>

	<!-- 전달 폼 -->
	<form id="ticketForm" action="/user/kakaoDetail" method="get">
		<input type="hidden" name="pageNum" value="${paging.cri.pageNum}" />
		<input type="hidden" name="amount" value="${paging.cri.amount}" /> <input
			type="hidden"
			value='sec:authentication property="principal.username"' />
	</form>

</div>
<!-- .tm-container-outer -->

<script type="text/javascript">
	function cancelTicket(resno,isCheckin,isCancel){
		console.log(resno, isCheckin, isCancel);
		 if(isCancel == 1){
			alert("이미 취소완료된 항공권입니다.");
			return false;
		}else if(isCheckin ==1){
			alert("체크인 된 항공권은 취소가 불가합니다.");
			return false;
		}else{
			console.log("취소중...");
			$.ajax({
				url : "/user/userResDetail",
				async : false,
				dataType : "text",
				data : {
					resno : resno	
				},
				type : "POST",
				success : function(data){
					console.log(data);
				},error : function(err){
					console.log(err);
				}
				
			});
			
			location.reload(); 
		}
	}	

function checkin(resno,isCheckin,isCancel){
	console.log(resno, isCheckin, isCancel);
	 if(isCancel == 1){
		alert("취소된 항공권은 체크인이 불가합니다.");
		return false;
	}else if(isCheckin ==1){
		alert("이미 체크인이 완료 된 항공권입니다.");
		return false;
	}else{
		console.log("체크인중...");
		if(!confirm("체크인 후에는 티켓 취소가 불가합니다.")){
			return false;
		}else{
			$.ajax({
				url : "/user/userResDetail2",
				async : false,
				dataType : "text",
				data : {
					resno : resno	
				},
				type : "POST",
				success : function(data){
					console.log(data);
				},error : function(err){
					console.log(err);
				}
				
			});
			
			location.reload(); 
		}
	
	}
	
}
</script>
<!--  충돌부분 추가 
<script type="text/javascript">
	var $jLatest = jQuery.noConflict();
	$jLatest('input[id="dates"]').daterangepicker();
	$jLatest('input[id="startDate"]').daterangepicker(
			{
				singleDatePicker : true,
				timePicker : true,
				timePicker24Hour : true,
				"locale" : {
					"format" : 'YYYY-MM-DD HH:mm:SS',
					"separator" : " ~ ",
					"applyLabel" : "확인",
					"cancelLabel" : "취소",
					"fromLabel" : "From",
					"toLabel" : "To",
					"customRangeLabel" : "Custom",
					"weekLabel" : "주",
					"daysOfWeek" : [ "일", "월", "화", "수", "목", "금", "토" ],
					"monthNames" : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
							"8월", "9월", "10월", "11월", "12월" ],
					"firstDay" : 1
				},
			});
	$jLatest('input[id="endDate"]').daterangepicker(
			{
				singleDatePicker : true,
				timePicker : true,
				timePicker24Hour : true,
				"locale" : {
					"format" : 'YYYY-MM-DD HH:mm:SS',
					"separator" : " ~ ",
					"applyLabel" : "확인",
					"cancelLabel" : "취소",
					"fromLabel" : "From",
					"toLabel" : "To",
					"customRangeLabel" : "Custom",
					"weekLabel" : "주",
					"daysOfWeek" : [ "일", "월", "화", "수", "목", "금", "토" ],
					"monthNames" : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
							"8월", "9월", "10월", "11월", "12월" ],
					"firstDay" : 1
				},
			});
</script> -->
<!-- <script type="text/javascript">
	$(function() {
		$('.slideshow').each(function() {
			// each : 앞에 선택된 내용의 개수만큼 반복하도록 하는 메서드
			let $slides = $(this).find("img");
			let slideCount = $slides.length;
			let currentIndex = 0;
			$slides.eq(currentIndex).fadeIn();
			// 첫 이미지를 나타나게 함

			// 다음이미지가 나타나게 끔->현재 이미지를 페이드아웃하고 다음이미지를 나타나게 하고 현재이미지값으로 변경시켜서 로테이션돌게 함
			let showNextSlide = function() {
				let nextIndex = (currentIndex + 1) % slideCount;
				// 다음이미지의 인덱스 값을 구하는데 이미지가 4개이므로 최대값이 3이되어야 함 따라서 나머지 연산자를 통해 반복하도록 함(1~4의 값을 4로 나누므로 0~3을 반복시킴-어차피 0은 위에서 표시되도록 했으니까.....?)
				$slides.eq(currentIndex).fadeOut();
				// 현재 이미지를 사라지게 하고
				$slides.eq(nextIndex).fadeIn();
				// 위에서 구한 다음 이미지를 나타나게 함
				currentIndex = nextIndex;
				// 다음 이미지의 값을 현재로 
			}

			let timer = setInterval(showNextSlide, 1000);
			$(this).on('mouseover', function() {
				//타이머 취소
				clearInterval(timer);
			}).on('mouseout', function() {
				//타이머 시작
				timer = setInterval(showNextSlide, 1000);
			})
		})
	});

	// Slick Carousel
	$('.tm-slideshow').slick({
		infinite : true,
		arrows : true,
		slidesToShow : 1,
		slidesToScroll : 1
	});
</script> -->
<%@ include file="../includes/footer.jsp"%>