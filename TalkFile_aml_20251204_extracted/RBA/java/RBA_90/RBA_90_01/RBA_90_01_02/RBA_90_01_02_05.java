package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_02;

import java.io.IOException;
import java.util.List;

import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.express.server.dao.MCommonDAOSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DBUtil;

public class RBA_90_01_02_05  extends GetResultObject {

	  private static RBA_90_01_02_05 instance = null;

	  /**
	   * getInstance
	   * @return RBA_10_05_04_02
	   */
		public static  RBA_90_01_02_05 getInstance() {
			synchronized(RBA_90_01_02_05.class) {  
				if (instance == null) {
					instance = new RBA_90_01_02_05();
				}
			}
			return instance;
		}
	  
	  /**
	   * <pre>
	   * 
	   * </pre>
	   * @param input
	   * @return
	   */
	  public DataObj getSearchEvaluationCriteria(DataObj input) {
		    DataObj output = null;
		    try {
		      
		      String RPT_GJDT = Util.nvl(input.getText("RPT_GJDT") , "") ;
		      String JIPYO_IDX = Util.nvl(input.getText("JIPYO_IDX") , "");
		      String CNCT_JIPYO_C_I = Util.nvl(input.getText("CNCT_JIPYO_C_I") , "");
		    	
		      System.out.println("RPT_GJDT :: "+RPT_GJDT);
		      System.out.println("JIPYO_IDX :: "+JIPYO_IDX);
		      System.out.println("CNCT_JIPYO_C_I :: "+CNCT_JIPYO_C_I);
		      
		      List EvalDetails 	= DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_90_01_02_05_getSearchEvaluationCriteria", input));	//평가기준데이터
		      
		      input.put("GRP_CD", Util.nvl(input.getText("CNCT_JIPYO_C_I") , ""));
		      List EvalCmprV 	= DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_90_01_02_05_getSearchEvaluationCode", input));		//비교값
		      
		      input.put("GRP_CD", "A009");
		      List EvalCmprCalC = DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_90_01_02_05_getSearchEvaluationCode", input));		//산식코드(A009)

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
}
