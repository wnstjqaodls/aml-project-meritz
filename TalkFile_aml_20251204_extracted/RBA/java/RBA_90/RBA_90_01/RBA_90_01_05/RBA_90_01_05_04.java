package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_05;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.omg.CORBA.UserException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import jspeed.base.property.PropertyService;

@Controller
public class RBA_90_01_05_04  extends GetResultObject {

	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");
	public static final String GYLJ_S_C_FIX				= "3";

	public static final String ERRCODE_00000				= "00000";
	public static final String ERRCODE_00090				= "00090";
	public static final String ERRCODE_00091				= "00091";
	public static final String ERRCODE_00092				= "00092";
	public static final String ERRCODE_00093				= "00093";
	public static final String ERRCODE_00094				= "00094";
	public static final String ERRCODE_00095				= "00095";
	public static final String ERRCODE_00096				= "00096";
	public static final String ERRCODE_00097				= "00097";
	public static final String ERRCODE_00098				= "00098";
	public static final String ERRCODE_00099				= "00099";

	public static String WINMSG_00090						= "00090";
	public static String WINMSG_00091						= "업로드한 파일의 데이터가 없습니다.";
	public static String WINMSG_00092						= "보고기준일 의 지표를 확정해 주시기 바랍니다.";
	public static String WINMSG_00093						= "업로드한 파일의 지표번호값을 다시 확인하여 주시기 바랍니다.";
	public static String WINMSG_00094						= "기존데이터에 지표정보가 없습니다.";
	public static String WINMSG_00095						= "지표정보와 엑셀에 지표번호가 불일치...";
	public static String WINMSG_00096						= "결재상태가 완료일때만 업로드를 할 수있습니다.";
	public static String WINMSG_00097						= "기존데이터에 지표정보가 없습니다.";
	public static String WINMSG_00098						= "00098";
	public static String WINMSG_00099						= "파일 형식이 맞지 않습니다.";

	private static RBA_90_01_05_04 instance = null;

	public static  RBA_90_01_05_04 getInstance() {
		synchronized(RBA_90_01_05_04.class) {
		if (instance == null) {
			instance = new RBA_90_01_05_04();
		}
		return instance;
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public DataObj doSave(List<Map<String, Object>> val) throws UserException {

		DataObj output  = null;

		try {

			if(val != null){

				output = new DataObj();

				for (int i = 0; i < val.size(); i++) {

					HashMap<Object, Object> map =(HashMap)val.get(i);
					String RPT_GJDT = Util.nvl(map.get("RPT_GJDT").toString());
					String JIPYO_IDX = Util.nvl(map.get("JIPYO_IDX").toString());
					String RPT_PNT = Util.nvl(map.get("RPT_PNT").toString() , "");
					String RANK = Util.nvl(map.get("RANK").toString() , "");
					String GRP_AVG_PNT = Util.nvl(map.get("GRP_AVG_PNT").toString() , "");
					String GRP_MAX_PNT = Util.nvl(map.get("GRP_MAX_PNT").toString() , "");
					String GRP_MIN_PNT = Util.nvl(map.get("GRP_MIN_PNT").toString() , "");

					String USER_ID = Util.nvl(map.get("USER_ID").toString() , "");

					map.put("RPT_GJDT", RPT_GJDT);
					map.put("JIPYO_IDX", JIPYO_IDX);
					map.put("ITEM_S_C", "2");							//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
					map.put("DR_OP_JKW_NO", USER_ID);
					map.put("RPT_PNT",RPT_PNT);							//보고점수
					map.put("RANK",RANK);
					map.put("GRP_AVG_PNT",GRP_AVG_PNT);
					map.put("GRP_MAX_PNT",GRP_MAX_PNT);
					map.put("GRP_MIN_PNT",GRP_MIN_PNT);

					MDaoUtilSingle.setData("RBA_90_01_05_04_doSave", map);	//추가요건-> 지표보고현황을 지표점수를 수정할수 있게 요청

				}

			}
			if ( output != null ) {
				output.put("ERRCODE", ERRCODE_00000);
				output.put("WINMSG",  "정상 처리되었습니다.");
				output.put("ERRMSG",  "정상 처리되었습니다.");
			}

			} catch (AMLException e) {

				output = new DataObj();
				output.put("ERRCODE", "00001");
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));

			}
		return output;
	}

