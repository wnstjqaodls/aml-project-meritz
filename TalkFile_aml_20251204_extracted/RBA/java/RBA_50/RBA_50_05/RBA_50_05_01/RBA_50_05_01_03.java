package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01;

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
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * ML/TF 위험평가
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-08
 */
@Controller
public class RBA_50_05_01_03 extends GetResultObject {

	private static RBA_50_05_01_03 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_03
	*/
	public static  RBA_50_05_01_03 getInstance() {
		synchronized(RBA_50_05_01_03.class) {
		    if (instance == null) {
			    instance = new RBA_50_05_01_03();
		    }
		}
		return instance;
	}

	@RequestMapping(value="/rba/RBA_50_05_01_03doSave.do", method=RequestMethod.POST)
	 public String doSaveF (HttpServletRequest req, ModelMap model ,FileVO paramVO )throws AMLException {

		  DataObj output = new DataObj();
	      MDaoUtil mDao = null;
	      StringBuffer strErr = new StringBuffer(128);
	      String filePath = Constants._UPLOAD_RBA_DIR;
	      String fileFullPath = "";

	      try {
	        // Group Code List
	        mDao = new MDaoUtil();

	        @SuppressWarnings("unused")
	        int result = 0;

	        HashMap hm = ParamUtil.getReqParamHashMap(req);
	        SessionHelper helper = new SessionHelper(req.getSession());

	        String PROC_SMDV_C = Util.replace(Util.nvl(req.getParameter("PROC_SMDV_C")), "-", "");
	        String VALT_BRNO = Util.replace(Util.nvl(req.getParameter("VALT_BRNO")), "-", "");

	        String DR_OP_JKW_NO = Util.nvl(helper.getLoginId());
	        String ATTCH_FILE_NO = Util.nvl(req.getParameter("ATTCH_FILE_NO"));
	        String BAS_YYMM = Util.replace(Util.nvl(req.getParameter("BAS_YYMM")), "-", "");
	        String RSK_VALT_PNT = Util.nvl(req.getParameter("RSK_VALT_PNT"),"0");

	        Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO [" + ATTCH_FILE_NO);

	        DataObj param = new DataObj();

	        if ("insert".equals(req.getParameter("mode"))) {
	          output = mDao.getData("RBA_50_03_01_01_getRbaAttchFileNo", param);
	          ATTCH_FILE_NO = output.getText("SEQ");
	          Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! [" + ATTCH_FILE_NO);
	        }

	        DataObj obj1 = new DataObj();
	        StringBuffer strPath = new StringBuffer(128);

	        obj1.put("BAS_YYMM", BAS_YYMM);
	        obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	        obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	        obj1.put("VALT_BRNO", VALT_BRNO);
	        obj1.put("PROC_SMDV_C", PROC_SMDV_C);

	        strPath.append(filePath);
	        strPath.append(BAS_YYMM);
	        strPath.append('/');
	        strPath.append(VALT_BRNO);
	        strPath.append('/');

	        fileFullPath = strPath.toString();
	        fileFullPath = fileFullPath.replace("/", System.getProperty("file.separator"));

	        DataObj fdo = MDaoUtilSingle.getData("RBA_50_05_01_03_getSearch2",hm);
			List<HashMap> fileList = fdo.getRowsToMap();
			System.out.println("fileList ::::::::"+fileList.toString());
	        //추가1
	        // 파일 이동 및 처리
			if((null == paramVO.getFilePaths()) == false) {
				for(int i = 0; i < paramVO.getFilePaths().length; i++)
				{
					if(paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1)
					{
						File	tempDir		= new File(paramVO.getFilePaths()[i]);
						File	tempFile	= new File(tempDir, paramVO.getStoredFileNms()[i]);

						if(tempFile.isFile())
						{
							File	realFile	= FileUtil.renameTo(tempFile, filePath);

							String[]	filePath1	= paramVO.getFilePaths();
							filePath1[i]				= StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"),filePath,"");

							paramVO.setFilePath(filePath1[i]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
						else
						{
							String[]	filePath1	= paramVO.getFilePaths();
							filePath1[i]				= StringUtils.replace(filePath1[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, filePath);

							paramVO.setFilePath(filePath1[0]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
					}else {
						String[]	filePath1	= paramVO.getFilePaths();
						filePath1[i]				= StringUtils.replace(filePath1[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, filePath);

						paramVO.setFilePath(filePath1[0]);
						paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
					}
				}

				//기존파일 목록 비교 후 삭제처리	수정추가 2
				for(int i=0; i < fileList.size(); i++)
				{
					boolean btn = false;

					for(int k = 0; k < paramVO.getFilePaths().length; k++)
					{
						String r = paramVO.getStoredFileNms()[k];

						if(r.equals(fileList.get(i).get("PHSC_FILE_NM")))
						{
							btn = false;
							break;
						}
						else
						{
							btn = true;
						}
					}

					//넘어온 값과 기존파일목록에 존재하지 않으면 삭제
					if(btn)
					{
						String filePath1 = Constants._UPLOAD_AML_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath1);
					}
				}

				//db 파일 삭제
				mDao.setData("RBA_50_03_01_01_doFileDelete", hm);
				//파일일괄 인서트

				System.out.println("hm ::::::::"+hm.toString());
				for(int i = 0; i < paramVO.getFilePaths().length; i++)
				{
					DataObj obj11 = new DataObj();
					obj11.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
		            obj11.put("FILE_SER", (i + 1));
		            obj11.put("DATA_G", "G");
		            obj11.put("FILE_POS", paramVO.getFilePath());
		            obj11.put("LOSC_FILE_NM", paramVO.getOrigFileNms()[i]);
		            obj11.put("PHSC_FILE_NM", paramVO.getStoredFileNms()[i]);
		            obj11.put("FILE_SIZE", paramVO.getFileSizes()[i]);
		            obj11.put("DOWNLOAD_CNT", 0);
		            obj11.put("DR_OP_JKW_NO", DR_OP_JKW_NO);

		            result = mDao.setData("RBA_10_02_01_01_insertFile", obj11);
				}
		} else { //추가4

			for(int i=0; i < fileList.size(); i++)
			{
				//기존 파일 삭제
				String filePath1 = Constants._UPLOAD_AML_DIR+fileList.get(i).get("FILE_POS")+"/"+fileList.get(i).get("PHSC_FILE_NM");
				FileUtil.deleteFile(filePath1);
			}

			//db 파일 삭제
			mDao.setData("RBA_50_03_01_01_doFileDelete", hm);
		}

		//추가4
       String query_id ="";

   	   String PROC_FLD_C = Util.nvl(req.getParameter("PROC_FLD_C"));
   	   String PROC_LGDV_C = Util.nvl(req.getParameter("PROC_LGDV_C"));
   	   String PROC_MDDV_C = Util.nvl(req.getParameter("PROC_MDDV_C"));

       obj1.put("PROC_FLD_C", PROC_FLD_C);
   	   obj1.put("PROC_LGDV_C", PROC_LGDV_C);
   	   obj1.put("PROC_MDDV_C", PROC_MDDV_C);
   	   obj1.put("RSK_VALT_PNT", RSK_VALT_PNT);

       query_id ="RBA_50_05_01_03_doSave_merge";
       mDao.setData(query_id, obj1);

       output.put("flag", req.getParameter("flag"));
       output.put("afterFunction", req.getParameter("afterFunction"));
       output.put(
           "WINMSG",
           MessageHelper.getInstance().getMessage("0002",
               req.getParameter("LANG_CD"), "정상처리되었습니다."));
       output.put("afterClose", req.getParameter("afterClose"));
       output.put("PARAM_DATA", req);
       output.put("ERRCODE", "00000");

		mDao.commit();
		model.addAttribute("status", "success");
	    model.addAttribute("serviceMessage", "저장 처리되었습니다.");

	    }  catch (IOException ioe) {
	        Log.logAML(Log.ERROR,this,"updateInfo(IOException)",ioe.toString());
	        output = new DataObj();
	        output.put("flag", req.getParameter("flag"));
	        output.put("ERRCODE", "00001");
	        strErr.append(getClass().getName());
			strErr.append(".updateInfo \n\r");
			strErr.append(ioe.toString());
			output.put("ERRMSG",strErr.toString());
	      } catch (AMLException e) {
	        Log.logAML(Log.ERROR, this, "updateInfo(Exception)", e.getMessage());
	        output = new DataObj();
	        output.put("flag", req.getParameter("flag"));
	        output.put("ERRCODE", "00001");
	        strErr.append(getClass().getName());
			strErr.append(".updateInfo \n\r");
			strErr.append(e.toString());
			output.put("ERRMSG",strErr.toString());
	      } catch (Exception e) {
	    	  if(mDao != null) { mDao.rollback(); }
		} finally {
	        if (mDao != null) {
	          mDao.close();
	        }
	      }
	      return "jsonView";
	 }

	/**
	* <pre>
	* 수기평가 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSave(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = new DataObj();
		    SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();

		    input.put("DR_OP_JKW_NO", logigId);

		    //구분이 0: 등록  , 1: 수정
		    String GUBN = input.get("GUBN").toString();
		    String sqlId = ("0".equals(GUBN)) ? "RBA_50_05_01_03_doSave_insert" : "RBA_50_05_01_03_doSave_update";
		    input.put("ATTCH_FILE_NO", 0);

			MDaoUtilSingle.setData(sqlId, input);

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
	        output = MDaoUtilSingle.getData("RBA_50_05_01_03_getSearch2",
	            (HashMap) input);

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



	 @SuppressWarnings("unchecked")
	 public DataObj doSaveF(MultipartRequest req) {
	      DataObj output = new DataObj();
	      MDaoUtil mDao = null;
	      StringBuffer strErr = new StringBuffer(128);
	      String filePath = PropertyService.getInstance().getProperty("aml.config",
	          "uploadPath.rba");
	      String fileFullPath = "";

	      try {
	        // Group Code List
	        mDao = new MDaoUtil();

	        @SuppressWarnings("unused")
	        int result = 0;

	        SessionHelper helper = new SessionHelper(req.getSession());

	        String PROC_SMDV_C = Util.replace(Util.nvl(req.getParameter("PROC_SMDV_C")), "-", "");
	        String VALT_BRNO = Util.replace(
	            Util.nvl(req.getParameter("VALT_BRNO")), "-", "");


	        String DR_OP_JKW_NO = Util.nvl(helper.getLoginId());
	        String ATTCH_FILE_NO = Util.nvl(req.getParameter("ATTCH_FILE_NO"));
	        String BAS_YYMM = Util.replace(Util.nvl(req.getParameter("BAS_YYMM")), "-", "");
	        String RSK_VALT_PNT = Util.nvl(req.getParameter("RSK_VALT_PNT"),"0");

	        Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO [" + ATTCH_FILE_NO);

	        DataObj param = new DataObj();

	        if ("insert".equals(req.getParameter("mode"))) {
	          output = mDao.getData("RBA_50_03_01_01_getRbaAttchFileNo", param);
	          ATTCH_FILE_NO = output.getText("SEQ");
	          Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! [" + ATTCH_FILE_NO);
	        }

	        DataObj obj1 = new DataObj();
	        StringBuffer strPath = new StringBuffer(128);

	        obj1.put("BAS_YYMM", BAS_YYMM);
	        obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	        obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	        obj1.put("VALT_BRNO", VALT_BRNO);
	        obj1.put("PROC_SMDV_C", PROC_SMDV_C);


	        Log.logAML(Log.DEBUG, this,
	            "#### VALT_TRN [" + req.getParameter("VALT_TRN"));
	        Log.logAML(Log.DEBUG, this,
	            "#### VALT_G   [" + req.getParameter("VALT_G"));
	        Log.logAML(Log.DEBUG, this,
	            "#### VALT_JUNGJI_YN [" + req.getParameter("VALT_JUNGJI_YN"));
	        Log.logAML(Log.DEBUG, this,
	            "#### VALT_SDT [" + req.getParameter("VALT_SDT"));
	        Log.logAML(Log.DEBUG, this,
	            "#### VALT_EDT [" + req.getParameter("VALT_EDT"));

	        strPath.append(filePath);
	        strPath.append("/RBA/");
	        strPath.append(BAS_YYMM);
	        strPath.append('/');
	        strPath.append(VALT_BRNO);
	        strPath.append('/');

	        fileFullPath = strPath.toString();
	        //fileFullPath = filePath + "/" + "RBA" + "/" + BAS_YYMM + "/"+ VALT_BRNO + "/";
	        fileFullPath = fileFullPath.replace("/",
	            System.getProperty("file.separator"));

	        String[] FILE_SER = req.getParameterValues("FILE_SER");
	        String[] FILE_POS_temp = req.getParameterValues("FILE_POS_temp");
	        String[] LOSC_FILE_NM_temp = req.getParameterValues("LOSC_FILE_NM_temp");
	        String[] PHSC_FILE_NM_temp = req.getParameterValues("PHSC_FILE_NM_temp");
	        String[] FILE_SIZE_temp = req.getParameterValues("FILE_SIZE_temp");
	        String[] DOWNLOAD_CNT_temp = req.getParameterValues("DOWNLOAD_CNT_temp");
	        String[] NOTI_ATTACH = req.getParameterValues("NOTI_ATTACH");

	        Log.logAML(Log.DEBUG, this, "#### FILE_SER [" + FILE_SER);
	        Log.logAML(Log.DEBUG, this, "#### FILE_POS_temp [" + FILE_POS_temp);
	        Log.logAML(Log.DEBUG, this, "#### LOSC_FILE_NM_temp ["
	            + LOSC_FILE_NM_temp);
	        Log.logAML(Log.DEBUG, this, "#### PHSC_FILE_NM_temp ["
	            + PHSC_FILE_NM_temp);
	        Log.logAML(Log.DEBUG, this, "#### FILE_SIZE_temp [" + FILE_SIZE_temp);
	        Log.logAML(Log.DEBUG, this, "#### DOWNLOAD_CNT_temp ["
	            + DOWNLOAD_CNT_temp);
	        Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH [" + NOTI_ATTACH);
	        AttachFileDataSource[] attachFileDSs = req.getAttachFiles("NOTI_ATTACH");

	        int count_file = 0;
	        int count_file_real = 0;

	        Log.logAML(Log.DEBUG, this, "#### FILE_SER.length [" + FILE_SER.length);
	        for (int i = 0; i < FILE_SER.length; i++) {
	          Log.logAML(Log.DEBUG, this, "#### for~~~~~~~~~~~~[ " + i);
	          Log.logAML(Log.DEBUG, this, "#### FILE_SER[i] [" + FILE_SER[i] );
	          Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH[i] [" + NOTI_ATTACH[i]);

	           if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	            count_file++;
	          } else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	            count_file++;
	          }
	        }

	        Log.logAML(Log.DEBUG, this, "#### count_file [" + count_file);

	        if (req.getAttach("NOTI_ATTACH") != null) {
	          Log.logAML(Log.DEBUG, this, "#### count_file_real_if ["
	              + count_file_real);
	          count_file_real = attachFileDSs.length;
	        }

	        Log.logAML(Log.DEBUG, this, "#### count_file_real [" + count_file_real);

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

	            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);
	            req.upload(attachFileDSs[count_file], fileFullPath,
	                PHSC_FILE_NM_temp[i]);
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

	            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);
	            count_file++;
	          } else {
	            Log.logAML(Log.DEBUG, this, "#### 넌뭔데");
	          }

	        }

	        String query_id ="";

        	String PROC_FLD_C = Util.nvl(req.getParameter("PROC_FLD_C"));
        	String PROC_LGDV_C = Util.nvl(req.getParameter("PROC_LGDV_C"));
        	String PROC_MDDV_C = Util.nvl(req.getParameter("PROC_MDDV_C"));

        	obj1.put("PROC_FLD_C", PROC_FLD_C);
        	obj1.put("PROC_LGDV_C", PROC_LGDV_C);
        	obj1.put("PROC_MDDV_C", PROC_MDDV_C);
        	obj1.put("RSK_VALT_PNT", RSK_VALT_PNT);

	        query_id ="RBA_50_05_01_03_doSave_merge";
	        mDao.setData(query_id, obj1);

	        output.put("flag", req.getParameter("flag"));
	        output.put("afterFunction", req.getParameter("afterFunction"));
	        output.put(
	            "WINMSG",
	            MessageHelper.getInstance().getMessage("0002",
	                req.getParameter("LANG_CD"), "정상처리되었습니다."));
	        output.put("afterClose", req.getParameter("afterClose"));
	        output.put("PARAM_DATA", req);
	        output.put("ERRCODE", "00000");

	        mDao.commit();
	      }  catch (IOException ioe) {
	        Log.logAML(Log.ERROR,this,"updateInfo(IOException)",ioe.toString());
	        output = new DataObj();
	        output.put("flag", req.getParameter("flag"));
	        output.put("ERRCODE", "00001");
	        strErr.append(getClass().getName());
			strErr.append(".updateInfo \n\r");
			strErr.append(ioe.toString());
			output.put("ERRMSG",strErr.toString());
	        //output.put("ERRMSG",getClass().getName() + ".updateInfo \n\r" + ioe.toString());
	      } catch (AMLException e) {
	        Log.logAML(Log.ERROR, this, "updateInfo(Exception)", e.getMessage());
	        output = new DataObj();
	        output.put("flag", req.getParameter("flag"));
	        output.put("ERRCODE", "00001");
	        strErr.append(getClass().getName());
			strErr.append(".updateInfo \n\r");
			strErr.append(e.toString());
			output.put("ERRMSG",strErr.toString());
	        //output.put("ERRMSG",getClass().getName() + ".updateInfo \n\r" + e.toString());
	      } finally {
	        if (mDao != null) {
	          mDao.close();
	        }
	      }
	      return output;
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

	            db.setData("RBA_10_05_01_01_doDeleteA", inputMap);
	           // db.setData("RBA_10_05_01_01_doDeleteB", inputMap);
	          }

	        	output2 = db.getData("RBA_50_01_01_01_get_FILE_SER", input);
	        	int FILE_SEQ = output2.getInt("FILE_SER");
	        	if(FILE_SEQ < 2) {
	        		input.put("CHG_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
	        		input.put("ATTCH_FILE_NO",0);
	    	        db.setData("RBA_50_05_01_03_UPDATE_SRBA_V_HRSK_R", input);
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

	    }catch (NumberFormatException e) {
	    	  if (db != null) {
	    		  db.rollback();
	    	  }
	    	  Log.logAML(Log.ERROR, this, "doDeleteD", e.getMessage());

	    	  output = new DataObj();
	    	  output.put("ERRCODE", "00001");
	    	  output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    }catch (AMLException e) {
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


		@SuppressWarnings({ "rawtypes", "unchecked" })
		public DataObj doDelete(DataObj input) {
		      DataObj output = null;
		      DataSet gdRes = null;

		      try {
		    	 output = new DataObj();
		        // 구분 조회
		        MDaoUtilSingle.setData("RBA_50_05_01_03_doDelete",(HashMap) input);

		        output.put("ERRCODE", "00000");
		        output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doDelete(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		      return output;
		 }

}