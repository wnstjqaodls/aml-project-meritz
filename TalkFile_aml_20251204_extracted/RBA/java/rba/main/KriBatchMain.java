package com.gtone.rba.main;


import javax.annotation.Resource;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.gtone.rba.common.util.DateUtil;
import com.gtone.rba.controller.KriController;
import com.gtone.rba.domain.SchdVO;


/**
 * Kri 생성 배치 class
 * 매월 1일자로 배치 실행 
 * 해당 배치는 kri, rule 추출
 * @author jacky
 *
 */

@Component
public class KriBatchMain {
	
	private static final Logger logger = LoggerFactory.getLogger("KriController");	
	
	private String yyyyMm;
	
	
	@Resource(name = "KriController")
	private KriController controller;
	
	
	public static void main(String[] args) 
	{

		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");			
		KriBatchMain kriBatch = ctx.getBean(KriBatchMain.class);		
		
		try
		{
			SchdVO paramVO = new SchdVO();
			
			if(args.length == 0 )
			{
				//배치가 매월1일날 실행되므로 월은 전월기준으로 생성.
				kriBatch.yyyyMm = DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( DateUtil.getYear()+DateUtil.getMonth(), "yyyyMM"), -1) , "yyyyMM");
				paramVO.setbasLong("00");
			}
			if(args.length == 1 )
			{
				kriBatch.yyyyMm= args[0];
				paramVO.setbasLong("00");
			}
			else if(args.length > 1 )
			{
				kriBatch.yyyyMm= args[0];   // 
				
				//logger.info("INPUT0 ["+ args[0] +" : "+ args[1] +"] KRI 배치가 시작 되었습니다.");
				
				if( args[1].equals("1") ) {
					paramVO.setbasLong("01");   // 상반기
				} else if( args[1].equals("2")){
					paramVO.setbasLong("02");   // 하반기
				} else if( args[1].equals("91")){
					paramVO.setbasLong("91");   // 상반기 : 전사 데이타조회는 화면에서 구현
				} else if( args[1].equals("92") ){
					paramVO.setbasLong("92");   // 하반기 : 전사 데이타조회는 화면에서 구현
				} 
			}
			
