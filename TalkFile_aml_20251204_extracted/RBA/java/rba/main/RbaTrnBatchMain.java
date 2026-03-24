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
import com.gtone.rba.controller.RbaTrnController;
import com.gtone.rba.domain.SchdVO;


/**
 * RBA 거래원장 생성 배치 class
 * 매월 1일자로 배치 실행
 * 해당 배치는 rba 거래 및 kri 추출시 사용.
 * @author jacky
 *
 */

@Component
public class RbaTrnBatchMain {

	private static final Logger logger = LoggerFactory.getLogger("RbaTrnBatchMain");

	private String yyyyMm;

	@Resource(name = "RbaTrnController")
	private RbaTrnController controller;


	public static void main(String[] args)
	{

		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");
		RbaTrnBatchMain trnBatch = ctx.getBean(RbaTrnBatchMain.class);

		try
		{
			long startTime = System.currentTimeMillis();

			if(args.length > 0)
			{
				trnBatch.yyyyMm= args[0];
				//trnBatch.dlDt= args[0];
			}
			else
			{
				//배치가 매월1일날 실행되므로 월은 전월기준으로 생성.
				trnBatch.yyyyMm = DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( DateUtil.getYear()+DateUtil.getMonth(), "yyyyMM"), -1) , "yyyyMM");
				//일배치로 dlDt 적재
				//trnBatch.dlDt = DateFormatUtils.format(DateUtils.addDays(DateUtil.check( DateUtil.getCurrentDate(""), "yyyyMMdd"), -1) , "yyyyMMdd");
				//System.out.println("1111111111111 :::::::::::: "+trnBatch.dlDt);
			}

			SchdVO paramVO = new SchdVO();
			paramVO.setBasYyyy(trnBatch.yyyyMm.substring(0,4));
			paramVO.setBasYymm(trnBatch.yyyyMm);
			paramVO.setTgtTrnSdt(trnBatch.yyyyMm+"01");
			paramVO.setTgtTrnEdt(DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), 1) , "yyyyMMdd") );
			//paramVO.setBasYymm(trnBatch.dlDt.substring(0,6));
			//paramVO.setTgtTrnSdt(trnBatch.dlDt);
			//paramVO.setTgtTrnEdt(DateFormatUtils.format(DateUtils.addDays(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), 1) , "yyyyMMdd") );
			//paramVO.setTgtTrnEdt(DateFormatUtils.format(DateUtils.addMonths(DateUtil.check( paramVO.getTgtTrnSdt(), "yyyyMMdd"), 1) , "yyyyMMdd") );

			logger.info("[START] 기준년월 ["+paramVO.getBasYymm()+"] 거래원장 배치가 시작 되었습니다.");
			logger.info("대상기간 ["+paramVO.getTgtTrnSdt()+" ~ "+paramVO.getTgtTrnEdt()+"] 거래원장 배치가 시작 되었습니다.");



			trnBatch.excute(paramVO);

			long endTime = System.currentTimeMillis();
			long resutTime = endTime - startTime;

			int seconds = (int) (resutTime / 1000) %60;
			int minutes = (int) (resutTime / (1000*60)) %60;
			int hours = (int) (resutTime / (1000*60*60)) %60;

			logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
			logger.info("[endTime] 소요시간  ::: " + hours + " 시간 "+minutes+" 분 "+seconds+" 초");

			logger.info("[END] 기준년월 ["+paramVO.getBasYymm()+"] 거래원장 배치가 완료 되었습니다.");

		}catch(Exception e){
			logger.error("거래원장에러",e);
		}


	}


	private void excute(SchdVO paramVO)throws Exception
	{
		controller.excuteTrn(paramVO);
	}

}
