package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * FIU 지표등록관리
 * </pre>
 * @author 권얼
 * @version 1.0
 * @history 1.0 2018-12-13
 */
public class RBA_90_01_03_07 extends GetResultObject {

  private static RBA_90_01_03_07 instance = null;
  public static final String ITEM_S_C_1	= "1";

  /**
   * getInstance
   * @return RBA_90_01_03_07
   */
	public static  RBA_90_01_03_07 getInstance() {
		synchronized(RBA_90_01_03_07.class) {
			if (instance == null) {
				instance = new RBA_90_01_03_07();
			}
		}
		return instance;
	}

  public DataObj doSearch(DataObj input) {
	  DataObj output = new DataObj();
	  DataSet gdRes = null;

	  try {

		  output = MDaoUtilSingle.getData("RBA_90_01_03_07_doSearch", input);

		  if (output.getCount("RPT_GJDT") > 0) {
		      gdRes = Common.setGridData(output);

		  }
		  /*
		  else {
		      output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
		      output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
		  }
		  */
		  output.put("ERRCODE", "00000");
		  output.put("gdRes", gdRes);

	  } catch(AMLException e) {
		  Log.logAML(Log.ERROR, this, "doSearch", e.getMessage());

		  output = new DataObj();
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }
	  return output;
  }

  public DataObj doSave(DataObj input) {
	  DataObj output = new DataObj();

	  try {
//		  input.put("ITEM_S_C", ITEM_S_C_1);				//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
		  input.put("DR_OP_JKW_NO", ((SessionHelper)input.get("SessionHelper")).getUserId().intValue());
		  MDaoUtilSingle.setData("RBA_90_01_03_07_doMerge_JRBA_JIPYO_V", input);
		  MDaoUtilSingle.setData("RBA_90_01_03_07_doUpdate_JRBA_JIPYO_MM_I", input);

		  output.put("ERRCODE", "00000");
		  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("gdRes", null); // Grid Data

	  } catch (AMLException e) {
		  Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

		  output = new DataObj();
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }
	  return output;
  }
}