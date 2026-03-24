package com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_03;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.apache.commons.lang.StringUtils;
import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.common.ParamUtil;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 프로세스별 통제활동 관리
 * </pre>
 * @author LCJ
 * @version 1.0
 * @history 1.0 2018-04-30
 */
@Controller
public class RBA_50_04_03_02 extends GetResultObject {

	private static RBA_50_04_03_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_01
	*/
	public static  RBA_50_04_03_02 getInstance() {
		if (instance == null) {
			instance = new RBA_50_04_03_02();
		}
		return instance;
	}

	/**
	* <pre>
	* 프로세스 리스트 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_03_02_doSearch", input);
			// grid data
			if (output.getCount("CNTL_ELMN_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}


	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_03_03_doSearch", input);
			// grid data
			if (output.getCount("CNTL_ELMN_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}


	public DataObj doSearch4(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_03_04_doSearch", input);
			// grid data
			if (output.getCount("CNTL_ELMN_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	
	
	public DataObj doSearchCust(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_03_02_doSearchCust", input);
			// grid data
			if (output.getCount("AML_CUST_ID") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}


	public DataObj getSearchFile(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_50_04_03_02_getRbaAttchInfo",(HashMap) input);
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

	/**
	* <pre>
	* 통제요소 수행 데이터 저장
	* </pre>
	* @param input
	* @return
	*/

	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		DataObj param = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;

