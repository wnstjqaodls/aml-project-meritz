package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03;

import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 보고지표 관리
 * </pre>
 * @author 김홍진
 * @version 1.0
 * @history 1.0 2016-12-20
 */
public class RBA_90_01_03_02 extends GetResultObject {

  private static RBA_90_01_03_02 instance = null;

  /**
   * getInstance
   * @return RBA_10_05_04_02
   */
	public static  RBA_90_01_03_02 getInstance() {
		synchronized(RBA_90_01_03_02.class) {
			if (instance == null) {
				instance = new RBA_90_01_03_02();
			}
		}
		return instance;
	}

  /**
   * <pre>
   * 보고지표 조회
   * </pre>
   * @param input
   * @return
   */
  public DataObj doSearch(DataObj input) {
    DataObj output = null;
    DataSet gdRes = null;

    try {

      output = MDaoUtilSingle.getData("RBA_90_01_03_02_doSearch", input);

      if (output.getCount("JIPYO_IDX") > 0) {
        gdRes = Common.setGridData(output);
      }
      /*
      else {
        output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
      }
      */

      output.put("ERRCODE", "00000");
      output.put("gdRes", gdRes);

    } catch (AMLException e) {
      Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
      output = new DataObj();
      output.put("ERRCODE", "00001");
      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    }
    return output;
  }

  /**
   * @param input
   * @return
   */
  @SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
public DataObj doSave(DataObj input) throws AMLException {
    DataObj output = null;
    MDaoUtil db = null;
    try {

      List gdReq = (List) input.get("gdReq");
      EvalScoreCalculationAction evlScoreCal = new EvalScoreCalculationAction();

      db = new MDaoUtil();
      db.begin();


      int gdReq_size = gdReq.size();
      for (int i = 0; i < gdReq_size ; i++) {

        HashMap<Object, Object> inputRow = (HashMap) gdReq.get(i);

        String RPT_GJDT = Util.nvl(inputRow.get("RPT_GJDT"), "");
        String JIPYO_IDX = Util.nvl(inputRow.get("JIPYO_IDX"), "");
        String IN_V = Util.nvl(inputRow.get("IN_V"), "");
        String MAX_IN_V = Util.nvl(inputRow.get("MAX_IN_V"), "");

        inputRow.put("RPT_GJDT", (Util.nvl(inputRow.get("RPT_GJDT"), "")));
        inputRow.put("JIPYO_IDX",(Util.nvl(inputRow.get("JIPYO_IDX"), "")));
        inputRow.put("IN_V",(Util.nvl(inputRow.get("IN_V"), "0")));

        inputRow.put("ITEM_S_C","1");															//항목상태 HIDDEN ('A010', 0:미확정, 1:저장, 2:확정)
        inputRow.put("MAX_IN_V",(Util.nvl(inputRow.get("MAX_IN_V"), "0")));
        inputRow.put("DR_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId());
        inputRow.put("CHG_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId());


        inputRow.put("RPT_PNT", Util.nvl(evlScoreCal.EvalScoreCalculationResult(RPT_GJDT ,JIPYO_IDX,IN_V, MAX_IN_V),"0") );	//보고점수

        db.setData("RBA_90_01_03_02_doMerge", inputRow);
        db.setData("RBA_90_01_03_02_doMerge2", inputRow);

      }
      db.commit();


//보고기준일자
//지표ID
//입력값


      output = new DataObj();
      output.put("ERRCODE", "00000");
      output.put("ERRMSG",MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"), "정상처리되었습니다..."));
      output.put("WINMSG",MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"), "정상처리되었습니다."));
      output.put("gdRes", null); // Grid Data

    } catch (RuntimeException re) {
      try {
        if (db != null) {
          db.rollback();
          db.close();
        }
      } catch (Exception ee) {
        if (output != null) {
          try {
            output.close();
          } catch (Exception e1) {
            output = null;
          }
        }
      }
      Log.logAML(Log.ERROR, this, "doSave",re.getMessage());

      output = new DataObj();
      output.put("ERRCODE", "00001");
      output.put("ERRMSG",re.toString());
    } catch (Exception e) {
      try {
        if (db != null) {
          db.rollback();
          db.close();
        }
      } catch (Exception ee) {
        if (output != null) {
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
        if (db != null) {
          db.close();
        }
      } catch (Exception ee) {
        if (output != null) {
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