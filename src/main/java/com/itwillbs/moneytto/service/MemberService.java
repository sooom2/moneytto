package com.itwillbs.moneytto.service;

import java.net.URI;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.moneytto.mapper.MemberMapper;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	// 좌표 가져오기
	public String setLocation(String member_address) {
		
		String member_location = "";
		
		URI uri = UriComponentsBuilder.fromUriString("https://dapi.kakao.com/v2/local/search/address.json")
			 	.queryParam("query",member_address).encode().build().toUri();
	
	    // Spring 요청 제공 클래스 
	    RequestEntity<Void> req = RequestEntity
			        .get(uri)
			        .header("Host", "dapi.kakao.com")
			        .header("Authorization", "KakaoAK 4604b4522a19d2b6152b5213355cdb86")
			        .build();
	    
	    ResponseEntity<String> resp = new RestTemplate().exchange(req, String.class);
	    
	    JSONArray jsonArray;
		try {
			jsonArray = new JSONObject(resp.getBody()).getJSONArray("documents");
		    member_location = jsonArray.getJSONObject(0).getString("x") + ", " + jsonArray.getJSONObject(0).getString("y");
		} catch (JSONException e) {
			System.out.println("MemberService - setCoord null");
			e.printStackTrace();
		}
	    return member_location;
	}
	/*회원추가수정*/
	
	public int registMember(HashMap<String, String> member) {
		return mapper.insertMember(member);
	}
	// 카카오 회원 확인
	public HashMap<String, String> kakaoMember(String email) {
		return mapper.selectKakao(email);
	}
	
	// 아이디 조회
	public HashMap<String, String> findId(HashMap<String, String> member) {
		return mapper.findId(member);
	}
	// 비밀번호 재설정
	public int renewPw(HashMap<String, String> member) {
		
		return mapper.renewPw(member);
	}
	// SMS 인증
	public void certifiedPhoneNumber(String phone, int randomNumber) {
		String api_key = "NCSQU2TAT8POKQ76";
	    String api_secret = "N5KAV8MZDEGWQZYSQGJI27HQIQLB06VH";
	    Message coolsms = new Message(api_key, api_secret);

	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", phone);    // 수신전화번호
	    params.put("from", "01076110230");    // 발신전화번호
	    params.put("type", "SMS");
	    params.put("text", "[머니또] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); 

	    try {
	        org.json.simple.JSONObject obj = (org.json.simple.JSONObject)coolsms.send(params);
	        System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	        System.out.println(e.getMessage());
	        System.out.println(e.getCode());
	      }
		
	}

	// 아이디 검증.
	public HashMap<String, String> checkId(String id) {
		
		return mapper.checkId(id);
	}
	// 비밀번호 찾기 회원 인증.
		public HashMap<String, String> phoneCheck(HashMap<String, String> member) {
			
			return mapper.phoneCheck(member);
	}

	// 회원 정보 수정
	public int updateMember(HashMap<String, String> member) {
		
		return mapper.updateMember(member);
	}

	public HashMap<String, String> getMember(String id) {
		
		return mapper.selectMember(id);
	}

	public int setAuth(String id) {
	
		return mapper.updateAuth(id);
	}

	public List<HashMap<String, String>> getSellItemList(String id) {
		
		return mapper.selectSellItemList(id);
	}
	public List<HashMap<String, String>> getWishItemList(String id) {
		
		return mapper.selectWishItemList(id);
	}

	public List<HashMap<String, String>> getBuyItemList(String id) {
		
		return mapper.selectBuyItemList(id);
	}
	
	public int insertWish(String id, String item_code) {
		
		return mapper.insertWish(id, item_code);
	}
	
	public int deleteWish(String id, String item_code) {
		
		return mapper.deleteWish(id, item_code);
	}

	public List<HashMap<String, String>> getWishItem(String id, String item_code) {
		
		return mapper.selectWish(id, item_code);
	}

	public HashMap<String, String> selectAuctionMember(Object attribute) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 회원 탈퇴
	public int quitMember(HashMap<String, String> member) {
		
		return mapper.updateQuitMember(member);
	}

	public int updateDeposit(String auction_code, String success_id, int deposit) {
		return mapper.updateDeposit(auction_code, success_id, deposit);
	}

	public int updatePoint(String id, String point) {
		return mapper.updatePoint(id, point);
	}
	// 회원등급조회
	public HashMap<String, String> getMemberGrade(HashMap<String, String> member) {
		
		return mapper.selectMemberGradeByMember(member);
	}
	
	public HashMap<String, String> getMemberGrade(String id) {
		HashMap<String, String> member = mapper.selectMember(id);
		
		return mapper.selectMemberGradeByMember(member);
	}

	public String selectImage(String name) {
		return mapper.selectImage(name);
	}
	// 리뷰 ==================================================================
	public List<HashMap<String, String>> getWrittenReviewList(HashMap<String, String> member) {
		return mapper.selectWrittenReviewListByMember(member);
	}
	public List<HashMap<String, String>> getWrittenReviewList(String id) {
		return mapper.selectWrittenReviewListById(id);
	}
	// ================================================================== 리뷰
	public List<HashMap<String, String>> getReceivedReviewList(HashMap<String, String> member) {
		// TODO Auto-generated method stub
		return mapper.selectRecivedReviewListByMember(member);
	}
	public List<HashMap<String, String>> getReceivedReviewList(String id) {
		return mapper.selectRecivedReviewListById(id);
	}
	
	public HashMap<String, String> getReview(String id, String item_code) {
		return mapper.selectReview(id, item_code);
	}
	
// 관리자===============================================================
	// 회원목록
	public List<HashMap<String, String>> selectAdminMember(HashMap<String, String> map) {
		return mapper.selectAdminMember(map);
	}

	public int updateMemberPoint(String id, int pay_price) {
		return mapper.updateMemberPoint(id, pay_price);
	}
	

	//====================================================================
	//알람
	public List<HashMap<String, String>> getChat(String id) {
		return mapper.chat(id);
	}

	public List<HashMap<String, String>> getReport(String id) {
		return mapper.report(id);
	}

	public List<HashMap<String, String>> getPoint(String id) {
		return mapper.point(id);
	}

	public List<HashMap<String, String>> getAuction(String id) {
		return mapper.auction(id);
	}
	//등급
	public List<HashMap<String, String>> getGrade() {
		return mapper.grade();
	}


	

	
}
