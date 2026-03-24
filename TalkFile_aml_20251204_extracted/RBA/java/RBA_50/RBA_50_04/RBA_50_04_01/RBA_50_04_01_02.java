/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_01;


import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.dao.MCommonDAOSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DBUtil;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;
import org.springframework.web.util.HtmlUtils;

/**
 * <pre>
 * 통제점검항목 상세 팝업
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-24
 */
@Controller
public class RBA_50_04_01_02 extends GetResultObject {

	private static RBA_50_04_01_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_04_01_02
	*/
	public static  RBA_50_04_01_02 getInstance() {
		if (instance == null) {
			instance = new RBA_50_04_01_02();
		}
		return instance;
	}



	public DataObj getSearchCntlItemList(DataObj input) {
	    DataObj output = null;
	    try {

	      String BAS_YYMM = Util.nvl(input.getText("BAS_YYMM") , "") ;
	      String CNTL_ELMN_C = Util.nvl(input.getText("CNTL_ELMN_C") , "");

	      System.out.println("BAS_YYMM :: "+BAS_YYMM);
	      System.out.println("CNTL_ELMN_C :: "+CNTL_ELMN_C);

	      List EvalDetails 	= DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_50_04_01_02_getSearchEvaluationCriteria", input));	//평가기준데이터

	      input.put("GRP_CD", Util.nvl(input.getText("CNCT_JIPYO_C_I") , ""));
	      List EvalCmprV 	= DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_50_04_01_02_getSearchEvaluationCode", input));		//비교값

	      input.put("GRP_CD", "A009");
	      List EvalCmprCalC = DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_50_04_01_02_getSearchEvaluationCode", input));		//산식코드(A009)

	      output = new DataObj();

	      output.put("EvalDetails", EvalDetails);	//평가기준데이터
	      output.put("EvalCmprCalC", EvalCmprCalC);	//산식코드(A009)
	      output.put("EvalCmprV", EvalCmprV);		//비교값

	      output.put("ERRCODE", "00000");

	    }  catch (IOException ioe) {
	      Log.logAML(Log.ERROR,this,"getSearchEvaluationCriteria(IOException)",ioe.toString());
	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", ioe.toString());
	    } catch (RuntimeException re) {
	      Log.logAML(Log.ERROR,this,"getSearchEvaluationCriteria(RuntimeException)",re.toString());
	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", re.toString());
	    } catch (Exception e) {
	      Log.logAML(Log.ERROR, this, "getSearchEvaluationCriteria(Exception)", e.getMessage());
	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    }
	    return output;
	  }



	/**
	* <pre>
	* 통제점검항목 요소 및 점검항목 조회
	* </pre>
	* @param input
	* @return
	*/

	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_04_01_02_doSearch", input);

