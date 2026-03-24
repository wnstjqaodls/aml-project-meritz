package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_03;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 잔여위험평가
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-15
 */
public class RBA_50_05_03_01 extends GetResultObject {

	private static RBA_50_05_03_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_03_01
	*/
	public static  RBA_50_05_03_01 getInstance() {
		synchronized(RBA_50_05_03_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_03_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 잔여위험결과
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_03_01_getSearch", input);
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
		        Log.logAML(Log.ERROR, this, "getSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	/**
	* <pre>
	* 잔여위험 추이
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_03_02_getSearch", input);
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
		        Log.logAML(Log.ERROR, this, "doSearch2(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	
	public DataObj doSearch_3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_03_02_getSearch3", input);
			// grid data
		
			if (output.getCount("VAL_H") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch2(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	/**
	* <pre>
	* 부서별 잔여위험
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_03_01_getSearch3", input);
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
		        Log.logAML(Log.ERROR, this, "doSearch3(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	/**
	* <pre>
	* 프로세스별 잔여위험
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch4(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_03_01_getSearch4", input);
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
		        Log.logAML(Log.ERROR, this, "doSearch4(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	
	/**
	* <pre>
	* 잔여위험 등급 임계치 저장
	* </pre>
	* @param input
	* @return
	*/
	
	public DataObj doSave2(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
		try {
			mDao = new MDaoUtil();
			mDao.begin();
			
			input.put("REMDR_RSK_GD_C" , input.getText("REMDR_RSK_GD_C1"));
			input.put("GD_S_SECT", input.getText("GD_S_SECT1"));
			input.put("GD_E_SECT", input.getText("GD_E_SECT1"));
			input.put("TOP_ACUM_PER", input.getText("TOP_ACUM_PER1"));
			mDao.setData("RBA_50_05_03_02_doSave", input);
			
			input.set("REMDR_RSK_GD_C" , input.getText("REMDR_RSK_GD_C2"));
			input.set("GD_S_SECT", input.getText("GD_S_SECT2"));
			input.set("GD_E_SECT", input.getText("GD_E_SECT2"));
			input.set("TOP_ACUM_PER", input.getText("TOP_ACUM_PER2"));
			mDao.setData("RBA_50_05_03_02_doSave", input);
			
			input.set("REMDR_RSK_GD_C" , input.getText("REMDR_RSK_GD_C3"));
			input.set("GD_S_SECT", input.getText("GD_S_SECT3"));
			input.set("GD_E_SECT", input.getText("GD_E_SECT3"));
			input.set("TOP_ACUM_PER", input.getText("TOP_ACUM_PER3"));
			mDao.setData("RBA_50_05_03_02_doSave", input);
			
			input.set("REMDR_RSK_GD_C" , input.getText("REMDR_RSK_GD_C4"));
			input.set("GD_S_SECT", input.getText("GD_S_SECT4"));
			input.set("GD_E_SECT", input.getText("GD_E_SECT4"));
			input.set("TOP_ACUM_PER", input.getText("TOP_ACUM_PER4"));
			mDao.setData("RBA_50_05_03_02_doSave", input);
			
			input.set("REMDR_RSK_GD_C" , input.getText("REMDR_RSK_GD_C5"));
			input.set("GD_S_SECT", input.getText("GD_S_SECT5"));
			input.set("GD_E_SECT", input.getText("GD_E_SECT5"));
			input.set("TOP_ACUM_PER", input.getText("TOP_ACUM_PER5"));
			mDao.setData("RBA_50_05_03_02_doSave", input);
			
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
	
	public DataObj doSearchCnt(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_03_01_getSearchCnt", input);
			// grid data
			if (output.getCount("REMDR_RSK_GD_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "getSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	public DataObj getSearchChart1(DataObj input) {
		DataObj output = new DataObj();
		DataSet gdRes = null;

		try {
			
			String brno = "";
			String bas_yymm = "";

			output = MDaoUtilSingle.getData("RBA_50_05_03_01_getChart", input);
			// grid data
			if (output.getCount("JSON_RESULT") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchRslt(Exception)", e.getMessage());
			e.printStackTrace();
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
}