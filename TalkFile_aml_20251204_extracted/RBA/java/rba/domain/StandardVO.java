package com.gtone.rba.domain;

import java.math.BigDecimal;

import jbit.core.domain.DefaultVO;

public class StandardVO extends DefaultVO<StandardVO>{

	private static final long serialVersionUID = 6315383592146036723L;
	
	private String basYyyy;		//기준년도
	private String basYymm;		//기준년월
	private Integer valtTrn;	//평가회차
	private String natBC;		//국가분튜코드
	private String natC;		//국가코드
	private String natBNm;		//국가분류명
	private String natNm;		//국가명
	private String srvcGC;		//서비스구분코드
	private String gdsNo;		//상품코드
	private String srvcGNm;		//서비스구분명
	private String jobBC;		//직업분류코드
	private String jobC;		//직업코드(업종)
	private String jobBNm;		//직업분류명
	private String jobNm;		//직업명
	
	private String rskCatg;			//위험카테고리
	private String rskFac;			//위험factor
	private String rskEvt;			//위험이벤트
	private String rnmcno;			//고객번호
	
	//거래원장
	private String dlDt;			//거래일자
	private Integer dlSq;			//거래일련번호
	private String gnlAcNo;			//계약번호
	private String chnlClsnCode;	//거래채널 대분류 코드
	private String dlChnnlCd;		//거래채널코드
	private String dlTypCd;			//거래종류코드
	
	private String handlngBrnCd;	//취급지점코드
	private String mnggBrnCd;		//관리지점코드
	private String prftBrnCd;		//실적지점코드
	
	private String acntTypeClsnCode;//계좌유형분류코드
	private String prdtClsnCode;	//금융상품분류코드
	private String servClsnCode;	//금융서비스분류코드
		
