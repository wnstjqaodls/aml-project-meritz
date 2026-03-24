package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
public class RBA_90_01_03_06 extends GetResultObject {
	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");


	public static final String JIPYO_FIX_Y					= "1";
	public static final String ITEM_S_C_FIX_Y				= "2";


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

	public static String WINMSG_00090						= "00090";
	public static String WINMSG_00091						= "업로드한 파일의 데이터가 없습니다.";
	public static String WINMSG_00092						= "보고기준일 의 지표를 확정해 주시기 바랍니다.";
	public static String WINMSG_00093						= "업로드한 파일의 인덱스값을 다시 확인하여 주시기 바랍니다.";
	public static String WINMSG_00094						= "지표정보가 없습니다.";
	public static String WINMSG_00095						= "지표정보와 엑셀에 지표번호가 불일치...";
	public static String WINMSG_00096						= "지표번호 결과값을 확인 하여 주시기 바랍니다.";
	public static String WINMSG_00097						= "결과값은 숫자만 가능 합니다.";
	public static String WINMSG_00098						= "00098";



	  private static RBA_90_01_03_06 instance = null;

	  /**
	   * getInstance
	   * @return RBA_90_01_03_06
	   */
	  public static  RBA_90_01_03_06 getInstance() {
	   // if (instance == null) {
	   //   instance = new RBA_90_01_03_06();
	   // }
	   // return instance;
	    synchronized(RBA_90_01_03_06.class) {
	    	if (instance == null) {
			    instance = new RBA_90_01_03_06();
		    }
		}
		return instance;
	  }

