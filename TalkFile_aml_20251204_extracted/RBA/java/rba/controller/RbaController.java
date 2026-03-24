package com.gtone.rba.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.gtone.rba.common.util.DateUtil;
import com.gtone.rba.domain.CommVO;
import com.gtone.rba.domain.IndicatorVO;
import com.gtone.rba.domain.MltfVO;
import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.domain.StandardVO;
import com.gtone.rba.service.RbaService;

@Controller("RbaController")
public class RbaController {

	private static final Logger logger = LoggerFactory.getLogger("RbaBatchMain");

	@Resource(name="RbaService")
    private RbaService service;


	/**
	 * 총평가회차 및 진행중회차
	 * @return
	 * @throws Exception
	 */
	public SchdVO selectIngStep(SchdVO paramVO)throws Exception
	{
		return service.selectIngStep(paramVO);
	}


	/**
	 * 위험평가일정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SchdVO selectSchd(SchdVO paramVO)throws Exception
	{
		return service.selectSchd(paramVO);
	}

	/**
	 * 로그 이력 START
	 * @param commVO
	 * @throws Exception
	 */
	public void startLog(CommVO commVO)throws Exception
	{
		service.startLog(commVO);
	}


	/**
	 * 로그 이력 END
	 * @param commVO
	 * @throws Exception
	 */
	public void endLog(CommVO commVO)throws Exception
	{
		service.endLog(commVO);
	}


	/**
	 * STEP1
	 * 노출위험, 사업위험 추출
	 * 진행상태 10일때 실행
	 * 완료시 11 업데이트
	 * @param info
	 * @throws Exception
	 */
	public void excuteMltfStep1(SchdVO info)throws Exception{

		/*
		 * logger.info("[평가대상지점 노출위험 START] 노출위험 평가 배치를 시작합니다. 평가년도 :: ["+info.
		 * getBasYyyy()+"] 평가회차 :: ["+info.getValtTrn()+"]");
		 * logger.info("대상기간 :: ["+info.getTgtTrnSdt()+" ~ "+info.getTgtTrnEdt()+"]");
		 * 
		 * 
		 * StandardVO paramVO = new StandardVO(); paramVO.setBasYyyy(info.getBasYyyy());
		 * paramVO.setValtTrn(info.getValtTrn());
		 * paramVO.setTgtTrnSdt(info.getTgtTrnSdt());
		 * paramVO.setTgtTrnEdt(DateUtil.addDays(info.getTgtTrnEdt(),1)); //대상종료일 +1
		 * 
		 * paramVO.setTgtTrnSdtYymm(info.getTgtTrnSdt().substring(0, 6));
		 * paramVO.setTgtTrnEdtYymm(info.getTgtTrnEdt().substring(0, 6));
		 * 
		 * logger.info("[고액자산가 마지막 년월] ::::::::::: "+paramVO.getTgtTrnEdtYymm());
		 * 
		 * //평가회차별 기준데이터 생성 (국가,직업 스냅샷)
		 * logger.info("[노출위험 STEP 1.] 평가회차별 기준데이터 생성 (국가,직업 스냅샷) 시작");
		 * service.setNatJobI(paramVO);
		 * logger.info("[노출위험 STEP 1.] 평가회차별 기준데이터 생성 (국가,직업 스냅샷) 완료");
		 * 
		 * //평가회차별 고객정보 생성 logger.info("[노출위험 STEP 2.] 평가회차별 고객정보 생성 시작");
		 * service.setCustI(paramVO); logger.info("[노출위험 STEP 2.] 평가회차별 고객정보 생성 완료");
		 * 
		 * //이벤트별 국가, 고객 생성. logger.info("[노출위험 STEP 3.] 이벤트별 국가,고객정보 생성 시작");
		 * service.setEventNatCustT(paramVO);
		 * logger.info("[노출위험 STEP 3.] 이벤트별 국가,고객정보 생성 완료");
		 * 
		 * 
		 * IndicatorVO indiVO = new IndicatorVO();
		 * indiVO.setBasYyyy(paramVO.getBasYyyy());
		 * indiVO.setValtTrn(paramVO.getValtTrn());
		 * indiVO.setTgtTrnSdt(paramVO.getTgtTrnSdt());
		 * indiVO.setTgtTrnEdt(paramVO.getTgtTrnEdt());
		 * indiVO.setTgtTrnSdtYymm(paramVO.getTgtTrnSdtYymm());
		 * indiVO.setTgtTrnEdtYymm(paramVO.getTgtTrnEdtYymm());
		 * 
		 * //노출위험,사업위험 지표 추출 logger.info("[노출위험 STEP 4.] 노출위험,사업위험 지표 생성 시작");
		 * service.setIndicatorStep1(indiVO);
		 * logger.info("[노출위험 STEP 4.] 노출위험,사업위험 지표 생성 완료");
		 * 
		 * 
		 * logger.info("[평가대상지점 END] 노출위험 평가 배치가 완료 되었습니다.");
		 */

	}



