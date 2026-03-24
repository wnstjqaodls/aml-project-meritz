package com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_02;

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
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 위험평가 일정관리
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-19
 */
public class RBA_50_01_02_01 extends GetResultObject {

	private static RBA_50_01_02_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_01_02_01
	*/
	public static  RBA_50_01_02_01 getInstance() {
		synchronized(RBA_50_01_02_01.class) {
			if (instance == null) {
				instance = new RBA_50_01_02_01();
			}
		}
		return instance;
	}


	public DataObj doSearch00(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_01_02_01_getSearch00", input);
			// grid data
			if (output.getCount("BAS_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch00(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	/**
	   * <pre>
	   * 평가 등록지점조회
	   * </pre>
	   * @param input
	   * @return
	   */
	public DataObj doSearchBrno(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_01_02_01_getSearchBrno", input);
			// grid data
			if (output.getCount("BRNO") > 0) {
				gdRes = Common.setGridData(output);
			} /*else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearchBrno(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	  /**
	   * <pre>
	   * 평가 미등록지점조회
	   * </pre>
	   * @param input
	   * @return
	   */
	public DataObj doSearchBrno2(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_01_02_01_getSearchBrno2", input);
			// grid data
			if (output.getCount("BRNO") > 0) {
				gdRes = Common.setGridData(output);
			} /*else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearchBrno2(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	  /**
	   * <pre>
	   * 평가지점관리
	   * </pre>
	   * @param input
	   * @return
	   */
	  @SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSaveBrno(DataObj input) throws AMLException {
	    DataObj output = null;
	    MDaoUtil mDao = null;
	    try {
	    	SessionAML sess = (SessionAML) input.get("SessionAML");
  	        SessionHelper sessHelper = sess.getSessionHelper();
  	        mDao = new MDaoUtil();
  	        mDao.begin();

  	      Object gdReqValue = input.get("gdReq");

	    	if (gdReqValue instanceof List) {

	    	  List gdReq = (List) input.get("gdReq");


	  	      mDao.setData("RBA_50_01_02_01_doDeleteBrno", input);
	  	      int gdReq_size = gdReq.size();
	  	      for (int i = 0; i < gdReq_size ; i++) {
	  	        HashMap inputRow = (HashMap) gdReq.get(i);
	  	          inputRow.put("BAS_YYMM", input.getText("BAS_YYMM"));
	  	          inputRow.put("DR_OP_JKW_NO", Util.nvl(sessHelper.getLoginId()));
	  	          mDao.setData("RBA_50_01_02_01_doSaveBrno", inputRow);
	  	      }

	    	} else {
			    mDao.setData("RBA_50_01_02_01_doDeleteBrno", input);
	    	}


	      mDao.commit();

	      output = new DataObj();
	      output.put("ERRCODE", "00000");
	      output.put(
	          "ERRMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다..."));
	      output.put(
	          "WINMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다."));
	      output.put("gdRes", null); // Grid Data

	    } catch (AMLException ex) {
	      if (mDao != null) {
	    	  mDao.rollback();
	    	  mDao.close();
	      }

	      Log.logAML(Log.ERROR, this, "doSaveBrno", ex.getMessage());

	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", ex.toString());
	    } finally {
	    	if (mDao != null) {
	    		mDao.close();
	    	}
	    }
	    return output;
	  }

	  /**
	   * <pre>
	   * 평가지점관리 삭제
	   * </pre>
	   * @param input
	   * @return
	   */
	  @SuppressWarnings({ "rawtypes", "unchecked" })
	  public DataObj doDelete(DataObj input) throws AMLException {
	    DataObj output = null;
	    MDaoUtil mDao = null;
	    try {

	      List gdReq = (List) input.get("gdReq");
//	      SessionAML sess = (SessionAML) input.get("SessionAML");
//	      SessionHelper sessHelper = sess.getSessionHelper();
	      mDao = new MDaoUtil();
	      mDao.begin();

	      int gdReq_size = gdReq.size();
	      for (int i = 0; i < gdReq_size ; i++) {
	        HashMap inputRow = (HashMap) gdReq.get(i);
	          mDao.setData("RBA_50_01_02_01_doDeleteBrno", inputRow);
	      }
	      mDao.commit();

	      output = new DataObj();
	      output.put("ERRCODE", "00000");
	      output.put(
	          "ERRMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다..."));
	      output.put(
	          "WINMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다."));
	      output.put("gdRes", null); // Grid Data

	    } catch (AMLException ex) {
	      if (mDao != null) {
	    	  mDao.rollback();
	    	  mDao.close();
	      }

	      Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());

	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", ex.toString());
	    } finally {
	    	if (mDao != null) {
	    		mDao.close();
	    	}
	    }
	    return output;
	  }

}