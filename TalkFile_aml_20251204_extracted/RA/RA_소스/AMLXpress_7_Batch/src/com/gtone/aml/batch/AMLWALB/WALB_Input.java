package com.gtone.aml.batch.AMLWALB;

import com.gtone.aml.batch.common.util.InputUtil;
/**
 * 
*<pre>
* WatchList 필터링 배치를 위한 외부 parameter
* WatchListフィルタリングバッチのための外部パラメータ
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class WALB_Input extends InputUtil {
	
	private boolean bChkNtn = false;
	private String  sNtvFgnrCcd = "N";

	public boolean isbChkNtn() {
		return bChkNtn;
	}

	public void setbChkNtn(boolean bChkNtn) {
		this.bChkNtn = bChkNtn;
	}

	public String getsNtvFgnrCcd() {
		return sNtvFgnrCcd;
	}

	public void setsNtvFgnrCcd(String sNtvFgnrCcd) {
		this.sNtvFgnrCcd = sNtvFgnrCcd;
	}	
     
}