	private BigDecimal dlAmt;		//거래금액
	
	
	//고객정보 원장	
	private String 	csNm;			//고객명		
	private String	ntnCd;			//국가코드
	private String	indvCorpCcd;	//개인법인구분
	private String	indstRskDvdCd;	//업종코드
	private String	ocptnCd;		//직업코드
	private String	lgAmtAstsYn;	//고액자산가여부
	private String	pepYn;			//pep여부
	private String	unageAgedYn;	//미성자고령자여부
	private String	newEstbCorpYn;	//신설법인여부
	private String	nprftGroupYn;	//비영리단체여부

	
	//대상년월
	private String tgtTrnSdt;
	private String tgtTrnEdt;
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
	public Integer getValtTrn() {
		return valtTrn;
	}
	public void setValtTrn(Integer valtTrn) {
		this.valtTrn = valtTrn;
	}
	public String getNatBC() {
		return natBC;
	}
	public void setNatBC(String natBC) {
		this.natBC = natBC;
	}
	public String getNatC() {
		return natC;
	}
	public void setNatC(String natC) {
		this.natC = natC;
	}
	public String getNatBNm() {
		return natBNm;
	}
	public void setNatBNm(String natBNm) {
		this.natBNm = natBNm;
	}
	public String getNatNm() {
		return natNm;
	}
	public void setNatNm(String natNm) {
		this.natNm = natNm;
	}
	public String getSrvcGC() {
		return srvcGC;
	}
	public void setSrvcGC(String srvcGC) {
		this.srvcGC = srvcGC;
	}
	public String getGdsNo() {
		return gdsNo;
	}
	public void setGdsNo(String gdsNo) {
		this.gdsNo = gdsNo;
	}
	public String getSrvcGNm() {
		return srvcGNm;
	}
	public void setSrvcGNm(String srvcGNm) {
		this.srvcGNm = srvcGNm;
	}
	public String getJobBC() {
		return jobBC;
	}
	public void setJobBC(String jobBC) {
		this.jobBC = jobBC;
	}
	public String getJobC() {
		return jobC;
	}
	public void setJobC(String jobC) {
		this.jobC = jobC;
	}
	public String getJobBNm() {
		return jobBNm;
	}
	public void setJobBNm(String jobBNm) {
		this.jobBNm = jobBNm;
	}
	public String getJobNm() {
		return jobNm;
	}
	public void setJobNm(String jobNm) {
		this.jobNm = jobNm;
	}
	public String getRskCatg() {
		return rskCatg;
	}
	public void setRskCatg(String rskCatg) {
		this.rskCatg = rskCatg;
	}
	public String getRskFac() {
		return rskFac;
	}
	public void setRskFac(String rskFac) {
		this.rskFac = rskFac;
	}
	public String getRskEvt() {
		return rskEvt;
	}
	public void setRskEvt(String rskEvt) {
		this.rskEvt = rskEvt;
	}
	public String getRnmcno() {
		return rnmcno;
	}
	public void setRnmcno(String rnmcno) {
		this.rnmcno = rnmcno;
	}
	public String getDlDt() {
		return dlDt;
	}
	public void setDlDt(String dlDt) {
		this.dlDt = dlDt;
	}
	public Integer getDlSq() {
		return dlSq;
	}
	public void setDlSq(Integer dlSq) {
		this.dlSq = dlSq;
	}
	public String getGnlAcNo() {
		return gnlAcNo;
	}
	public void setGnlAcNo(String gnlAcNo) {
		this.gnlAcNo = gnlAcNo;
	}
	public String getChnlClsnCode() {
		return chnlClsnCode;
	}
	public void setChnlClsnCode(String chnlClsnCode) {
		this.chnlClsnCode = chnlClsnCode;
	}
	public String getDlChnnlCd() {
		return dlChnnlCd;
	}
	public void setDlChnnlCd(String dlChnnlCd) {
		this.dlChnnlCd = dlChnnlCd;
	}
	public String getDlTypCd() {
		return dlTypCd;
	}
	public void setDlTypCd(String dlTypCd) {
		this.dlTypCd = dlTypCd;
	}
	public String getHandlngBrnCd() {
		return handlngBrnCd;
	}
	public void setHandlngBrnCd(String handlngBrnCd) {
		this.handlngBrnCd = handlngBrnCd;
	}
	public String getMnggBrnCd() {
		return mnggBrnCd;
	}
	public void setMnggBrnCd(String mnggBrnCd) {
		this.mnggBrnCd = mnggBrnCd;
	}
	public String getPrftBrnCd() {
		return prftBrnCd;
	}
	public void setPrftBrnCd(String prftBrnCd) {
		this.prftBrnCd = prftBrnCd;
	}
	public String getAcntTypeClsnCode() {
		return acntTypeClsnCode;
	}
	public void setAcntTypeClsnCode(String acntTypeClsnCode) {
		this.acntTypeClsnCode = acntTypeClsnCode;
	}
	public String getPrdtClsnCode() {
		return prdtClsnCode;
	}
	public void setPrdtClsnCode(String prdtClsnCode) {
		this.prdtClsnCode = prdtClsnCode;
	}
	public String getServClsnCode() {
		return servClsnCode;
	}
	public void setServClsnCode(String servClsnCode) {
		this.servClsnCode = servClsnCode;
	}
	public BigDecimal getDlAmt() {
		return dlAmt;
	}
	public void setDlAmt(BigDecimal dlAmt) {
		this.dlAmt = dlAmt;
	}
	public String getCsNm() {
		return csNm;
	}
	public void setCsNm(String csNm) {
		this.csNm = csNm;
	}
	public String getNtnCd() {
		return ntnCd;
	}
	public void setNtnCd(String ntnCd) {
		this.ntnCd = ntnCd;
	}
	public String getIndvCorpCcd() {
		return indvCorpCcd;
	}
	public void setIndvCorpCcd(String indvCorpCcd) {
		this.indvCorpCcd = indvCorpCcd;
	}
	public String getIndstRskDvdCd() {
		return indstRskDvdCd;
	}
	public void setIndstRskDvdCd(String indstRskDvdCd) {
		this.indstRskDvdCd = indstRskDvdCd;
	}
	public String getOcptnCd() {
		return ocptnCd;
	}
	public void setOcptnCd(String ocptnCd) {
		this.ocptnCd = ocptnCd;
	}
	public String getLgAmtAstsYn() {
		return lgAmtAstsYn;
	}
	public void setLgAmtAstsYn(String lgAmtAstsYn) {
		this.lgAmtAstsYn = lgAmtAstsYn;
	}
	public String getPepYn() {
		return pepYn;
	}
	public void setPepYn(String pepYn) {
		this.pepYn = pepYn;
	}
	public String getUnageAgedYn() {
		return unageAgedYn;
	}
	public void setUnageAgedYn(String unageAgedYn) {
		this.unageAgedYn = unageAgedYn;
	}
	public String getNewEstbCorpYn() {
		return newEstbCorpYn;
	}
	public void setNewEstbCorpYn(String newEstbCorpYn) {
		this.newEstbCorpYn = newEstbCorpYn;
	}
	public String getNprftGroupYn() {
		return nprftGroupYn;
	}
	public void setNprftGroupYn(String nprftGroupYn) {
		this.nprftGroupYn = nprftGroupYn;
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
