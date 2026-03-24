package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01;

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
 * ML/TF 위험평가
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-30
 */
public class RBA_50_05_01_01 extends GetResultObject {

	private static RBA_50_05_01_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_01
	*/
	public static  RBA_50_05_01_01 getInstance() {
		synchronized(RBA_50_05_01_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_01_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* ML/TF위험평가 빈도조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch", input);
			if ( output.getCount("RSK_CATG1_C") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	/**
	* <pre>
	* ML/TF위험평가 빈도조회 헤더
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch6(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch1", input);
			// grid data
			if (output.getCount("RI0101") > 0) {
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

	/**
	* <pre>
	* ML/TF위험 부점별 수기평가
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch2", input);
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
	* ML/TF위험수기평가내역
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch3", input);
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
	* ML/TF총위험 평가점수
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch4(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch4", input);
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
	* ML/TF총위험 평가추이
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch5(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch5", input);
			// grid data
			if (output.getCount("VALT_BRNO") > 0) {
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
	* ML/TF총위험 평가추이
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch7(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_01_getSearch7", input);
			// grid data
			if (output.getCount("PROC_SMDV_C") > 0) {
				gdRes = Common.setGridData(output); 
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch7(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	/**
	 * <pre>
	 * 위험요소별 고유위험 조회
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch8(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_05_07_01_getSearch", input);
			// grid data
			if (output.getCount("RSK_CATG1_C") > 0) {
				gdRes = Common.setGridData(output); 
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSearch8(Exception)", e.getMessage());
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
//			String query_id = "RBA_50_05_01_01_getChart";
//			
//			System.out.println(" >>>>>>>>> 쿼리 실행전  >>>>>>>>> " + input.getText("BAS_YYMM") + ">>>>>>>>>" + input.getText("selectedBrnoNm"));
//			output = MDaoUtilSingle.getData(query_id, input);
////			gdRes = Common.setGridData(output);
//			String json = output.getText("CHART_JSON");
//			System.out.println(" >>>>>>>>> CHART_JSON  >>>>>>>>> " + json);
//			output.put("chartDataJson", json);
////			output.put("9gdRes",gdRes);
////			System.out.println(" >>>>>>>>> gdRes  >>>>>>>>> " + gdRes);
//			output.put("ERRCODE", "00000");
//			System.out.println(" >>>>>>>>> 쿼리 실행 후  >>>>>>>>> " + output);

			output = MDaoUtilSingle.getData("RBA_50_05_01_01_getChart", input);
//			output.put("BRNO"		 , brno);
//			output.put("BAS_YYMM" , bas_yymm);
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
	
	public DataObj getSearchChart2(DataObj input) {
		DataObj output = new DataObj();
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_07_01_getChart", input);
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