package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;

public class CddVO extends DefaultVO<CddVO>{

	private static final long serialVersionUID = 2539859208472028474L;
	
	private String yyyymmdd;		// 기준일자		20200930
	
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}
	
}
