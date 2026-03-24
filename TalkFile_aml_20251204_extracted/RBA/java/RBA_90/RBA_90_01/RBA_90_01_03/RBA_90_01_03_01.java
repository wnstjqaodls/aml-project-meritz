package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03;

import java.util.HashMap;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * FIU 지표등록관리
 * </pre>
 * @author 권얼
 * @version 1.0
 * @history 1.0 2018-12-13
 */
public class RBA_90_01_03_01 extends GetResultObject {

  private static RBA_90_01_03_01 instance = null;
  public static final String ITEM_S_C_1	= "1";
  public static final String ITEM_S_C_2	= "2";

  /**
   * getInstance
   * @return RBA_90_01_03_01
   */
  public static  RBA_90_01_03_01 getInstance() {
    if (instance == null) {
      instance = new RBA_90_01_03_01();
    }
    return instance;
  }

  /**
   * <pre>
   * FIU 지표등록관리 조회
   * </pre>
   * @param input
   * @return
   */
  public DataObj doSearch(DataObj input) {
    DataObj output = new DataObj();
    DataSet gdRes = null;

    try {
    	String query_id = "RBA_90_01_03_01_getRPT_GJDT";
		String LAST_RPT_GJDT = MDaoUtilSingle.getData(query_id, input).getText("LAST_RPT_GJDT");
    	input.put("LAST_RPT_GJDT", LAST_RPT_GJDT);

	    query_id = "RBA_90_01_03_01_doSearch";
	    output = MDaoUtilSingle.getData(query_id, input);

	    if (output.getCount("JIPYO_IDX") > 0) {
	      gdRes = Common.setGridData(output);
	    } else {
	      output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	      output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	    }
	    output.put("ERRCODE", "00000");
	    output.put("gdRes", gdRes);

    } catch (AMLException e) {
      Log.logAML(Log.ERROR, this, "doSearch", e.getMessage());
      output.put("ERRCODE", "00001");
      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    }

    return output;
  }

  /**
   * @param input
   * @return
   */
  public DataObj doSave(DataObj input) {
	  DataObj output = new DataObj();

	  try {

		  EvalScoreCalculationAction evlScoreCal = new EvalScoreCalculationAction();

		  String[] JIPYO_IDX_arr = input.getText("JIPYO_IDX_arr").split(",");	//보고지표인덱스
		  String[] IN_V_TP_C_arr = input.getText("IN_V_TP_C_arr").split(",");	//입력값
		  String[] MAX_IN_V_arr  = input.getText("MAX_IN_V_arr").split(",");	//MAX값
		  String[] IN_V_TP_C_TYPE_arr  = input.getText("IN_V_TP_C_TYPE_arr").split(",");	//입력값타입

		  for (int i = 0; i < JIPYO_IDX_arr.length; i++) {
			  HashMap<Object, Object> map = new HashMap<Object, Object>();

			  String RPT_GJDT = Util.nvl(input.getText("RPT_GJDT"),"");
			  String JIPYO_IDX = Util.nvl(JIPYO_IDX_arr[i],"");
			  String IN_V = Util.nvl(IN_V_TP_C_arr[i],"").replace("all", "").replace(",", "");	//클라이언트에서 'IN_V_TP_C_arr'배열로 넘길때 마지막데이터가 셀렉트박스고 그 값이 비어있으면, 값이 사라지면서 사이즈가 줄어드는 현상때문에 빈값이 아니라 'all'을 넣어서 넘겨주고 replace를 해준다.
			  String IN_V_TP_C_TYPE = Util.nvl(IN_V_TP_C_TYPE_arr[i],"");

			  if ("N".equals(IN_V_TP_C_TYPE)) {		//입력값이 number타입일때만 체크 20190208
				  if (IN_V.indexOf("0") == 0) {		//입력값의 첫번째 자리 값이 '0'
					  if (IN_V.indexOf(".") == -1) {	//소수점이 존재하지 않는다면 '0'을 삭제.
						  int temp = Integer.parseInt(IN_V);
						  IN_V = Integer.toString(temp);
					  } else {	//소수점이 존재하는 경우
						  int IN_V_length = IN_V.length();
						  int dotIndex = IN_V.indexOf(".");

						  String IN_V_tmp = Integer.toString(Integer.parseInt(IN_V.replace(".", "")));
						  int IN_V_tmp_length = IN_V_tmp.length();

						  if (IN_V_length-1 != IN_V_tmp_length) {	//소수점을 없앴기때문에 -1 해준다. 이게 true면 입력값 앞쪽에 n개에 0이 있었다는 의미
							  if (dotIndex != 1) {	//true면 001.52 같은 경우, false면 앞에 0하나고 바로 소수점이 온 경우  (0.12 같은경우)
								  dotIndex -= (IN_V_length-1) - IN_V_tmp_length;	//0이 제거된 만큼 소수점 위치도 다시 잡아준다.
								  char[] c = IN_V_tmp.toCharArray();
								  String result = "";
								  for (int j = 0; j < c.length; j++) {
									  if ( j == dotIndex ) {
										  result += ".";
									  }
									  result += c[j];
								  }
								  IN_V = result;
							  }
						  }
					  }
				  }

				  if (IN_V.lastIndexOf(".") == IN_V.length()-1) {	//입력값의 마지막자리 값이 '.'이면 제거필요
					  IN_V = IN_V.substring(0, IN_V.indexOf("."));

				  }else if (IN_V.contains(".")) {
					  Double temp = Double.parseDouble(IN_V);
					  
					  java.text.DecimalFormat df = new java.text.DecimalFormat("0.####################");
					  IN_V = df.format(temp);

					  if ("0".equals(IN_V.substring(IN_V.indexOf(".")+1))) {	//소수점 뒤에 숫자가 0만 존재할경우 자연수만 남기고 삭제
						  IN_V = IN_V.substring(0, IN_V.indexOf("."));
					  }
				  }
			  }

			  String MAX_IN_V = Util.nvl(MAX_IN_V_arr[i],"");// MAX값

			  map.put("RPT_GJDT", input.getText("RPT_GJDT"));
			  map.put("JIPYO_IDX", JIPYO_IDX_arr[i]);
			  map.put("IN_V", IN_V);
			  map.put("ITEM_S_C", ITEM_S_C_1);	//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
			  map.put("DR_OP_JKW_NO", ((SessionHelper)input.get("SessionHelper")).getUserId().intValue());
			  //map.put("RPT_PNT", MDaoUtilSingle.getData("RBA_90_01_03_01_calculateJipyoScore", map).getText("CAL_PNT"));	//보고점수
//			  map.put("RPT_PNT", Util.nvl(evlScoreCal.EvalScoreCalculationResult(RPT_GJDT , JIPYO_IDX, IN_V , MAX_IN_V),"0"));			//보고점수
			  map.put("RPT_PNT", "0");			//보고점수  점수계산로직 제거 2025.03.31

			  MDaoUtilSingle.setData("RBA_90_01_03_01_doSave", map);
			  MDaoUtilSingle.setData("RBA_90_01_03_01_doSave2", map);
		  }

		  output.put("ERRCODE", "00000");
		  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("gdRes", null); // Grid Data

	  } catch (AMLException e) {
		  Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  } catch (NumberFormatException e) {
		  Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  } catch (Exception e) {
		  Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }

	  return output;
  }