			if (output.getCount("CNTL_ELMN_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	/**
	* <pre>
	* </pre>
	* @param input
	* @return
	 * @throws AMLException
	*/
	public DataObj doSave(DataObj input) {
		DataObj output = null;
		MDaoUtil db = null;
		try {

			db = new MDaoUtil();
			db.begin();
			
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			db.setData("RBA_50_04_01_02_doUpDateMain", input); //기본정보UPDATE
			//db.setData("RBA_50_04_01_02_doUpDateCode", input); //code UPDATE

			db.setData("RBA_50_04_01_02_doDeleteCntlElmnList", input); //삭제
			int number = Integer.valueOf(input.get("trCnt").toString());

			for ( int i = 0; i < number; i++ ) {

				DataObj param = new DataObj();


				if( StringHelper.evl(input.get("CNTL_ITEM_DE_CTNT", i), "").isEmpty() ) {
					continue;
				}

				int SNO = i + 1;
				input.put("CNTL_ITEM_C", SNO);

				param.put("BAS_YYMM", StringHelper.evl(input.get("BAS_YYMM"), ""));
				param.put("CNTL_CATG1_C", StringHelper.evl(input.get("CNTL_CATG1_C"), ""));
				param.put("CNTL_CATG2_C", StringHelper.evl(input.get("CNTL_CATG2_C"), ""));
				param.put("CNTL_ELMN_C", StringHelper.evl(input.get("CNTL_ELMN_C"), ""));
				param.put("CNTL_ITEM_C", "0");
				param.put("CNTL_ITEM_DE_C", SNO);
				param.put("CNTL_ITEM_DE_CTNT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("CNTL_ITEM_DE_CTNT", i), "")));
				param.put("AUTO_EXT_YN", StringHelper.evl(input.get("AUTO_EXT_YN", i), ""));
				param.put("AUTO_SAMPLE_CTNT", StringHelper.evl(input.get("AUTO_SAMPLE_CTNT", i), ""));

				param.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

				db.setData("RBA_50_04_01_02_doInsertCntlElmnList", param); //insert

			}




			db.commit();

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Grid Data

		} catch (NumberFormatException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (RuntimeException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (AMLException e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}
		return output;
	}
	
	
	
	
	/**
	* <pre>
	* </pre>
	* @param input
	* @return
	 * @throws AMLException
	*/
	public DataObj doAdd(DataObj input) {
		DataObj output = null;
		MDaoUtil db = null;
		try {

			db = new MDaoUtil();
			db.begin();
			
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			db.setData("RBA_50_04_01_02_insert_SRBA_CNTL_ELMN_M", input); //기본정보UPDATE
			//db.setData("RBA_50_04_01_02_doUpDateCode", input); //code UPDATE

			db.setData("RBA_50_04_01_02_doDeleteCntlElmnList", input); //삭제
			int number = Integer.valueOf(input.get("trCnt").toString());

			for ( int i = 0; i < number; i++ ) {

				DataObj param = new DataObj();


				if( StringHelper.evl(input.get("CNTL_ITEM_DE_CTNT", i), "").isEmpty() ) {
					continue;
				}

				int SNO = i + 1;
				input.put("CNTL_ITEM_C", SNO);

				param.put("BAS_YYMM", StringHelper.evl(input.get("BAS_YYMM"), ""));
				param.put("CNTL_CATG1_C", StringHelper.evl(input.get("CNTL_CATG1_C"), ""));
				param.put("CNTL_CATG2_C", StringHelper.evl(input.get("CNTL_CATG2_C"), ""));
				param.put("CNTL_ELMN_C", StringHelper.evl(input.get("CNTL_ELMN_C"), ""));
				param.put("CNTL_ITEM_C", "0");
				param.put("CNTL_ITEM_DE_C", SNO);
				param.put("CNTL_ITEM_DE_CTNT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("CNTL_ITEM_DE_CTNT", i), "")));
				param.put("AUTO_EXT_YN", StringHelper.evl(input.get("AUTO_EXT_YN", i), ""));
				param.put("AUTO_SAMPLE_CTNT", StringHelper.evl(input.get("AUTO_SAMPLE_CTNT", i), ""));

				param.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

				db.setData("RBA_50_04_01_02_doInsertCntlElmnList", param); //insert

			}




			db.commit();

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Grid Data

		} catch (NumberFormatException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (RuntimeException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (AMLException e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}
		return output;
	}
	
	
	
	
	/**
	* <pre>
	* </pre>
	* @param input
	* @return
	 * @throws AMLException
	*/
	public DataObj doDeleteForCntl(DataObj input) {
		DataObj output = null;
		MDaoUtil db = null;
		try {

			db = new MDaoUtil();
			db.begin();
			
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			db.setData("RBA_50_04_01_02_delete_SRBA_CNTL_ELMN_M", input); //기본정보 삭제
			db.setData("RBA_50_04_01_02_delete_SRBA_CNTL_BRNO_I", input); //기본정보 삭제
			db.setData("RBA_50_04_01_02_doDeleteCntlElmnList", input); //삭제

			db.commit();

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Grid Data

		} catch (NumberFormatException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (RuntimeException re) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (AMLException e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
			} catch (AMLException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}
		return output;
	}


	@RequestMapping(value="/rba/RBA_50_04_01_02doSave.do", method=RequestMethod.POST)
	public String doSave(HttpServletRequest request, ModelMap model ,FileVO paramVO ) {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		try
			{
				mDao = new MDaoUtil();
				mDao.begin();
				output = new DataObj();
				SessionHelper helper = new SessionHelper(request.getSession());
				String logigId = helper.getLoginId();
				String DR_OP_JKW_NO = logigId; //등록조작자번호
				String CHG_OP_JKW_NO = logigId; //변경조작자번호

				String GUBN = request.getParameter("GUBN");  //구분이 0: 등록  , 1: 수정
				HashMap hm = ParamUtil.getReqParamHashMap(request);
				hm.put("TONGJE_FLD_C", request.getParameter("PROC_FLD_C"));
				hm.put("TONGJE_NO", request.getParameter("S_TONGJE_NO"));
				hm.put("DSGN_VALT_TP_C", request.getParameter("S_DSGN_VALT_TP_C"));
			    hm.put("VALD_VALT_METH_C", request.getParameter("S_VALD_VALT_METH_C"));
			    hm.put("VALT_METH_C", request.getParameter("S_VALT_METH_C"));
				hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
				hm.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
				hm.put("BRNO_LIST", request.getParameter("TJ_BRNO_CD_LIST"));
				System.out.println("hm ::::::::"+hm.toString());

//				DataObj SNO = mDao.getData("RBA_50_03_01_01_getMaxSno", hm);
//				DataSet ds = Common.setGridData(SNO);
//				hm.put("SNO", ds.getString(0, "SNO"));


				@SuppressWarnings("unused")
				int result = 0;


				//기존 파일목록
				DataObj fdo = MDaoUtilSingle.getData("RBA_50_04_01_02_getRbaAttchInfo",hm);
				List<HashMap> fileList = fdo.getRowsToMap();

		        // 파일 이동 및 처리
				if((null == paramVO.getFilePaths()) == false)
				{
					for(int i = 0; i < paramVO.getFilePaths().length; i++)
					{
						if(paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1)
						{
							File	tempDir		= new File(paramVO.getFilePaths()[i]);
							File	tempFile	= new File(tempDir, paramVO.getStoredFileNms()[i]);

							if(tempFile.isFile())
							{
								File	realFile	= FileUtil.renameTo(tempFile, Constants._UPLOAD_RBA_DIR);

								String[]	filePath	= paramVO.getFilePaths();
								filePath[i]				= StringUtils.replace(realFile.getParent(),Constants._UPLOAD_RBA_DIR,"");

								paramVO.setFilePath(filePath[i]);
								paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
							}
							else
							{
								String[]	filePath	= paramVO.getFilePaths();
								filePath[i]				= StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_RBA_DIR);

								paramVO.setFilePath(filePath[0]);
							}
						}else {
							String[]	filePath	= paramVO.getFilePaths();
							filePath[i]				= StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_RBA_DIR);

							paramVO.setFilePath(filePath[0]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
					}

					//기존파일 목록 비교 후 삭제처리
					for(int i=0; i < fileList.size(); i++)
					{
						boolean btn = false;

						for(int k = 0; k < paramVO.getFilePaths().length; k++)
						{
							String r = paramVO.getStoredFileNms()[k];

							if(r.equals(fileList.get(i).get("PHSC_FILE_NM")))
							{
								//btn = true;
								btn = false;
								break;
							}
							else
							{
								//btn = false;
								//break;
								btn = true;
							}
						}

						//넘어온 값과 기존파일목에 존재하지 않으면 삭제
						if(btn)
						{
							String filePath = Constants._UPLOAD_RBA_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
							FileUtil.deleteFile(filePath);
						}
					}


					//db 파일 삭제
					mDao.setData("RBA_30_04_03_1N_deleteFile", hm);


  				  //  String RPT_GJDT = Util.replace(Util.nvl(hm.get("RPT_GJDT")), "-", "");
			      //  String FIU_RPT_GJDT = Util.replace(Util.nvl(hm.get("FIU_RPT_GJDT")), "-", "");
			        String DR_OP_JKW_NO2 = Util.nvl(helper.getLoginId());
			        String ATTCH_FILE_NO = Util.nvl(hm.get("ATTCH_FILE_NO"));
			      //  String BAS_YYMM = Util.replace(Util.nvl(hm.get("BAS_YYMM")), "-", "");

			        if("".equals(ATTCH_FILE_NO))
			        {
			        	 output = mDao.getData("comm.RBA_10_02_01_01_getRbaAttchFileSeq", hm);
				         ATTCH_FILE_NO = output.getText("SEQ");
			        }

		            Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! :" + ATTCH_FILE_NO);


					//파일일괄 인서트
					for(int i = 0; i < paramVO.getFilePaths().length; i++)
					{
						DataObj obj1 = new DataObj();
						obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			            obj1.put("FILE_SER", i+1);
			            obj1.put("DATA_G", "G");
			            obj1.put("FILE_POS", paramVO.getFilePath());
			            obj1.put("LOSC_FILE_NM", paramVO.getOrigFileNms()[i]);
			            obj1.put("PHSC_FILE_NM", paramVO.getStoredFileNms()[i]);
			            obj1.put("FILE_SIZE", paramVO.getFileSizes()[i]);
			            obj1.put("DOWNLOAD_CNT", 0);
			            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO2);

			            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);

					}
					hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
					hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO2);
					mDao.setData("RBA_50_04_01_01_UPDATE_SRBA_V_TONGJE_M", hm);
					mDao.commit();
				}
				else
				{
					for(int i=0; i < fileList.size(); i++)
					{
						//기존 파일 삭제
						String filePath = Constants._UPLOAD_RBA_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}

					//db 파일 삭제
					mDao.setData("RBA_30_04_03_1N_deleteFile", hm);
					mDao.commit();
				}

				String sqlId = ("0".equals(GUBN)) ? "RBA_50_04_01_02_doSave_insert" : "RBA_50_04_01_02_doSave_update";

				//첨부파일이 없으면
				if(hm.get("ATTCH_FILE_NO") == null || "".equals(hm.get("ATTCH_FILE_NO"))){
					hm.put("ATTCH_FILE_NO", 0);
				}
			    mDao.setData(sqlId, hm);
				//통제 부점 저장 로직 시작
			    mDao.setData("RBA_50_04_01_02_doDeleteBrno", hm);

			    if (hm.get("BRNO_LIST") != null &&  !"".equals(hm.get("BRNO_LIST"))) {
			    	String[] BRNO_LIST =hm.get("BRNO_LIST").toString().split(",");

			    	for(int i=0;i <BRNO_LIST.length; i++ ) {
			    		hm.put("BRNO", BRNO_LIST[i]);
			    		mDao.setData("RBA_50_04_01_02_doSaveBrno", hm);
			    	}
			    }
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
			} catch(IOException e)
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
			} catch(AMLException e)
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

	public DataObj getSearchF(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_50_04_01_02_getRbaAttchInfo",(HashMap) input);
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
	* 통제점검항목 삭제
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;
		int result = 0;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = new DataObj();

		    if (input.get("BRNO_LIST") != null &&  !"".equals(input.get("BRNO_LIST"))) {
		    	String[] BRNO_LIST =input.get("BRNO_LIST").toString().split(",");

		    	for(int i=0;i <BRNO_LIST.length; i++ ) {
		    		input.put("BRNO", BRNO_LIST[i]);
		    		//SRBA_V_TONGJE_M 삭제
				    mDao.setData("RBA_50_04_01_02_doDelete_SRBA_V_TONGJE_M", input);
		    		//SRBA_V_TJ_BRNO 삭제
				    mDao.setData("RBA_50_04_01_02_doDelete_SRBA_V_TJ_BRNO", input);
		    	}
		    }else {
		    	//SRBA_V_TONGJE_M 삭제
			    mDao.setData("RBA_50_04_01_02_doDelete_SRBA_V_TONGJE_M", input);
	    		//SRBA_V_TJ_BRNO 삭제
			    mDao.setData("RBA_50_04_01_02_doDelete_SRBA_V_TJ_BRNO", input);
		    }
		  //파일삭제
			HashMap hm = new HashMap();
			hm.put("BAS_YYMM", input.get("BAS_YYMM"));
			hm.put("PROC_SMDV_C", input.get("TONGJE_SMDV_C"));
			hm.put("TONGJE_NO", input.get("TONGJE_NO"));

			DataObj fdo = MDaoUtilSingle.getData("RBA_50_04_01_02_getRbaAttchInfo", hm);
			List<HashMap> fileList = fdo.getRowsToMap();
			System.out.println("fileList ::::::::"+fileList.toString());
			StringBuffer strPath = new StringBuffer(256);
			for(int i=0; i < fileList.size(); i++)
			{
				strPath.setLength(0);
				strPath.append(Constants._UPLOAD_RBA_DIR);
				strPath.append(fileList.get(i).get("FILE_POS"));
				strPath.append('/');
				strPath.append(fileList.get(i).get("PHSC_FILE_NM"));
				String filePath = strPath.toString();
				//String filePath = Constants._UPLOAD_NOTICE_DIR+fileList.get(i).get("FILE_POS")+"/"+fileList.get(i).get("PHSC_FILE_NM");
				FileUtil.deleteFile(filePath);
			}
			result = MDaoUtilSingle.setData("RBA_50_03_01_01_doFileDelete", fdo);
		    mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (IOException io) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSearch", io.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", io.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally {
			if(mDao != null) {
				mDao.close();
			}

		}
		return output;
	}

	public DataObj getSearchCntlElmnList(DataObj input) {
	    DataObj output = null;
	    try {

	      String BAS_YYMM = Util.nvl(input.getText("BAS_YYMM") , "") ;
	      String CNTL_ELMN_C = Util.nvl(input.getText("CNTL_ELMN_C") , "");

	      System.out.println("BAS_YYMM :: "+BAS_YYMM);
	      System.out.println("CNTL_ELMN_C :: "+CNTL_ELMN_C);

	      List EvalDetails 	= DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_50_04_01_02_getSearchCntlElmnList", input));	//평가기준데이터

	      output = new DataObj();
	      output.put("EvalDetails", EvalDetails);	//평가기준데이터

	      output.put("ERRCODE", "00000");

	    }  catch (IOException ioe) {
	      Log.logAML(Log.ERROR,this,"getSearchEvaluationCriteria(IOException)",ioe.toString());
	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", ioe.toString());
	    } catch (RuntimeException re) {
	      Log.logAML(Log.ERROR,this,"getSearchEvaluationCriteria(RuntimeException)",re.toString());
	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", re.toString());
	    } catch (Exception e) {
	      Log.logAML(Log.ERROR, this, "getSearchEvaluationCriteria(Exception)", e.getMessage());
	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    }
	    return output;
	  }
}