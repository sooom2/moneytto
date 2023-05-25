<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/member.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e29d96072ee2bce354a10f8ac53225f"></script>
<script>

$(document).ready(function(){
// 	$(".ThumbNailTypeImgBox, .ThumbNailTypeItemInfoBox").on("click",function(){
// 		location.href="market_detail"
// 	})
	$('.WishWishImg').click(function(){
				
		$(this).closest('img').hasClass("wish")
		
			$.ajax({
	       		url : 'wishClick',
	       		type : 'POST',
	       		context : this,
	       		data : {
	       			info_movie_code : info_movie_code
	       		},
	       		success : function(result){
	       			alert(result.msg)		// [좋아요 성공, 좋아요 취소]
       	
	       			
	       			if(result.resultType == "insert"){
	       				$(this).find('img').attr({
	       					'src' : '${pageContext.request.contextPath}/resources/images/ico/after-like.png',
	       					alt : '찜하기 완료'
	       				})
	       			}else if(result.resultType = "delete"){
	       				$(this).find('img').attr({
	       					'src' : '${pageContext.request.contextPath}/resources/images/ico/before-like.png',
	       					alt : "찜하기"
	       				})
	       			}
	       			$(this).find('span').html(result.like_count)
	       		}
	       	}) 
		
		
		
		$(this).find('img').toggleClass("wish").attr("src", "${path }/resources/images/main/Ico_wish_on.png");
	})
	
	
	$(".tabTab").on("click",function(){
		var itemType = $(this).attr('data-attr');
		$(".tabTab").removeClass("active")
		$(this).addClass("active")
		// active된 탭에 대한 css 작업 필요
		location.href = "mypage?itemList="+itemType;
		})
	})
	
	
	
function memberAuth(){
	let authWindow = window.open("about:blank","authWindow","width=500, height=700");
	authWindow.location = "https://testapi.openbanking.or.kr/oauth/2.0/authorize"
	+"?response_type=code"
	+"&client_id=bd507152-7d5b-4954-be9e-ef67beadb7eb"
	+"&redirect_uri=http://localhost:8080/moneytto/memberAuth"
	+"&scope=login inquiry transfer"
	+"&state=11111111111111111111111111111111"
	+"&auth_type=0";
	// 산업은행 - 12345678
}
	// 망했어요 모르겟어요	
	var polylineLength = new kakao.maps.Polyline({
					path : [
							new kakao.maps.LatLng(${member.member_X}, ${member.member_Y}),
					        new kakao.maps.LatLng(120, 35)
							]
					}).getLength();
	// 망했어요 모르겟어요

</script>
</head>
<body>
	<jsp:include page="../nav.jsp" />
							
	<div class="profileWrapper">
		<div class="profileContainer">
			<div class="memberInfoWrapper">
				<div class="memberInfoInfoArea">
					<div class="userDataWrapper">
<!-- 						<div> -->
<!-- 							<div class="userDataImgBox"> -->
<%-- 								<img src="${path}/resources/images/mypage/cute.png" --%>
<!-- 									alt="profileImg" class="userDataProfileImg "> -->
<!-- 							</div> -->
							<div class="profile_edit_image">
							<div class="profile_edit_image_box">
								<img src="${path}/resources/images/mypage/cute.png" alt="머니또의 프로필 이미지">
								<img src="https://ccimage.hellomarket.com/img/web/member/edit_camera.svg" alt="프로필 사진 등록 이미지">
								<input type="file" class="pf_img" name="file" id="upFile" accept="image/jpeg, image/png">
							</div>
							</div>
							<div class="userDataNickName">${member.member_nickname } 님</div>
<!-- 						</div> -->
					</div>
					<div class="memberInfoProductCountBox">
						<div class="memberInfoText">상품</div>
						<div class="memberInfoCount">0</div>
					</div>
					<div class="memberInfoReviewBox">
						<div class="memberInfoText">등급</div>
						<div class="memberInfoRating">
							<!-- 이미지 태그 넣을 부분 -->
							
							<!--  -->
							<div class="memberInfoCount">${member.grade_score }등급</div>
						</div>
					</div>
					
					<div class="memberInfoReviewBox">
						<div class="memberInfoText">남은머니</div>
						<div class="memberInfoCount">${member.member_point }원</div>
					</div><div class="memberInfoReviewBox">
						<div class="memberInfoText">계좌 인증하기</div>
						<div class="memberInfoCount" onclick="memberAuth()">계좌 인증하기</div>
					</div>
					<div class="memberInfoRating">
						<div class="payCharge"><Input type="button" value="충전" onclick="location.href='payCharge'"></div> &nbsp;&nbsp;
						<div class="payReturn"><Input type="button" value="환급"></div>
					</div>
					<div class="memberInfoMyDataBox" onclick='location.href="mypageInfo"'>
						<div class="memberInfoSettingMyData">내정보 설정</div>
					</div>
				</div>
			</div>
			
			<!-- 탭 -->
			<div class="listWrapper">
				<div class="tabWrapper">
					<div class="tabTab active"  data-attr="sellItem"><a href="#">판매 상품</a></div>
					<div class="tabTab" data-attr="wishItem"><a href="#">찜한 상품</a></div>
					<div class="tabTab" data-attr="buyItem"><a href="#">구매 상품</a></div>
					<div class="tabTab"><a href="#">참여 중인 경매</a></div>
