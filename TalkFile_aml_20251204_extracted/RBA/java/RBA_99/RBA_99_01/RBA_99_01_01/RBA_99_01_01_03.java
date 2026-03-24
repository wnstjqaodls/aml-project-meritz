package com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01;


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

public class RBA_99_01_01_03 extends GetResultObject {

	/** 인스턴스 */
    private static RBA_99_01_01_03 instance = null;

    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_99_01_01_03</code>
     */
	public static RBA_99_01_01_03 getInstance() {
		synchronized(RBA_99_01_01_03.class) {
			if (instance == null) {
				instance = new RBA_99_01_01_03();
			}
		}
		return instance;
	}

	/**
     * 교육정보 조회<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(KRI 지표정보 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */
    public DataObj getEDUInfo(DataObj input)
    {
    	DataObj output = new DataObj();
    	DataSet gdRes = null;

    	try {
    		output = MDaoUtilSingle.getData("RBA_99_01_01_03_GetEDUInfo", input);

			if (output.getCount("EDU_ID") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
    	} catch(AMLException e) {
    		Log.logAML(Log.ERROR, this, "getEDUInfo", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    	}

    	return output;
    }


	//직원정보 조회
    public DataObj getJKWInfo(DataObj input)
    {
    	DataObj output = new DataObj();
    	DataSet gdRes = null;

    	try {
    		output = MDaoUtilSingle.getData("RBA_99_01_01_03_GetJKWInfo", input);

			if (output.getCount("EDU_ID") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
    	} catch(AMLException e) {
    		Log.logAML(Log.ERROR, this, "getEDUInfo", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    	}

    	return output;
    }

    /**
	* <pre>
	* 행 저장
	* </pre>
	* @param input
	* @return
	 * @throws RuntimeException
	 * @throws IOException
	 * @throws SQLException
	*/

	//저장 delete and insert
		@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
		public DataObj doSave(DataObj input) {
			String sqlID;
			DataObj output = new DataObj();
			DataObj output1 = new DataObj();
	        String EDU_ID=null;
	        String JKW_NO=null;
	        String DPRT_CD, DPRT_NM=null;
			String NOTE_CTNT=null;

			MDaoUtil db = null;
			int insertCnt = 0;

			int count = 0;

			try {
				db = new MDaoUtil();
				db.begin();


				List gdReq = (List) input.get("gdReq");
				insertCnt = gdReq.size();
				String str = "";
				EDU_ID = input.getText("EDU_ID");


				for ( int i = 0; i < insertCnt; i++ ) {
					HashMap inputMap = (HashMap) gdReq.get(i);
					inputMap.put("EDU_ID", EDU_ID);

					//verify
					output1 = MDaoUtilSingle.getData("RBA_99_01_01_03_VERIFY_JKW_AND_DPT", inputMap);

					JKW_NO = output1.get("LOGIN_ID").toString();
					DPRT_CD = output1.get("DEP_DESC").toString();
					DPRT_NM = output1.get("DEP_TITLE").toString().replace(" ", "");

					if(output1.getCount() == 0) {
						str += "직원번호 : "+inputMap.get("JKW_NO")+"<br>" + "성명 : "+inputMap.get("JKW_NM")+"<br>"+"부서 : "+inputMap.get("DPRT_NM")+"<br>부서 및 직원번호를 확인하세요.";

						output.put("ERRCODE", "00001");
						output.put("ERRMSG", str);
						output.put("WINMSG", str);
						return output ;
					}

					NOTE_CTNT = StringHelper.evl(inputMap.get("NOTE_CTNT"), "").trim();
					inputMap.put("JKW_NO", JKW_NO);
					inputMap.put("DPRT_CD", DPRT_CD);
					inputMap.put("NOTE_CTNT", NOTE_CTNT);

					inputMap.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 등록조작자번호
					inputMap.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호


					sqlID = "RBA_99_01_01_03_MERGE_IC_EDU_TGT_JKW";
					count = db.setData(sqlID, inputMap);

				}

				db.commit();

				output.put("ERRCODE", "00000");
				if( str==null || "".equals(str) ) {
					output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				} else {
					output.put("ERRMSG", str);
				}

			} catch (NumberFormatException e) {
				try {
					if ( db != null ) {
						db.rollback();
					}
				} catch (AMLException e1) {
					 Log.logAML (Log.ERROR,this,"doSave",e1);
				}

				output.put("ERRCODE", "00001");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0006", input.getText("LANG_CD"), "저장중 오류가 발생하였습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0006", input.getText("LANG_CD"), "저장중 오류가 발생하였습니다."));
			} catch (AMLException e) {
				try {
					if ( db != null ) {
						db.rollback();
					}
				} catch (AMLException e1) {
					 Log.logAML (Log.ERROR,this,"doSave",e);
				}

				output.put("ERRCODE", "00001");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
			}
			finally {
				if ( db != null ) {
					db.close();
				}
			}

			return output;
		}

    /**
	* <pre>
	* 행 삭제
	* </pre>
	* @param input
	* @return
	 * @throws RuntimeException
	 * @throws IOException
	 * @throws SQLException
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
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
				mDao.setData("RBA_99_01_01_03_DELETE_IC_EDU_TGT_JKW", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
		} catch (AMLException e) {
			if (mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}

	public DataObj doUpdateINGR(DataObj input) throws AMLException {
        DataObj output = new DataObj();
        DataSet gdRes = null;
        int count = 0;

        try {
        	count=MDaoUtilSingle.setData("RBA_99_01_01_03_ING_R_UPDATE", input);

        	if(count > 0)
    		{
    			gdRes = Common.setGridData(output);
    		} else
    		{
    			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        		output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    		}
    		output.put("ERRCODE", "00000");
    		output.put("gdRes", gdRes);

		} catch(AMLException e)
    	{
    		Log.logAML(1, this, "doUpdateINGR", e.getMessage());
    		output = new DataObj();
    		output.put("ERRCODE", "00001");
    		output.put("ERRMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    		output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    	}
    	return output;

    }

}
