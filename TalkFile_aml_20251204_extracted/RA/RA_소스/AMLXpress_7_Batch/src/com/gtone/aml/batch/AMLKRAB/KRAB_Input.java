package com.gtone.aml.batch.AMLKRAB;

import com.gtone.aml.batch.common.util.InputUtil;

/**
 * 
*<pre>
* KYC RA 배치의 외부 parameter
* KYC RAバッチの外部parameter
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class KRAB_Input extends InputUtil {
     String runDate;

     /**
      * <pre>
      * 배치 실행일을 반환한다.
      * バッチ実行日を返す。
      * @en
      * </pre>
      *@return
      */
    public String getRunDate() {
        return runDate;
    }

    /**
     * <pre>
     * 배치 실행일을 지정한다.
     * バッチ実行日を指定する。
     * @en
     * </pre>
     *@param runDate
     */
    public void setRunDate(String runDate) {
        this.runDate = runDate;
    }

 
}
