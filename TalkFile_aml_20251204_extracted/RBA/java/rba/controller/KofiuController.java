package com.gtone.rba.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gtone.rba.domain.KofiuVO;
import com.gtone.rba.service.KofiuService;

@Controller("KofiuController")
public class KofiuController {

	private static final Logger logger = LoggerFactory.getLogger("KofiuBatchMain");
	
	@Resource(name="KofiuService")
    private KofiuService service;
	
	
	/**
	 * 보고기준일자, 배치기준일자 가져오기
	 * @param paramVO
	 * @throws Exception
	 */
	public void excuteStep0(KofiuVO paramVO)throws Exception{
		service.excuteStep0(paramVO);
	}
	
	
	/**
	 * 고유위험 연계표준 데이터 적재
	 * @param paramVO
	 * @throws Exception
	 */
	@RequestMapping("/excuteStep1.do")
	public void excuteStep1(KofiuVO paramVO)throws Exception{
		logger.info("[START] kofiu자동지표 데이터 적재 배치를 시작합니다.");	
		service.excuteStep1(paramVO);
		logger.info("[END] kofiu자동지표 데이터 적재 배치가 완료 되었습니다.");		
	}
	
}
