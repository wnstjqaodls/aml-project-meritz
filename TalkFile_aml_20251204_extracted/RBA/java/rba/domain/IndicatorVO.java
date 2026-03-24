package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;

public class IndicatorVO extends DefaultVO<IndicatorVO>{

	private static final long serialVersionUID = 9074193378943862044L;
	
	//노출위험 지표추출관리
	private String basYyyy;		//기준년도
	private Integer valtTrn;	//평가회차
	private String brno;		//부점번호
	private String rskIndct;	//위험indicator
	private String indvCorpCcd;	//개인법인구분코드
	private String srvcGC;		//서비스구분코드
	private String rskCatg;		//위험 카테고리
	private String rskEvt;		//위험 이벤트
	private String rskLvlC;		//위험 레벨
	private String jipyoV;		//지표값
	private String unfyYn;		//통폐합 여부
	

	private Integer calJipyoV;	//계산1차지표값
	private Integer lstTotV;	//최종합계값
	private Integer stdScor;	//표준화점수
	private Integer expsScor;	//노출위험 스코어
	private Integer expsAmt;	//노출위험금액
	
	private String baseOrgNo;
	private String facOrgNo;	//흡수한 지점
	
	//대상년월
	private String tgtTrnSdt;
	private String tgtTrnEdt;
	
	private String tgtTrnSdtYymm; //시작 대상년월 YYYYMM
	private String tgtTrnEdtYymm; //종료 대상년월 YYYYMM 
	
	
	//샘플링
	private String tongjeOprValtId; //통제운영평가ID
	
	public String getBasYyyy() {
		return basYyyy;
	}
	public void setBasYyyy(String basYyyy) {
		this.basYyyy = basYyyy;
	}
	public Integer getValtTrn() {
		return valtTrn;
	}
	public void setValtTrn(Integer valtTrn) {
		this.valtTrn = valtTrn;
	}
	public String getBrno() {
		return brno;
	}
	public void setBrno(String brno) {
		this.brno = brno;
	}
	public String getRskIndct() {
		return rskIndct;
	}
	public void setRskIndct(String rskIndct) {
		this.rskIndct = rskIndct;
	}
	public String getIndvCorpCcd() {
		return indvCorpCcd;
	}
	public void setIndvCorpCcd(String indvCorpCcd) {
		this.indvCorpCcd = indvCorpCcd;
	}
	public String getSrvcGC() {
		return srvcGC;
	}
	public void setSrvcGC(String srvcGC) {
		this.srvcGC = srvcGC;
	}
	public String getRskCatg() {
		return rskCatg;
	}
	public void setRskCatg(String rskCatg) {
		this.rskCatg = rskCatg;
	}
	public String getRskEvt() {
		return rskEvt;
	}
	public void setRskEvt(String rskEvt) {
		this.rskEvt = rskEvt;
	}
	public String getRskLvlC() {
		return rskLvlC;
	}
	public void setRskLvlC(String rskLvlC) {
		this.rskLvlC = rskLvlC;
	}
	public String getJipyoV() {
		return jipyoV;
	}
	public void setJipyoV(String jipyoV) {
		this.jipyoV = jipyoV;
	}
	public String getUnfyYn() {
		return unfyYn;
	}
	public void setUnfyYn(String unfyYn) {
		this.unfyYn = unfyYn;
	}
	public Integer getCalJipyoV() {
		return calJipyoV;
	}
	public void setCalJipyoV(Integer calJipyoV) {
		this.calJipyoV = calJipyoV;
	}
	public Integer getLstTotV() {
		return lstTotV;
	}
	public void setLstTotV(Integer lstTotV) {
		this.lstTotV = lstTotV;
	}
	public Integer getStdScor() {
		return stdScor;
	}
	public void setStdScor(Integer stdScor) {
		this.stdScor = stdScor;
	}
	public Integer getExpsScor() {
		return expsScor;
	}
	public void setExpsScor(Integer expsScor) {
		this.expsScor = expsScor;
	}
	public Integer getExpsAmt() {
		return expsAmt;
	}
	public void setExpsAmt(Integer expsAmt) {
		this.expsAmt = expsAmt;
	}
	public String getBaseOrgNo() {
		return baseOrgNo;
	}
	public void setBaseOrgNo(String baseOrgNo) {
		this.baseOrgNo = baseOrgNo;
	}
	public String getFacOrgNo() {
		return facOrgNo;
	}
	public void setFacOrgNo(String facOrgNo) {
		this.facOrgNo = facOrgNo;
	}
	public String getTgtTrnSdt() {
		return tgtTrnSdt;
	}
	public void setTgtTrnSdt(String tgtTrnSdt) {
		this.tgtTrnSdt = tgtTrnSdt;
	}
	public String getTgtTrnEdt() {
		return tgtTrnEdt;
	}
	public void setTgtTrnEdt(String tgtTrnEdt) {
		this.tgtTrnEdt = tgtTrnEdt;
	}
	public String getTgtTrnSdtYymm() {
		return tgtTrnSdtYymm;
	}
	public void setTgtTrnSdtYymm(String tgtTrnSdtYymm) {
		this.tgtTrnSdtYymm = tgtTrnSdtYymm;
	}
	public String getTgtTrnEdtYymm() {
		return tgtTrnEdtYymm;
	}
	public void setTgtTrnEdtYymm(String tgtTrnEdtYymm) {
		this.tgtTrnEdtYymm = tgtTrnEdtYymm;
	}
	public String getTongjeOprValtId() {
		return tongjeOprValtId;
	}
	public void setTongjeOprValtId(String tongjeOprValtId) {
		this.tongjeOprValtId = tongjeOprValtId;
	}
}
