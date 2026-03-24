package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;


/**
 * KoFIU vo class
 * @author jekwak
 *
 */
public class KofiuVO extends DefaultVO<KofiuVO>{

	private static final long serialVersionUID = 7716793531924007316L;
	
	// FIU 보고기준일자
	private String rptGjdt;
	
	// FIU 항목코드
	private String hmCd;
	
	// FIU 항목명
	private  String hmNm;
	
	// 데이터 적재 기준일자
	private String btBasDt;
	
	// 오늘날짜
	private String today;
	
	private String YYYYMM;
//	private String YYYYMMDD;
	private String J1_S_DT;
	private String J1_E_DT;
	
	
	public String getRptGjdt() {
		return rptGjdt;
	}

	public void setRptGjdt(String rptGjdt) {
		this.rptGjdt = rptGjdt;
	}

	public String getHmNm() {
		return hmNm;
	}
	
	public String getHmCd() {
		return hmCd;
	}

	public void setHmCd(String hmCd) {
		this.hmCd = hmCd;
	}

//	public String getYYYYMMDD() {
//		return YYYYMMDD;
//	}

	public String getJ1_S_DT() {
		return J1_S_DT;
	}
	public String getJ1_E_DT() {
		return J1_E_DT;
	}
	
	public String getYYYYMM() {
		return YYYYMM;
	}
	
//	public void setYYYYMMDD(String YYYYMMDD) {
//		this.YYYYMMDD = YYYYMMDD;
//	}
	
	public void setJ1_S_DT(String J1_S_DT) {
		this.J1_S_DT = J1_S_DT;
	}
	public void setJ1_E_DT(String J1_E_DT) {
		this.J1_E_DT = J1_E_DT;
	}
	public void setYYYYMM(String YYYYMM) {
		this.YYYYMM = YYYYMM;
	}
	
	public void setHmNm(String hmNm) {
		this.hmNm = hmNm;
	}

	public String getBatGjdt() {
		return btBasDt;
	}

	public void setBatGjdt(String btBasDt) {
		this.btBasDt = btBasDt;
	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}
	
	
}
