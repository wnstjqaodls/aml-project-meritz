package com.gtone.aml.server.AML_10.AML_10_25.AML_10_25_03;

import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
*<pre>
* 상품위험평가 수행 적정설 
*</pre>
*@author  
*@version 1.0
*@history 1.0 2025-06 삼성증권 컨설팅 자료   
*/
public class AML_10_25_03_01 extends GetResultObject {

	private static AML_10_25_03_01 instance = null;

	/**
	 * getInstance
	 * @return AML_10_25_02_01
	 */
	
	public static AML_10_25_03_01 getInstance() {
		return instance == null ? (instance = new AML_10_25_03_01()) : instance;
		//if ( instance == null ) {
		//	instance = new AML_10_25_03_01();
		//}
		//return instance;
	}

	/**
	 * <pre>
	 * 위험평가 상품 구분 코드 조회
	 */
	public DataObj getSearch(DataObj input) {
		
		DataObj output = null; 
		DataSet gdRes = null;
		String searchgubun;

		try {

			searchgubun = input.getText("searchgubun");
			
			if("A".equals(searchgubun)) {
				output = MDaoUtilSingle.getData("AML_10_25_03_01_getSearch", input);	
			}else if("B".equals(searchgubun)) {
				output = MDaoUtilSingle.getData("AML_10_25_03_01_getSearch2", input);
			}else {
				output = MDaoUtilSingle.getData("AML_10_25_03_01_getSearch3", input);
			}
			
			if(output.getCount("PRD_EVLTN_ID") > 0) {
				gdRes = Common.setGridData(output);	
			}else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			
			output.put("ERRCODE", "00000");
			//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
			output.put("gdRes", gdRes);
			
		} catch (AMLException e) {
			
			Log.logAML(1, this, "getCodeSearch(AMLException)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil db = null;

		String searchgubun;
		System.out.println("--Fsave--"); 
		try {

			db = new MDaoUtil();
	    	db.begin();
	    	
	    	searchgubun = input.get("searchgubun").toString();
			
			if("B".equals(searchgubun)) {
				db.setData("AML_10_25_03_01_ORIGINAL_MERGE", input);
			}else {
				System.out.println("--FFsave--");
				db.setData("AML_10_25_03_01_DERIVED_MERGE", input);
				System.out.println("--FFFsave--");
			}
			
	    	db.commit();
	    	
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data
			

		} catch(AMLException e) {
        	if (db != null) {
                try {
                  db.rollback();
                  db.close();
                } catch (AMLException ee) {
                    db = null;
                } catch (Exception ee) {
                  db = null;
                }
        	}

    		Log.logAML(1, this, "doSave", e.getMessage());
    		output = new DataObj();
    		output.put("ERRCODE", "00001");
    		output.put("ERRMSG", e.toString());

    	} catch(Exception e) {
        	if (db != null) {
                try {
                  db.rollback();
                  db.close();
                } catch (AMLException ee) {
                    db = null;
                } catch (Exception ee) {
                  db = null;
                }
        	}
            Log.logAML(1, this, "doSave", e.getMessage());
            output = new DataObj();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.toString());

        } finally {
            if (db != null) {
                db.close();
              }
      	}
        return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave2(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil db = null;

		String searchgubun;
		
		try {

			db = new MDaoUtil();
	    	db.begin();
	    	
	    	searchgubun = input.get("searchgubun").toString();
			
			if("B".equals(searchgubun)) {
				db.setData("AML_10_25_03_01_ORIGINAL_MERGE2", input);
			}else {
				db.setData("AML_10_25_03_01_DERIVED_MERGE2", input);
			}
			
	    	db.commit();
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data
			

		} catch(AMLException e) {
        	if (db != null) {
                try {
                  db.rollback();
                  db.close();
                } catch (AMLException ee) {
                    db = null;
                } catch (Exception ee) {
                  db = null;
                }
        	}

    		Log.logAML(1, this, "doSave2", e.getMessage());
    		output = new DataObj();
    		output.put("ERRCODE", "00001");
    		output.put("ERRMSG", e.toString());

    	} catch(Exception e) {
        	if (db != null) {
                try {
                  db.rollback();
                  db.close();
                } catch (AMLException ee) {
                    db = null;
                } catch (Exception ee) {
                  db = null;
                }
        	}
            Log.logAML(1, this, "doSave2", e.getMessage());
            output = new DataObj();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.toString());

        } finally {
            if (db != null) {
                db.close();
              }
      	}
        return output;
	}
	
}
