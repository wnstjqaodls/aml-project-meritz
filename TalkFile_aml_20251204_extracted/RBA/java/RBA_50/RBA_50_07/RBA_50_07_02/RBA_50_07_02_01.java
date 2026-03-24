package com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_02;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
*<pre>
* 고위험 영역개선 관리
*</pre>
*@author bjson
*@version 1.0
*@history 1.0 2018-04-25
*/
public class RBA_50_07_02_01 extends GetResultObject {

    private static RBA_50_07_02_01 instance = null;
    /**
     * getInstance
     * @return RBA_50_07_02
     */
    public static RBA_50_07_02_01 getInstance() {
        if(instance == null) {
            instance = new RBA_50_07_02_01();
        }
        return instance;
    }

    /**
   	 * <pre>
        *   부점별현황 조회
        * </pre>
        *@param input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
        *@return GRID_DATA(개선목록 POOL관리 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
        *@throws Exception
   	 */
   	public DataObj doSearch(DataObj input) {

   		DataObj output = null;
   		DataSet gdRes = null;


   		Log.logAML(Log.INFO, this, "doSearch", "고위험 영역개선 관리-부점별현황 조회 ");

   		try {
   			output = MDaoUtilSingle.getData("RBA_50_07_02_01_getSearch1", input);

   			Log.logAML(Log.INFO, this, "doSearch", output.size());
   			Log.logAML(Log.INFO, this, "doSearch", output);
   		// grid data
   		if (output.getCount("BAS_YYMM") > 0) {
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
        *   부점별 개선방안 상세등록내역 조회
        * </pre>
        *@param input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
        *@return GRID_DATA(개선목록 POOL관리 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
        *@throws Exception
   	 */
    public DataObj doSearch2(DataObj input) {
        DataObj output = new DataObj();
        DataSet gdRes = null;

        Log.logAML(Log.INFO, this, "doSearch", "부점별 개선방안 상세등록내역 조회");

        try {
            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_07_02_01_getSearch2", input);

            gdRes = Common.setGridData(dbOut);

            output.put("ERRCODE", "00000");
            output.put("ERRMSG", gdRes.getRowCount() > 0
                    ? MessageHelper.getInstance().getMessage("0043",input.getText("LANG_CD"),"조회 되었습니다.")
                    : MessageHelper.getInstance().getMessage("0039",input.getText("LANG_CD"),"자료가 존재하지 않습니다."));
            output.put("gdRes", gdRes);
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearch2", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }


    /**
	* <pre>
	* 고위험영역개선 일괄결재
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = new MDaoUtil();

		DataObj gyljIdObj = new DataObj(); // 채번 결재ID Object
		DataObj gyljSerObj = new DataObj(); // 채번 결재일련번호 Object
		DataObj gyljGcObj = new DataObj(); // 채번 결재일련번호 Object

		String query_id = null; // 결재ID 채번 or 결재일련번호 채번
		String query_id1 = null; // 결재이력등록
		String query_id2 = null; //  위험평가지표 결재 상태 변경
		String query_id3 = null;

		String gyljId = null; // 채번 결재ID
		String gyljSer = null; // 채번 결재일련번호

		int IMPRV_CMPT_YN = 0; //개선완료여부

		try {
			// 1.결재 Start
			//Date date = new Date();

			SimpleDateFormat nDt = new SimpleDateFormat("yyyyMMdd");
			//SimpleDateFormat nTime = new SimpleDateFormat("HHmmss");

			SessionAML sess = (SessionAML) input.get("SessionAML");

			String loginId = sess.getSessionHelper().getLoginId();
			String roleId = sess.getsAML_ROLE_ID();

			List gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			Log.logAML(Log.INFO, this, "결재상태코드", input.get("GYLJ_S_C"));

			//String sGyljId = StringHelper.evl(input.getText("GYLJ_ID"),"0"); // 결재ID가 없을 때는 0으로

			String sGyljFlag = input.getText("GYLJ_FLAG"); // 결재FLAG(0:승인요청,1:반려,2:승인)

			for (int i = 0; i < gdReq_size ; ++i) {

				HashMap Obj = (HashMap) gdReq.get(i);


				String sGyljId = StringHelper.evl(input.getText("GYLJ_ID"),"0"); // 결재ID가 없을 때는 0으로

				String GYLJ_G_C = input.get("GYLJ_G_C").toString(); //결재구분
				String GYLJ_S_C = input.get("GYLJ_S_C").toString(); //결재상태 구분

				input.put("DR_OP_JKW_NO", loginId); // 등록조작자번호
				input.put("CHG_OP_JKW_NO", loginId); // 변경조작자번호
				input.put("GYLJ_JKW_NO", loginId); // 결재직원번호
				input.put("ROLE_ID", roleId); // ROLE_ID

				Log.logAML(Log.INFO, this, "결재ID", Obj.get("GYLJ_ID").toString());

				input.put("GYLJ_ID", Obj.get("GYLJ_ID").toString());//


				//승인요청일때 결재선 구분
				if("0".equals(sGyljFlag)) {
					//roleId가 4(본점담당자) 이면  W04 준법개선관리결재   아니면 W05 지점개선관리결재
					GYLJ_G_C =  "4".equals(roleId) ? "W04" : "W05";
				} else {
					query_id3  = "RBA_50_07_02_04_doSave_getGylj_G_C";
					gyljGcObj = MDaoUtilSingle.getData(query_id3, input);
					GYLJ_G_C = gyljGcObj.get("GYLJ_G_C").toString();//결재구분코드
				}

				input.put("GYLJ_G_C", GYLJ_G_C); //결재구분
				input.put("GYLJ_LINE_G_C", GYLJ_G_C); //결재구분

				Obj.put("GYLJ_G_C", GYLJ_G_C); // 결재구분
				Obj.put("GYLJ_LINE_G_C", GYLJ_G_C); // 등록조작자번호

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
					DataObj result = mDao.getData("RBA_50_07_02_04_doSave_check_final_Approve", input);
					if ("0".equals(result.get("NEXT_GYLJ_ROLE_ID").toString())) {
						//최종승인일때
						GYLJ_S_C = "3";
						IMPRV_CMPT_YN = 1;//승인일때 개선완료여부를 1로 셋팅
						input.put("IMPRV_DT", nDt); //개선일자
						Obj.put("DR_OP_JKW_NO", loginId); // 등록조작자번호
					} else {
						//이후 결재 단계가 있을때
						GYLJ_S_C = "21";
					}
				}


				Obj.put("DR_OP_JKW_NO", loginId); // 등록조작자번호
				Obj.put("CHG_OP_JKW_NO", loginId); // 변경조작자번호
				Obj.put("GYLJ_LINE_G_C", input.get("GYLJ_G_C")); //결재구분
				Obj.put("GYLJ_JKW_NO", loginId); // 결재직원번호
				Obj.put("ROLE_ID", roleId); // ROLE_ID

				Obj.put("GYLJ_S_C", GYLJ_S_C);  // 결재상태코드

				Obj.put("GYLJ_FLAG", input.get("GYLJ_FLAG"));  // 결재FLAG(0:승인요청,1:반려,2:승인)
				Obj.put("NOTE_CTNT", input.get("NOTE_CTNT"));

				input.put("DR_OP_JKW_NO", loginId); // 등록조작자번호
				input.put("CHG_OP_JKW_NO", loginId); // 변경조작자번호
				input.put("GYLJ_JKW_NO", loginId); // 결재직원번호
				input.put("ROLE_ID", roleId); // ROLE_ID


				Obj.put("IMPRV_CMPT_YN", IMPRV_CMPT_YN);

				// 1-1.결재상태 별 결재이력 반영
				if("0".equals(sGyljFlag) && "0".equals(sGyljId)) {
					// 최초결재요청 시 결재ID 채번
					query_id = "RBA_50_07_02_04_doSave_getGyljId";
					gyljIdObj = MDaoUtilSingle.getData(query_id, Obj);

					// 채번내역 세팅
					gyljId = gyljIdObj.get("MAX_GYLJ_ID").toString();
					Obj.put("GYLJ_ID", gyljId); // 결재ID

					// 결재이력등록 - 최초결재요청등록
					query_id1 = "RBA_50_07_02_04_doSave_insertFirstKRBA_GYLJ_H";
					mDao.setData(query_id1, Obj);

				} else {
					// 재승인요청 or 반려 or 승인 시 결재일련번호 채번
					query_id = "RBA_50_07_02_04_doSave_getGyljSer";
					gyljSerObj = MDaoUtilSingle.getData(query_id, Obj);

					// 채번내역 세팅
					gyljSer = gyljSerObj.get("MAX_GYLJ_SER").toString();
					Obj.put("GYLJ_SER", gyljSer); // 결재일련번호

					// 결재이력등록 - 결재진행내역등록
					query_id1 = "RBA_50_07_02_04_doSave_insertAddKRBA_GYLJ_H";
					mDao.setData(query_id1, Obj);
				}
				// 개선관리 상태 변경
				query_id2 = "RBA_50_07_02_04_doUpdateSRBA_IMPRV_M";
				mDao.setData(query_id2, Obj);

			}


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





