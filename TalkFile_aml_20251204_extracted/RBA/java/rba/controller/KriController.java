package com.gtone.rba.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.service.KriService;

@Controller("KriController")
public class KriController {

	private static final Logger logger = LoggerFactory.getLogger("KriBatchMain");
	
	@Resource(name="KriService")
    private KriService service;
	
	public void excuteKri(SchdVO paramVO)throws Exception
	{
		service.excuteKri(paramVO);
	}
}