  public DataObj doConfirm(DataObj input) {
	  DataObj output = null;

	  try {

		  String[] JIPYO_IDX_arr = input.getText("JIPYO_IDX_arr").split(",");	//보고지표인덱스
		  String[] ITEM_S_C_arr = input.getText("ITEM_S_C_arr").split(",");		//항목상태코드

		  for (int i = 0; i < JIPYO_IDX_arr.length; i++) {
			  HashMap<Object, Object> map = new HashMap<Object, Object>();

			  map.put("RPT_GJDT", input.getText("RPT_GJDT"));
			  map.put("JIPYO_IDX", JIPYO_IDX_arr[i]);
			  map.put("ITEM_S_C", ITEM_S_C_arr[i]);				//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
			  map.put("DR_OP_JKW_NO", ((SessionHelper)input.get("SessionHelper")).getUserId().intValue());

			  MDaoUtilSingle.setData("RBA_90_01_03_01_doConfirm", map);
			  MDaoUtilSingle.setData("RBA_90_01_03_01_doConfirm2", map);
		  }

		  output = new DataObj();
		  output.put("ERRCODE", "00000");
		  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("gdRes", null); // Grid Data

	  } catch (AMLException e) {
		  Log.logAML(Log.ERROR, this, "doConfirm", e.getMessage());

		  output = new DataObj();
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }

	  return output;
  }

  public DataObj checkFixJipyo(DataObj input) {

	  DataObj output = new DataObj();
	  DataSet gdRes = null;

	  try {
	    String query_id = "RBA_90_01_03_01_checkFixJipyo";
	    output = MDaoUtilSingle.getData(query_id, input);

	    if (output.getCount("JIPYO_FIX_YN") > 0) {
	    	gdRes = Common.setGridData(output);
	    } else {
	    	output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	    }
	    output.put("ERRCODE", "00000");
	    output.put("gdRes", gdRes);

	  } catch (AMLException e) {
	    Log.logAML(Log.ERROR, this, "checkFixJipyo", e.getMessage());
	    output.put("ERRCODE", "00001");
	    output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }

	  return output;
  }

