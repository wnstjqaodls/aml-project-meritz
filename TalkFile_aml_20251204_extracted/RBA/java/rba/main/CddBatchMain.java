package com.gtone.rba.main;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.gtone.rba.domain.CddVO;
import com.gtone.rba.service.CddService;


@Component
public class CddBatchMain {

	private static final Logger logger = LoggerFactory.getLogger("CddBatchMain");	
		
	
	@Resource(name = "CddService")
	private CddService service;
	
	private String yyyymmdd         = ""; // 분기기준일자     20200930
	private String monCode          = ""; // 추출코드         ALL or CDD_03
	
	
	
	public static void main(String[] args) 
	{
		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");			
		CddBatchMain batch = ctx.getBean(CddBatchMain.class);		
				
		//수동실행시.
		if(args.length > 0)
		{
			batch.yyyymmdd          = args[0]; // 기준일자     20200930
			batch.monCode           = args[1]; // 추출코드     ALL or CDD_03
			
			batch.excute();	
		}
				
	}
	
	private void excute() 
	{
 
		try
		{
			long startTime = System.currentTimeMillis();
			
			CddVO paramVO = new CddVO();
			paramVO.setYyyymmdd(yyyymmdd);
			

				 
			if("ALL".equals(monCode))
			{
				logger.info("[ALL] 전체 배치를 시작하였습니다.");
				service.setCdd_ALL(paramVO);				
				logger.info("[ALL] 전체 배치를 종료하였습니다.");
			}
			
			if("O".equals(monCode))
			{
				logger.info("[Online] Online 배치를 시작하였습니다.");
				service.setCdd_Online(paramVO);				
				logger.info("[Online] Online 배치를 종료하였습니다.");
			}
			
			
	        
            if("CDD_101".equals(monCode))
            {
                    logger.info("CDD_101 배치를 시작하였습니다.");
                    service.setCdd_101(paramVO);                            
                    logger.info("CDD_101 배치를 종료하였습니다."); 
            }
            
            if("CDD_102".equals(monCode))
            {
                    logger.info("CDD_102 배치를 시작하였습니다.");
                    service.setCdd_102(paramVO);                            
                    logger.info("CDD_102 배치를 종료하였습니다.");
            }
            
            if("CDD_103".equals(monCode))
            {
                    logger.info("CDD_103 배치를 시작하였습니다.");
                    service.setCdd_103(paramVO);                            
                    logger.info("CDD_103 배치를 종료하였습니다.");
            }                       
            
            if("CDD_104".equals(monCode))
            {
                    logger.info("CDD_104 배치를 시작하였습니다.");
                    service.setCdd_104(paramVO);                            
                    logger.info("CDD_104 배치를 종료하였습니다.");
            }

            if("CDD_105".equals(monCode))
            {
                    logger.info("CDD_105 배치를 시작하였습니다.");
                    service.setCdd_105(paramVO);                            
                    logger.info("CDD_105 배치를 종료하였습니다.");
            }
            
            if("CDD_106".equals(monCode)) 
            {
                    logger.info("CDD_106 배치를 시작하였습니다.");
                    service.setCdd_106(paramVO);                            
                    logger.info("CDD_106 배치를 종료하였습니다.");
            }
            
            if("CDD_107".equals(monCode)) 
            {
                    logger.info("CDD_107 배치를 시작하였습니다.");
                    service.setCdd_107(paramVO);                            
                    logger.info("CDD_107 배치를 종료하였습니다.");
            }
            
            if("CDD_108".equals(monCode)) 
            {
                    logger.info("CDD_108 배치를 시작하였습니다.");
                    service.setCdd_108(paramVO);                            
                    logger.info("CDD_108 배치를 종료하였습니다.");
            }
            
            if("CDD_109".equals(monCode)) 
            {
                    logger.info("CDD_109 배치를 시작하였습니다.");
                    service.setCdd_109(paramVO);                            
                    logger.info("CDD_109 배치를 종료하였습니다.");
            }
             
            if("CDD_110".equals(monCode)) 
            {
                    logger.info("CDD_110 배치를 시작하였습니다.");
                    service.setCdd_110(paramVO);                            
                    logger.info("CDD_110 배치를 종료하였습니다.");
            }

            if("CDD_111".equals(monCode))
            {
                    logger.info("CDD_111 배치를 시작하였습니다.");
                    service.setCdd_111(paramVO);                            
                    logger.info("CDD_111 배치를 종료하였습니다."); 
            }
            
            if("CDD_112".equals(monCode))
            {
                    logger.info("CDD_112 배치를 시작하였습니다.");
                    service.setCdd_112(paramVO);                            
                    logger.info("CDD_112 배치를 종료하였습니다.");
            }
            
            if("CDD_113".equals(monCode))
            {
                    logger.info("CDD_113 배치를 시작하였습니다.");
                    service.setCdd_113(paramVO);                            
                    logger.info("CDD_113 배치를 종료하였습니다.");
            }                       
            
            if("CDD_114".equals(monCode))
            {
                    logger.info("CDD_114 배치를 시작하였습니다.");
                    service.setCdd_114(paramVO);                            
                    logger.info("CDD_114 배치를 종료하였습니다.");
            }

            if("CDD_115".equals(monCode))
            {
                    logger.info("CDD_115 배치를 시작하였습니다.");
                    service.setCdd_115(paramVO);                            
                    logger.info("CDD_115 배치를 종료하였습니다.");
            }
            
            if("CDD_116".equals(monCode)) 
            {
                    logger.info("CDD_116 배치를 시작하였습니다.");
                    service.setCdd_116(paramVO);                            
                    logger.info("CDD_116 배치를 종료하였습니다.");
            }
            
            if("CDD_117".equals(monCode)) 
            {
                    logger.info("CDD_117 배치를 시작하였습니다.");
                    service.setCdd_117(paramVO);                            
                    logger.info("CDD_117 배치를 종료하였습니다.");
            }
            
            if("CDD_118".equals(monCode)) 
            {
                    logger.info("CDD_118 배치를 시작하였습니다.");
                    service.setCdd_118(paramVO);                            
                    logger.info("CDD_118 배치를 종료하였습니다.");
            }
            
            if("CDD_119".equals(monCode)) 
            {
                    logger.info("CDD_119 배치를 시작하였습니다.");
                    service.setCdd_119(paramVO);                            
                    logger.info("CDD_119 배치를 종료하였습니다.");
            }
             
            if("CDD_120".equals(monCode)) 
            {
                    logger.info("CDD_120 배치를 시작하였습니다.");
                    service.setCdd_120(paramVO);                            
                    logger.info("CDD_120 배치를 종료하였습니다.");
            }

            if("CDD_121".equals(monCode))
            {
                    logger.info("CDD_121 배치를 시작하였습니다.");
                    service.setCdd_121(paramVO);                            
                    logger.info("CDD_121 배치를 종료하였습니다."); 
            }
            
            if("CDD_122".equals(monCode))
            {
                    logger.info("CDD_122 배치를 시작하였습니다.");
                    service.setCdd_122(paramVO);                            
                    logger.info("CDD_122 배치를 종료하였습니다.");
            }
            
            if("CDD_123".equals(monCode))
            {
                    logger.info("CDD_123 배치를 시작하였습니다.");
                    service.setCdd_123(paramVO);                            
                    logger.info("CDD_123 배치를 종료하였습니다.");
            }                       
            
            if("CDD_124".equals(monCode))
            {
                    logger.info("CDD_124 배치를 시작하였습니다.");
                    service.setCdd_124(paramVO);                            
                    logger.info("CDD_124 배치를 종료하였습니다.");
            }

            if("CDD_125".equals(monCode))
            {
                    logger.info("CDD_125 배치를 시작하였습니다.");
                    service.setCdd_125(paramVO);                            
                    logger.info("CDD_125 배치를 종료하였습니다.");
            }
            
            if("CDD_126".equals(monCode)) 
            {
                    logger.info("CDD_126 배치를 시작하였습니다.");
                    service.setCdd_126(paramVO);                            
                    logger.info("CDD_126 배치를 종료하였습니다.");
            }
            
            if("CDD_127".equals(monCode)) 
            {
                    logger.info("CDD_127 배치를 시작하였습니다.");
                    service.setCdd_127(paramVO);                            
                    logger.info("CDD_127 배치를 종료하였습니다.");
            }
            
            if("CDD_128".equals(monCode)) 
            {
                    logger.info("CDD_128 배치를 시작하였습니다.");
                    service.setCdd_128(paramVO);                            
                    logger.info("CDD_128 배치를 종료하였습니다.");
            }
            
            if("CDD_129".equals(monCode)) 
            {
                    logger.info("CDD_129 배치를 시작하였습니다.");
                    service.setCdd_129(paramVO);                            
                    logger.info("CDD_129 배치를 종료하였습니다.");
            }
             
            if("CDD_130".equals(monCode)) 
            {
                    logger.info("CDD_130 배치를 시작하였습니다.");
                    service.setCdd_130(paramVO);                            
                    logger.info("CDD_130 배치를 종료하였습니다.");
            }

            if("CDD_131".equals(monCode))
            {
                    logger.info("CDD_131 배치를 시작하였습니다.");
                    service.setCdd_131(paramVO);                            
                    logger.info("CDD_131 배치를 종료하였습니다."); 
            }
            
            if("CDD_132".equals(monCode))
            {
                    logger.info("CDD_132 배치를 시작하였습니다.");
                    service.setCdd_132(paramVO);                            
                    logger.info("CDD_132 배치를 종료하였습니다.");
            }
            
            if("CDD_133".equals(monCode))
            {
                    logger.info("CDD_133 배치를 시작하였습니다.");
                    service.setCdd_133(paramVO);                            
                    logger.info("CDD_133 배치를 종료하였습니다.");
            }                       
            
            if("CDD_134".equals(monCode))
            {
                    logger.info("CDD_134 배치를 시작하였습니다.");
                    service.setCdd_134(paramVO);                            
                    logger.info("CDD_134 배치를 종료하였습니다.");
            }

            if("CDD_135".equals(monCode))
            {
                    logger.info("CDD_135 배치를 시작하였습니다.");
                    service.setCdd_135(paramVO);                            
                    logger.info("CDD_135 배치를 종료하였습니다.");
            }                  
            if ("CDD_136".equals(this.monCode))
            {
            		logger.info("CDD_136 배치를 시작하였습니다.");
            		this.service.setCdd_136(paramVO);
            		logger.info("CDD_136 배치를 종료하였습니다.");
            }
            if ("CDD_137".equals(this.monCode))
            {
            		logger.info("CDD_137 배치를 시작하였습니다.");
            		this.service.setCdd_137(paramVO);
            		logger.info("CDD_137 배치를 종료하였습니다.");
            }
            if ("CDD_138".equals(this.monCode))
            {
            		logger.info("CDD_138 배치를 시작하였습니다.");
            		this.service.setCdd_138(paramVO);
            		logger.info("CDD_138 배치를 종료하였습니다.");
            }
            if ("CDD_140".equals(this.monCode))
            {
            		logger.info("CDD_140 배치를 시작하였습니다.");
            		this.service.setCdd_138(paramVO);
            		logger.info("CDD_140 배치를 종료하였습니다.");
            }
            if("CDD_190".equals(monCode))
            {
                    logger.info("CDD_190 배치를 시작하였습니다.");
                    service.setCdd_190(paramVO);                            
                    logger.info("CDD_190 배치를 종료하였습니다.");
            }                  
      						 
			
			
			if("CDD_201".equals(monCode))
			{
				logger.info("CDD_201 배치를 시작하였습니다.");
				service.setCdd_201(paramVO);				
				logger.info("CDD_201 배치를 종료하였습니다."); 
			}
			
			if("CDD_202".equals(monCode))
			{
				logger.info("CDD_202 배치를 시작하였습니다.");
				service.setCdd_202(paramVO);				
				logger.info("CDD_202 배치를 종료하였습니다.");
			}
			
			if("CDD_203".equals(monCode))
			{
				logger.info("CDD_203 배치를 시작하였습니다.");
				service.setCdd_203(paramVO);				
				logger.info("CDD_203 배치를 종료하였습니다.");
			}			
			
			if("CDD_204".equals(monCode))
			{
				logger.info("CDD_204 배치를 시작하였습니다.");
				service.setCdd_204(paramVO);				
				logger.info("CDD_204 배치를 종료하였습니다.");
			}
			
			if("CDD_206".equals(monCode)) 
			{
				logger.info("CDD_206 배치를 시작하였습니다.");
				service.setCdd_206(paramVO);				
				logger.info("CDD_206 배치를 종료하였습니다.");
			}
			
			if("CDD_207".equals(monCode)) 
			{
				logger.info("CDD_207 배치를 시작하였습니다.");
				service.setCdd_207(paramVO);				
				logger.info("CDD_207 배치를 종료하였습니다.");
			}
			
			if("CDD_208".equals(monCode)) 
			{
				logger.info("CDD_208 배치를 시작하였습니다.");
				service.setCdd_208(paramVO);				
				logger.info("CDD_208 배치를 종료하였습니다.");
			}
			
			if("CDD_209".equals(monCode)) 
			{
				logger.info("CDD_209 배치를 시작하였습니다.");
				service.setCdd_209(paramVO);				
				logger.info("CDD_209 배치를 종료하였습니다.");
			}
			 
			if("CDD_210".equals(monCode)) 
			{
				logger.info("CDD_210 배치를 시작하였습니다.");
				service.setCdd_210(paramVO);				
				logger.info("CDD_210 배치를 종료하였습니다.");
			}
			
			if("CDD_211".equals(monCode)) 
			{
				logger.info("CDD_211 배치를 시작하였습니다.");
				service.setCdd_211(paramVO);				
				logger.info("CDD_211 배치를 종료하였습니다.");
			}
			
			if("CDD_212".equals(monCode)) 
			{
				logger.info("CDD_212 배치를 시작하였습니다.");
				service.setCdd_212(paramVO);				
				logger.info("CDD_212 배치를 종료하였습니다.");
			}
			
			if("CDD_213".equals(monCode)) 
			{
				logger.info("CDD_213 배치를 시작하였습니다.");
				service.setCdd_213(paramVO);				
				logger.info("CDD_213 배치를 종료하였습니다.");
			}
/*	20241024 CDD_214 시나리오 삭제	    
			if ("CDD_214".equals(this.monCode))
		    {
		        logger.info("CDD_214 배치를 시작하였습니다.");
		        this.service.setCdd_214(paramVO);
		        logger.info("CDD_214 배치를 종료하였습니다.");
		    }
*/		    
			if ("CDD_215".equals(this.monCode))
		    {
		        logger.info("CDD_215 배치를 시작하였습니다.");
		        this.service.setCdd_215(paramVO);
		        logger.info("CDD_215 배치를 종료하였습니다.");
		    }
			
			if ("CDD_216".equals(this.monCode))
		    {
		        logger.info("CDD_216 배치를 시작하였습니다.");
		        this.service.setCdd_215(paramVO);
		        logger.info("CDD_216 배치를 종료하였습니다.");
		    }
		      
			long endTime = System.currentTimeMillis();	
			long resutTime = endTime - startTime;	
			logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
		}catch(Exception e){
			e.printStackTrace();
			logger.error("[ERROR] ::: ",e);
		}
	}
}