		@RequestMapping("/rba/90_01_03_06_doSaveFile.do")
		public String doFileSave(HttpServletRequest request, ModelMap model,FileVO paramVO)throws Exception
		{
				HashMap hm = ParamUtil.getReqParamHashMap(request);
				String filePath = Constants.COMMON_TEMP_FILE_UPLOAD_DIR; //PropertyService.getInstance().getProperty("aml.config", "upload.file.wl");
				boolean JipyoCheck = true;
				HSSFWorkbook workbook = null;
				FileInputStream fis = null;
				HSSFSheet sheet= null;
				DataObj output  = null;
				DataObj output2 = null;
				DataObj output3 = null;
				String newFilePathName ="";
				String RPT_GJDT = "";
				String VIEW_RPT_GJDT ="";
				String ERRCODE = ERRCODE_00000;

				try
				{
					output = new DataObj();
					output2 = new DataObj();
					output3 = new DataObj();

					List<Map<String, Object>> val = new ArrayList<Map<String , Object>>() ;
					SessionHelper helper = new SessionHelper(request.getSession());
					BigDecimal userId = helper.getUserId();

					String filename = hm.get("storedFileNms").toString();
					RPT_GJDT = Util.nvl(request.getParameter("RPT_GJDT") , "") ;
					VIEW_RPT_GJDT =  RPT_GJDT.substring(0 , 4)+"-"+ RPT_GJDT.substring(4 , 6)+"-"+RPT_GJDT.substring(6 , 8);
					String fileFullInfo = filePath + "/" + filename;
					newFilePathName = fileFullInfo.replace("/", System.getProperty("file.separator"));
					newFilePathName = newFilePathName.replace("\\", "/");
					fis = new FileInputStream(newFilePathName);
					workbook = new HSSFWorkbook(fis);
					sheet = workbook.getSheetAt(0);
					int rows = sheet.getPhysicalNumberOfRows();

					hm.put("RPT_GJDT", RPT_GJDT);

					output2 = MDaoUtilSingle.getData("RBA_90_01_02_01_getSearch2", hm);		//지표확정여부 가져오는 쿼리

					if(!(rows >1)){ //업로드 엑셀 데이터가 없는 경우
						ERRCODE = ERRCODE_00091;
						model.addAttribute("status", "fail");
					    model.addAttribute("serviceMessage", WINMSG_00091);
					    return "jsonView";
					}
					if (output2.getCount("RPT_GJDT") > 0) {

						String JIPYO_FIX_YN = Util.nvl(output2.getText("JIPYO_FIX_YN",0));		//지표관리 확정여부

						if(JIPYO_FIX_Y.equals(JIPYO_FIX_YN)){		//지표관리 확정이 된것만 업로드

							output3 = MDaoUtilSingle.getData("RBA_90_01_03_02_doSearch", hm);
							String  InputFIX_YN = null;
							String  Index = null;
							String  In_V = null;

								for (int i = 1; i < rows; i++) {

									if(!JipyoCheck) {
										break;
									}

									HSSFRow row = sheet.getRow(i);
									if (row != null) {	//null 체크

										//row.getCell(0) ==> 입력
										//row.getCell(1) ==> 인덱스
										//row.getCell(2) ==> 위험평가 지표명
										//row.getCell(3) ==> 입력항목명
										//row.getCell(4) ==> 입력단위
										//row.getCell(5) ==> 결과값
										//row.getCell(6) ==> 지표코드

										//입력값 결과값 인덱스 비교
										InputFIX_YN=Util.nvl(row.getCell(0).toString() , "") ;		//입력
										Index=Util.nvl(row.getCell(1).toString() , "") ;			//인덱스

										In_V =Util.nvl(row.getCell(5).toString() , "");			//결과값

										//[20230724 START] 엑셀보고파일 양식 변경 O.12.03.01 (1) ==>  O.12.03.011
										Index = Index.replace(" (", "").replace(")", "").trim();
										In_V = In_V.replaceAll("," , "");		
										In_V = In_V.replace(" ", "").contains("해당없음") ? "0" : In_V;
										//[20230724 END]엑셀보고파일 양식 변경 O.12.03.01 (1) ==>  O.12.03.011


										//입력값이 있는 경우 확정인 경우 이므로 스킵한다.
										if (!"".equals(InputFIX_YN) || !"O".equals(InputFIX_YN) || !"◎".equals(InputFIX_YN)) {

											//인덱스값 null체크
											if (StringUtils.isEmpty(Index) == false) {


												//디비값 null체크
												if (output3.getCount("RPT_GJDT") > 0) {

													for (int j = 0; j < output3.getCount(); j++) {
														String JIPYO_IDX = Util.nvl(output3.getText("JIPYO_IDX", j) , "");
														String MAX_IN_V =  Util.nvl(output3.getText("MAX_IN_V", j) , "");
														String ITEM_S_C =  Util.nvl(output3.getText("ITEM_S_C", j) , "");
														String CNCT_JIPYO_C_I =  Util.nvl(output3.getText("CNCT_JIPYO_C_I", j) , "");

														if(In_V == null || "".equals(In_V)){

															JipyoCheck = false;
															ERRCODE = ERRCODE_00096;
															model.addAttribute("status", "fail");
														    model.addAttribute("serviceMessage", "지표번호("+Index+") 결과값을 확인 하여 주시기 바랍니다.");
															break;
														}

														if(Index.equals(JIPYO_IDX)){
															System.out.println("JIPYO_IDX 디비값과 동일:: "+JIPYO_IDX);
															System.out.println("Index 	   디비값과 동일 :: "+Index);
															System.out.println("디비값과 동일");
															JipyoCheck = true;

															if(!ITEM_S_C_FIX_Y.equals(ITEM_S_C)){//확정상태가 아닌것만 저장
																if("O99998".equals(CNCT_JIPYO_C_I)){
																	if( isStringYN( In_V ) == false) {
																		JipyoCheck = false;
																		ERRCODE = ERRCODE_00098;
																		model.addAttribute("status", "fail");
																		model.addAttribute("serviceMessage", "지표번호("+Index+")의 결과값은  Y, N만 가능 합니다.");
																		break;
																	}
																}else {
																	if( isStringDouble( In_V ) == false ) {
																		JipyoCheck = false;
																		ERRCODE = ERRCODE_00097;
																		model.addAttribute("status", "fail");
																		model.addAttribute("serviceMessage", "지표번호("+Index+")의 결과값은 숫자만 가능 합니다.");
																		break;
																	}
																}

																Map<String,Object> gdResVal = new HashMap<String, Object>() ;
																gdResVal.put("RPT_GJDT", RPT_GJDT);
																gdResVal.put("JIPYO_IDX", Index);
																gdResVal.put("IN_V", In_V);
																gdResVal.put("MAX_IN_V", MAX_IN_V);
																gdResVal.put("USER_ID", userId);
																gdResVal.put("CNCT_JIPYO_C_I", CNCT_JIPYO_C_I);

																val.add(gdResVal);
															}

															ERRCODE = ERRCODE_00000;
															break;

														}else{// 디비의지표정보와 엑셀에 지표번호가 불일치
															System.out.println("JIPYO_IDX 디비값과 불일치:: "+JIPYO_IDX);
															System.out.println("Index 	   디비값과 불일치 :: "+Index);
															System.out.println("디비값과 불일치");
															JipyoCheck = false;
															ERRCODE = ERRCODE_00095;
															model.addAttribute("status", "fail");
														    model.addAttribute("serviceMessage", "지표번호("+Index+") 불일치하거나 사용여부를 확인해 주시기 바랍니다.");
														}
													}

												}else{

													System.out.println("지표정보 데이터가 없음....");
													ERRCODE = ERRCODE_00094;
													model.addAttribute("status", "fail");
												    model.addAttribute("serviceMessage", WINMSG_00094);
												}

											}else{//엑셀에서 받은 index값이 null일때
												System.out.println("엑셀에서 받은 index값이 null일때......");
												JipyoCheck = false;
												ERRCODE = ERRCODE_00093;
												model.addAttribute("status", "fail");
											    model.addAttribute("serviceMessage", WINMSG_00093);
											}

										}

									}
								}

							}else{ //지표관리 확정이 안된경우
								ERRCODE = ERRCODE_00092;
								model.addAttribute("status", "fail");
							    model.addAttribute("serviceMessage", "보고기준일자("+VIEW_RPT_GJDT+")의 지표를 확정하여 주시기 바랍니다.");
							}

					}else{//업로드한 파일의 데이터가 없습니다.

						System.out.println("지표정보 데이터가 없음....");
						ERRCODE = ERRCODE_00094;
						ERRCODE = ERRCODE_00092;
						model.addAttribute("status", "fail");
					    model.addAttribute("serviceMessage", WINMSG_00094);
					}


					if(ERRCODE_00000.equals(ERRCODE)){
						output = doSave(val);
						model.addAttribute("status", "success");
					    model.addAttribute("serviceMessage", "정상 처리되었습니다.");
					}

				} catch(RuntimeException e) {
					Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
					model.addAttribute("status", "fail");
					model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				} catch(AMLException e) {
					Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				} catch(Exception e) {
					Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				} finally {
					if((newFilePathName == null)== false) {
						newFilePathName = newFilePathName.replace("\\", "/");
					}
					File uploadFile = new File(newFilePathName);

					if(uploadFile != null){
						uploadFile.delete();
					}

					if (workbook != null) {
                       try {
						    workbook.close();
                       }catch (IOException e) {
                    	   Log.logAML(Log.ERROR, this, "doFileSave(IOException)", e.toString());
       				   }
					}
					if (fis != null) {
                        try {
						fis.close();
                        }catch (IOException e) {
                        	Log.logAML(Log.ERROR, this, "doFileSave(IOException)", e.toString());
       				   }
					}

				}
				return "jsonView";
		}

