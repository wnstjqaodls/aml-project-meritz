package com.gtone.rba.server.type03.RBA_50.RBA_50_02.RBA_50_02_02;


import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;

import jspeed.base.util.StringHelper;

/**
 * <pre>
 * 부서별 업무프로세스관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-25
 */
public class RBA_50_02_02_03 extends GetResultObject {

	private static RBA_50_02_02_03 instance = null;
	/**
	* getInstance
	* @return RBA_50_02_02_03
	*/
	public static  RBA_50_02_02_03 getInstance() {
		synchronized(RBA_50_02_02_03.class) {
			if (instance == null) {
				instance = new RBA_50_02_02_03();
			}
		}
		return instance;
	}

	/**
	 * <pre>
	 * 부서별 업무프로세스 결재 저장
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = new MDaoUtil();

		DataObj gyljIdObj = new DataObj(); // 채번 결재ID Object
		DataObj gyljSerObj = new DataObj(); // 채번 결재일련번호 Object

		String query_id = null; // 결재ID 채번 or 결재일련번호 채번
		String query_id1 = null; // 결재이력등록
		String query_id2 = null; //  위험평가지표 결재 상태 변경


		String gyljId = null; // 채번 결재ID
		String gyljSer = null; // 채번 결재일련번호

		try {
			// 1.결재 Start
			//Date date = new Date();
			SessionAML sess = (SessionAML) input.get("SessionAML");

			String loginId = sess.getSessionHelper().getLoginId();
			String roleId = sess.getsAML_ROLE_ID();


			String sGyljFlag = input.getText("GYLJ_FLAG"); // 결재FLAG(0:승인요청,1:반려,2:승인)
			String sGyljId = StringHelper.evl(input.getText("GYLJ_ID"),"0"); // 결재ID가 없을 때는 0으로


			String GYLJ_G_C = input.get("GYLJ_G_C").toString(); //결재구분
			String GYLJ_S_C = input.get("GYLJ_S_C").toString(); //결재상태 구분 구분


			input.put("DR_OP_JKW_NO", loginId); // 등록조작자번호
			input.put("CHG_OP_JKW_NO", loginId); // 변경조작자번호
			input.put("GYLJ_JKW_NO", loginId); // 결재직원번호
			input.put("ROLE_ID", roleId); // ROLE_ID

			//승인요청일때 결재선 구분
			if("0".equals(sGyljFlag)) {
				//roleId가 4(본점담당자) 이면  W01 준법프로세스관리결재   아니면 W02 지점프로세스관리결재
				GYLJ_G_C =  "4".equals(roleId) ? "W01" : "W02";
			}
			input.put("GYLJ_G_C", GYLJ_G_C); //결재구분
			input.put("GYLJ_LINE_G_C", GYLJ_G_C); //결재구분

			// 결재 플래그에 따른 결재상태 구분코드 설정
			//결재상태 구분코드 (R325) 21:승인요청 22:반려  3: 완료
			if("0".equals(sGyljFlag)) {
				//승인요청일때
				GYLJ_S_C = "21";
			} else if("1".equals(sGyljFlag)) {
				//반려일때
				GYLJ_S_C = "22";
			} else {
				//승인일때
				DataObj result = mDao.getData("RBA_50_02_02_03_doSave_check_final_Approve", input);
				if ("0".equals(result.get("NEXT_GYLJ_ROLE_ID").toString())) {
					//최종승인일때
					GYLJ_S_C = "3";
				} else {
					//이후 결재 단계가 있을때
					GYLJ_S_C = "21";
				}
			}

			input.put("GYLJ_S_C", GYLJ_S_C);



			// 1-1.결재상태 별 결재이력 반영
			//승인요청시에
			if("0".equals(sGyljFlag) && "0".equals(sGyljId) ) {
				// 최초결재요청 시 결재ID 채번
				query_id = "RBA_50_03_02_03_doSave_getGyljId";
				gyljIdObj = MDaoUtilSingle.getData(query_id, input);

				// 채번내역 세팅
				gyljId = gyljIdObj.get("MAX_GYLJ_ID").toString();
				input.put("GYLJ_ID", gyljId); // 결재ID

				// 결재이력등록 - 최초결재요청등록
				query_id1 = "RBA_50_03_02_03_doSave_insertFirstKRBA_GYLJ_H";
				mDao.setData(query_id1, input);

			} else {
				// 재승인요청 or 반려 or 승인 시 결재일련번호 채번
				query_id = "RBA_50_03_02_03_doSave_getGyljSer";
				gyljSerObj = MDaoUtilSingle.getData(query_id, input);

				// 채번내역 세팅
				gyljSer = gyljSerObj.get("MAX_GYLJ_SER").toString();
				input.put("GYLJ_SER", gyljSer); // 결재일련번호

				// 결재이력등록 - 결재진행내역등록
				query_id1 = "RBA_50_03_02_03_doSave_insertAddKRBA_GYLJ_H";
				mDao.setData(query_id1, input);
			}
			// 업무프로세스 결재 테이블
			query_id2 = "RBA_50_02_02_03_doSave_SRBA_V_PROC_GYLJ";
			mDao.setData(query_id2, input);
			// 1.결재 End

			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
		} catch (AMLException e) {
			mDao.rollback();
			Log.logAML(Log.ERROR, this, "doSave(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			if (mDao != null) {
				mDao.close();
			}

		}
		return output;
	}

}