	/**
	 * STEP2
	 * ML/TF 위험 산출
	 * 진행상태 20 (평가지점 확정시) 실행
	 * 완료시 21
	 */
	public void excuteMltfStep2(SchdVO info)throws Exception{

		logger.info("[ML/TF 위험산출 START] ML/TF 위험산출 평가 배치를 시작합니다. 평가년도 :: ["+info.getBasYyyy()+"] 평가회차 :: ["+info.getValtTrn()+"]");
		logger.info("대상기간 :: ["+info.getTgtTrnSdt()+" ~ "+info.getTgtTrnEdt()+"]");


		MltfVO paramVO = new MltfVO();
		paramVO.setBasYymm(info.getBasYymm());
		paramVO.setBasYymmS(info.getTgtTrnSdt().substring(0,6));
		paramVO.setBasYymmE(info.getTgtTrnEdt().substring(0,6)); //대상종료일 +1
		paramVO.setTgtTrnSdt(info.getTgtTrnSdt());
		paramVO.setTgtTrnEdt(info.getTgtTrnEdt()); //대상종료일 +1
		
		logger.info("대상기간 BasYymm :: ["+paramVO.getBasYymmS()+" ~ "+paramVO.getBasYymmE()+"]");

		//ML/TF 위험지표 추출
		logger.info("[ML/TF 위험지표 STEP 1.] 노출위험,사업위험 지표 생성 시작");
		service.setIndicatorStep1(paramVO);
		logger.info("[ML/TF 위험지표 STEP 1.] 노출위험,사업위험 지표 생성 완료");

		//지점별 운영평가, 템플릿 ,샘플링 추출
		//logger.info("[노출위험 STEP 2.] 지점별 운영평가, 템플릿, 샘플링 생성 시작");
		//service.setBrnoValtTjAct(paramVO);
		//logger.info("[노출위험 STEP 2.] 지점별 운영평가, 템플릿, 샘플링 생성 완료");

		//logger.info("[ML/TF 위험산출 END] ML/TF 위험산출 평가 배치가 완료 되었습니다.");

	}