		@SuppressWarnings({ "unchecked", "rawtypes" })
		public DataObj doSave(List<Map<String, Object>> val) throws AMLException {

			DataObj output  = null;

			try {

				if(val != null){

					output = new DataObj();
					EvalScoreCalculationAction evlScoreCal = new EvalScoreCalculationAction();

					for (int i = 0; i < val.size(); i++) {

						HashMap<Object, Object> map =(HashMap)val.get(i);
						String RPT_GJDT = Util.nvl(map.get("RPT_GJDT").toString());
						String JIPYO_IDX = Util.nvl(map.get("JIPYO_IDX").toString());
						String IN_V = Util.nvl(map.get("IN_V").toString() , "");
						IN_V = IN_V.replaceAll("," , "");		// 2025.10.16
						
						String CNCT_JIPYO_C_I = Util.nvl(map.get("CNCT_JIPYO_C_I").toString() , "");

						if(!"0".equals(IN_V) && !"O99998".equals(CNCT_JIPYO_C_I)){

							int IN_V_NUM = IN_V.lastIndexOf(".0");
							if(new BigDecimal(IN_V.substring(IN_V_NUM+1)).compareTo(BigDecimal.ZERO)<= 0){

								IN_V = IN_V.substring(0 , IN_V_NUM);
							}
						}

						String USER_ID = Util.nvl(map.get("USER_ID").toString() , "");
						String MAX_IN_V = Util.nvl(map.get("MAX_IN_V").toString(),"");// MAX값

						System.out.println("RPT_GJDT :: "+RPT_GJDT);
						System.out.println("JIPYO_IDX :: "+JIPYO_IDX);
						System.out.println("IN_V :: "+IN_V);

						map.put("RPT_GJDT", RPT_GJDT);
						map.put("JIPYO_IDX", JIPYO_IDX);
						map.put("IN_V", IN_V);
						map.put("ITEM_S_C", "1");							//항목상태코드 ('A010', 0:미확정, 1:저장, 2:확정)
						map.put("DR_OP_JKW_NO", USER_ID);
						//2025-04-01 점수계산 로직 제거
						map.put("RPT_PNT", "0");			//보고점수
//						map.put("RPT_PNT", Util.nvl(evlScoreCal.EvalScoreCalculationResult(RPT_GJDT , JIPYO_IDX, IN_V , MAX_IN_V),"0"));			//보고점수

						MDaoUtilSingle.setData("RBA_90_01_03_01_doSave", map);
						MDaoUtilSingle.setData("RBA_90_01_03_01_doSave2", map);

					}

				}
				if (output != null) {
					output.put("ERRCODE", ERRCODE_00000);
					output.put("WINMSG",  "정상 처리되었습니다.");
					output.put("ERRMSG",  "정상 처리되었습니다.");
				}

				} catch (AMLException e) {

					output = new DataObj();
					output.put("ERRCODE", "00001");
					output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));

				}
			//finally {}
			return output;
		}

		public static boolean isStringDouble(String s) {
		    try {
		        Double.parseDouble(s);
		        return true;
		    } catch (NumberFormatException e) {
		        return false;
		    }
		  }

		public static boolean isStringYN(String s) {
			if("Y".equals(s.toUpperCase())||"N".equals(s.toUpperCase())) {
				return true;
			}else {
				return false;
			}
		}


}
