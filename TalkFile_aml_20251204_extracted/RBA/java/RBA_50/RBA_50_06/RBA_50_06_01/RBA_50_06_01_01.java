package com.gtone.rba.server.type03.RBA_50.RBA_50_06.RBA_50_06_01;

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
*<pre>
* KRI 지표관리
*</pre>
*@author KDO
*@version 1.0
*@history 1.0 2018. 5.23
*/
public class RBA_50_06_01_01 extends GetResultObject {

	/**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
    private static RBA_50_06_01_01 instance = null;
    
    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_06_01_01</code>
     *              인스턴스
     */
    public static  RBA_50_06_01_01 getInstance() 
    { return instance==null?(instance=new RBA_50_06_01_01()):instance; }

    
    /**
     * KRI 지표 관리<br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(KRI 지표 조회리스트 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearchKRI(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_06_01_01_doSearchKRI", input);
            
            if (dbOut.getCount("KRI_NO")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearchKRI", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }

    /**
     * RULE 지표 관리<br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(RULE 지표 조회리스트 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearchRULE(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_06_01_01_doSearchRULE", input);
            
            if (dbOut.getCount("RULE_NO")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearchRULE", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }
 
    /**
     * KRI_RULE 맵핑 관리 Header 정보(RULE NO) 조회 <br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(KRI_RULE 맵핑 조회리스트 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearchKRI_RULE(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_06_01_01_doSearchKRI_RULE", input);
            
            if (dbOut.getCount("RULE_NO")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearchKRI_RULE", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }
    
    
    /**
     * KRI_RULE 맵핑 관리 KRI 정보(관련 위험지표 Category, Factor, 맵핑된 Rule 건수) 조회 <br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(KRI_RULE 맵핑 관리 KRI 정보 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearchKRI_RULE2(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_06_01_01_doSearchKRI_RULE2", input);
            
            if (dbOut.getCount("RSK_CATG")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearchKRI_RULE2", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }
    
    /**
     * KRI_RULE 맵핑 정보 조회 <br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(KRI_RULE 맵핑 정보 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearchKRI_RULE3(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_06_01_01_doSearchKRI_RULE3", input);
            
            if (dbOut.getCount("KRI_NO")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearchKRI_RULE3", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }

	/**
	* <pre>
	* KRI, RULE 맵핑 데이터 저장
	* </pre>
	* @param input
	* @return
	 * @throws AMLException 
	*/
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;
		MDaoUtil mao = null;
		DataObj param = null;
		
		input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
		
		try {
			mao = new MDaoUtil();
			mao.begin();
			
			String[] data =null;
			String KRI_NO = "";
			String RULE_NO = "";
			String chckYN="";
			
			output = new DataObj();
			param = new DataObj();
			
			if(input.get("CHK_DATA") != null &&  !"".equals(input.get("CHK_DATA"))) {
				String[] saveData = input.get("CHK_DATA").toString().split(",");
				
				for(int i=0; i<saveData.length; i++) {
					String modData = saveData[i];
					
					data = modData.split("##");
					
					KRI_NO = data[0].substring(0, 4);
					RULE_NO = data[0].substring(4, 8);
					chckYN = data[1];
					param.put("KRI_NO", KRI_NO);
					param.put("RULE_NO", RULE_NO);
					
					if("true".equals(chckYN)) {
						//삭제후 insert
						mao.setData("RBA_50_06_01_01_doDeleteKRI_RULE", param);
						mao.setData("RBA_50_06_01_01_doSaveKRI_RULE", param);
					} else {
						mao.setData("RBA_50_06_01_01_doDeleteKRI_RULE", param);
					}
				}
			}
			mao.commit();
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		      } catch (AMLException e) {
			    if( mao != null) {
			    	mao.rollback();
			    }
		        Log.logAML(Log.ERROR, this, "doSave(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		finally {
			if(mao!= null) {
				mao.close();
			}
		}
		return output;
	}



}