	/**
	 * 노출 위험평가
	 * @param paramVO
	 * @throws Exception
	 */
	public void excuteMltf(SchdVO info)throws Exception{

		logger.info("[노출위험 START] 노출위험 평가 배치를 시작합니다. 평가년도 :: ["+info.getBasYyyy()+"] 평가회차 :: ["+info.getValtTrn()+"]");
		logger.info("대상기간 :: ["+info.getTgtTrnSdt()+" ~ "+info.getTgtTrnEdt()+"]");


		StandardVO paramVO = new StandardVO();
		paramVO.setBasYyyy(info.getBasYyyy());
		//paramVO.setValtTrn(info.getValtTrn());
		paramVO.setTgtTrnSdt(info.getTgtTrnSdt());
		paramVO.setTgtTrnEdt(DateUtil.addDays(info.getTgtTrnEdt(),1)); //대상종료일 +1

		paramVO.setTgtTrnSdtYymm(info.getTgtTrnSdt().substring(0, 6));
		paramVO.setTgtTrnEdtYymm(info.getTgtTrnEdt().substring(0, 6));

		logger.info("[고액자산가 마지막 년월] ::::::::::: "+paramVO.getTgtTrnEdtYymm());

		//평가회차별 기준데이터 생성 (국가,직업 스냅샷)
		logger.info("[노출위험 STEP 1.] 평가회차별 기준데이터 생성 (국가,직업 스냅샷) 시작");
		service.setNatJobI(paramVO);
		logger.info("[노출위험 STEP 1.] 평가회차별 기준데이터 생성 (국가,직업 스냅샷) 완료");

		//평가회차별 고객정보 생성
		logger.info("[노출위험 STEP 2.] 평가회차별 고객정보 생성 시작");
		service.setCustI(paramVO);
		logger.info("[노출위험 STEP 2.] 평가회차별 고객정보 생성 완료");

		//이벤트별 국가, 고객 생성.
		logger.info("[노출위험 STEP 3.] 이벤트별 국가,고객정보 생성 시작");
		service.setEventNatCustT(paramVO);
		logger.info("[노출위험 STEP 3.] 이벤트별 국가,고객정보 생성 완료");


		IndicatorVO indiVO = new IndicatorVO();
		indiVO.setBasYyyy(paramVO.getBasYyyy());
		indiVO.setValtTrn(paramVO.getValtTrn());
		indiVO.setTgtTrnSdt(paramVO.getTgtTrnSdt());
		indiVO.setTgtTrnEdt(paramVO.getTgtTrnEdt());
		indiVO.setTgtTrnSdtYymm(paramVO.getTgtTrnSdtYymm());
		indiVO.setTgtTrnEdtYymm(paramVO.getTgtTrnEdtYymm());

		//노출위험 지표 추출
		logger.info("[노출위험 STEP 4.] 노출위험 지표 생성 시작");
		service.setIndicator(indiVO);
		logger.info("[노출위험 STEP 4.] 노출위험 지표 생성 완료");

		//사업위험 지표 추출
		logger.info("[노출위험 STEP 5.] 사업위험 지표 생성 시작");
		service.setBizIndicator(indiVO);
		logger.info("[노출위험 STEP 5.] 사업위험 지표 생성 완료");

		//지점별 운영평가, 템플릿 ,샘플링 추출
		logger.info("[노출위험 STEP 6.] 지점별 운영평가, 템플릿, 샘플링 생성 시작");
		service.setBrnoValtTjAct(indiVO);
		logger.info("[노출위험 STEP 6.] 지점별 운영평가, 템플릿, 샘플링 생성 완료");


		logger.info("[노출위험 END] 노출위험 평가 배치가 완료 되었습니다.");

	}
	
	
	/**
	 * 통제요소 부점별 배분
	 * @throws Exception
	 */
	public void excuteTongjeBrno(SchdVO info)throws Exception{
		
		info.setBasYyyy(info.getBasYymm().substring(0,4));
		logger.info("[통제요소 부점별 배분 START]  평가년도 :: ["+info.getBasYyyy()+"] 평가회차 :: ["+info.getBasYymm()+"]");

		service.setTongjeBrno(info);
		logger.info("[통제요소 부점별 배분 END] ");

	}
	
	
	/**
	 * 통제요소 자동산출값 추출
	 * @throws Exception
	 */
	public void excuteTongjeAutoValue(SchdVO info)throws Exception{
		
		info.setBasYyyy(info.getBasYymm().substring(0,4));
		
		
		
		logger.info("[통제요소 자동산출 START]  평가기간 :: ["+info.getTgtTrnSdt()+"] ~ ["+info.getTgtTrnEdt()+"]");

		service.setTongjeAutoValue(info);
		logger.info("[통제요소 자동산출 END] ");

	}