		try {
			output= new DataObj();
			mDao = new MDaoUtil();
			mDao.begin();

			SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();
		    String[] arr = null;

		    String BAS_YYMM = input.get("BAS_YYMM").toString();
		    String CNTL_CATG1_C = input.get("CNTL_CATG1_C").toString();
		    String CNTL_CATG2_C = input.get("CNTL_CATG2_C").toString();
		    String CNTL_ELMN_C = input.get("CNTL_ELMN_C").toString();
		    String BRNO = input.get("BRNO").toString();
		    String EVAL_TYPE_CD1 = input.get("EVAL_TYPE_CD1").toString();
		    String CNTL_ITEM_C = "";
		    
		    int SNO = 0;
		    int count_y = 0;
		    int count_sum = 0;
		    Double val_1 = 0.0;
		    Double val_2 = 0.0;
		    Double score = 0.0;


		    String CNTL_ITEM_DE_C ="";
		    String CHECK_YN ="";

		    param = new DataObj();
		    param.put("BAS_YYMM", BAS_YYMM);
		    param.put("CNTL_CATG1_C", CNTL_CATG1_C);
		    param.put("CNTL_CATG2_C", CNTL_CATG2_C);
		    param.put("CNTL_ELMN_C", CNTL_ELMN_C);
		    param.put("BRNO", BRNO);
		    param.put("CNTL_ITEM_C", CNTL_ITEM_C);
		    param.put("DR_OP_JKW_NO", logigId);
		    param.put("CHG_OP_JKW_NO", logigId);

		    String dataArr[] = input.get("dataArr").toString().split(",");



		    for(int i=0; i< dataArr.length; i++) {
		    	arr = dataArr[i].split("#");
		    	CNTL_ITEM_DE_C   = arr[0].trim();
		    	CHECK_YN         =  arr[1].trim();

		    	if(EVAL_TYPE_CD1.equalsIgnoreCase("1") && CHECK_YN.equalsIgnoreCase("Y")  ) {  //단수Y/N 케이스
		    		count_y++;
		    	}
		    	count_sum ++;

		    	if(EVAL_TYPE_CD1.equalsIgnoreCase("3") && i == 0  ) {  //실적 상단
		    		val_1 = Double.parseDouble(CHECK_YN) ;
		    	} else if(EVAL_TYPE_CD1.equalsIgnoreCase("3") && i == 1  ) {  //실적 하단
		    		val_2 = Double.parseDouble(CHECK_YN);
		    	}

		    	param.put("CNTL_ITEM_DE_C", CNTL_ITEM_DE_C);


		    	if( EVAL_TYPE_CD1.equalsIgnoreCase("3")  ) {  //실적입력

					param.put("CHECK_YN", "0");
					param.put("CNTL_VALUE", CHECK_YN);
				} else {

					param.put("CHECK_YN", CHECK_YN);
					param.put("CNTL_VALUE", "0");
				}


				mDao.setData("RBA_50_04_03_02_doUpdateCntlBrnoElmnList", param);

		    }


		    if( EVAL_TYPE_CD1.equalsIgnoreCase("1")  ) {
		    	score = Double.valueOf(count_y)*100 / Double.valueOf(count_sum);
		    	input.put("CNT_PNT", score);
		    	mDao.setData("RBA_50_04_03_02_doUpdate", input); //기본정보UPDATE
			} else if( EVAL_TYPE_CD1.equalsIgnoreCase("3")  ){
				score = val_2 * 100 / val_1;
				input.put("CNT_PNT", score);
				mDao.setData("RBA_50_04_03_02_doUpdate", input); //기본정보UPDATE
			}
		    
		    mDao.commit();

			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
				if (mDao != null) {
					mDao.rollback();
				}
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally {
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}


	public DataObj doSave3(DataObj input) throws AMLException {

		DataObj output = null;
		DataObj param = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;

		try {
			output= new DataObj();
			mDao = new MDaoUtil();
			mDao.begin();

			SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();
		    String[] arr = null;

		    String BAS_YYMM = input.get("BAS_YYMM").toString();
		    String CNTL_CATG1_C = input.get("CNTL_CATG1_C").toString();
		    String CNTL_CATG2_C = input.get("CNTL_CATG2_C").toString();
		    String CNTL_ELMN_C = input.get("CNTL_ELMN_C").toString();
		    String BRNO = input.get("BRNO").toString();
		    String CNTL_ITEM_C = "";

		    int SNO = 0;
		    int count_y = 0;
		    int count_sum = 0;
		    Double score = 0.0;


		    String CNTL_ITEM_DE_C ="";
		    String CHECK_YN ="";

		    param = new DataObj();
		    param.put("BAS_YYMM", BAS_YYMM);
		    param.put("CNTL_CATG1_C", CNTL_CATG1_C);
		    param.put("CNTL_CATG2_C", CNTL_CATG2_C);
		    param.put("CNTL_ELMN_C", CNTL_ELMN_C);
		    param.put("BRNO", BRNO);
		    param.put("CNTL_ITEM_C", CNTL_ITEM_C);
		    param.put("DR_OP_JKW_NO", logigId);
		    param.put("CHG_OP_JKW_NO", logigId);

		    String dataArr[] = input.get("dataArr").toString().split(",");



		    for(int i=0; i< dataArr.length; i++) {
		    	arr = dataArr[i].split("#");
		    	CNTL_ITEM_DE_C   = arr[0].trim();
		    	CHECK_YN         =  arr[1].trim();

		    	if(CHECK_YN.equalsIgnoreCase("Y")  ) {  //단수Y/N 케이스
		    		count_y++;
		    	}
		    	count_sum ++;

		    	param.put("SNO", CNTL_ITEM_DE_C);
		    	param.put("CHECK_YN", CHECK_YN);
		    	param.put("CNTL_VALUE", "0");


				mDao.setData("RBA_50_04_03_03_doUpdateCntlBrnoElmnList", param);

		    }



	    	score = Double.valueOf(count_y)*100 / Double.valueOf(count_sum);
	    	input.put("CNT_PNT", score);
	    	mDao.setData("RBA_50_04_03_02_doUpdate", input); //기본정보UPDATE


		    mDao.commit();

			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} finally {
			if(mDao != null ) {
				mDao.close();
			}
		}
		return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/rba/50_04_03_02_doSaveFile.do", method=RequestMethod.POST)
	public String doFileSave(HttpServletRequest request, ModelMap model ,FileVO paramVO )throws Exception {
		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		try {
				mDao = new MDaoUtil();
				HashMap hm = ParamUtil.getReqParamHashMap(request);
				SessionHelper helper = new SessionHelper(request.getSession());
				
				String logigId = helper.getLoginId();
				String DR_OP_JKW_NO2 = Util.nvl(helper.getLoginId());
				String DR_OP_JKW_NO = logigId; //등록조작자번호
				String CHG_OP_JKW_NO = logigId; //변경조작자번호
				String CNTL_ELMN_C = Util.nvl(request.getParameter("CNTL_ELMN_C"));; 
				String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
				String BRNO = Util.nvl(request.getParameter("BRNO"));
				
				hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
				hm.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
				hm.put("CNTL_ELMN_C", CNTL_ELMN_C);
				hm.put("BRNO", BRNO);
				
				System.out.println("hm ::::::::" + hm.toString());
				
		        @SuppressWarnings("unused")
		        int result = 0;

		       
		        //기존 파일목록 
				DataObj fdo = MDaoUtilSingle.getData("RBA_50_04_03_02_getRbaAttchList",hm);
				List<HashMap> fileList = fdo.getRowsToMap();
				
			     // 파일 이동 및 처리
					if (null != paramVO.getFilePaths()) {
						for (int i = 0; i < paramVO.getFilePaths().length; i++) {
							if (paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1) {
	
								File tempDir = new File(paramVO.getFilePaths()[i]);
								File tempFile = new File(tempDir, paramVO.getStoredFileNms()[i]);
								if (tempFile.isFile()) {
									File realFile = FileUtil.renameTo(tempFile, Constants._UPLOAD_RBA_DIR);
	
									String[] filePath = paramVO.getFilePaths();
									filePath[i] = StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"), Constants._UPLOAD_RBA_DIR, "");
	
									paramVO.setFilePath(filePath[i]);
									paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
								} else {
									String[] filePath = paramVO.getFilePaths();
									filePath[i] = StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR,
											Constants._UPLOAD_RBA_DIR);
	
									paramVO.setFilePath(filePath[0]);
									paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
								}
								
								
							} else {
								String[] filePath = paramVO.getFilePaths();
								filePath[i] = StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR,
										Constants._UPLOAD_RBA_DIR);
	
								paramVO.setFilePath(filePath[i]);
								paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
							}
						}
	
						if("".equals(ATTCH_FILE_NO))
				        {
				        	 output = mDao.getData("comm.RBA_10_02_01_01_getRbaAttchFileSeq", hm);
					         ATTCH_FILE_NO = output.getText("SEQ");
	
				        }
	
						System.out.println("FILEPATH=============" + paramVO.getFilePath());
						
						//기존파일 목록 비교 후 삭제처리						
						for(int i=0; i < fileList.size(); i++){

							boolean btn = false;

							for(int k = 0; k < paramVO.getFilePaths().length; k++){

								String r = paramVO.getStoredFileNms()[k];			

								if(r.equals(fileList.get(i).get("PHSC_FILE_NM"))){

									btn = false;						
									break;

								}else{

									btn = true;
								}
							}

							//넘어온 값과 기존파일목에 존재하지 않으면 삭제
							if(btn){

								String filePath = Constants._UPLOAD_RBA_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
								FileUtil.deleteFile(filePath);
							}
						}					

						//db 파일 삭제
						hm.put("CNTL_ELMN_C", CNTL_ELMN_C);
						hm.put("BRNO", BRNO);
						hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
						mDao.setData("RBA_50_04_03_02_doResetFile", hm);
						mDao.commit();
						
						// 파일일괄 인서트
						String vOrgFileNm = new String();
	
						for (int i = 0; i < paramVO.getFilePaths().length; i++) {
							DataObj obj11 = new DataObj();
							// 첨부파일 stored XSS
							vOrgFileNm = paramVO.getOrigFileNms()[i].replaceAll("<", "&lt;").replaceAll(">", "&gt;")
									.replaceAll("\"", "&quot;").replaceAll("\"", "&#039;").replaceAll("\'", "&#x27;")
									.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;").replaceAll("\\\\", "&#x2F;");

							obj11.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
							obj11.put("FILE_SER", "" + (i + 1));
							obj11.put("DATA_G", "G");
							obj11.put("FILE_POS", paramVO.getFilePath());
							// obj11.put("USER_FILE_NM", paramVO.getOrigFileNms()[i]);
							obj11.put("LOSC_FILE_NM", vOrgFileNm);
							obj11.put("PHSC_FILE_NM", paramVO.getStoredFileNms()[i]);
							obj11.put("FILE_SIZE", paramVO.getFileSizes()[i]);
							obj11.put("DOWNLOAD_CNT", 0);
							obj11.put("DR_OP_JKW_NO", DR_OP_JKW_NO2);

							result = mDao.setData("comm.RBA_10_02_01_01_insertFile", obj11);

						}
						hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
					}

					hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
					mDao.setData("RBA_50_04_03_02_doSaveFile", hm);
					mDao.commit();
					
					model.addAttribute("status", "success");
					model.addAttribute("serviceMessage", "정상 처리되었습니다.");
				}
				catch(IndexOutOfBoundsException e)
				{
					try {
						if (mDao != null) {
							mDao.rollback();
						}
					} catch (AMLException e1) {
						Log.logAML(Log.ERROR,this,"doSave",e.toString());
						model.addAttribute("status", "fail");
						model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
					}
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
					model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}catch(AMLException e)
				{
					try {
						if (mDao != null) {
							mDao.rollback();
						}
					} catch (AMLException e1) {
						Log.logAML(Log.ERROR,this,"doSave",e.toString());
						model.addAttribute("status", "fail");
						model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
					}
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
					model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}
				catch(Exception e)
				{
					try {
						if (mDao != null) {
							mDao.rollback();
						}
					} catch (AMLException e1) {
						Log.logAML(Log.ERROR,this,"doSave",e.toString());
						model.addAttribute("status", "fail");
					    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
					}
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}finally {
					if (mDao != null) {
						mDao.close();
					}
				}
	
				return "jsonView";
	  }



}