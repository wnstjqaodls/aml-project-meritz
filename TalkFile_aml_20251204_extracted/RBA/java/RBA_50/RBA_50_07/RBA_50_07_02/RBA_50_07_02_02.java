package com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_02;

import org.omg.CORBA.UserException;

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
*<pre>
* 개선조치대응사항 등록/수정
*</pre>
*@author bjson
*@version 1.0
*@history 1.0 2018-04-25
*/
public class RBA_50_07_02_02 extends GetResultObject {

    private static RBA_50_07_02_02 instance = null;
    /**
     * getInstance
     * @return RBA_50_07_02
     */
    public static RBA_50_07_02_02 getInstance() {
        if(instance == null) {
            instance = new RBA_50_07_02_02();
        }
        return instance;
    }
    
   
    /**
	 * <pre>
	 * 개선조치대응사항 상세조회(AML 업무프로세스)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch1(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch1", input);
			
			// grid data
			if (output.getCount("VALT_BRNO") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 상세조회(RBA 위험평가)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch21(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch21", input);
			
			// grid data
			if (output.getCount("REMDR_RSK_GD_C_NM1") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 상세조회(RBA 위험평가)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch22(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch22", input);
			
			// grid data
			if (output.getCount("REMDR_RSK_GD_C_NM2") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 상세조회(RBA 위험평가)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch23(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch23", input);
			
			// grid data
			if (output.getCount("REMDR_RSK_GD_C_NM3") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 상세조회(Top5 ML/TF Risk)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch3(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch3", input);
			
			// grid data
			if (output.getCount("VALT_BRNO") > 0) {
				gdRes = Common.setGridData(output);
				
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("CNT" ,0);
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
	 *  개선조치대응사항 상세조회(통제점수)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch32(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch32", input);
			
			
			// grid data
			if (output.getCount("VALT_BRNO") > 0) {
				gdRes = Common.setGridData(output);
				
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 상세조회(통제점수_상세)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch33(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch33", input);
			
			
			// grid data
			if (output.getCount("TONGJE_NO") > 0) {
				gdRes = Common.setGridData(output);
				
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 상세조회(개선방안)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch4(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch4", input);
			
			// grid data
			if (output.getCount("VALT_BRNO") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 *  개선조치대응사항 평가기준년월 조회(개선방안)
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch5(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_02_02_getSearch5", input);
			
			// grid data
			if (output.getCount("C_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	 * 개선대응방안  수정
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSave(DataObj input) throws UserException {
		
		
		Log.logAML(Log.INFO, this, "doSave", "개선관리 저장=="+input);
		
		DataObj output = new DataObj();
		
		//Log.logAML(Log.INFO, this, "doSave", "부서코드=="+((SessionHelper) input.get("SessionHelper")).get getDeptId());
		//Log.logAML(Log.INFO, this, "doSave", "부서코드=="+((SessionHelper) input.get("SessionHelper")).getLoginId());
		
		input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 등록조작자번호
		input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
	
		
		Log.logAML(Log.INFO, this, "doSave", "개선관리 저장");
		
		try {
			
		    MDaoUtilSingle.setData("RBA_50_07_02_02_doSave", input);
			output.put("ERRCODE", "00000");
		
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		
		return output;
	}
	
	
}
