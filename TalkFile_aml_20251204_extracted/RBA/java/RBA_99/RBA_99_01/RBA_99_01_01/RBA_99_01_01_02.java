package com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DateUtil;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import kr.co.itplus.jwizard.dataformat.DataSet;

@Controller
public class RBA_99_01_01_02 extends GetResultObject {

	private static RBA_99_01_01_02 instance = null;

	public static RBA_99_01_01_02 getInstance() {
		if ( instance == null ) {
			instance = new RBA_99_01_01_02();
		}
		return instance;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/rba/doEDUSave.do", method=RequestMethod.POST)
	public String doSave(HttpServletRequest request, ModelMap model ,FileVO paramVO, @RequestParam Map inHash )	  {
		MDaoUtil mDao = null;
		DataObj output    = null;
		try {

			mDao = new MDaoUtil();
			HashMap hm = ParamUtil.getReqParamHashMap(request);
			SessionHelper helper = new SessionHelper(request.getSession());
			String logigId = helper.getLoginId();
			String DR_OP_JKW_NO2 = Util.nvl(helper.getLoginId());
			String DR_OP_JKW_NO = logigId; //등록조작자번호
			String CHG_OP_JKW_NO = logigId; //변경조작자번호
			String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
			String ISDIREC = ("".equals((request.getParameter("S_ISDIREC"))) || "N".equals((request.getParameter("S_ISDIREC"))) ? "N" : "Y");
			String ISMNG = ("".equals((request.getParameter("S_ISMNG"))) || "N".equals((request.getParameter("S_ISMNG"))) ? "N" : "Y");
			String ISDEDIC = ("".equals((request.getParameter("S_ISDEDIC"))) || "N".equals((request.getParameter("S_ISDEDIC"))) ? "N" : "Y");
			String ISAUDIT = ("".equals((request.getParameter("S_ISAUDIT"))) || "N".equals((request.getParameter("S_ISAUDIT"))) ? "N" : "Y");
			String ISSALES = ("".equals((request.getParameter("S_ISSALES"))) || "N".equals((request.getParameter("S_ISSALES"))) ? "N" : "Y");
			String ISNEWEMP = ("".equals((request.getParameter("S_ISNEWEMP"))) || "N".equals((request.getParameter("S_ISNEWEMP"))) ? "N" : "Y");
			String ISNOMAL = ("".equals((request.getParameter("S_ISNOMAL"))) || "N".equals((request.getParameter("S_ISNOMAL"))) ? "N" : "Y");
			String ISPERSONAL = ("".equals((request.getParameter("S_ISPERSONAL"))) || "N".equals((request.getParameter("S_ISPERSONAL"))) ? "N" : "Y");
			String DR_DPRT_CD = Util.nvl(request.getParameter("DR_DPRT_CD"));
			String EDU_STS_CD = Util.nvl(request.getParameter("EDU_STS_CD"));
			String CRE_OGN_CCD = Util.nvl(request.getParameter("CRE_OGN_CCD"));
			String EDU_STD_CNT = Util.nvl(request.getParameter("EDU_STD_CNT"));
			String EDU_ESTD_CNT = Util.nvl(request.getParameter("EDU_ESTD_CNT"));
			// 교육 대상(직접입력)
			String TCHR_CERT_CCD = Util.nvl(request.getParameter("TCHR_CERT_CCD"));

			System.out.println("hm ::::::::" + hm.toString());

//			DataObj EDU_ID = mDao.getData("RBA_99_01_01_02_EDU_ID_SEQ_nextval", hm);
			DataObj EDU_ID = mDao.getData("RBA_99_01_01_02_EDU_GYLJ_ID_SEQ_nextval", hm);
			DataSet ds = Common.setGridData(EDU_ID);

			if("".equals(CRE_OGN_CCD)) {
				CRE_OGN_CCD = "Y";
			}

			if("".equals(EDU_STS_CD)) {
				EDU_STS_CD = "S";
			}

			hm.put("EDU_ID", ds.getString(0, "EDU_ID_SEQ"));
			System.out.println("EDU_ID ::::::::" + hm.get("EDU_ID"));
			hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
			hm.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
			hm.put("DR_DPRT_CD", DR_DPRT_CD);
			hm.put("EDU_STS_CD", EDU_STS_CD);
			hm.put("CRE_OGN_CCD", CRE_OGN_CCD);
			hm.put("TCHR_CERT_CCD", TCHR_CERT_CCD);

			if ("Y".equals(ISDIREC)) {
				String EDU_TGT_CCD = "1003";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISMNG)){
				String EDU_TGT_CCD = "1004";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISDEDIC)){
				String EDU_TGT_CCD = "1001";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISAUDIT)){
				String EDU_TGT_CCD = "1002";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISSALES)){
				String EDU_TGT_CCD = "1005";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}
			if ("Y".equals(ISNEWEMP)){
				String EDU_TGT_CCD = "1006";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISNOMAL)){
				String EDU_TGT_CCD = "1007";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISPERSONAL)){
				String EDU_TGT_CCD = "1008";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			// 파일처리
			@SuppressWarnings("unused")
			int result = 0;

			//기존 파일목록 
			DataObj fdo = MDaoUtilSingle.getData("RBA_99_01_01_02_getRbaAttchInfo",hm);
			List<HashMap> fileList = fdo.getRowsToMap();
			
			// 파일 이동 및 처리
			if (null != paramVO.getFilePaths()) {
				for (int i = 0; i < paramVO.getFilePaths().length; i++) {
					if (paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1) {

						File tempDir = new File(paramVO.getFilePaths()[i]);
						File tempFile = new File(tempDir, paramVO.getStoredFileNms()[i]);
						if (tempFile.isFile()) {
							File realFile = FileUtil.renameTo(tempFile, Constants._UPLOAD_EDU_DIR);

							String[] filePath = paramVO.getFilePaths();
							filePath[i] = StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"), Constants._UPLOAD_EDU_DIR, "");

							paramVO.setFilePath(filePath[i]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						} else {
							String[] filePath = paramVO.getFilePaths();
							filePath[i] = StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR,
									Constants._UPLOAD_EDU_DIR);

							paramVO.setFilePath(filePath[0]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
					} else {
						String[] filePath = paramVO.getFilePaths();
						filePath[i] = StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR,
								Constants._UPLOAD_EDU_DIR);

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

						String filePath = Constants._UPLOAD_EDU_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}
				}					

				//db 파일 삭제
				hm.put("EDU_ID", EDU_ID);
				mDao.setData("RBA_99_01_01_02_doDeleteFile", hm);					

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
			hm.put("EDU_STD_CNT", EDU_STD_CNT);
			hm.put("EDU_ESTD_CNT", EDU_ESTD_CNT);
			mDao.setData("RBA_99_01_01_02_doSave", hm);
			mDao.commit();
			
			model.addAttribute("EDU_ID", hm.get("EDU_ID") );
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

	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/rba/doEDUUpdate.do", method=RequestMethod.POST)
	public String doUpdate(HttpServletRequest request, ModelMap model ,FileVO paramVO, @RequestParam Map inHash )	  {
		MDaoUtil mDao = null;
		DataObj output    = null;
		try {

			mDao = new MDaoUtil();
			HashMap hm = ParamUtil.getReqParamHashMap(request);
			SessionHelper helper = new SessionHelper(request.getSession());
			String logigId = helper.getLoginId();
			String DR_OP_JKW_NO2 = Util.nvl(helper.getLoginId());
			String DR_OP_JKW_NO = logigId; //등록조작자번호
			String CHG_OP_JKW_NO = logigId; //변경조작자번호
			String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
			String ISDIREC = ("".equals((request.getParameter("S_ISDIREC"))) || "N".equals((request.getParameter("S_ISDIREC"))) ? "N" : "Y");
			String ISMNG = ("".equals((request.getParameter("S_ISMNG"))) || "N".equals((request.getParameter("S_ISMNG"))) ? "N" : "Y");
			String ISDEDIC = ("".equals((request.getParameter("S_ISDEDIC"))) || "N".equals((request.getParameter("S_ISDEDIC"))) ? "N" : "Y");
			String ISAUDIT = ("".equals((request.getParameter("S_ISAUDIT"))) || "N".equals((request.getParameter("S_ISAUDIT"))) ? "N" : "Y");
			String ISSALES = ("".equals((request.getParameter("S_ISSALES"))) || "N".equals((request.getParameter("S_ISSALES"))) ? "N" : "Y");
			String ISNEWEMP = ("".equals((request.getParameter("S_ISNEWEMP"))) || "N".equals((request.getParameter("S_ISNEWEMP"))) ? "N" : "Y");
			String ISNOMAL = ("".equals((request.getParameter("S_ISNOMAL"))) || "N".equals((request.getParameter("S_ISNOMAL"))) ? "N" : "Y");
			String ISPERSONAL = ("".equals((request.getParameter("S_ISPERSONAL"))) || "N".equals((request.getParameter("S_ISPERSONAL"))) ? "N" : "Y");
			String DR_DPRT_CD = Util.nvl(request.getParameter("DR_DPRT_CD"));
			String EDU_STS_CD = Util.nvl(request.getParameter("EDU_STS_CD"));
			String CRE_OGN_CCD = Util.nvl(request.getParameter("CRE_OGN_CCD"));
			// 교육 대상(직접입력)
			String TCHR_CERT_CCD = Util.nvl(request.getParameter("TCHR_CERT_CCD"));

			System.out.println("hm ::::::::" + hm.toString());

//			DataObj EDU_ID = mDao.getData("RBA_99_01_01_02_EDU_ID_SEQ_nextval", hm);
			String EDU_ID = Util.nvl(request.getParameter("EDU_ID"));
//			DataSet ds = Common.setGridData(EDU_ID);

			if("".equals(CRE_OGN_CCD)) {
				CRE_OGN_CCD = "Y";
			}

			if("".equals(EDU_STS_CD)) {
				EDU_STS_CD = "S";
			}

//			hm.put("EDU_ID", ds.getString(0, "EDU_ID_SEQ"));
			hm.put("EDU_ID",EDU_ID);
			System.out.println("EDU_ID ::::::::" + hm.get("EDU_ID"));
			hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
			hm.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
			hm.put("DR_DPRT_CD", DR_DPRT_CD);
			hm.put("EDU_STS_CD", EDU_STS_CD);
			hm.put("CRE_OGN_CCD", CRE_OGN_CCD);
			hm.put("TCHR_CERT_CCD", TCHR_CERT_CCD);

			if ("Y".equals(ISDIREC)) {
				String EDU_TGT_CCD = "1003";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				
				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISMNG)){
				String EDU_TGT_CCD = "1004";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);

				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISDEDIC)){
				String EDU_TGT_CCD = "1001";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);

				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISAUDIT)){
				String EDU_TGT_CCD = "1002";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				
				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISSALES)){
				String EDU_TGT_CCD = "1005";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				
				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}
			if ("Y".equals(ISNEWEMP)){
				String EDU_TGT_CCD = "1006";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				
				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISNOMAL)){
				String EDU_TGT_CCD = "1007";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				
				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			if ("Y".equals(ISPERSONAL)){
				String EDU_TGT_CCD = "1008";
				hm.put("EDU_TGT_CCD", EDU_TGT_CCD);
				
				mDao.setData("RBA_99_01_01_02_doDelete_2", hm);
				mDao.commit();
				mDao.setData("RBA_99_01_01_02_doSave_2", hm);
			}

			// 교육 이수자 명세
//			mDao.setData("RBA_99_01_01_02_doUpdateEmp", hm);			

			
			@SuppressWarnings("unused")
			int result = 0;

			// 파일처리
			@SuppressWarnings("unused")
			int result2 = 0;

			//기존 파일목록 
			DataObj fdo = MDaoUtilSingle.getData("RBA_99_01_01_02_getEduAttchInfo",hm);
			List<HashMap> fileList = fdo.getRowsToMap();
			
			// 파일 이동 및 처리
			if (null != paramVO.getFilePaths()) {
				for (int i = 0; i < paramVO.getFilePaths().length; i++) {
					if (paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1) {

						File tempDir = new File(paramVO.getFilePaths()[i]);
						File tempFile = new File(tempDir, paramVO.getStoredFileNms()[i]);
						if (tempFile.isFile()) {
							File realFile = FileUtil.renameTo(tempFile, Constants._UPLOAD_EDU_DIR);

							String[] filePath = paramVO.getFilePaths();
							filePath[i] = StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"), Constants._UPLOAD_EDU_DIR, "");

							paramVO.setFilePath(filePath[i]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						} else {
							String[] filePath = paramVO.getFilePaths();
							filePath[i] = StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR,
									Constants._UPLOAD_EDU_DIR);

							paramVO.setFilePath(filePath[0]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
					} else {
						String[] filePath = paramVO.getFilePaths();
						filePath[i] = StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR,
								Constants._UPLOAD_EDU_DIR);

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

						String filePath = Constants._UPLOAD_EDU_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}
				}					

				//db 파일 삭제
				hm.put("EDU_ID", EDU_ID);
				hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				mDao.setData("RBA_99_01_01_02_doDeleteFile", hm);			
				
//				// 파일일괄 인서트
//				String vOrgFileNm = new String();
//
//				for (int i = 0; i < paramVO.getFilePaths().length; i++) {
//					DataObj obj11 = new DataObj();
//					// 첨부파일 stored XSS
//					vOrgFileNm = paramVO.getOrigFileNms()[i].replaceAll("<", "&lt;").replaceAll(">", "&gt;")
//							.replaceAll("\"", "&quot;").replaceAll("\"", "&#039;").replaceAll("\'", "&#x27;")
//							.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;").replaceAll("\\\\", "&#x2F;");
//
//					obj11.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
//					obj11.put("FILE_SER", "" + (i + 1));
//					obj11.put("DATA_G", "G");
//					obj11.put("FILE_POS", paramVO.getFilePath());
//					// obj11.put("USER_FILE_NM", paramVO.getOrigFileNms()[i]);
//					obj11.put("LOSC_FILE_NM", vOrgFileNm);
//					obj11.put("PHSC_FILE_NM", paramVO.getStoredFileNms()[i]);
//					obj11.put("FILE_SIZE", paramVO.getFileSizes()[i]);
//					obj11.put("DOWNLOAD_CNT", 0);
//					obj11.put("DR_OP_JKW_NO", DR_OP_JKW_NO2);
//
//					result2 = mDao.setData("comm.RBA_10_02_01_01_insertFile", obj11);
//					
//					
//					
//
//
//				}
				//파일일괄 인서트
				for(int i = 0; i < paramVO.getFilePaths().length; i++){
					DataObj obj11 = new DataObj();
					// 첨부파일 stored XSS
					String vOrgFileNm = new String();

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
					
					result = mDao.setData("RBA_10_02_01_01_insertFile", obj11);
				}
				
				
//				hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
//			}
			}else{

				for(int i=0; i < fileList.size(); i++){

					//기존 파일 삭제
					String filePath = Constants._UPLOAD_EDU_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
					FileUtil.deleteFile(filePath);
				}	

				//db 파일 삭제
				mDao.setData("RBA_99_01_01_02_doDeleteFile", hm);
			}

			hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			mDao.setData("RBA_99_01_01_02_doUpdate", hm);
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
	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doUpdateEmp(DataObj input) throws AMLException {

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

				inputMap.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("CON_YN", "0" ); // 변경조작자번호
				inputMap.put("EDU_ID", input.get("EDU_ID"));
			
				mDao.setData("RBA_99_01_01_02_doUpdateEmp_NEW", inputMap);	
			}
			
			//DB commit
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doDeleteEmp(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
//        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

//			gdReq = (List) input.get("gdReq");
//			int gdReq_size = gdReq.size();
			
//			for (int i = 0; i < gdReq_size; i++) {
//				HashMap inputMap = (HashMap) gdReq.get(i);
//				inputMap.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
//				inputMap.put("CON_YN", "0" ); // 변경조작자번호
//				inputMap.put("EDU_ID", input.get("EDU_ID"));
//				inputMap.put("JKW_NO", input.get("JKW_NO"));
//
//				mDao.setData("RBA_99_01_01_01_doEduDelete_TGT_JKW", inputMap);	
//			}
			
			HashMap inputMap = new HashMap();
			inputMap.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
			inputMap.put("CON_YN", "0" ); // 변경조작자번호
			inputMap.put("EDU_ID", input.get("EDU_ID"));
			inputMap.put("JKW_NO", input.get("JKW_NO"));
				
			mDao.setData("RBA_99_01_01_01_doEduDelete_TGT_JKW", inputMap);	
			
			//DB commit
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
	
}
