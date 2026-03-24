package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_02;

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
 * AML 통제평가
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-14
 */
public class RBA_50_05_02_01 extends GetResultObject {

	private static RBA_50_05_02_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_02_01
	*/
	public static  RBA_50_05_02_01 getInstance() {
		synchronized(RBA_50_05_02_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_02_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 부점별 현황
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_01_getSearch", input);
			// grid data
			if (output.getCount("CNTL_CATG1_C_NM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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

	/**
	* <pre>
	* 부점별 통제유효성 평가내역
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_01_getSearch2", input);
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
	
	/**
	* <pre>
	* 통제유효성 평가내역 저장
	* </pre>
	* @param input
	* @return
	 * @throws AMLException 
	*/
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		DataObj param = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;

		try {
			output= new DataObj();
			mDao = new MDaoUtil();
			mDao.begin();
			
			SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();
		    String[] arr = null;
		    
		    String BAS_YYMM = input.get("BAS_YYMM").toString();
		    String VALT_BRNO = input.get("VALT_BRNO").toString();
		    String TONGJE_VALT_PNT ="";
		    String JIPYO_V ="";
		    String TONGJE_SMDV_C ="";
		    String TONGJE_VALD_PNT = "";
		    String VALD_VALT_METH_C = "";
		    
		    param = new DataObj();
		    param.put("BAS_YYMM", BAS_YYMM);
		    param.put("VALT_BRNO", VALT_BRNO);
		    param.put("DR_OP_JKW_NO", logigId);
		    
		    String dataArr[] = input.get("dataArr").toString().split("###");
		    
		    for(int i=0; i< dataArr.length; i++) {
		    	arr = dataArr[i].split("&&");
		    	TONGJE_SMDV_C   = arr[0].trim();
		    	JIPYO_V  =  arr[1].trim();
		    	TONGJE_VALT_PNT =  arr[2].trim();
		    	TONGJE_VALD_PNT = arr[3].trim();
		    	VALD_VALT_METH_C = arr[4].trim();
		    	
		    	//자동평가 통제지표는 패스
		    	if("2".equals(VALD_VALT_METH_C) || TONGJE_VALD_PNT == null) {
		    		continue;
		    	}
		    	//수기평가 인데 점수가0이면 패스
		    	if("3".equals(VALD_VALT_METH_C) && "0".equals(TONGJE_VALD_PNT)) {
		    		continue;
		    	}
		    	
		    	param.put("TONGJE_SMDV_C", TONGJE_SMDV_C);
		    	param.put("JIPYO_V", JIPYO_V);
		    	param.put("TONGJE_VALD_PNT", TONGJE_VALD_PNT);
		    	
		    	
		    	if("1".equals(VALD_VALT_METH_C) || "3".equals(VALD_VALT_METH_C)){
		    		param.put("TONGJE_VALT_PNT", TONGJE_VALT_PNT);
		    	}
		    	
		    	mDao.setData("RBA_50_05_02_01_doSave", param);
		    	
		    }
		    
		    mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} finally {
			if(mDao != null ) {
				mDao.close();
			}
		}
		return output;
	}
	
	/**
	* <pre>
	* 통제유효성 평가점수
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_01_getSearch3", input);
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
	* 통제유효성 평가추이
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch4(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_01_getSearch4", input);
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
	* 통제유효성 평가추이
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch5(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_01_getSearch5", input);
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
		        Log.logAML(Log.ERROR, this, "doSearch5(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	
	/**
	* <pre>
	* 통제유효성 평가추이
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch6(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_01_getSearch6", input);
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
		        Log.logAML(Log.ERROR, this, "doSearch6(Exception)", e.getMessage());
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
			output = MDaoUtilSingle.getData("RBA_50_05_02_01_getChart", input);
			
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