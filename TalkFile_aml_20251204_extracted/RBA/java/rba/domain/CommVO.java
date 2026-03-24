package com.gtone.rba.domain;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class CommVO {

	private String basYymm;
	private String rbaBtchDt;
	private String ingStep;
	private String rbaBtchSdt;
	private String rbaBtchEdt;	
	private String rbaBtchSC;	//상태코드 (1:정상, 2:진행중, 9:오류)
	private String errCtnt;
	

	public CommVO(){
		super();
	}
	
	
	/**
	 * 생성자
	 * @param basYymm 기준년월
	 * @param ingStep 진행상태
	 * @param rbaBtchDt 배치일자
	 * @param rbaBtchSC 배치상태
	 * @param errCtnt 오류내용
	 */
	public CommVO(String basYymm, String ingStep, String rbaBtchDt, String rbaBtchSC, String errCtnt){
		super();
		this.basYymm = basYymm;
		this.ingStep = ingStep;
		this.rbaBtchDt = rbaBtchDt;
		this.rbaBtchSC = rbaBtchSC;
		this.errCtnt = errCtnt;
	}
	

	public String getBasYymm() {
		return basYymm;
	}


	public void setBasYymm(String basYymm) {
		this.basYymm = basYymm;
	}


	public String getRbaBtchDt() {
		return rbaBtchDt;
	}


	public void setRbaBtchDt(String rbaBtchDt) {
		this.rbaBtchDt = rbaBtchDt;
	}


	public String getIngStep() {
		return ingStep;
	}


	public void setIngStep(String ingStep) {
		this.ingStep = ingStep;
	}


	public String getRbaBtchSdt() {
		return rbaBtchSdt;
	}


	public void setRbaBtchSdt(String rbaBtchSdt) {
		this.rbaBtchSdt = rbaBtchSdt;
	}


	public String getRbaBtchEdt() {
		return rbaBtchEdt;
	}


	public void setRbaBtchEdt(String rbaBtchEdt) {
		this.rbaBtchEdt = rbaBtchEdt;
	}


	public String getRbaBtchSC() {
		return rbaBtchSC;
	}


	public void setRbaBtchSC(String rbaBtchSC) {
		this.rbaBtchSC = rbaBtchSC;
	}


	public String getErrCtnt() {
		return errCtnt;
	}


	public void setErrCtnt(String errCtnt) {
		this.errCtnt = errCtnt;
	}


	@Override
	public String toString(){
		return ToStringBuilder.reflectionToString(this,ToStringStyle.MULTI_LINE_STYLE).toString();
	}
}
