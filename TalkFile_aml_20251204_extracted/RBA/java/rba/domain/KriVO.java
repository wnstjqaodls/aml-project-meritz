package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;

/**
 * KRI 
 * @author Jacky
 *
 */
public class KriVO extends DefaultVO<KriVO>{

	private static final long serialVersionUID = -5725114725034608437L;

	private String basYyyy;		//기준년도
	private String basYymm;
	private String basLong;         //
    private String tgtTrnSdt;		//평가대상 시작일자		
	private String tgtTrnEdt;		//평가대상 종료일자
	private String pgtTrnSdt;		//평가대상 전월 시작일자		
	private String pgtTrnEdt;		//평가대상 전월 종료일자
	private Integer extrBasAmt;
	
	private String tgtTrnSdtYymm; //시작 대상년월 YYYYMM
	private String tgtTrnEdtYymm; //종료 대상년월 YYYYMM 고액자산가 마지막 대상년월
	
	
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
	
	public String getbasLong() {
		return basLong;
	}


	public void setbasLong(String basLong) {
		this.basLong = basLong;
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
	
	
	
	
	
	public String getPgtTrnSdt() {
		return pgtTrnSdt;
	}


	public void setPgtTrnSdt(String pgtTrnSdt) {
		this.pgtTrnSdt = pgtTrnSdt;
	}


	public String getPgtTrnEdt() {
		return pgtTrnEdt;
	}


	public void setPgtTrnEdt(String pgtTrnEdt) {
		this.pgtTrnEdt = pgtTrnEdt;
	}
	
	
	public Integer getextrBasAmt() {
		return extrBasAmt;
	}


	public void setextrBasAmt(Integer extrBasAmt) {
		this.extrBasAmt = extrBasAmt;
	}
	
	public String getTgtTrnEdtYymm() {
		return tgtTrnEdtYymm;
	}
	public void setTgtTrnEdtYymm(String tgtTrnEdtYymm) {
		this.tgtTrnEdtYymm = tgtTrnEdtYymm;
	}
	public String getTgtTrnSdtYymm() {
		return tgtTrnSdtYymm;
	}
	public void setTgtTrnSdtYymm(String tgtTrnSdtYymm) {
		this.tgtTrnSdtYymm = tgtTrnSdtYymm;
	}
}

