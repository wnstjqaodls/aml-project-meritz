package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_05;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 보고지표결과현황
 * </pre>
 * @author SeungRok
 * @version 1.0
 * @hisory 17.01.10
 **/

public class RBA_90_01_05_01 extends GetResultObject {

  private static RBA_90_01_05_01 instance = null;

	public static  RBA_90_01_05_01 getInstance() {
		synchronized(RBA_90_01_05_01.class) {
			if (instance == null) {
				instance = new RBA_90_01_05_01();
			}
		}
		return instance;
	}

  public DataObj doSearch(DataObj input) {
    DataObj output = null;
    DataSet gdRes = null;

    try {

      // FIU보고서 조회
      output = MDaoUtilSingle.getData("RBA_90_01_05_01_dosearch", input);
      if (output.getCount("JIPYO_IDX") > 0) {
        gdRes = Common.setGridData(output);
      } else {
        output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
      }

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

  public DataObj getSearchRslt(DataObj input) {

    DataObj output = new DataObj();
    DataSet gdRes = null;

    try {
    	//String query_id = "RBA_90_01_05_02_dosearch";
        String query_id = "RBA_90_01_05_02_dosearch2";
      output = MDaoUtilSingle.getData(query_id, input);

      if (output.getCount("CNT") > 0) {
        gdRes = Common.setGridData(output);
        output.put("ERRCODE", "00000");
      } else {
        output.put( "ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
        output.put( "WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
      }

      output.put("ERRCODE", "00000");
      output.put("gdRes", gdRes);
    } catch (AMLException e) {
      Log.logAML(Log.ERROR, this, "getSearchRslt(Exception)", e.getMessage());
      output = new DataObj();
      output.put("ERRCODE", "00001");
      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    }
    return output;
  }

}