	@RequestMapping("/rba/RBA_90_01_05_04_doSaveFile.do")
	public String doFileSave(HttpServletRequest request, ModelMap model,FileVO paramVO)throws Exception
	{

		HSSFWorkbook workbook = null;
		FileInputStream fis = null;
		HSSFSheet sheet= null;

		DataObj output2 = null;
		DataObj output3 = null;

		String filePath = Constants.COMMON_TEMP_FILE_UPLOAD_DIR; //PropertyService.getInstance().getProperty("aml.config", "upload.file.wl");
		String fileFullPath = "";
		String newFilePathName ="";
		String RPT_GJDT = "";
		String ERRCODE = ERRCODE_00000;

		try {
			output2 = new DataObj();
			output3 = new DataObj();
			SessionHelper helper = new SessionHelper(request.getSession());
			List<Map<String, Object>> val = new ArrayList<Map<String , Object>>() ;

			@SuppressWarnings("rawtypes")
			HashMap hm = ParamUtil.getReqParamHashMap(request);
			RPT_GJDT = Util.nvl(request.getParameter("RPT_GJDT") , "") ;
			hm.put("RPT_GJDT", RPT_GJDT);

			BigDecimal userId = helper.getUserId();

			String filename = hm.get("storedFileNms").toString();

			fileFullPath = filePath + "/" + filename;
			if(request.getParameter("storedFileNms") != null) {
				newFilePathName = fileFullPath.replace("/", System.getProperty("file.separator"));
				newFilePathName = newFilePathName.replace("\\", "/");
			}

			fis = new FileInputStream(newFilePathName);
			workbook = new HSSFWorkbook(fis);
			sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();

			output2 = MDaoUtilSingle.getData("RBA_90_01_03_01_checkFixJipyo", hm);		//보고기준일자의 결재상태확인
			if (output2.getCount("GYLJ_S_C") == 0) {
				Log.logAML(Log.DEBUG,"기존데이터에 지표정보가 없습니다.");
				ERRCODE = ERRCODE_00097;
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", WINMSG_00097);
			    return "jsonView";
			}

			String JIPYO_GYLJ_S_C = Util.nvl(output2.getText("GYLJ_S_C",0));		//지표결재상태코드 ('A014', 0:미결재, 12:승인요청, 22:반려, 3:완료)
			//결재가 완료된 상태일때
			if(!GYLJ_S_C_FIX.equals(JIPYO_GYLJ_S_C)) {
				Log.logAML(Log.DEBUG,"보고기준일자의 결재가 완료상태가 아닙니다.");
				ERRCODE = ERRCODE_00096;
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", WINMSG_00096);
			    return "jsonView";
			}


			boolean b = rows >1;
			if(!b){ //업로드 엑셀 데이터가 없는 경우
				ERRCODE = ERRCODE_00091;
				Log.logAML(Log.DEBUG,"업로드한 파일의 데이터가 없습니다.");
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", WINMSG_00091);
			    return "jsonView";
			}

			output3 = MDaoUtilSingle.getData("RBA_90_01_02_01_getSearch", hm);
			if(output3.getCount("RPT_GJDT") == 0) {
				Log.logAML(Log.DEBUG,"기존데이터에 지표정보가 없습니다.");
				ERRCODE = ERRCODE_00094;
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", WINMSG_00094);
			    return "jsonView";
			}

			// excel loop start
			for (int i = 5; i < rows; i++) {
				HSSFRow row = sheet.getRow(i);
				if (row == null) { continue; }

				//row.getCell(1) ==> 인덱스
				//row.getCell(6) ==> 순위
				//row.getCell(7) ==> 지표점수
				//row.getCell(9) ==> 평가그룹 평균점수
				//row.getCell(10) ==> 평가그룹 최대점수
				//row.getCell(11) ==> 평가그룹 최소점수

				String JIPYO_IDX   = Util.nvl(row.getCell(1).toString() , "");
				String RANK   	   = Util.nvl(row.getCell(6).toString() , "");
				Log.logAML(Log.DEBUG, "JIPYO_IDX : "+JIPYO_IDX + ",  RANK : "+RANK + "(i : "+i+")");
				String RPT_PNT 	   = isStringNum(Util.nvl(row.getCell(7).toString() , "0"));
				String GRP_AVG_PNT = isStringNum(Util.nvl(row.getCell(9).toString() , "0"));
				String GRP_MAX_PNT = isStringNum(Util.nvl(row.getCell(10).toString() , "0"));
				String GRP_MIN_PNT = isStringNum(Util.nvl(row.getCell(11).toString() , "0"));


				if("".equals(JIPYO_IDX) || (!JIPYO_IDX.startsWith("O.")  && !JIPYO_IDX.startsWith("I.")) ) {
					Log.logAML(Log.DEBUG, "비정상 row pass");
					continue;
				}

				if (JIPYO_IDX == null || "".equals(JIPYO_IDX) ) {
					Log.logAML(Log.DEBUG,"엑셀에서 받은 지표번호값이 null일때......");
					ERRCODE = ERRCODE_00093;
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", WINMSG_00093);
				    return "jsonView";
				}

				boolean isAdded = false;  // 결과파일의 지표번호와 DB의 지표번호 비교
				for (int j = 0; j < output3.getCount(); j++) {
					String L_JIPYO_IDX = Util.nvl(output3.getText("JIPYO_IDX", j) , "");
					if(!L_JIPYO_IDX.startsWith(JIPYO_IDX)) { continue; }

					isAdded = true;
					//Log.logAML(Log.DEBUG,"디비값과 동일");
					Log.logAML(Log.DEBUG,"보고일자 			:: "+RPT_GJDT);
					Log.logAML(Log.DEBUG,"순위 				:: "+RANK);
					Log.logAML(Log.DEBUG,"지표점수 			:: "+RPT_PNT);
					Log.logAML(Log.DEBUG,"평가그룹 평균점수 		:: "+GRP_AVG_PNT);
					Log.logAML(Log.DEBUG,"평가그룹 최대점수 		:: "+GRP_MAX_PNT);
					Log.logAML(Log.DEBUG,"평가그룹 최소점수 		:: "+GRP_MIN_PNT);

					Map<String,Object> gdResVal = new HashMap<String, Object>();
					gdResVal.put("RPT_GJDT",    RPT_GJDT);
					gdResVal.put("JIPYO_IDX",   L_JIPYO_IDX);
					gdResVal.put("RANK",        RANK);
					gdResVal.put("RPT_PNT",     RPT_PNT);
					gdResVal.put("GRP_AVG_PNT", GRP_AVG_PNT);
					gdResVal.put("GRP_MAX_PNT", GRP_MAX_PNT);
					gdResVal.put("GRP_MIN_PNT", GRP_MIN_PNT);
					gdResVal.put("USER_ID",     userId);

					val.add(gdResVal);

					ERRCODE = ERRCODE_00000;
					model.addAttribute("status", "success");
				    model.addAttribute("serviceMessage", "정상 처리되었습니다.");
					break;
				}

				if(!isAdded) {
					ERRCODE = ERRCODE_00095;
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", "지표번호("+JIPYO_IDX+")를 확인해 주시기 바랍니다.");
				    return "jsonView";
				}
			}

			if(ERRCODE_00000.equals(ERRCODE)){
				doSave(val);
				model.addAttribute("status", "success");
			    model.addAttribute("serviceMessage", "정상 처리되었습니다.");
			}

		} catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
			model.addAttribute("status", "fail");
		    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
		} catch (AMLException e) {
			Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
			model.addAttribute("status", "fail");
		    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
		} catch (Exception e) {
			Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
			model.addAttribute("status", "fail");
		    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
		} finally {

			if((newFilePathName==null)==false) {
				newFilePathName = newFilePathName.replace("\\", "/");
			}

			File uploadFile = new File(newFilePathName);
			if(uploadFile != null){
				 if (!uploadFile.delete()) {
					 Log.logAML(Log.ERROR,this,"doFileSave","처리 중 오류가 발생되었습니다.");
				 }
			}

			if (workbook != null) {
				try {workbook.close();} catch (IOException e) {e.printStackTrace();}
			}
			if (fis != null) {
				try {fis.close();} catch (IOException e) {e.printStackTrace();}
			}
		}
		return "jsonView";
	}

	public static boolean isStringDouble(String s) {
	    try {
	        Double.parseDouble(s);
	        return true;
	    } catch (NumberFormatException e) {
	        return false;
	    }
	  }

    public static String isStringNum(String num_str) {

		String num = num_str;
		Log.logAML(Log.DEBUG, "isStringNum() - num_str : "+num_str);

	    	if(!"0".equals(num)){
				try {
					int CHECK_NUM = num.lastIndexOf(".0");
					if(new BigDecimal(num.substring(CHECK_NUM+1)).compareTo(BigDecimal.ZERO)> 0){
						Log.logAML(Log.DEBUG,"pass");
					}else{
						num = num.substring(0 , CHECK_NUM);
					}
				} catch (NumberFormatException e) {
					Log.logAML(Log.DEBUG,"num_str "+num_str);
					return num_str;
				}
			}

	    return num;
   }

}
