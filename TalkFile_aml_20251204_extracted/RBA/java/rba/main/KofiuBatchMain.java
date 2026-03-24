package com.gtone.rba.main;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import com.gtone.rba.controller.KofiuController;
import com.gtone.rba.domain.KofiuVO;

/**
 * KoFIU 지표 보고 데이터 적재 배치 class
 * 
 * @author jekwak
 *
 */
@Component
public class KofiuBatchMain {

	private static final Logger logger = LoggerFactory.getLogger("KofiuBatchMain");	
	
	@Resource(name = "KofiuController")
	private KofiuController controller;
	
	
	public static void main(String[] args) 
	{
		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");			
		KofiuBatchMain batch = ctx.getBean(KofiuBatchMain.class);		
		
		KofiuVO paramVO = new KofiuVO();

		if(args.length > 0){
			paramVO.setRptGjdt(args[0]);
		}
		
		batch.excute(paramVO);	
	}
	
	/**
	 * 진행상태별 STEP 콜
	 * @throws Exception
	 */
	private void excute(KofiuVO paramVO) {
		try {
			logger.info("[START] KoFIU 배치가 시작 되었습니다.");
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Calendar c1 = Calendar.getInstance();
			paramVO.setToday(sdf.format(c1.getTime()));
			
			long startTime = System.currentTimeMillis();
			
			controller.excuteStep0(paramVO);		// 배치기준일자 가져오기
			controller.excuteStep1(paramVO);		// 자동지표 데이터 적재	
			
			long endTime = System.currentTimeMillis();
			long resutTime = endTime - startTime;
			logger.info("[endTime] 소요시간  ::: " + (resutTime / 1000) + "(s)");

		} catch (Exception e) {
			logger.error("[ERROR] ::: ", e);
		} finally {
			logger.info("[END] KoFIU 배치가 완료 되었습니다.");
		}

	}
}
