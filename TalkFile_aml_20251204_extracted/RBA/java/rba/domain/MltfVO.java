package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;

public class MltfVO extends DefaultVO<MltfVO>{

	private static final long serialVersionUID = -5384783313092848485L;

	//통제효과성
	private String basYyyy;
	private String basYymm;
	//대상년월
	private String basYymmS;
	private String basYymmE;
	private String tgtTrnSdt;
	private String tgtTrnEdt;
		
	private Integer valtTrn;
	private String brno;
	private String srvcGC;
	private String tongjeFldC;
	private String tongjeProcC;
	private String tongjeSubProcC;
	private String chId;
	private String tongjeActId;
	private String tongjeEffRt;

	//잔여위험
	private Integer remdrRskAmt;		//잔여위험 금액
	private Integer remdrRskScor;		//잔여위험 스코더
	private String mltfRskGdC;			//ML/TF 위험등급 코드

	public String getBasYyyy() {
		return basYyyy;
	}
	public void setBasYyyy(String basYyyy) {
		this.basYyyy = basYyyy;
	}
	
	public String getBasYymm() {
		return basYymm;
	}
	public void setBasYymm(String basYymm) {
		this.basYymm = basYymm;
	}
	
	public String getBasYymmS() {
		return basYymmS;
	}
	public void setBasYymmS(String basYymmS) {
		this.basYymmS = basYymmS;
	}
	
	public String getBasYymmE() {
		return basYymmE;
	}
	public void setBasYymmE(String basYymmE) {
		this.basYymmE = basYymmE;
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
	public String getSrvcGC() {
		return srvcGC;
	}
	public void setSrvcGC(String srvcGC) {
		this.srvcGC = srvcGC;
	}
	public String getTongjeFldC() {
		return tongjeFldC;
	}
	public void setTongjeFldC(String tongjeFldC) {
		this.tongjeFldC = tongjeFldC;
	}
	public String getTongjeProcC() {
		return tongjeProcC;
	}
	public void setTongjeProcC(String tongjeProcC) {
		this.tongjeProcC = tongjeProcC;
	}
	public String getTongjeSubProcC() {
		return tongjeSubProcC;
	}
	public void setTongjeSubProcC(String tongjeSubProcC) {
		this.tongjeSubProcC = tongjeSubProcC;
	}
	public String getChId() {
		return chId;
	}
	public void setChId(String chId) {
		this.chId = chId;
	}
	public String getTongjeActId() {
		return tongjeActId;
	}
	public void setTongjeActId(String tongjeActId) {
		this.tongjeActId = tongjeActId;
	}
	public String getTongjeEffRt() {
		return tongjeEffRt;
	}
	public void setTongjeEffRt(String tongjeEffRt) {
		this.tongjeEffRt = tongjeEffRt;
	}
	public Integer getRemdrRskAmt() {
		return remdrRskAmt;
	}
	public void setRemdrRskAmt(Integer remdrRskAmt) {
		this.remdrRskAmt = remdrRskAmt;
	}
	public Integer getRemdrRskScor() {
		return remdrRskScor;
	}
	public void setRemdrRskScor(Integer remdrRskScor) {
		this.remdrRskScor = remdrRskScor;
	}
	public String getMltfRskGdC() {
		return mltfRskGdC;
	}
	public void setMltfRskGdC(String mltfRskGdC) {
		this.mltfRskGdC = mltfRskGdC;
	}
}
