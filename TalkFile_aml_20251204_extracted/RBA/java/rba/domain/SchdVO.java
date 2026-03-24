package com.gtone.rba.domain;

import jbit.core.domain.DefaultVO;


/**
 * 스케쥴 vo class
 * @author jacky
 *
 */
public class SchdVO extends DefaultVO<SchdVO>{

	private static final long serialVersionUID = 6542852096705811516L;
	
	private String basYyyy;
	private String basYymm;
	private String basLong;         //
	private String ptrYymm; 		//파티션 삭제
	
	private String rskMngActC;		//위험관리 활동코드
	private String rskMngActDtlC;	//위험관리 활동 상세코드
	private String valtTrn;		//평가회차
	private String ingTrn;			//진행중인회차
	private String valtSdt;			//평가시작일
	private String valtEdt;			//평가종료일
	private String realEdt;			//실제종료일
	private String tgtTrnSdt;		//평가대상 시작일자		
	private String tgtTrnEdt;		//평가대상 종료일자	
	
	private String pgtTrnSdt;		//평가대상 전월 시작일자		
	private String pgtTrnEdt;		//평가대상 전월 종료일자
	
	
	private String ingStep;			//진행단계
	private Integer fixYn;			//확정여부
	private Integer extrBasAmt;
	
	
	
	/**
	 * 최초 10 ( 노출위험 추출 )
	 * 평가지점 확정 20
	 * @author TD4438
	 *
	 */
	public static enum ING_STEP{
		STEP01("40"),
		STEP02("60"),
		STEP03("70"),
		STEP01_END("41"),
		STEP02_END("61"),
		STEP03_END("71"),
		STEPEND("99")
		;
		
		String val;
		
		ING_STEP(String val){
			this.val = val;
		}
		
		public String getValue()
		{
			return val;
		}
		
		public String getName()
		{
			return name();
		}
		
	}


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


	public String getPtrYymm() {
		return ptrYymm;
	}


	public void setPtrYymm(String ptrYymm) {
		this.ptrYymm = ptrYymm;
	}

	public String getRskMngActC() {
		return rskMngActC;
	}


	public void setRskMngActC(String rskMngActC) {
		this.rskMngActC = rskMngActC;
	}


	public String getRskMngActDtlC() {
		return rskMngActDtlC;
	}


	public void setRskMngActDtlC(String rskMngActDtlC) {
		this.rskMngActDtlC = rskMngActDtlC;
	}


	public String getValtTrn() {
		return valtTrn;
	}


	public void setValtTrn(String valtTrn) {
		this.valtTrn = valtTrn;
	}


	public String getIngTrn() {
		return ingTrn;
	}


	public void setIngTrn(String ingTrn) {
		this.ingTrn = ingTrn;
	}


	public String getValtSdt() {
		return valtSdt;
	}


	public void setValtSdt(String valtSdt) {
		this.valtSdt = valtSdt;
	}


	public String getValtEdt() {
		return valtEdt;
	}


	public void setValtEdt(String valtEdt) {
		this.valtEdt = valtEdt;
	}


	public String getRealEdt() {
		return realEdt;
	}


	public void setRealEdt(String realEdt) {
		this.realEdt = realEdt;
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
	
	
	
	


	public String getIngStep() {
		return ingStep;
	}


	public void setIngStep(String ingStep) {
		this.ingStep = ingStep;
	}


	public Integer getFixYn() {
		return fixYn;
	}


	public void setFixYn(Integer fixYn) {
		this.fixYn = fixYn;
	}
	
	
	
	public Integer getextrBasAmt() {
		return extrBasAmt;
	}


	public void setextrBasAmt(Integer extrBasAmt) {
		this.extrBasAmt = extrBasAmt;
	}
	
}
