package com.itwillbs.moneytto.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.moneytto.service.*;

@Controller
public class AuctionController {
	
	@Autowired
	private AuctionService service;
	
	// 경매 메인페이지
	@RequestMapping(value = "auctionMain", method = RequestMethod.GET)
	public String auctionMain(Model model) { 
		// 이미지 코드와 경매 코드를 찾아서 목록 뿌리기
		List<HashMap<String, String>> auction = service.selectAuction();
		System.out.println(auction);
		model.addAttribute("auction", auction);
		
		
		return "auction/auctionMain";
	}
	
	// 실시간 경매
	@RequestMapping(value="auction", method = RequestMethod.GET)
	public String auction(@RequestParam String auction_code, Model model) { // 이미지 코드와 경매 코드를 받아서 목록 상세
		
		// 여기서 채팅방 or 내용 검색해서 기록이 있으면 그 기록을 화면에 보여줄꺼
		// 여기서 넘길수 있는게 auction_code 고 
		
//		HashMap<String, String> auctionLog = service.selectAuctionLog();
		
//		if() { // 경매 페이지로 들어갈 때 이 아이템에 대한 경매기록이 있는지 확인해야하고 경매 기록이 없을 경우 밑에 코드 사용
//			채팅방에는 방번호, 아이템 번호, chat_content 이렇게 있고
			
			/* 여기서 아이템 번호에는 옥션_코드 들가면 되고 방번호는 내가 임의로 넣으면 되나? 
			예를 들어 구분자나 경매기록이니 'log'를 붙여서 사용하거나 다 공통된거 사용하는게 좋긴 한데 다른곳에서 쓸일이 있으려나? 
			쓸일이 있어도 /log 같은거 사용해서 구분하는게 best같은데 맞지 
			마이페이지에서도 필요할꺼고 */
//		} else if() {} // 경매 관련 기록이 있을경우 그 기록의 정보를 화면에 표시 
		
		// 이것도 바뀔건 아니고
		HashMap<String, String> auction = service.selectAuctionCode(auction_code);
		System.out.println(auction);
		model.addAttribute("auction", auction);
		// 시작 가격 - 이건 계속 바뀌는 거 그래도 필요하네
		String price = Integer.parseInt(auction.get("auction_present_price").replace(",", "")) + "";
		model.addAttribute("price", price);
		// 보증금 계산 - 고정
		String deposit = (int)(Integer.parseInt(auction.get("auction_present_price").replace(",", "")) * 0.1) + "";
		// 물건 호가 계산 - 고정
		String askingPrice = (int)(Integer.parseInt(auction.get("auction_present_price").replace(",", "")) * 0.01) + "";
		// 즉시 구매 - 고정
		String purchase = (int)(Integer.parseInt(auction.get("auction_present_price").replace(",", "")) * 1.8) + "";
		model.addAttribute("deposit", deposit);
		model.addAttribute("askingPrice", askingPrice);
		model.addAttribute("purchase", purchase);
		
		return "auction/auction";
	}
	
	// 기간 경매
	@RequestMapping(value="auctionPeriod", method = RequestMethod.GET)
	public String auctionPeriod() { // 이미지 코드와 경매 코드를 받아서 목록 상세
		return "auction/auctionPeriod";
	}
	
	// 완료된 경매
	@RequestMapping(value="auctionFinish", method = RequestMethod.GET)
	public String auctionFinish() { // 이미지 코드와 경매 코드를 받아서 목록 상세
		return "auction/auctionFinish";
	}
	
	
	
	// 0524 test 여기서==========================
//	@Controller
//	public class ChatController {
		@RequestMapping(value = "/chat.action", method = { RequestMethod.GET })
		public String chat (HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
			return "auction/chat";
		}
//	}
	
	// 0524 test 여기까지==========================
	
}