  public DataObj getLastData(DataObj input) {

	  DataObj output = new DataObj();
	  DataObj output2 = new DataObj();

	  try {
		  String RPT_GJDT = input.getText("RPT_GJDT");
		  String[] JIPYO_IDX_arr = input.getText("JIPYO_IDX").split(",");
		  String JIPYO_IDX = "";

		  for (int i = 0; i < JIPYO_IDX_arr.length; i++) {
			  JIPYO_IDX = JIPYO_IDX_arr[i];
			  input.put("JIPYO_IDX", JIPYO_IDX);

			  String LAST_RPT_GJDT = MDaoUtilSingle.getData("RBA_90_01_03_01_getRPT_GJDT", input).getText("LAST_RPT_GJDT");

			  if ( ("0".equals(LAST_RPT_GJDT)) == false ) {
				  input.put("LAST_RPT_GJDT", LAST_RPT_GJDT);
				  output = MDaoUtilSingle.getData("RBA_90_01_03_01_getLastData", input);

				  // 지표보고현황에서 사용될 테이블(JRBA_FIU_JIPYO_V)에 직전이력데이터 넣어준다. 20190429
				  output2 = MDaoUtilSingle.getData("RBA_90_01_03_01_getLastData2", input);

				  if (output.getCount("IN_V") > 0 && output2.getCount() > 0) {
//					  EvalScoreCalculationAction evlScoreCal = new EvalScoreCalculationAction();
					  String IN_V = Util.nvl(output.getText("IN_V"), "");
					  String MAX_IN_V = Util.nvl(output.getText("MAX_IN_V"), "");

					  input.put("IN_V", IN_V);
					  input.put("MAX_IN_V", MAX_IN_V);
					  input.put("ATTCH_FILE_NO", output.getText("ATTCH_FILE_NO"));

					  input.put("ITEM_S_C", ITEM_S_C_1);	//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
//					  input.put("RPT_PNT", Util.nvl(evlScoreCal.EvalScoreCalculationResult(RPT_GJDT, JIPYO_IDX, IN_V, MAX_IN_V), "0")); //보고점수
					  input.put("RPT_PNT", "0");			//보고점수  점수계산로직 제거 2025.03.31
					  input.put("DR_OP_JKW_NO", ((SessionHelper)input.get("SessionHelper")).getUserId().intValue());

					  MDaoUtilSingle.setData("RBA_90_01_03_01_loadDataInsert", input);

					  input.put("GRP_AVG_PNT", output2.getText("GRP_AVG_PNT"));
					  input.put("GRP_MAX_PNT", output2.getText("GRP_MAX_PNT"));
					  input.put("GRP_MIN_PNT", output2.getText("GRP_MIN_PNT"));
					  input.put("RANK", output2.getText("RANK"));

					  MDaoUtilSingle.setData("RBA_90_01_03_01_loadDataInsert2", input);

					  output.put("ERRCODE", "00000");
					  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
					  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
					  output.put("gdRes", null); // Grid Data

				  } else {
					  output.put("ERRCODE", "00000");
					  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
					  output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				  }
			  } else {
				  output.put("ERRCODE", "00000");
				  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				  output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			  }
		  }

	  } catch (AMLException e) {
		  Log.logAML(Log.ERROR, this, "getLastData", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  } catch (Exception e) {
		  Log.logAML(Log.ERROR, this, "getLastData", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }

	  return output;
  }

  /**
   * @param input
   * @return
   */
  public DataObj doAutoImport(DataObj input) {
	  DataObj output = new DataObj();
	  DataObj output2 = new DataObj();
	  DataObj input2 = new DataObj();
	  try {

//		  EvalScoreCalculationAction evlScoreCal = new EvalScoreCalculationAction();

		  String RPT_GJDT = Util.nvl(input.getText("RPT_GJDT") , "") ;
		  input2.put("RPT_GJDT", RPT_GJDT);

		  output2 = MDaoUtilSingle.getData("RBA_90_01_03_01_doAutoImportBtBasDt", input2);

		  if(output2.getCount("RPT_GJDT") > 0){

			  String BT_BAS_DT = Util.nvl(output2.getText("BT_BAS_DT", 0),"");
			  if (("".equals(BT_BAS_DT)) == false) {

				  BT_BAS_DT = BT_BAS_DT.substring(0, 6);
				  input2.put("BAS_YYMM", BT_BAS_DT);

				  output = MDaoUtilSingle.getData("RBA_90_01_03_01_doAutoImport", input2);

				  if(output.getCount("BAS_YYMM") > 0){

					  for (int i = 0; i < output.getCount(); i++) {
						  HashMap<Object, Object> map = new HashMap<Object, Object>();

						  String JIPYO_IDX	= Util.nvl(output.getText("JIPYO_IDX", i),"");
						  String MAX_IN_V 	= Util.nvl(output.getText("MAX_IN_V", i),"");
						  String IN_V 		= Util.nvl(output.getText("IN_V", i),"");
						  String ITEM_S_C	= Util.nvl(output.getText("ITEM_S_C", i),"");

						  //ITEM_S_C ->2 확정 인 값은 저장 하지 않는다
						  if(!ITEM_S_C_2.equals(ITEM_S_C)){

							  map.put("RPT_GJDT", RPT_GJDT);
							  map.put("JIPYO_IDX", JIPYO_IDX);
							  map.put("IN_V", IN_V);
							  map.put("ITEM_S_C", "1");							//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
							  map.put("DR_OP_JKW_NO", ((SessionHelper)input.get("SessionHelper")).getUserId().intValue());
//							  map.put("RPT_PNT", Util.nvl(evlScoreCal.EvalScoreCalculationResult(RPT_GJDT , JIPYO_IDX, IN_V , MAX_IN_V),"0"));			//보고점수
							  map.put("RPT_PNT", "0");	//보고점수  점수계산로직 제거 2025.03.31

							  MDaoUtilSingle.setData("RBA_90_01_03_01_doSave", map);
							  MDaoUtilSingle.setData("RBA_90_01_03_01_doSave2", map);
						  }
					  }

					  MDaoUtilSingle.setData("RBA_90_01_03_01_doAutoImportUpdate", input2);

					  output.put("ERRCODE", "00000");
					  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
					  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
					  output.put("gdRes", null); // Grid Data

				  } else {
					  output.put("ERRCODE", "00000");
					  output.put("ERRMSG","자동으로 가져올 정보가 없습니다.");
					  output.put("WINMSG","자동으로 가져올 정보가 없습니다.");
					  output.put("gdRes", null); // Wise Grid Data
				  }

			  } else {
				  output.put("ERRCODE", "00000");
				  output.put("ERRMSG","자동으로 가져올 정보가 없습니다.");
				  output.put("WINMSG","자동으로 가져올 정보가 없습니다.");
				  output.put("gdRes", null); // Wise Grid Data
			  }

		  }else{
			  output.put("ERRCODE", "00000");
			  output.put("ERRMSG","자동으로 가져올 정보가 없습니다. ");
			  output.put("WINMSG","자동으로 가져올 정보가 없습니다.");
			  output.put("gdRes", null); // Wise Grid Data
		  }

	  } catch (AMLException e) {
		  Log.logAML(Log.ERROR, this, "doAutoImport", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  } catch (Exception e) {
		  Log.logAML(Log.ERROR, this, "doAutoImport", e.getMessage());
		  output.put("ERRCODE", "00001");
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	  }

	  return output;
  }

	public DataObj doSearchExcel(DataObj input) {
		DataObj output = new DataObj();
	    DataSet gdRes = null;

	    try {
	    	String query_id = "RBA_90_01_03_01_getRPT_GJDT";
	    	String LAST_RPT_GJDT = MDaoUtilSingle.getData(query_id, input).getText("LAST_RPT_GJDT");
	    	input.put("LAST_RPT_GJDT", LAST_RPT_GJDT);

	    	query_id = "RBA_90_01_03_01_doSearchExcel";
	    	output = MDaoUtilSingle.getData(query_id, input);
	    	if (output.getCount("JIPYO_IDX") > 0) {
	    		gdRes = Common.setGridData(output);
	    	}

	    	output.put("ERRCODE", "00000");
	    	output.put("gdRes", gdRes);
	    } catch (AMLException e) {
	    	Log.logAML(Log.ERROR, this, "doSearchExcel", e.getMessage());

	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    } catch (Exception e) {
	    	Log.logAML(Log.ERROR, this, "doSearchExcel", e.getMessage());

	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    }

	    return output;
	}
	/**
	* <pre>
	* Kofiu 지표등록관리 파일 조회
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchF(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_90_01_03_03_newgetAttachFile",(HashMap) input);
	        // grid data
	        if (output.getCount("CNT") > 0) {
	          gdRes = Common.setGridData(output);
	        } else {
	          output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	        }

	        output.put("ERRCODE", "00000");
	        output.put("gdRes", gdRes);


	      } catch (AMLException e) {
	        Log.logAML(Log.ERROR, this, "getSearchF(Exception)", e.getMessage());
	        output = new DataObj();
	        output.put("ERRCODE", "00001");
	        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	      }
	      return output;
	 }



}