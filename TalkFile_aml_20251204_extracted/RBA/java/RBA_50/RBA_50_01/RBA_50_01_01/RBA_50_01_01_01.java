package com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_01;

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
import org.springframework.web.util.HtmlUtils;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.AMLCommonLogAction;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 위험평가 일정관리
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-19
 */
@Controller
public class RBA_50_01_01_01 extends GetResultObject {

	private static RBA_50_01_01_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_01_01_01
	*/
	public static  RBA_50_01_01_01 getInstance() {
		synchronized(RBA_50_01_01_01.class) {
			if (instance == null) {
				instance = new RBA_50_01_01_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 위험평가 일정관리 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_01_01_01_getSearch", input);
			// grid data
			if (output.getCount("BAS_YYMM") > 0) {
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
	/**
	* <pre>
	* 위험평가 일정관리 첨부파일
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
	        output = MDaoUtilSingle.getData("RBA_50_01_01_01_getSearch2",(HashMap) input);
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
	* 위험평가 일정관리 첨부파일
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getEndCheck(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_50_01_01_01_getEndCheck",
	            (HashMap) input);

	        // grid data
	        if (output.getCount("BAS_YYMM") > 0) {
	          gdRes = Common.setGridData(output);
	        } else {
	          output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	          output.put("WINMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	        }

	        output.put("ERRCODE", "00000");
	        output.put("gdRes", gdRes);

	      } catch (AMLException e) {
	        Log.logAML(Log.ERROR, this, "getEndCheck(Exception)", e.getMessage());
	        output = new DataObj();
	        output.put("ERRCODE", "00001");
	        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	      }
	      return output;
	 }

	  public DataObj doSave(MultipartRequest req) {
	      DataObj output = new DataObj();
	      //DataObj output2 = new DataObj();
	      MDaoUtil mDao = null;

	      String filePath = PropertyService.getInstance().getProperty("aml.config","uploadPath.rba");
	      String fileFullPath = "";

	      try {
	        // Group Code List
	        mDao = new MDaoUtil();

	        @SuppressWarnings("unused")
	        int result = 0;

	        SessionHelper helper = new SessionHelper(req.getSession());

	        String RPT_GJDT = Util.replace(Util.nvl(req.getParameter("RPT_GJDT")), "-", "");
	       // String FIU_RPT_GJDT = Util.replace(Util.nvl(req.getParameter("FIU_RPT_GJDT")), "-", "");
	        String DR_OP_JKW_NO = Util.nvl(helper.getLoginId());
	        String ATTCH_FILE_NO = Util.nvl(req.getParameter("ATTCH_FILE_NO"));
	        String BAS_YYMM = Util.replace(Util.nvl(req.getParameter("BAS_YYMM")), "-", "");
	        StringBuffer strPath = new StringBuffer(128);

	        Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO :" + ATTCH_FILE_NO );

	        DataObj param = new DataObj();

	        if ("insert".equals(req.getParameter("mode"))) {
	          output = mDao.getData("comm.RBA_10_02_01_01_getRbaAttchFileSeq", param);
	          ATTCH_FILE_NO = output.getText("SEQ");
	          Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! :" + ATTCH_FILE_NO);
	        }

	        DataObj obj1 = new DataObj();

	        obj1.put("BAS_YYMM", BAS_YYMM);
	        obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	        obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);

	        Log.logAML(Log.DEBUG, this,"#### VALT_TRN [" + req.getParameter("VALT_TRN"));
	        Log.logAML(Log.DEBUG, this,"#### VALT_G   [" + req.getParameter("VALT_G") );
	        Log.logAML(Log.DEBUG, this,"#### VALT_JUNGJI_YN [" + req.getParameter("VALT_JUNGJI_YN"));
	        Log.logAML(Log.DEBUG, this,"#### VALT_SDT [" + req.getParameter("VALT_SDT") );
	        Log.logAML(Log.DEBUG, this,"#### VALT_EDT [" + req.getParameter("VALT_EDT") );

	        strPath.append(filePath);
	        strPath.append("/JIPYO/");
	        strPath.append(RPT_GJDT);
	        strPath.append('/');

	        fileFullPath = strPath.toString();
	        //fileFullPath = filePath + "/" + "JIPYO" + "/" + RPT_GJDT + "/";
	        fileFullPath = fileFullPath.replace("/",System.getProperty("file.separator"));

	        String[] FILE_SER = req.getParameterValues("FILE_SER");
	        String[] FILE_POS_temp = req.getParameterValues("FILE_POS_temp");
	        String[] LOSC_FILE_NM_temp = req.getParameterValues("LOSC_FILE_NM_temp");
	        String[] PHSC_FILE_NM_temp = req.getParameterValues("PHSC_FILE_NM_temp");
	        String[] FILE_SIZE_temp = req.getParameterValues("FILE_SIZE_temp");
	        String[] DOWNLOAD_CNT_temp = req.getParameterValues("DOWNLOAD_CNT_temp");
	        String[] NOTI_ATTACH = req.getParameterValues("NOTI_ATTACH");

	        Log.logAML(Log.DEBUG, this, "#### FILE_SER [" + FILE_SER );
	        Log.logAML(Log.DEBUG, this, "#### FILE_POS_temp [" + FILE_POS_temp );
	        Log.logAML(Log.DEBUG, this, "#### LOSC_FILE_NM_temp ["+ LOSC_FILE_NM_temp);
	        Log.logAML(Log.DEBUG, this, "#### PHSC_FILE_NM_temp ["+ PHSC_FILE_NM_temp);
	        Log.logAML(Log.DEBUG, this, "#### FILE_SIZE_temp [" + FILE_SIZE_temp);
	        Log.logAML(Log.DEBUG, this, "#### DOWNLOAD_CNT_temp ["+ DOWNLOAD_CNT_temp);
	        Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH [" + NOTI_ATTACH);
	        AttachFileDataSource[] attachFileDSs = req.getAttachFiles("NOTI_ATTACH");

	        int count_file = 0;
	        int count_file_real = 0;

	        Log.logAML(Log.DEBUG, this, "#### FILE_SER.length :" + FILE_SER.length);
	        for (int i = 0; i < FILE_SER.length; i++) {
	          Log.logAML(Log.DEBUG, this, "#### for~~~~~~~~~~~~: " + i );
	          Log.logAML(Log.DEBUG, this, "#### FILE_SER[i] :" + FILE_SER[i] );
	          Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH[i] :" + NOTI_ATTACH[i]);

	           if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	            count_file++;
	          } else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	            count_file++;
	          }
	        }

	        Log.logAML(Log.DEBUG, this, "#### count_file :" + count_file);

	        if (req.getAttach("NOTI_ATTACH") != null) {
	          Log.logAML(Log.DEBUG, this, "#### count_file_real_if :"+ count_file_real);
	          count_file_real = attachFileDSs.length;
	        }

	        Log.logAML(Log.DEBUG, this, "#### count_file_real :" + count_file_real);

	        if (count_file_real != count_file) {

	          mDao.rollback();
	          output.put("ERRCODE", "00999");
	          output.put(
	              "ERRMSG",
	              MessageHelper.getInstance().getMessage("0053",
	                  helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
	          output.put(
	              "WINMSG",
	              MessageHelper.getInstance().getMessage("0053",
	                  helper.getLangType(), "첨부된 파일정보를 확인하십시요."));

	          return output;
	        }

	        // ==================================================================

	        count_file = 0;
	        int FILE_SEQ_max = 0;
	        long fileLen = 0;
	        StringBuffer strFile = new StringBuffer(128);

	        // output = JDaoUtilSingle.getData( "AML_90_01_03_04_MAX_NIC90B_2",new
	        // Object[]{BOARD_ID,BOARD_SEQ} );
	        FILE_SEQ_max = 0;// output.getInt("FILE_SER");

	        for (int i = 0; i < FILE_SER.length; i++) {

	          if (!FILE_SER[i].equals("0") && NOTI_ATTACH[i].equals("")) {
	            Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 있고 첨부파일이 없을때(기존파일 고정)");
	            // 첨부정보 저장처리
	            FILE_SEQ_max++;



	            obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	            obj1.put("FILE_SER", FILE_SEQ_max);
	            obj1.put("DATA_G", "G");
	            obj1.put("FILE_POS", FILE_POS_temp[i]);
	            obj1.put("LOSC_FILE_NM", LOSC_FILE_NM_temp[i]);
	            obj1.put("PHSC_FILE_NM", PHSC_FILE_NM_temp[i]);
	            obj1.put("FILE_SIZE", FILE_SIZE_temp[i]);
	            obj1.put("DOWNLOAD_CNT", DOWNLOAD_CNT_temp[i]);
	            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	            System.out.println("=====================11111111111111111111111111111111111===============");
	            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);

	          } else if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	            FILE_SEQ_max++;
	            Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 있고 첨부파일이 있을때(기존파일을 변경");

	            obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	            obj1.put("FILE_SER", FILE_SEQ_max);
	            obj1.put("DATA_G", "G");
	            obj1.put("FILE_POS", FILE_POS_temp[i]);
	            obj1.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
	            obj1.put("PHSC_FILE_NM", PHSC_FILE_NM_temp[i]);
	            obj1.put("FILE_SIZE", FILE_SIZE_temp[i]);
	            obj1.put("DOWNLOAD_CNT", DOWNLOAD_CNT_temp[i]);
	            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	            System.out.println("=====================222222222222222222222222222222222===============");
	            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);
	            req.upload(attachFileDSs[count_file], fileFullPath,PHSC_FILE_NM_temp[i]);
	            count_file++;
	          } else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	            Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 없고 첨부파일이 있을때(신규파일 추가)");
	            FILE_SEQ_max++;

	            strFile.setLength(0);
		        strFile.append(ATTCH_FILE_NO);
		        strFile.append('_');
		        strFile.append((FILE_SEQ_max));
		        String PHSC_FILE_NM = strFile.toString();
	            //String PHSC_FILE_NM = ATTCH_FILE_NO + "_" + (FILE_SEQ_max);
	            req.upload(attachFileDSs[count_file], fileFullPath, PHSC_FILE_NM);
	            fileLen = attachFileDSs[count_file].getSize();
	            if (fileLen > 1) {
	              fileLen = fileLen - 2; // getSize시 원래사이즈보다 2가 큼
	            }

	            obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	            obj1.put("FILE_SER", FILE_SEQ_max);
	            obj1.put("DATA_G", "G");
	            obj1.put("FILE_POS", fileFullPath);
	            obj1.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
	            obj1.put("PHSC_FILE_NM", PHSC_FILE_NM);
	            obj1.put("FILE_SIZE", fileLen);
	            obj1.put("DOWNLOAD_CNT", 0);
	            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	            System.out.println("=====================33333333333333333333333333333333===============");
	            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);
	            count_file++;
	          } else {
	            Log.logAML(Log.DEBUG, this, "#### 넌뭔데");
	          }

	        }


	        String query_id = "RBA_50_01_01_01_UPDATE_SRBA_VALT_SCHD_M";
	        mDao.setData(query_id, obj1);

	        output.put("flag", req.getParameter("flag"));
	        output.put("afterFunction", req.getParameter("afterFunction"));
	        output.put("WINMSG",MessageHelper.getInstance().getMessage("0002",req.getParameter("LANG_CD"), "정상처리되었습니다."));
	        output.put("afterClose", req.getParameter("afterClose"));
	        output.put("PARAM_DATA", req);
	        output.put("ERRCODE", "00000");

	        mDao.commit();
	      }  catch (IOException ioe) {
	        Log.logAML(Log.ERROR,this,"doSave(IOException)",ioe.toString());
	        output = new DataObj();
	        output.put("flag", req.getParameter("flag"));
	        output.put("ERRCODE", "00001");
	        output.put("ERRMSG",
	            getClass().getName() + ".updateInfo \n\r" + ioe.toString());
	      } catch (AMLException e) {
	        Log.logAML(Log.ERROR, this, "doSave(Exception)", e.getMessage());
	        output = new DataObj();
	        output.put("flag", req.getParameter("flag"));
	        output.put("ERRCODE", "00001");
	        output.put("ERRMSG",
	            getClass().getName() + ".updateInfo \n\r" + e.toString());
	      } finally {
	        if (mDao != null) {
	          mDao.close();
	        }
	      }
	      return output;
	    }

	  @SuppressWarnings({ "rawtypes", "unchecked" })
	  @RequestMapping(value="/rba/doSave.do", method=RequestMethod.POST)
	  public String doSave(HttpServletRequest request, ModelMap model ,FileVO paramVO , @RequestParam Map inHash)throws Exception
	  {
			DataObj output = new DataObj();
			MDaoUtil mDao = new MDaoUtil();
			HashMap hm = ParamUtil.getReqParamHashMap(request);
			System.out.println("hm ::::::::"+hm.toString());
			try
			{
				mDao = new MDaoUtil();

		        @SuppressWarnings("unused")
		        int result = 0;

		        SessionHelper helper = new SessionHelper(request.getSession());

		        //기존 파일목록
				DataObj fdo = MDaoUtilSingle.getData("RBA_50_01_01_01_getSearch2",hm);
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
								filePath[i]				= StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"),Constants._UPLOAD_RBA_DIR,"");

								paramVO.setFilePath(filePath[i]);
								paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
							}
							else
							{
								String[]	filePath	= paramVO.getFilePaths();
								filePath[i]				= StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_RBA_DIR);

								paramVO.setFilePath(filePath[0]);
							}
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
							String filePath = fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
							FileUtil.deleteFile(filePath);
						}
					}


					//db 파일 삭제
					mDao.setData("RBA_30_04_03_1N_deleteFile", hm);

			        String DR_OP_JKW_NO = Util.nvl(helper.getLoginId());
			        String ATTCH_FILE_NO = Util.nvl(hm.get("ATTCH_FILE_NO"));

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
			            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);

			            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);

					}
					hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
					hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
					mDao.setData("RBA_50_01_01_01_UPDATE_SRBA_VALT_SCHD_M", hm);
					mDao.commit();
				}
				else
				{
					for(int i=0; i < fileList.size(); i++)
					{
						//기존 파일 삭제
						String filePath = fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}

					//db 파일 삭제
					mDao.setData("RBA_30_04_03_1N_deleteFile", hm);
					mDao.commit();
				}
				model.addAttribute("status", "success");
			    model.addAttribute("serviceMessage", "정상 처리되었습니다.");

			    /* AML Page Log 등록 처리 모듈  **********************************************/
            	AMLCommonLogAction amlCommonLogAction =  new AMLCommonLogAction();
            	inHash.put("classNm", "com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_01.RBA_50_01_01_01");
            	inHash.put("methodID", "doSave");
            	amlCommonLogAction.amlLogInsert(request, inHash);
                /* ***************************************************************************/

			}
			catch(IOException ioe)
			{
				Log.logAML(Log.ERROR,this,"doSave",ioe.toString());
				model.addAttribute("status", "fail");
				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			}
			catch(AMLException e)
			{
				Log.logAML(Log.ERROR,this,"doSave",e.toString());
				model.addAttribute("status", "fail");
				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			}
			catch(Exception e)
			{
				Log.logAML(Log.ERROR,this,"doSave",e.toString());
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			}

			return "jsonView";
	  }



	  @SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	  public DataObj doFileDelete(DataObj input) throws AMLException {

	      DataObj output = null;
	      DataObj output2 = null;
	      MDaoUtil db = null;

	      try {
	      	  List gdReq = (List) input.get("gdReq");
	            db = new MDaoUtil();

	            // 삭제 시작
	            db.begin();
	            int gdReq_size = gdReq.size();
	            for (int i = 0; i < gdReq_size; i++) {
	              HashMap inputMap = (HashMap) gdReq.get(i);

	            db.setData("RBA_50_01_01_01_doDeleteA", inputMap);
	           // db.setData("RBA_10_05_01_01_doDeleteB", inputMap);
	            output2 = db.getData("RBA_50_01_01_01_get_FILE_SER", inputMap);
	          }
	            String CHG_OP_JKW_NO = ((SessionHelper) input.get("SessionHelper")).getLoginId();

	        	int FILE_SEQ = output2.getInt("FILE_SER");
	        	if(FILE_SEQ < 2) {
	        		input.put("CHG_OP_JKW_NO",CHG_OP_JKW_NO); // 변경조작자번호
	        		input.put("ATTCH_FILE_NO",0);
	    	        db.setData("RBA_50_01_01_01_UPDATE_SRBA_VALT_SCHD_M", input);
	        	}

	          db.commit();

	          output = new DataObj();
	          output.put("ERRCODE", "00000");
	          output.put(
	              "ERRMSG",
	              MessageHelper.getInstance().getMessage("0002",
	                  input.getText("LANG_CD"), "정상처리되었습니다..."));
	          output.put(
	              "WINMSG",
	              MessageHelper.getInstance().getMessage("0002",
	                  input.getText("LANG_CD"), "정상처리되었습니다."));
	          output.put("gdRes", null); // Wise Grid Data

	      } catch (NumberFormatException e) {
	    	  if (db != null) {
	    		  db.rollback();
	    	  }
	    	  Log.logAML(Log.ERROR, this, "doDeleteD", e.getMessage());

	    	  output = new DataObj();
	    	  output.put("ERRCODE", "00001");
	    	  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	      } catch (AMLException e) {
	    	  if (db != null) {
	    		  db.rollback();
	    	  }
	        Log.logAML(Log.ERROR, this, "doDeleteD", e.getMessage());

	        output = new DataObj();
	        output.put("ERRCODE", "00001");
	        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	      } finally {
	    	  if (db != null) {
	    		  db.close();
	    	  }
	      }
	      return output;
	    }
	/**
	* <pre>
	* 위험평가 일정수정
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doModify(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		try {

		 	String [] array = HtmlUtils.htmlEscape(StringHelper.evl(input.get("arrRBA_VALT_SMDV_C"), "")).toString().split(",");

		 	mDao = new MDaoUtil();
		 	
		 	input.put("VALT_SDT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("VALT_SDT"), "")));
		 	input.put("VALT_EDT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("VALT_EDT"), "")));
		 	input.put("BAS_YYMM", HtmlUtils.htmlEscape(StringHelper.evl(input.get("BAS_YYMM"), "")));
		 	input.put("VALT_METH_CTNT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("VALT_METH_CTNT"), "")));
		 	input.put("TGT_TRN_SDT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("TGT_TRN_SDT"), "")));
		 	input.put("TGT_TRN_EDT", HtmlUtils.htmlEscape(StringHelper.evl(input.get("TGT_TRN_EDT"), "")));

		 	if( array.length == 1 ) {
		 		input.put("RBA_VALT_SMDV_C", array[0]);
		 		input.put("CHG_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

				mDao.begin();
				mDao.setData("RBA_50_01_01_01_setModify_one", input);
				//DB commit
				mDao.commit();

		 	} else {
		 		for (int i = 0; i< array.length; i++) {
			 		input.put("RBA_VALT_SMDV_C", array[i]);
			 		input.put("CHG_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

					mDao.begin();
					mDao.setData("RBA_50_01_01_01_setModify", input);
					//DB commit
					mDao.commit();
			 	}
		 	}



			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doModify", ex.getMessage());
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

	/**
	* <pre>
	* 위험평가 마감 및 취소처리
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doFinish(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			input.put("FIX_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			mDao.setData("RBA_50_01_01_01_setFinish_M", input); //SRBA_VALT_SCHD_D 실제종료일자를 현재날짜로 업데이트

			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doFinish", ex.getMessage());
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



	public DataObj doConfirm(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			mDao.setData("RBA_50_01_01_01_setConfirm_M", input); //SRBA_VALT_SCHD_D 실제종료일자를 현재날짜로 업데이트
			mDao.setData("RBA_50_01_01_01_setConfirm_D", input); //SRBA_VALT_SCHD_D 실제종료일자를 현재날짜로 업데이트

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
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
	/**
	* <pre>
	* 위험평가 일정복사
	* [1). RBA위험평가 일정 SRBA_VALT_SCHD_M]
	* [2). RBA위험평가 상세일정 SRBA_VALT_SCHD_D]
	* [3). RBA위험평가부점 SRBA_VALT_BRNO]
	* [4). RBA내부통제 배점 SRBA_TJ_ALLT_I]
	* [5). RBA_ML/TF위험평가지표_배점 SRBA_RSK_ALLT_I]
	* [6). RBA 잔여위험 임계치 관리 SRBA_REMDR_RSK_I]
	* [7). RBA_평가_ML/TF위험지표  SRBA_V_RSK_JIPYO_M]
	* [8). RBA_평가_내부통제 SRBA_V_TONGJE_M]
	* [9). RBA_평가_내부통제_부점 SRBA_V_TJ_BRNO]
	* [10). RBA_평가_프로세스_통제_매핑  SRBA_V_PROC_TJ_MP]
	* [11). RBA_평가_업무프로세스  SRBA_V_PROC_M]
	* [12). RBA_평가_업무프로세스_부점  SRBA_V_PROC_BRNO]
	*
	* COPY_YYMM: 추가될 년도
	* BAS_YYMM : 기준년도
	* </pre>
	* @param input
	* @return
	*/
	public DataObj docopy(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			//1) 이미 있는 기준년월이랑 겹치지 않는지 검사.
			DataObj output1 = new DataObj();
			output1 = mDao.getData("RBAS_common_getComboData_BasYear", input);
			int[] dupCheck = output1.findValueIndexArray("CODE", input.getText("COPY_YYMM"));

			input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

			//2) 기준년도 중복검사 후 중복이 없으면(dupCheck.length가 0) 데이타 복사를 시작한다. 아니면 기준년도 확인 alert을 발생시킨다.
			if(dupCheck.length == 0){
				//총 12개의 테이블에 복사를 해야 한다. [COPY_YYMM: 추가될 년도 BAS_YYMM: 기준년도]

				DataObj output2 = new DataObj();

				//RISK1=> 위험평가 일정
				if ("1".equals(input.getText("RISK1"))) {
					System.out.println("RBA위험평가 일정 복사시작");
					
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_VALT_SCHD_M", input); 	//1. SRBA_VALT_SCHD_M 	RBA위험평가 일정
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_VALT_SCHD_D", input);		//2. SRBA_VALT_SCHD_D 	RBA위험평가 상세일정
				}


				//RISK2=> 평가부점
				if ("1".equals(input.getText("RISK2"))) {
					System.out.println("조직정보 복사시작");
					mDao.setData("RBA_50_01_01_01_DELETE_SRBA_VALT_BRNO", input);
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_VALT_BRNO", input);		//5. SRBA_VALT_BRNO	RBA위험평가 부점
				}


				//RISK3=> 위험요소
				if ("1".equals(input.getText("RISK3"))) {
					System.out.println("위험요소 복사시작");
					mDao.setData("RBA_50_01_01_01_DELETE_SRBA_RISK_ELMT_M", input);
					mDao.setData("RBA_50_01_01_01_DELETE_SRBA_RISK_WEIGHT_M", input);
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_RISK_ELMT_M", input);
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_RISK_WEIGHT_M", input);
					/*
					 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_REMDR_RSK_I", input);
					 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_TONGJE_TP_I", input); // 설계평가,
					 * 운영평가, 위험 등 점수
					 */
				}

				//RISK4=> 평가요소 ,  부점 매핑정보
				if ("1".equals(input.getText("RISK4"))) {
					System.out.println("평가요소 및 매핑정보  복사시작");
					mDao.setData("RBA_50_01_01_01_DELETE_SRBA_CNTL_ELMN_M", input);
					mDao.setData("RBA_50_01_01_01_DELETE_SRBA_CNTL_ITEM_D", input);
					mDao.setData("RBA_50_01_01_01_DELETE_SRBA_CNTL_BRNO_I", input);
					
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_CNTL_ELMN_M", input);
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_CNTL_ITEM_D", input);
					mDao.setData("RBA_50_01_01_01_docopy_SRBA_CNTL_BRNO_I", input);

					/*
					 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_V_RSK_JIPYO_M", input);
					 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_V_TONGJE_M", input);
					 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_V_TJ_BRNO", input);
					 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_V_PROC_TJ_MP", input);
					 */
				}


				//RISK5=> 프로세스 정보
				/*
				 * if ("1".equals(input.getText("RISK5"))) {
				 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_V_PROC_M", input);
				 * mDao.setData("RBA_50_01_01_01_docopy_SRBA_V_PROC_BRNO", input); }
				 */


				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			}else{
				output.put("ERRCODE", "00001");
				output.put("ERRMSG", "이미 존재하는 년월입니다. 기준년월을 다시 설정해주세요. ");
				output.put("WINMSG", "이미 존재하는 년월입니다. 기준년월을 다시 설정해주세요. ");
			}
			//DB commit
			mDao.commit();

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "docopy", ex.getMessage());
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

	/**
	* <pre>
	* RBA 해당회차 삭제
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		//DataObj output2 = new DataObj();
		DataSet gdRes = null;
		MDaoUtil mDao = null;


		try {
		//output2 = MDaoUtilSingle.getData("RBA_50_01_01_01_getGylj", input);
//			if (Integer.parseInt(output2.getText("CNT")) <= 0) {
				mDao = new MDaoUtil();
				mDao.begin();

				mDao.setData("RBA_50_01_01_01_setDelete_SRBA_VALT_SCHD_M", input);
				mDao.setData("RBA_50_01_01_01_setDelete_SRBA_VALT_SCHD_D", input);
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_VALT_BRNO", input);
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_RISK_ELMT_M", input);
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_RISK_WEIGHT_M", input);
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_CNTL_ELMN_M", input);
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_CNTL_BRNO_I", input);
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_TJACT_IMPRV_I", input);  // 개선
				mDao.setData("RBA_50_01_01_01_DELETE_SRBA_APPR_M", input);   // 결재 master

				//DB commit
				mDao.commit();

				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("ERRCODE", "00000");
//			} else {
//				output.put("ERRMSG", "프로세스 결재가 진행되어 일정 삭제를 할 수 없습니다.");
//				output.put("WINMSG", "프로세스 결재가 진행되어 일정 삭제를 할 수 없습니다.");
//				output.put("ERRCODE", "00001");
//			}

			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
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


	/**
	* <pre>
	* 위험평가 종료처리
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doEnd(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		DataObj output3 = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

			mDao.setData("RBA_50_01_01_01_setEnd", input);
			int dIngStep = 0;
			String wIngStep = input.getText("ING_STEP");
			String REAL_EDT = input.getText("REAL_EDT");
			String flag ="0";
			output3 = MDaoUtilSingle.getData("RBA_50_01_01_01_getProcessCnt", input);
			for (int i=0; i< output3.getCount("VALT03"); i++) {
				if("20".equals(input.getText("ING_STEP")) || "21".equals(input.getText("ING_STEP"))){
					if (Integer.parseInt((String) output3.get("VALT03", i)) > 0) {
						flag = "1";
						break;
					}
				}else if ("30".equals(input.getText("ING_STEP")) || "31".equals(input.getText("ING_STEP"))) {
					if (Integer.parseInt((String) output3.get("VALT13", i)) > 0) {
						flag = "2";
						break;
					}
				}

			}

			if(("".equals(wIngStep)) == false) {
				//마감처리
				output2 = MDaoUtilSingle.getData("RBA_50_01_01_01_getIngStep_M", input);
				dIngStep = Integer.parseInt(output2.getText("ING_STEP"));

				   if("10".equals(input.getText("ING_STEP")) || "11".equals(input.getText("ING_STEP"))) {
						//종료일  업을시
						if("".equals(REAL_EDT)) {
							input.put("ING_STEP","0");
						}
						mDao.setData("RBA_50_01_01_01_setIngStep_M", input); //마감시 ING_STEP  변경
						//DB commit
						mDao.commit();

						output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
						output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
						output.put("ERRCODE", "00000");

					}else if("20".equals(input.getText("ING_STEP")) || "21".equals(input.getText("ING_STEP"))) {
						//종료일  업을시
						if("".equals(REAL_EDT)) {
							input.put("ING_STEP","11");
						}
						mDao.setData("RBA_50_01_01_01_setIngStep_M", input); //마감시 ING_STEP  변경
						//DB commit
						mDao.commit();

						output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("ERRCODE", "00000");
					}else if("30".equals(input.getText("ING_STEP")) || "31".equals(input.getText("ING_STEP"))) {
						//종료일  업을시
						if("".equals(REAL_EDT)) {
							input.put("ING_STEP","21");
						}
						mDao.setData("RBA_50_01_01_01_setIngStep_M", input); //마감시 ING_STEP  변경
						//DB commit
						mDao.commit();

						output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("ERRCODE", "00000");
					}else {
						//DB commit
						mDao.commit();
					}
			}else {
				//DB commit
				mDao.commit();

				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("ERRCODE", "00000");
			}

		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
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