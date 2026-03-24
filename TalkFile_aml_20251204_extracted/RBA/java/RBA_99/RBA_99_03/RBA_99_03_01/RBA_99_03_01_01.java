package com.gtone.rba.server.common.RBA_99.RBA_99_03.RBA_99_03_01;

import java.io.IOException;
import java.sql.SQLException;
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
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 자격보유현황관리
 * </pre>
 * @author  KMJ2
 * @version 1.0
 * @history 1.0 2024-02-20
 */

public class RBA_99_03_01_01 extends GetResultObject {
	private static RBA_99_03_01_01 instance = null;

	/*
	 * 인스턴스 반환.
	 * <p>
	 * @return  <code>RBA_99_03_01_01</code>
	 *              인스턴스
	 */
	public static RBA_99_03_01_01 getInstance() {
		return instance == null ? (instance = new RBA_99_03_01_01()) : instance;
	}
	
	/**
	 * @param input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * 			소속 부점, 날짜, 교육대상
	 * @return
	 */
	
	public DataObj doSearch(DataObj input) {
		DataObj output = new DataObj();
		DataSet gdRes = null;

		try {
			@SuppressWarnings("unused")
			String branchCode, QUA_CERT, QUA_CODE;
			int branchCodeYN;

			//input 세팅
			//부점
			branchCode = input.getText("branchCode");
			branchCodeYN = "999".equals(Util.nvl(branchCode, "999")) ? 1 : 0;
			
			input.add("branchCodeYN", branchCodeYN);
			
			//db조회
			DataObj dbOut = MDaoUtilSingle.getData("RBA_99_03_01_01_doSearch", input);

			if (dbOut.getCount("SEQ") > 0) {
				gdRes = Common.setGridData(dbOut);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSearch", e.toString());
			output.clear();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", e.getMessage());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "doSearch", e.toString());
			output.clear();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", e.getMessage());
		}
		return output;
	}
	
	/**
	* <pre>
	* 자격보유현황관리 저장
	* </pre>
	* @param input
	* @return
	 * @throws RuntimeException 
	 * @throws IOException 
	 * @throws SQLException 
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		DataObj output1 = null;
		MDaoUtil mDao = null;
        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();
			
			String str = "";
		
			//각 행별로
			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				
				//이름, 부서 ID 받아오기 (insert 시 필요)
				if(inputMap.get("JKW_NO") == null || "".equals(inputMap.get("JKW_NO")) || inputMap.get("DPRT_CD") == null || "".equals(inputMap.get("DPRT_CD"))) {
					output1= MDaoUtilSingle.getData("RBA_99_03_01_01_SEARCH_JKW_AND_DPT", inputMap);
					if(output1.getCount() == 0) {
						str += "성명:"+inputMap.get("JKW_NM")+"/부서:"+inputMap.get("DPRT_NM")+" 정보가 '사용자관리' 에서 조회 되지 않습니다."+"<br>";
						continue;
					}
					
					inputMap.put("JKW_NO", output1.getText("LOGIN_ID"));
					inputMap.put("DPRT_CD", output1.getText("DEP_DESC"));
				}
				
				//CCD 모두 지우기
				mDao.setData("RBA_99_03_01_01_DELETE_IC_CERT_CCD", inputMap);
				
				//코드별로 저장 필요
				//CERT_CCD
				if (!"-".equals(inputMap.get("CAMS")) && !"".equals(inputMap.get("CAMS")) ) {
					inputMap.put("CERT_CCD","1001");
					inputMap.put("ACQ_DT",inputMap.get("CAMS"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("KCAMS")) && !"".equals(inputMap.get("KCAMS")) ) {
					inputMap.put("CERT_CCD","1002");
					inputMap.put("ACQ_DT",inputMap.get("KCAMS"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("TPAC1")) && !"".equals(inputMap.get("TPAC1")) ) {
					inputMap.put("CERT_CCD","1003");
					inputMap.put("ACQ_DT",inputMap.get("TPAC1"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("TPAC2")) && !"".equals(inputMap.get("TPAC2")) ) {
					inputMap.put("CERT_CCD","1004");
					inputMap.put("ACQ_DT",inputMap.get("TPAC2"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("ANTI_LANDER_AG_PRO")) && !"".equals(inputMap.get("ANTI_LANDER_AG_PRO")) ) {
					inputMap.put("CERT_CCD","1005");
					inputMap.put("ACQ_DT",inputMap.get("ANTI_LANDER_AG_PRO"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("ANTI_LANDER_AG_FU")) && !"".equals(inputMap.get("ANTI_LANDER_AG_FU")) ) {
					inputMap.put("CERT_CCD","1006");
					inputMap.put("ACQ_DT",inputMap.get("ANTI_LANDER_AG_FU"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("BRAN_COMP_OFFI")) && !"".equals(inputMap.get("BRAN_COMP_OFFI")) ) {
					inputMap.put("CERT_CCD","1007");
					inputMap.put("ACQ_DT",inputMap.get("BRAN_COMP_OFFI"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("SKK_UNI_FIN_LEAD")) && !"".equals(inputMap.get("SKK_UNI_FIN_LEAD")) ) {
					inputMap.put("CERT_CCD","1008");
					inputMap.put("ACQ_DT",inputMap.get("SKK_UNI_FIN_LEAD"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("E_MK_ANTI_LANDER_COURSE")) && !"".equals(inputMap.get("E_MK_ANTI_LANDER_COURSE")) ) {
					inputMap.put("CERT_CCD","1009");
					inputMap.put("ACQ_DT",inputMap.get("E_MK_ANTI_LANDER_COURSE"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				if (!"-".equals(inputMap.get("DK_UNI_MASTER_COURSE")) && !"".equals(inputMap.get("DK_UNI_MASTER_COURSE")) ) {
					inputMap.put("CERT_CCD","1010");
					inputMap.put("ACQ_DT",inputMap.get("DK_UNI_MASTER_COURSE"));
					mDao.setData("RBA_99_03_01_01_INSERT_IC_CERT_CCD", inputMap);
				}
				mDao.setData("RBA_99_03_01_01_MERGE_IC_CERT_M", inputMap);
				
			}
			
			//DB commit
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			if(str==null || "".equals(str)) {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			}else {
				output.put("ERRCODE", "00001");
				output.put("ERRMSG", str);
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
			}

		} catch (AMLException e) {
			if (mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
	
		
	//삭제
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
				mDao.setData("RBA_99_03_01_01_DELETE_IC_CERT_M", inputMap);
				mDao.setData("RBA_99_03_01_01_DELETE_IC_CERT_CCD", inputMap);
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

}
