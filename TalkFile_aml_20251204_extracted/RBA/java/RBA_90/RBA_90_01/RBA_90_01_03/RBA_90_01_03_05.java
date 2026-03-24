package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03;

import java.io.IOException;
import java.sql.SQLException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.express.server.dao.MCommonDAOSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.jdbc.CacheResultSet;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

public class RBA_90_01_03_05 extends GetResultObject {

	private static RBA_90_01_03_05 instance = null;

	/**
	 * getInstance
	 * @return RBA_90_01_03_05
	 */
	public static  RBA_90_01_03_05 getInstance() {
		synchronized(RBA_90_01_03_05.class) {
		if ( instance == null ) {
			instance = new RBA_90_01_03_05();
		}
		}
		return instance;
	}

	/**
	 * <pre>
	 * 
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj getSearchEvaluationCode(DataObj input) {
		DataObj output = null;
		MCommonDAOSingle mDaos = null;
		CacheResultSet EvalCmprV = null;
		CacheResultSet EvalCmprCalC = null;
		DataSet gdRes = null;
		StringBuffer buf = new StringBuffer(2048);

		try {
			//		      String  RPT_GJDT =     	  Util.nvl(input.getText("RPT_GJDT") , "");
			String IN_V_TP_C = Util.nvl(input.getText("IN_V_TP_C"), "");
			//		      String  CNCT_JIPYO_C_I =     	  Util.nvl(input.getText("CNCT_JIPYO_C_I") , "");

			mDaos = new MCommonDAOSingle();
			buf = new StringBuffer(1024);

			buf.append("<tr>  \n");
			buf.append("<td class='tbl_Top' width='5%'><input type='checkbox' id='EVAL_DATE_SEL' name='EVAL_DATE_SEL' /></td>  \n");
			buf.append("<td class='tbl_Top' width='20%'><input type='text' class='input_text' onkeyup='onlyNumber1(this);' onkeypress='onlyNumber1(this);'  id='CAL_PNT' name='CAL_PNT' /></td>  \n");
			buf.append("<td class='tbl_Top' width='20%'>  \n");

			input.put("GRP_CD", "A009");
			EvalCmprCalC = mDaos.executeQuery("RBA_90_01_02_05_getSearchEvaluationCode", input); //산식코드(A009)
			if ( EvalCmprCalC != null ) {
				buf.append("<select id='JIPYO_CMPR_CAL_C' name='JIPYO_CMPR_CAL_C' style='width: 100%' class='selectBox_01'>  \n");
				while (EvalCmprCalC.next()) {
					String DTL_CD = StringHelper.nvl(EvalCmprCalC.getString("DTL_CD"), "");
					String DTL_NM = StringHelper.nvl(EvalCmprCalC.getString("DTL_NM"), "");
					buf.append("<option value='");
					buf.append(DTL_CD);
					buf.append("'>");
					buf.append(DTL_NM);
					buf.append("</option>  \n");
				}
				buf.append("</select>  \n");
			}
			buf.append("</td>  \n");
			buf.append("<td class='tbl_Top' width='53%'>  \n");
			if ( "C".equals(IN_V_TP_C) ) { //CODE
				input.put("GRP_CD", Util.nvl(input.getText("CNCT_JIPYO_C_I"), ""));
				EvalCmprV = mDaos.executeQuery("RBA_90_01_02_05_getSearchEvaluationCode", input); //비교값
				if ( EvalCmprV == null ) {
					buf.append("<select id='JIPYO_CMPR_CAL_C' name='JIPYO_CMPR_CAL_C' style='width: 100%' class='selectBox_01' >  \n");
					buf.append("<option value=''></option>  \n");
					buf.append("</select>  \n");
				} else {
					buf.append("<select id='JIPYO_CMPR_CAL_C' name='JIPYO_CMPR_CAL_C' style='width: 100%' class='selectBox_01' >  \n");
					while (EvalCmprV.next()) {
						String DTL_CD = StringHelper.nvl(EvalCmprV.getString("DTL_CD"), "");
						String DTL_NM = StringHelper.nvl(EvalCmprV.getString("DTL_NM"), "");
						buf.append("<option value='");
						buf.append(DTL_CD);
						buf.append("'>");
						buf.append(DTL_NM);
						buf.append("</option>  \n");
					}

					buf.append("</select> \n");
				}

			} else if ( "N".equals(IN_V_TP_C) ) { //NUMBER
				buf.append("<input type='text' class='input_text' onkeyup='onlyNumber1(this);' onkeypress='onlyNumber1(this);' id='JIPYO_CMPR_CAL_C' name='JIPYO_CMPR_CAL_C'  />  \n");

			} else { //TEXT
				buf.append("<input type='text' class='input_text' id='JIPYO_CMPR_CAL_C' name='JIPYO_CMPR_CAL_C' />  \n");
			}

			buf.append("</td>  \n");
			System.out.println("buf.toString :: " + buf.toString());

			DataObj resultDataobj = new DataObj();
			resultDataobj.put("RESULT", buf);
			gdRes = Common.setGridData(resultDataobj);

			output = new DataObj();
			output.put("gdRes", gdRes);
			output.put("ERRCODE", "00000");

		} catch (SQLException ioe) {
			Log.logAML(Log.ERROR, this, "getSearchEvaluationCode(SQLException)", ioe.toString());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
		} catch (IOException ioe) {
			Log.logAML(Log.ERROR, this, "getSearchEvaluationCode(IOException)", ioe.toString());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
		} catch (RuntimeException re) {
			Log.logAML(Log.ERROR, this, "getSearchEvaluationCode(RuntimeException)", re.toString());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "getSearchEvaluationCode(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**
	 * 
	 * @param input
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public DataObj doSave(DataObj input) {
		DataObj output = null;
		MDaoUtil db = null;
		try {

			db = new MDaoUtil();
			db.begin();

			db.setData("RBA_90_01_02_03_DELETE_JRBA_JIPYO_BAS_I", input); //삭제
			int number = Integer.valueOf(input.get("trCnt").toString());

			for ( int i = 0; i < number; i++ ) {

				DataObj param = new DataObj();

				int SNO = i + 1;
				input.put("SNO", SNO);

				//param.put("EVAL_DATE_SEL", StringHelper.evl(input.get("EVAL_DATE_SEL",i), "")); 체크박스 여부
				param.put("SNO", SNO);
				param.put("RPT_GJDT", StringHelper.evl(input.get("RPT_GJDT"), ""));
				param.put("JIPYO_IDX", StringHelper.evl(input.get("JIPYO_IDX"), ""));
				param.put("CAL_PNT", StringHelper.evl(input.get("CAL_PNT", i), ""));
				param.put("JIPYO_CMPR_CAL_C", StringHelper.evl(input.get("JIPYO_CMPR_CAL_C", i), ""));
				param.put("CMPR_V", StringHelper.evl(input.get("CMPR_V", i), ""));
				param.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
				param.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

				db.setData("RBA_90_01_02_03_INSERT_JRBA_JIPYO_BAS_I", param); //삭제

			}

			db.commit();

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Grid Data

		} catch (NumberFormatException re) {
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
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (AMLException re) {
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
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
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
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (Exception e) {
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
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
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
		return output;
	}
}