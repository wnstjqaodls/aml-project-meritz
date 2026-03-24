package com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_01;

import java.io.IOException;

import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 위험평가 재수행
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-19
 */
public class RBA_50_01_01_08 extends GetResultObject {

	private static RBA_50_01_01_08 instance = null;
	/**
	* getInstance
	* @return RBA_50_01_01_08
	*/
	public static  RBA_50_01_01_08 getInstance() {
		synchronized(RBA_50_01_01_08.class) {  
			if (instance == null) {
				instance = new RBA_50_01_01_08();
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
	public DataObj startBatch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output= new DataObj();
			String BAS_YYMM = input.get("BAS_YYMM").toString();
			String ING_STEP = input.get("ING_STEP").toString();
			String cmd = "/home/rba/Batch/rba/RBARISKB_MZ.sh "+BAS_YYMM+" "+ING_STEP;
			
			Log.logAML(Log.DEBUG, this, "######## 10100!!! [" + "" + "]");
			Log.logAML(Log.DEBUG, this, "######## 10200 BAS_YYMM!!! [" + BAS_YYMM + "]");
			Log.logAML(Log.DEBUG, this, "######## 10300 ING_STEP!!! [" + ING_STEP + "]");
			Log.logAML(Log.DEBUG, this, "######## 10400 cmd!!! [" + cmd + "]");
			
			Process proc = Runtime.getRuntime().exec(cmd);

			Thread.sleep(5000);
			proc.destroy();
			
			output.put("WINMSG",MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		  }  catch (IOException ioe) {       
		        Log.logAML(Log.ERROR,this,"getSearch(IOException)",ioe.toString()); 
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("ERRMSG", ioe.toString());
		      } catch (RuntimeException re) {
		        Log.logAML(Log.ERROR,this,"getSearch(RuntimeException)",re.toString());    
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("ERRMSG", re.toString());
		      } catch (InterruptedException re) {
		    	  Log.logAML(Log.ERROR,this,"getSearch(RuntimeException)",re.toString());    
		    	  output = new DataObj();
		    	  output.put("ERRCODE", "00001");
		    	  output.put("ERRMSG", re.toString());
		      }
		return output;
	}	
}