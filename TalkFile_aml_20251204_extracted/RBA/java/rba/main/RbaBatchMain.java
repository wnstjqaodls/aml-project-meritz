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
import com.gtone.rba.controller.RbaController;
import com.gtone.rba.domain.CommVO;
import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.domain.SchdVO.ING_STEP;


/**
 * RBA 생성 배치 class
 * 스케줄러를 통해 매일 실행
 * 오늘날짜가 평가시작일일 경우 배치 실행된다.
 *
 * @author jacky
 *
 */
@Component
public class RbaBatchMain {

	private static final Logger logger = LoggerFactory.getLogger("RbaBatchMain");


	@Resource(name = "RbaController")
	private RbaController controller;

	private String yyyy="";
	private String mode=""; //

	public static void main(String[] args)
	{
		ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:META-INF/spring/context-*.xml");
		RbaBatchMain batch = ctx.getBean(RbaBatchMain.class);


		//수동실행시.
		if(args.length > 0)
		{
			batch.yyyy = args[0]; //기준년도
			batch.mode= args[1];	//step
		}
		else{
			batch.yyyy = DateUtil.getYear();
		}

		batch.excute();
	}



	/**
	 * 진행상태별 STEP 콜
	 * @throws Exception
	 */
	private void excute()
	{
		CommVO commVO = null;
		String basYymm ="";
		String ingStep ="";
		String btchDt = DateUtil.getSysdate();

		long startTime = System.currentTimeMillis();

		try
		{
			logger.info("[START] RBA 배치가 시작 되었습니다.");


			SchdVO schdVO = new SchdVO();
			schdVO.setBasYymm(yyyy);//수동실행시 기준년월 입력받은 값으로 없으면 최근 진행년월
			schdVO.setIngStep(mode);
			
			logger.info("평가년도 :: ["+yyyy+"]  step code :: ["+mode+"]");


			//진행상태 가져오기
			SchdVO schd = controller.selectIngStep(schdVO);

			if(schd != null)
			{

				SchdVO paramVO = new SchdVO();
				//paramVO.setBasYyyy(schd.getBasYyyy());
				paramVO.setBasYymm(schd.getBasYymm());
				//paramVO.setValtTrn(schd.getIngTrn()); //평가회차를 현재진행중인 회차로 설정
				
				logger.info("평가년도 :: ["+paramVO.getBasYymm()+"]  진행상태 :: ["+schd.getIngStep()+"]");
				logger.info("대상일자 :: ["+schd.getTgtTrnSdt()+"]  대상일자 :: ["+schd.getTgtTrnEdt()+"]");
				
				//SchdVO info = controller.selectSchd(paramVO);
				
				

				
				/**
				 * 운영평가 시작일과 현재일 비교하여 노출 배치 실행.
				 * 운영평가 실제 종료일이 존재하고 현재일자 -1과 같을때 내부효과성 배치 실행.
				 */

				String chkDt = DateFormatUtils.format(DateUtils.addDays(DateUtil.check(DateUtil.getCurrentDate(""), "yyyyMMdd"), -1),"yyyyMMdd");
				logger.info("[chkDt] ::: "+chkDt);


				/**
				 * 노출위험
				 * 최초 진행상태(ING_STEP == 40)일 경우 노출위험,사업위험 추출
				 * 노출위험,사업위험 추출완료시 ING_STEP == 41
				 * ML/TF 추출 완료시 ING_STEP == 41
				 */
				//노출위험
				if("2.3".equals(mode) || "M".equals(mode))
				{
					//노출 score 및 사업위험 추출
					controller.excuteMltfStep2(schd);

					//진행상태 업데이트(41)
					schd.setIngStep(ING_STEP.STEP01_END.getValue());
					controller.updateIngStep1(schd);
				}
				/**
				 * 통제요소관리 확정이후, 부점별 통제요소 배분
				 * 진행상태(ING_STEP == 60)일 경우 
				 * 부점별 통제요소 배분후 추출완료시 ING_STEP == 61
				 */
				else if("3.3".equals(mode) || "M".equals(mode))
				{
					controller.excuteTongjeBrno(schd);  // 통제요소 부점 배분
					
					//controller.excuteTongjeAutoValue(schd); // 통제요소 자동산출 반영
					
					//진행상태 업데이트(61)
					schd.setIngStep(ING_STEP.STEP02_END.getValue());
					controller.updateIngStep2(schd);

				}
				/**
				 * 통제요소 부점평가 입력 및 확정이후 , 통제 평가결과
				 * 진행상태(ING_STEP == 70)일 경우 
				 * 부점별 통제활동의 결과 집계 수행 완료시 ING_STEP == 71
				 */
				else if("3.4".equals(mode) || "M".equals(mode))
				{
					controller.excuteTongje(schd);
					
					//진행상태 업데이트(71)
					schd.setIngStep(ING_STEP.STEP03_END.getValue());
					controller.updateIngStep3(schd);

				}

				
			}


		}catch(Exception e){
			e.printStackTrace();
			logger.error("[ERROR] ::: ",e);
			/*try {
				//배치로그 배치상태 완료
				commVO = new CommVO(basYymm ,ingStep ,btchDt ,"9" ,"오류발생 로그파일을 확인하세요." );
				controller.endLog(commVO);
			} catch (Exception e1) {
				e1.printStackTrace();
			}				*/
		}
		finally
		{
			long endTime = System.currentTimeMillis();
			long resutTime = endTime - startTime;

			int seconds = (int) (resutTime / 1000) %60;
			int minutes = (int) (resutTime / (1000*60)) %60;
			int hours = (int) (resutTime / (1000*60*60)) %60;

			logger.info("[endTime] 소요시간  ::: " + (resutTime/1000) + "(s)");
			logger.info("[endTime] 소요시간  ::: " + hours + " 시간 "+minutes+" 분 "+seconds+" 초");

			logger.info("[END] RBA 배치가 완료 되었습니다.");
		}
	}

}