			paramVO.setextrBasAmt(1000);
			
	
		    if( paramVO.getbasLong() == "00" ) {
		    	paramVO.setBasYymm(kriBatch.yyyyMm);
				paramVO.setTgtTrnSdt(kriBatch.yyyyMm+"01");	
				paramVO.setTgtTrnEdt(DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), 1) , "yyyyMMdd") );
				paramVO.setPgtTrnSdt(DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), -1) , "yyyyMMdd"));	
				paramVO.setPgtTrnEdt(paramVO.getTgtTrnSdt());
		    } else {
		    	String YYYY_T = kriBatch.yyyyMm.substring(0, 4); // YYYY
		    	String YYYY_P = "";
		    	
		    	//logger.info("INPUT1 ["+ paramVO.getbasLong() +" ~ "+ YYYY_T +"] KRI 배치가 시작 되었습니다.");
		    	
		    	paramVO.setBasYymm(YYYY_T);    //202506
		    	if( paramVO.getbasLong() == "01" || paramVO.getbasLong() == "91" ) {
		    		
					paramVO.setTgtTrnSdt(YYYY_T+"0101");	
					paramVO.setTgtTrnEdt(YYYY_T+"0630");	
					
					//logger.info("INPUT2 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					
					YYYY_P = DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), -12) , "yyyy");
					paramVO.setPgtTrnSdt(YYYY_P+"0701");	
					paramVO.setPgtTrnEdt(YYYY_P+"1231");
		    	} else if( paramVO.getbasLong() == "02" || paramVO.getbasLong() == "92" ){
		    		YYYY_P = YYYY_T;
		    		paramVO.setTgtTrnSdt(YYYY_T+"0701");	
					paramVO.setTgtTrnEdt(YYYY_T+"1231");	
					paramVO.setPgtTrnSdt(YYYY_P+"0101");	
					paramVO.setPgtTrnEdt(YYYY_P+"0630");
		    	}
		    	
		    }
		    
			
			
			logger.info("[START] 기준년월 ["+paramVO.getBasYymm()+"] [" +  paramVO.getbasLong()  + "] KRI 배치가 시작 되었습니다.");
			logger.info("대상기간 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
			logger.info("이전대상 ["+paramVO.getPgtTrnSdt()+" ~ "+paramVO.getPgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
			
			long startTime = System.currentTimeMillis();	
			
			kriBatch.excute(paramVO);
			
			long endTime = System.currentTimeMillis();	
			long resutTime = endTime - startTime;			
			
			
			logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
			logger.info("[END] 기준년월 ["+paramVO.getBasYymm()+"] KRI 배치가 완료 되었습니다.");		
			
			
			
			//test
			//kriBatch.yyyyMm = "202512";
			
			if(args.length == 0 )
			{
				//정규배치가 매월1일날 실행이후, 6월 , 12월 해당이 되면 6개월단위 배치수행을 합니다.
				String YYYY_T = kriBatch.yyyyMm.substring(0, 4); // YYYY
		    	String YYYY_P = "";
				logger.info("6 month check ["+ kriBatch.yyyyMm.toString().substring(4, 6) +" ~ "+ YYYY_T +"]");
				
				if( kriBatch.yyyyMm.toString().substring(4, 6).equalsIgnoreCase("06") ) {
					
			    	paramVO.setBasYymm(YYYY_T);    //202506
			    	
					paramVO.setTgtTrnSdt(YYYY_T+"0101");	
					paramVO.setTgtTrnEdt(YYYY_T+"0630");	
						
					YYYY_P = DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), -12) , "yyyy");
					paramVO.setPgtTrnSdt(YYYY_P+"0701");	
					paramVO.setPgtTrnEdt(YYYY_P+"1231");
					
					
					paramVO.setbasLong("01");
					logger.info("[START] 기준년월 ["+paramVO.getBasYymm()+"] [" +  paramVO.getbasLong()  + "] KRI 배치가 시작 되었습니다.");
					logger.info("대상기간 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					logger.info("이전대상 ["+paramVO.getPgtTrnSdt()+" ~ "+paramVO.getPgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					startTime = System.currentTimeMillis();	
					
					kriBatch.excute(paramVO);
					
					endTime = System.currentTimeMillis();	
					resutTime = endTime - startTime;	
					
					logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
					logger.info("[END] 기준년월 ["+paramVO.getBasYymm()+"] KRI 배치가 완료 되었습니다.");
					
					
					paramVO.setbasLong("91");
					logger.info("[START] 기준년월 ["+paramVO.getBasYymm()+"] [" +  paramVO.getbasLong()  + "] KRI 배치가 시작 되었습니다.");
					logger.info("대상기간 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					logger.info("이전대상 ["+paramVO.getPgtTrnSdt()+" ~ "+paramVO.getPgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					startTime = System.currentTimeMillis();	
					
					kriBatch.excute(paramVO);
					
					endTime = System.currentTimeMillis();	
					resutTime = endTime - startTime;	
					
					logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
					logger.info("[END] 기준년월 ["+paramVO.getBasYymm()+"] KRI 배치가 완료 되었습니다.");
					
				} else if( kriBatch.yyyyMm.toString().substring(4, 6).equalsIgnoreCase("12") ) {
					
                    YYYY_P = YYYY_T;
		    		paramVO.setTgtTrnSdt(YYYY_T+"0701");	
					paramVO.setTgtTrnEdt(YYYY_T+"1231");	
					paramVO.setPgtTrnSdt(YYYY_P+"0101");	
					paramVO.setPgtTrnEdt(YYYY_P+"0630");
					
					
					paramVO.setbasLong("02");
					logger.info("[START] 기준년월 ["+paramVO.getBasYymm()+"] [" +  paramVO.getbasLong()  + "] KRI 배치가 시작 되었습니다.");
					logger.info("대상기간 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					logger.info("이전대상 ["+paramVO.getPgtTrnSdt()+" ~ "+paramVO.getPgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					startTime = System.currentTimeMillis();	
					
					kriBatch.excute(paramVO);
					
					endTime = System.currentTimeMillis();	
					resutTime = endTime - startTime;	
					
					logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
					logger.info("[END] 기준년월 ["+paramVO.getBasYymm()+"] KRI 배치가 완료 되었습니다.");
					
					
					
					paramVO.setbasLong("92");
					logger.info("[START] 기준년월 ["+paramVO.getBasYymm()+"] [" +  paramVO.getbasLong()  + "] KRI 배치가 시작 되었습니다.");
					logger.info("대상기간 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					logger.info("이전대상 ["+paramVO.getPgtTrnSdt()+" ~ "+paramVO.getPgtTrnEdt()+"] KRI 배치가 시작 되었습니다.");
					startTime = System.currentTimeMillis();
					
					kriBatch.excute(paramVO);
					
					endTime = System.currentTimeMillis();	
					resutTime = endTime - startTime;	
					
					logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
					logger.info("[END] 기준년월 ["+paramVO.getBasYymm()+"] KRI 배치가 완료 되었습니다.");
					
					
					
				}
				
			}
			
		}catch(Exception e){
			logger.error("KRI 배치 오류 :: ",e);  
		}
			
		
	}
	

	private void excute(SchdVO paramVO)throws Exception
	{
		controller.excuteKri(paramVO);
	}

}
