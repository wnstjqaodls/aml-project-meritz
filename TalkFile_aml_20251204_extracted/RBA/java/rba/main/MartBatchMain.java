package com.gtone.rba.main;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.gtone.rba.domain.MartVO;
import com.gtone.rba.service.MartService;


@Component
public class MartBatchMain {

	private static final Logger logger = LoggerFactory.getLogger("MartBatchMain");	
		
	
	@Resource(name = "MartService")
	private MartService service;
	
	private String yyyymmdd="";
	private String tbname="";
	
	public static void main(String[] args) 
	{
		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");			
		MartBatchMain batch = ctx.getBean(MartBatchMain.class);		
				
		//수동실행시.
		if(args.length > 0)
		{
			batch.yyyymmdd = args[0]; //날짜		
			batch.tbname = args[1];	//테이블명
			
			batch.excute();	
		}
				
	}
	
	private void excute() 
	{

		try
		{
			long startTime = System.currentTimeMillis();
			
			MartVO paramVO = new MartVO();
			paramVO.setYyyymmdd(yyyymmdd);


				
			if("DAILY".equals(tbname))
			{
				logger.info("[DAILY] 전체 일일 배치를 시작하였습니다.");
				service.setNICDAILY(paramVO);				
				logger.info("[DAILY] 전체 일일 배치를 종료하였습니다.");
			}
			
			

 
			if("NIC01B".equals(tbname))
			{
				logger.info("NIC01B 배치를 시작하였습니다.");
				service.setNIC01B(paramVO);				
				logger.info("NIC01B 배치를 종료하였습니다.");
			}
			if("NIC02B".equals(tbname))
			{
				logger.info("NIC02B 배치를 시작하였습니다.");
				service.setNIC02B(paramVO);
				logger.info("NIC02B 배치를 종료하였습니다.");
			}
			if("NIC03B".equals(tbname))
			{
				logger.info("NIC03B 배치를 시작하였습니다.");
				service.setNIC03B(paramVO);				
				logger.info("NIC03B 배치를 종료하였습니다.");
			}
			if("NIC04B".equals(tbname))
			{
				logger.info("NIC04B 배치를 시작하였습니다.");
				service.setNIC04B(paramVO);				
				logger.info("NIC04B 배치를 종료하였습니다.");
			}
			if("NIC05B".equals(tbname))
			{
				logger.info("NIC05B 배치를 시작하였습니다.");
				service.setNIC05B(paramVO);				
				logger.info("NIC05B 배치를 종료하였습니다.");
			}
			if("NIC17B".equals(tbname))
			{
				logger.info("NIC17B 배치를 시작하였습니다.");
				service.setNIC17B(paramVO);
				logger.info("NIC17B 배치를 종료하였습니다.");
			}
			if("NIC18B".equals(tbname))
			{
				logger.info("NIC18B 배치를 시작하였습니다.");
				service.setNIC18B(paramVO);
				logger.info("NIC18B 배치를 종료하였습니다.");
			}
			if("NIC27B".equals(tbname))
			{
				logger.info("NIC27B 배치를 시작하였습니다.");
				service.setNIC27B(paramVO);
				logger.info("NIC27B 배치를 종료하였습니다.");
			}
			if("NIC35B".equals(tbname))
			{
				logger.info("NIC35B 배치를 시작하였습니다.");
				service.setNIC35B(paramVO);
				logger.info("NIC35B 배치를 종료하였습니다.");
			}
			if("NIC40B".equals(tbname))
			{
				logger.info("NIC40B 배치를 시작하였습니다.");
				service.setNIC40B(paramVO);
				logger.info("NIC40B 배치를 종료하였습니다.");
			}
			if("NIC41B".equals(tbname))
			{
				logger.info("NIC41B 배치를 시작하였습니다.");
				service.setNIC41B(paramVO);
				logger.info("NIC41B 배치를 종료하였습니다.");
			}
			if("NIC45B".equals(tbname))
			{
				logger.info("NIC45B 배치를 시작하였습니다.");
				service.setNIC45B(paramVO);
				logger.info("NIC45B 배치를 종료하였습니다.");
			}
			if("NIC61B".equals(tbname))
			{
				logger.info("NIC61B 배치를 시작하였습니다.");
				service.setNIC61B(paramVO);
				logger.info("NIC61B 배치를 종료하였습니다.");
			}
			if("NIC32B".equals(tbname))
			{
				logger.info("NIC32B 배치를 시작하였습니다.");
				service.setNIC32B(paramVO);
				logger.info("NIC32B 배치를 종료하였습니다.");
			}
			if("NIC61B_CTR".equals(tbname))
			{
				logger.info("NIC61B_CTR 배치를 시작하였습니다.");
				service.setNIC61B_CTR(paramVO);
				logger.info("NIC61B_CTR 배치를 종료하였습니다.");
			}
			if("NIC62B".equals(tbname))
			{
				logger.info("NIC62B 배치를 시작하였습니다.");
				service.setNIC62B(paramVO);
				logger.info("NIC62B 배치를 종료하였습니다.");
			}
			if("NIC63B".equals(tbname))
			{
				logger.info("NIC63B 배치를 시작하였습니다.");
				service.setNIC63B(paramVO);
				logger.info("NIC63B 배치를 종료하였습니다.");
			}
			if("C_USER".equals(tbname))
			{
				logger.info("C_USER 배치를 시작하였습니다.");
				service.setC_USER(paramVO);
				logger.info("C_USER 배치를 종료하였습니다.");
			}
			if("C_USER_DETAIL".equals(tbname))
			{
				logger.info("C_USER_DETAIL 배치를 시작하였습니다.");
				service.setC_USER_DETAIL(paramVO);
				logger.info("C_USER_DETAIL 배치를 종료하였습니다.");
			}
			if("C_USER_GROUP_ROLE".equals(tbname))
			{
				logger.info("C_USER_GROUP_ROLE 배치를 시작하였습니다.");
				service.setC_USER_GROUP_ROLE(paramVO);
				logger.info("C_USER_GROUP_ROLE 배치를 종료하였습니다.");
			}
			if("C_DEP_INFO".equals(tbname))
			{
				logger.info("C_DEP_INFO 배치를 시작하였습니다.");
				service.setC_DEP_INFO(paramVO);
				logger.info("C_DEP_INFO 배치를 종료하였습니다.");
			}
			if("NIC92B_M008".equals(tbname))
			{
				logger.info("NIC92B_M008 배치를 시작하였습니다.");
				service.setNIC92B_M008(paramVO);
				logger.info("NIC92B_M008 배치를 종료하였습니다.");
			}
			if("NIC95B_M044".equals(tbname))
			{
				logger.info("NIC95B_M044 배치를 시작하였습니다.");
				service.NIC95B_M044(paramVO);
				logger.info("NIC95B_M044 배치를 종료하였습니다.");
			}			
			if("NIC81B_1".equals(tbname))
			{
				logger.info("NIC81B_1 배치를 시작하였습니다.");
				service.NIC81B_1(paramVO);
				logger.info("NIC81B_1 배치를 종료하였습니다.");
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
