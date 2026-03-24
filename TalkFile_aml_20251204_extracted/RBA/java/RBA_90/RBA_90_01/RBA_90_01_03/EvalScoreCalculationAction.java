package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03;

import java.math.BigDecimal;
import java.util.HashMap;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import jspeed.base.property.PropertyService;

public class EvalScoreCalculationAction extends GetResultObject {
	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");

	public final static String JIPYOCCode = "O"; //위험구분 -> 운영위험
	public final static String VALTGCode1 = "1"; //평가구분 -> Range평가
	public final static String VALTGCode2 = "2"; //평가구분 -> 상대비율평가
	public final static String VALTGCode3 = "4"; //평가구분 -> 여부평가
	public final static String MaxInvZero = "0"; //0

	/**
	 * @param input
	 * RPT_GJDT 보고기준일자
	 * JIPYO_IDX 지표번호
	 * IN_V     입력값
	 * MAX_IN_V MAX값
	 * ALLT_PNT 배점
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String EvalScoreCalculationResult(String RPT_GJDT, String JIPYO_IDX, String IN_V, String MAX_IN_V) {

		DataObj output = null;
		MDaoUtil db = null;
		String VALT_G = ""; //평가구분
		String ALLT_PNT = ""; // 배점
		String RPT_PNT = "";

		try {

			if ( !("".equals(RPT_GJDT) || "".equals(JIPYO_IDX) || "".equals(IN_V)) ) {

				output = new DataObj();
				db = new MDaoUtil();
				db.begin();

				HashMap<Object, Object> val = new HashMap<Object, Object>();

				val.put("RPT_GJDT", RPT_GJDT); //보고기준일자
				val.put("CHECK_JIPYO_IDX", JIPYO_IDX); //지표번호
				val.put("JIPYO_C", JIPYOCCode); //운영위험

				//Range평가 ,여부평가, 상대비율평가
				output = MDaoUtilSingle.getData("RBA_90_01_03_02_doSearch", val);

				if ( output.getCount("VALT_G") > 0 ) {
					VALT_G = Util.nvl(output.get("VALT_G", 0).toString(), ""); //평가구분
					ALLT_PNT = Util.nvl(output.get("ALLT_PNT", 0).toString(), ""); //배점

				}

				//평가구분체크
				if ( !("".equals(VALT_G)) ) {

					//상대비율평가
					//MAX입력값이 0이면 안됨
					if ( VALTGCode2.equals(VALT_G) && !("".equals(MAX_IN_V) || MaxInvZero.equals(MAX_IN_V)) ) {

						//Step 1. 입력값 변환 (입력값 / Max(입력값))*배점 → 소수이하 둘째자리 반올림
						RPT_PNT = String.valueOf(new BigDecimal(IN_V).divide(new BigDecimal(MAX_IN_V), 2, BigDecimal.ROUND_HALF_UP).multiply(new BigDecimal(ALLT_PNT)));

						//Range평가 ,여부평가	  
					} else if ( VALTGCode1.equals(VALT_G) || VALTGCode3.equals(VALT_G) ) {

						HashMap<Object, Object> map = new HashMap<Object, Object>();

						map.put("RPT_GJDT", RPT_GJDT);
						map.put("JIPYO_IDX", JIPYO_IDX);
						map.put("IN_V", IN_V);

						RPT_PNT = MDaoUtilSingle.getData("RBA_90_01_03_01_calculateJipyoScore", map).getText("CAL_PNT");
					}
				}

				db.commit();
			}

		} catch (RuntimeException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, new EvalScoreCalculationAction(), "doSave", re.getMessage());

		} catch (AMLException e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, new EvalScoreCalculationAction(), "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}

		return RPT_PNT;
	}

}
