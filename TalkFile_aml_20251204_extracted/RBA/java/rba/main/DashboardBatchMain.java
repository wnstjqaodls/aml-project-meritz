package com.gtone.rba.main;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.gtone.rba.domain.DashboardVO;
import com.gtone.rba.service.DashboardService;

/*삼성증권 KRBA_BATCH > DashboardBatchMain.java */
@Component
public class DashboardBatchMain {

	private static final Logger logger = LoggerFactory.getLogger("DashboardBatchMain");	
		
	
	@Resource(name = "DashboardService")
	private DashboardService service;
	
	private String yyyymm="";
	private String tbname="";
	
	public static void main(String[] args) 
	{
		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");			
		DashboardBatchMain batch = ctx.getBean(DashboardBatchMain.class);		
				
		//수동실행시.
		if(args.length > 0)
		{
			batch.yyyymm = args[0]; //날짜(년월)		
			batch.tbname = args[1];	//업무구분 (DAILY, CTR, STR, ...)
			
			batch.excute();	
		}
				
	}
	
	private void excute() 
	{

		try
		{
			long startTime = System.currentTimeMillis();
			
			DashboardVO paramVO = new DashboardVO();
			paramVO.setYyyymm(yyyymm);
				
			if("DAILY".equals(tbname))
			{
				logger.info("전체 Dashboard 배치를 시작하였습니다.");
				service.setDashboardDAILY(paramVO);				
				logger.info("전체 Dashboard 배치를 종료하였습니다.");
			}
			else {
				if("KYC".equals(tbname)) {
					logger.info("KYC Dashboard 배치를 시작하였습니다.");
					service.setDashboardKYC(paramVO);				
					logger.info("KYC Dashboard 배치를 종료하였습니다.");
				}
				
				if("CDD".equals(tbname)) {
					logger.info("CDD Dashboard 배치를 시작하였습니다.");
					service.setDashboardCDD(paramVO);				
					logger.info("CDD Dashboard 배치를 종료하였습니다.");
				}
				
				if("CDD_R".equals(tbname)) {
					logger.info("CDD_R Dashboard 배치를 시작하였습니다.");
					service.setDashboardCDD_R(paramVO);				
					logger.info("CDD_R Dashboard 배치를 종료하였습니다.");
				}	
				
				if("CTR".equals(tbname))
				{
					logger.info("CTR Dashboard 배치를 시작하였습니다.");
					service.setDashboardCTR(paramVO);				
					logger.info("CTR Dashboard 배치를 종료하였습니다.");
				}
			
				if("STR".equals(tbname))
				{
					logger.info("STR Dashboard 배치를 시작하였습니다.");
					service.setDashboardSTR(paramVO);				
					logger.info("STR Dashboard 배치를 종료하였습니다.");
				}
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