<!-- 					<div class="tabTab"><a href="#">거래 후기</a></div> -->
<!-- 					<div class="tabTab"><a href="#">추천 상품</a></div> -->
				</div>
				
				<div class="filterBarWrapper">
					<div class="tabPcBox">
						<div class="tabFilterTab">
							<div style = "width:180px" class="DropBoxWrapper">
								<div class="DropBoxBox">
									<div class="CategoryText">카테고리 전체</div>
									<img
										src="https://ccimage.hellomarket.com/img/common/arrow/arrow_drop_down.svg"
										alt="화살표 이미지" class="CategoryArrow">
								</div>
							</div>
							
							<div style = "width:130px" class="DropBoxWrapper">
								<div class="DropBoxBox">
									<div class="SellStatusText">판매상태</div>
									<img
										src="https://ccimage.hellomarket.com/img/common/arrow/arrow_drop_down.svg"
										alt="화살표 이미지" class="SellStatusArrow">
								</div>
							</div>
							
							<div style = "width:140px" class="DropBoxWrapper">
								<div class="DropBoxBox">
									<div class="PriceText">가격</div>
									<img
										src="https://ccimage.hellomarket.com/img/common/arrow/arrow_drop_down.svg"
										alt="화살표 이미지" class="PriceArrow">
								</div>
							</div>
							<form class="SearchWrapper" style="width: 257px">
								<input type="text" placeholder="상품명 검색"
									class="SearchInput-ukztbj-1 inqgpT" value=""><img
									src="https://ccimage.hellomarket.com/img/web/common/black_glass.svg"
									alt="카테고리 검색 아이콘" class="SearchSearchImg-ukztbj-2 gSfjHN">
							</form>
						</div>
					</div>
					<div class="tagListWrapper-gkczkp-0 geRbir"></div>
					
				</div>
				<div class="listControlBox"><div class="listCount">전체 0</div>
				</div>
				<div class="itemWrapper">
				  	<div class="itemItemWrapper">
						<c:if test='${not empty itemList }'>
							<c:forEach var="item" items="${itemList}">
								<div class="itemItemBox">
		                          <div class="ThumbNailTypeWrapper">
		                              <div class="ThumbNailTypeItemBox">
		                                  <div class="ThumbNailTypeImgBox">
		                                      <img src="${path }/resources/images/main/noThumbnail.jpg" alt="itemImg" class="ThumbNailTypeItemImg"/>
		                                      <div class="SellStateImgWrapper">
		                                          <div class="SellStateImgStateBox"></div>
		                                      </div>
		                                    	<c:choose>
	                                      	 		<c:when test="${not empty item.wish_code }">
	                                      	 			<img src="${path }/resources/images/main/ico_heart_on_x3.png" 
	                                      	 			alt="좋아요 아이콘" class="WishWishImg" />
		                                      		</c:when>
                                   	 		   		<c:otherwise>
                                   	 		   			<img src="${path }/resources/images/main/ico_heart_off_x3.png"
                                   	 		   			 alt="좋아요 아이콘" class="WishWishImg wish" />
                                   	 		   		</c:otherwise>
	                                         </c:choose>
		                                  </div>
		                                  <div class="ThumbNailTypeItemInfoBox">
		                                      <div class="ThumbNailTypeItemInfo">
		                                          <div class="ThumbNailTypeTitle">${item.item_subject }</div>
		                                          <div class="ThumbNailTypePrice">${item.item_price }원</div>
		                                      </div>
		                                  </div>
		                              </div>
		                          </div>
		                      	</div>
                      		</c:forEach>
                   		</c:if>
                   	</div>
					<c:if test= '${empty itemList }'>
                      	<div class="EmptyEmptyBox">
							<div class="EmptyTitle">아쉽게도, 현재 검색된 상품이 없어요</div>
							<div class="EmptyGuide">필터를 재설정하거나 전체 상품 보기를 선택해주세요</div>
							<div class="EmptyBtnBox">
								<img
									src="https://ccimage.hellomarket.com/img/web/common/refresh_mark.svg"
									alt="초기화 마크" class="EmptyResetMark-xvqyzf-4 YrGaN">
								<div class="EmptyShowAllText">전체 상품 보기</div>
							</div>
						</div>
						<div class="EmptyNoticeBox"></div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../footer.jsp" />
</body>
</html>