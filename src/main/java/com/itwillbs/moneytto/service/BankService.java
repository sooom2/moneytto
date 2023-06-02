package com.itwillbs.moneytto.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.moneytto.mapper.BankMapper;
import com.itwillbs.moneytto.vo.AccountVO;
import com.itwillbs.moneytto.vo.ResponseTokenVO;

@Service
public class BankService {
	@Autowired
	private BankMapper mapper;
	
	// 토큰 정보 저장
	public int writeToken(String id, ResponseTokenVO responseToken) {
		// 토큰 정보 저장 요청
		int insertCount = mapper.insertToken(id, responseToken);
		if(insertCount > 0) { // 토큰 정보 저장 성공 시
			// 계좌 인증 상태 변경 요청
			return mapper.updateAccountAuthStatus(id); 
		} else {
			return 0;
		}
	}
	// 계좌 정보 조회
	public HashMap<String, String> getAccount(String member_id) {
		
		return mapper.selectAccount(member_id);
	}
	
	
	
	public int updateAccount(String member_id, String fintech_use_num, String balance_amt) {

		return mapper.updateAccount(member_id, fintech_use_num, balance_amt);
	}
	
	
}














