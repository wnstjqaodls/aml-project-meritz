package com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_01;

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

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description 내부감사 내역 관리
 * @FileName    RBA_50_08_06_01.java
 * @Group       GTONE
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      BSL
 * @Since       2018. 6. 22.
 ******************************************************************************************************************************************/


public class RBA_50_01_01_07 extends GetResultObject{

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
    private static RBA_50_01_01_07 instance = null;
    
    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_08_07_01</code>
     * 인스턴스
     */
	public static  RBA_50_01_01_07 getInstance() {
		synchronized(RBA_50_01_01_07.class) {  
			if (instance == null) {
				instance = new RBA_50_01_01_07();
			}
		}
		return instance;
	}

    /**
     * 사고발생금액 조회<br>
     * <p>
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearch(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_01_01_07_doSearch", input);
            
            if (dbOut.getCount("RBA_BTCH_DT")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
            
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearch", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }	
        return output;
    }
    
    public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
        List gdReq = null;
        
        DataObj obj1 = null;
    	int insert_YN=0;
    	int flag = 1;
		try {
			
			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();
			
			mDao = new MDaoUtil();
			mDao.begin();	
			
			for (int i = 0; i < gdReq_size; i++) {

				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

				obj1 = MDaoUtilSingle.getData( "RBA_50_08_07_01_insert_YN", inputMap);
				insert_YN = obj1.getInt("COUNT");
				
				if(insert_YN >= 1){
					mDao.setData("RBA_50_08_07_01_doSave", inputMap);
					output.put("ERRCODE", "00000");
					output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
					output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				}else { 	
					output.put("WINMSG", "이미 등록된 데이터 입니다.\n기준년월,사고발생구분,사고발생금액을 확인해 주십시오.");
					flag=0;
					break;
				}
			}
			
			if(flag==1){
				mDao.commit();
			}else {
				mDao.rollback();
			}
			
		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
    
    public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();
			
			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				mDao.setData("RBA_50_08_07_01_doDelete", inputMap);	
			}
			
			//DB commit
			mDao.commit();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
}
