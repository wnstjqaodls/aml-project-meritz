package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01;

import java.util.HashMap;

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
 * ML/TF 위험평가 상세
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-10
 */
public class RBA_50_05_01_02 extends GetResultObject {

	private static RBA_50_05_01_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_02
	*/
	public static  RBA_50_05_01_02 getInstance() {
		synchronized(RBA_50_05_01_02.class) {  
			if (instance == null) {
				instance = new RBA_50_05_01_02();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* ML/TF위험평가 상세조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch", input);
			// grid data
			if (output.getCount("VALT_YYMM") > 0) {
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
	* ML/TF위험평가 거래상세조회2
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
            int pageNumber = input.getInt("pageNumber");
            int pageSize   = input.getInt("pageSize"  );
            int stRowNum   = pageNumber * pageSize + 1;
            int edRowNum   = (pageNumber + 1) * pageSize;
            
            input.put("stRowNum", stRowNum);
            input.put("edRowNum", edRowNum);
            output = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch2_COUNT", input);
            int size = output.getInt("CNT");
            
            output = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch2", input);
			// grid data
		
			if (output.getCount("VALT_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
            HashMap<String,Object> pageInfo = new HashMap<String,Object>();
            pageInfo.put("pageNumber"   , pageNumber  );
            pageInfo.put("totalCount"   , size        );    // 페이징 시에 필요
            //pageInfo.put("fetchCount"   , gdRes.size());    // 스크롤링 쿼리시에 필요
            output.put("GRID_PAGE_DATA" , pageInfo    );
		
			  } catch (NumberFormatException e) {
				Log.logAML(Log.ERROR, this, "doSearch2(Exception)", e.getMessage());
				output = new DataObj();
				output.put("ERRCODE", "00001");
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
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
	* ML/TF위험평가 고객상세조회3
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
            int pageNumber = input.getInt("pageNumber");
            int pageSize   = input.getInt("pageSize"  );
            int stRowNum   = pageNumber * pageSize + 1;
            int edRowNum   = (pageNumber + 1) * pageSize;
            
            input.put("stRowNum", stRowNum);
            input.put("edRowNum", edRowNum);
            output = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch3_COUNT", input);
            int size = output.getInt("CNT");
            
            output = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch3", input);
			// grid data
		
			if (output.getCount("AML_CUST_ID") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
            HashMap<String,Object> pageInfo = new HashMap<String,Object>();
            pageInfo.put("pageNumber"   , pageNumber  );
            pageInfo.put("totalCount"   , size        );    // 페이징 시에 필요
            //pageInfo.put("fetchCount"   , gdRes.size());    // 스크롤링 쿼리시에 필요
            output.put("GRID_PAGE_DATA" , pageInfo    );
		
			  } catch (NumberFormatException e) {
				Log.logAML(Log.ERROR, this, "doSearch3(Exception)", e.getMessage());
				output = new DataObj();
				output.put("ERRCODE", "00001");
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch3(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	 
	
}