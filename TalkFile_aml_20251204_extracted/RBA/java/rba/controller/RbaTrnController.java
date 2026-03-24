package com.gtone.rba.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.service.RbaTrnService;


@Controller("RbaTrnController")
public class RbaTrnController {

	private static final Logger logger = LoggerFactory.getLogger("RbaTrnBatchMain");

	@Resource(name="RbaTrnService")
    private RbaTrnService service;


	@RequestMapping("/excuteTrn.do")
	public void excuteTrn(SchdVO paramVO)throws Exception{

		service.excuteTrn(paramVO);
	}



	public void excuteFirstTrn(SchdVO paramVO)throws Exception{

		service.excuteFirstTrn(paramVO);
	}
}
