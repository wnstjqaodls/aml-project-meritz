/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLWALB;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.gtone.wlf.core.data.SData;


/**
 * 
*<pre>
* 필터링에 필요한 Input과 결과 Output object
* フィルタリングに必要なinputと結果outputオブジェクト
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class WLE_IO_Object {
    private WLE_Input m_Input = null;
    private WLE_Output m_Output = null;

    
    /**
     * <pre>
     * 필터링에 필요한 Input Object를 반환한다.
     * フィルタリングに必要なinputオブジェクトを返す。
     * @en
     * </pre>
     *@return
     */
    public WLE_Input getInputData() {
        if(m_Input == null) m_Input = new WLE_Input();
        return m_Input;
    }

    /**
     * <pre>
     * 필터링 결과 Output Object를 반환한다.
     * フィルタリング結果outputオブジェクトを返す。
     * @en
     * </pre>
     *@return
     */
    public WLE_Output getOutputData() {
        if(m_Output == null) m_Output = new WLE_Output();
        return m_Output;
    }

    private String NVL(String val) {
        return NVL(val, null);
    }
    private String NVL(String val, String except) {
        if(except != null) {
            if(except.equalsIgnoreCase(val))
                return "";
        }
        return val != null ? val.trim() : "";
    }
    
    

    private static int RNMCNO_INDEX = -1;
    private static int CS_NM_INDEX = -1;
    private static int ENG_CS_NM_INDEX = -1;
    private static int NTN_CD_INDEX = -1;
    private static int DOB_INDEX = -1;
    private static int SEX_CD_INDEX = -1;
    private static int INDV_CORP_CCD_INDEX= -1;
    private static int RLT_CD_INDEX= -1;
    private static int RLT_SQ_INDEX= -1;
    private static Object[][] INPUT_COLUMN_INFO = null;
    private static int NTV_FGNR_CCD_INDEX = -1;
    private static int WL_RELATED_PER_CODE_INDEX = -1;
    
    /**
     * <pre>
     * 필터링 결과중에서 주요 필드(AML_CUST_ID,CS_NM,NTV_FGNR_CCD)의 index를 찾는다.
     * フィルタリング結果の中から主要フィールド(AML_CUST_ID,CS_NM,NTV_FGNR_CCD)のインデックスを見つける。
     * @en
     * </pre>
     *@param rs
     *@throws SQLException
     */
    public static void setINDEXS(ResultSet rs) throws SQLException {
        int colCount = rs.getMetaData().getColumnCount();
        if(colCount >= 3) INPUT_COLUMN_INFO = new Object[colCount-3][2];
        else
            throw new SQLException("MainQuery must select AML_CUST_ID, CS_NM, NTV_FGNR_CCD[, ...]");
        for(int i = 0, j = 0; i < colCount; i++) {
            if("RNMCNO".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	RNMCNO_INDEX = i;
            else if("CS_NM".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
                CS_NM_INDEX = i;
            else if("ENG_CS_NM".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	ENG_CS_NM_INDEX = i;
            else if("NTN_CD".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	NTN_CD_INDEX = i;
            else if("DOB".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	DOB_INDEX = i;
            else if("SEX_CD".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	SEX_CD_INDEX = i;
            else if("INDV_CORP_CCD".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	INDV_CORP_CCD_INDEX = i;
            else if("RLT_CD".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	RLT_CD_INDEX = i;
            else if("RLT_SQ".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	RLT_SQ_INDEX = i;
            else if("NTV_FGNR_CCD".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	NTV_FGNR_CCD_INDEX = i;
            else if("WL_RELATED_PER_CODE".equalsIgnoreCase(rs.getMetaData().getColumnName(i+1)))
            	WL_RELATED_PER_CODE_INDEX = i;
            else {
                INPUT_COLUMN_INFO[j][0] = rs.getMetaData().getColumnName(i+1);
                INPUT_COLUMN_INFO[j][1] = i;
                j++;
            }
        }
    }
    
    /**
     * <pre>
     * 결과의 모든 컬럼 이름을 반환한다.
     * 結果のすべてのカラム名を返す。
     * @en
     * </pre>
     *@return
     */
    public static Object[][] getINPUT_COLUMN_INFO() {
        return INPUT_COLUMN_INFO;
    }
    
    
    /**
     * 
    *<pre>
    * 필터링에 필요한 Parameter
    * フィルタリングに必要な変数
    * @en
    *</pre>
    *@author syk, hikim
    *@version 1.0
    *@history 1.0 2010-09-30
     */
    public class WLE_Input {
        String[] m_Parm;
        String[] m_EtcParm;
        WLE_Input() {
            setParm(null);
            setEtcParm(null);
        }
        /**
         * <pre>
         * 필터링에 필요한 추가 Parameter을 반환한다., 예)procFlag가 ONE일 때 고객ID
         * フィルタリングに必要な追加変数を返す。例)procFlagがONEの場合、顧客ID
         * @en
        *</pre>
         *@return
         */
        public String[] getEtcParm() {
            return m_EtcParm;
        }
        
        /**
         * <pre>
         * 필터링에 필요한 추가 Parameter을 지정한다.
         * フィルタリングに必要な追加変数を指定する。
         * @en
        *</pre>
         *@param parm
         */
        public void setEtcParm(String[] parm) {
            m_EtcParm = parm;
        }
        
        /**
         * <pre>
         * 전체 parameter값을 반환한다.
         * すべてのパラメータ値を返す。
         * @en
        *</pre>
         *@return
         */
        public String[] getParm() {
            return m_Parm;
        }
        
        /**
         <pre>
         * 전체 parameter값을 지정한다. 
         * すべてのパラメータ値を指定する。
         * @en
        *</pre>
         *@param parm
         */
        public void setParm(String[] parm) {
            m_Parm = parm;
            if(parm == null) return;
            if(RNMCNO_INDEX >= 0) 
            {
            	RNMCNO = NVL(m_Parm[RNMCNO_INDEX]);
            }
            if(CS_NM_INDEX >= 0) 
            {
                 CS_NM = NVL(m_Parm[CS_NM_INDEX]);
            }
            if(ENG_CS_NM_INDEX >= 0) 
            {
            	ENG_CS_NM = NVL(m_Parm[ENG_CS_NM_INDEX]);
            }
            if(NTN_CD_INDEX >= 0)
            {
            	NTN_CD = NVL(m_Parm[NTN_CD_INDEX]);
            }
            if(DOB_INDEX >= 0)
            {
            	DOB=NVL(m_Parm[DOB_INDEX]);
            }
            if(SEX_CD_INDEX >= 0)
            {
            	SEX_CD=NVL(m_Parm[SEX_CD_INDEX]);
            }
            if(INDV_CORP_CCD_INDEX >= 0)
            {
            	INDV_CORP_CCD=NVL(m_Parm[INDV_CORP_CCD_INDEX]);
            }
            if(RLT_CD_INDEX >= 0)
            {
            	RLT_CD=NVL(m_Parm[RLT_CD_INDEX]);
            }
            if(RLT_SQ_INDEX >= 0)
            {
            	RLT_SQ=NVL(m_Parm[RLT_SQ_INDEX]);
            }
            if(NTV_FGNR_CCD_INDEX >= 0)
            {
                NTV_FGNR_CCD=NVL(m_Parm[NTV_FGNR_CCD_INDEX]);
            }
            if(WL_RELATED_PER_CODE_INDEX >= 0)
            {
            	WL_RELATED_PER_CODE=NVL(m_Parm[WL_RELATED_PER_CODE_INDEX]);
            }
        }
        
        /**
         * <pre>
         * 특정 index의 parameter값을 반환한다.
         * 特定インデックスのパラメータ値を返す。
         * @en
        *</pre>
         *@param index
         *@return
         *@throws SQLException
         */
        public String getParmVal(int index) throws SQLException {
            return NVL(m_Parm[index]);
        }
        
        /**
         * <pre>
         * 특정 index의 추가 parameter값을 반환한다.
         * 特定インデックスの追加パラメータ値を返す。
         * @en
         *</pre>
         *@param index
         *@return
         *@throws SQLException
         */
        public String getEtcParmVal(int index) throws SQLException {
            if(m_EtcParm != null && m_EtcParm.length>index)
            {
                return NVL(m_EtcParm[index]);
            }
            else
            {
                return "";
            }
             
        }
        
        /**
         * <pre>
         * 고객ID의 값을 반환한다.
         * 顧客IDの値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getRNMCNO() throws SQLException {
            return RNMCNO;
        }
        
        /**
         * <pre>
         * 고객명의 값을 반환한다.
         * 顧客IDの値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getCS_NM() throws SQLException {
        	return CS_NM;
        }
        
        /**
         * <pre>
         * 내외국인 여부를 반환한다.
         * 日本人/外国人の有無を返す。
         * @en
         *</pre>
         *@return
         *@throws Exception
         */
        public String getNTV_FGNR_CCD() throws SQLException {
            return NTV_FGNR_CCD;
        }
        
        /**
         * <pre>
         * wl유관인물구분코드 를 반환한다.
         * 日本人/外国人の有無を返す。
         * @en
         *</pre>
         *@return
         *@throws Exception
         */
        public String getWL_RELATED_PER_CODE() throws SQLException {
            return WL_RELATED_PER_CODE;
        }
        
        /**
         * <pre>
         * 영문고객명의 값을 반환한다.
         * 顧客IDの値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getENG_CS_NM() throws SQLException {
        	return ENG_CS_NM;
        }
        
        
        /**
         * <pre>
         * 국가코드 값을 반환한다.
         * 顧客名の値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getNTN_CD() throws SQLException {
            return NTN_CD;
        }
        
        
        /**
         * <pre>
         * 생년월일(설립일자) 값을 반환한다.
         * 顧客名の値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getDOB() throws SQLException {
        	return DOB;
        }
        
        
        /**
         * <pre>
         * 성별 값을 반환한다.
         * 顧客名の値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getSEX_CD() throws SQLException {
        	return SEX_CD;
        }
        
        
        /**
         * <pre>
         * 개인법인구분코드 값을 반환한다.
         * 顧客名の値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getINDV_CORP_CCD() throws SQLException {
        	return INDV_CORP_CCD;
        }
        
        
        /**
         * <pre>
         * 개인법인구분코드 값을 반환한다.
         * 顧客名の値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getRLT_CD() throws SQLException {
        	return RLT_CD;
        }
        
        
        /**
         * <pre>
         * 개인법인구분코드 값을 반환한다.
         * 顧客名の値を返す。
         * @en
         *</pre>
         *@return
         *@throws SQLException
         */
        public String getRLT_SQ() throws SQLException {
        	return RLT_SQ;
        }
    }
    
    /**
     * <pre>
         * 고객ID의 값을 지정한다.
         * 顧客IDの値を指定する。
         * @en
         *</pre>
     *@param aml_cust_id
     */
    public void setRNMCNO(String rnmcno) {
        RNMCNO = rnmcno;
    }

    /**
     * <pre>
         * 고객이름의 값을 지정한다.
         * 顧客名の値を指定する。
         * @en
         *</pre>
     *@param cs_nm
     */
    public void setCS_NM(String cs_nm) {
        CS_NM = cs_nm;
    }
    
    /**
     * <pre>
         * 내외국인 여부를 지정한다.
         * 日本人/外国人の有無を指定する。
         * @en
         *</pre>
     *@param ntv_fgnr_ccd
     */
    public void setNTV_FGNR_CCD(String ntv_fgnr_ccd) {
        NTV_FGNR_CCD = ntv_fgnr_ccd;
    }
    
    /**
     * <pre>
         * wl유관인물구분코드를 지정한다.
         * 日本人/外国人の有無を指定する。
         * @en
         *</pre>
     *@param wl_related_per_code
     */
    public void setWL_RELATED_PER_CODE(String wl_related_per_code) {
    	WL_RELATED_PER_CODE = wl_related_per_code;
    }
    
    /**
     * <pre>
     * 고객이름의 값을 지정한다.
     * 顧客名の値を指定する。
     * @en
     *</pre>
     *@param cs_nm
     */
    public void setENG_CS_NM(String eng_cs_nm) {
    	ENG_CS_NM = eng_cs_nm;
    }
    /**
     * <pre>
     * 고객ID의 값을 지정한다.
     * 顧客IDの値を指定する。
     * @en
     *</pre>
     *@param aml_cust_id
     */
    public void setNTN_CD(String ntn_cd) {
    	NTN_CD = ntn_cd;
    }
    
    /**
     * <pre>
     * 고객이름의 값을 지정한다.
     * 顧客名の値を指定する。
     * @en
     *</pre>
     *@param cs_nm
     */
    public void setDOB(String dob) {
    	DOB = dob;
    }
    	
    /**
     * <pre>
     * 고객이름의 값을 지정한다.
     * 顧客名の値を指定する。
     * @en
     *</pre>
     *@param cs_nm
     */
    public void setSEX_CD(String sex_cd) {
    	SEX_CD = sex_cd;
    }
    /**
     * <pre>
     * 고객이름의 값을 지정한다.
     * 顧客名の値を指定する。
     * @en
     *</pre>
     *@param cs_nm
     */
    public void setINDV_CORP_CCD(String indv_corp_ccd) {
    	INDV_CORP_CCD = indv_corp_ccd;
    }
    public void setRLT_CD(String rlt_cd) {
    	RLT_CD = rlt_cd;
    }
    public void setRLT_SQ(String rlt_sq) {
    	RLT_SQ = rlt_sq;
    }


    String RNMCNO;
    String CS_NM;
    String ENG_CS_NM;
    String NTN_CD;
    String DOB;
    String SEX_CD;
    String INDV_CORP_CCD;
    String RLT_CD;
    String RLT_SQ;
    String NTV_FGNR_CCD;
    String WL_RELATED_PER_CODE;
    /**
     * 
    *<pre>
    * 필터링 결과 object
    * フィルタリング結果オブジェクト
    * @en
    *</pre>
    *@author syk, hikim
    *@version 1.0
    *@history 1.0 2010-09-30
     */ 
    public class WLE_Output {
        List<SData> m_WLE_Output;
        
        @SuppressWarnings("rawtypes")
        HashMap fieldNameMap ;
        
        
        /**
         * <pre>
         * 필터링 결과 갯수를 반환한다.
         * フィルタリング結果の数を返す。
         * @en
         *</pre>
         *@return
         */
        public int getSize() {
            return m_WLE_Output != null ? m_WLE_Output.size() : 0;
        }
        
        public String getWLE_Output_RecValue(int row_index, String col_name)  {
            String val = m_WLE_Output.get(row_index).getString(col_name);
            if(val == null || "null".equals(val))
            {
                System.out.println(col_name + " NOT FOUND");
                return "";
            }
            return val;
            
        }
        
        public List<SData> getWLE_Output_Rec() {
        	return m_WLE_Output;
        }
        
        
        
        public void setWLE_Output_Rec(List<SData> result) {
        	if(m_WLE_Output != null) {
        		m_WLE_Output = new ArrayList<SData>(); 
        	}
            m_WLE_Output = result;
        }
        
    }
}