	/**
	 * 내부통제 효과성 평가
	 * 1.통제효과성 산출 1.
	 * 2.통제효과성 산출 2.
	 * 3.통제효과성 최종결과
	 * @throws Exception
	 */
	public void excuteTongje(SchdVO info)throws Exception{
		
		info.setBasYyyy(info.getBasYymm().substring(0,4));
		logger.info("[통제요소 부점별 배분 START]  평가년도 :: ["+info.getBasYyyy()+"] 평가회차 :: ["+info.getBasYymm()+"]");

		service.setTongjePrc(info);
		logger.info("[통제요소 부점별 배분 END] ");

	}


	/**
	 * 진행회차 업데이트
	 * @param schdVO
	 * @throws Exception
	 */
	public void updateIngTrn(SchdVO schdVO)throws Exception{

		logger.info("[진행회차 업데이트 START] 진행회차 업데이트를 시작합니다. 평가년도 :: ["+schdVO.getBasYyyy()+"] 평가회차 :: ["+schdVO.getValtTrn()+"]");
		service.setUpdateIngTrn(schdVO);
		logger.info("[진행회차 업데이트 END] 진행회차 업데이트를 완료 하였습니다.");

	}

	/**
	 * 진행상태(ING_STEP) 업데이트
	 * @param schdVO
	 * @throws Exception
	 */
	public void updateIngStep1(SchdVO schdVO)throws Exception{

		logger.info("[진행상태 업데이트 START] 평가회차 :: ["+schdVO.getBasYymm()+"] 진행상태(ING_STEP) :: ["+schdVO.getIngStep()+"]");
		service.setUpdateIngStep1(schdVO);
		logger.info("[진행상태 업데이트 END] 진행상태 업데이트를 완료 하였습니다.");

	}
	
	public void updateIngStep2(SchdVO schdVO)throws Exception{

		logger.info("[진행상태 업데이트 START] 평가회차 :: ["+schdVO.getBasYymm()+"] 진행상태(ING_STEP) :: ["+schdVO.getIngStep()+"]");
		service.setUpdateIngStep2(schdVO);
		logger.info("[진행상태 업데이트 END] 진행상태 업데이트를 완료 하였습니다.");

	}
	
	public void updateIngStep3(SchdVO schdVO)throws Exception{

		logger.info("[진행상태 업데이트 START] 평가회차 :: ["+schdVO.getBasYymm()+"] 진행상태(ING_STEP) :: ["+schdVO.getIngStep()+"]");
		service.setUpdateIngStep3(schdVO);
		logger.info("[진행상태 업데이트 END] 진행상태 업데이트를 완료 하였습니다.");

	}
	
	
	
	public void updateIngStep(SchdVO schdVO)throws Exception{

		logger.info("[진행상태 업데이트 START] 평가회차 :: ["+schdVO.getBasYymm()+"] 진행상태(ING_STEP) :: ["+schdVO.getIngStep()+"]");
		service.setUpdateIngStep1(schdVO);
		logger.info("[진행상태 업데이트 END] 진행상태 업데이트를 완료 하였습니다.");

	}



	/**
	 * 마지막 최종회차(99) - 1년치 평균 구하는 회차입니다.
	 * @param info
	 * @throws Exception
	 */
	public void excuteFinal(SchdVO info)throws Exception{

		logger.info("[최종회차 START] 최종회차 배치를 시작합니다. 평가년도 :: ["+info.getBasYyyy()+"] 평가회차 :: ["+info.getValtTrn()+"]");

		MltfVO mltfVO = new MltfVO();
		mltfVO.setBasYyyy(info.getBasYyyy());
		//mltfVO.setValtTrn(info.getValtTrn());

		service.setFinalPrc(mltfVO);
		logger.info("[최종회차 END] 최종회차 배치가 완료 되었습니다.");

	}


}
