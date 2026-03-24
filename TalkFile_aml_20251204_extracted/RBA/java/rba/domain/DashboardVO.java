package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;
/*삼성증권 KRBA_BATCH > DashboardVO.java */
public class DashboardVO extends DefaultVO<DashboardVO>{

	private static final long serialVersionUID = 8769210519955515423L;
	
	private String yyyymm;
	private String yyyy;

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}
	
	
	public String getYyyy() {
		return yyyy;
	}
	
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	
	
	
}
