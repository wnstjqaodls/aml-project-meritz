package com.gtone.rba.service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import javax.annotation.Resource;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.gtone.rba.common.util.DateUtil;
import com.gtone.rba.common.util.SqlMapClient;
import com.gtone.rba.dao.DefaultDAO;
import com.gtone.rba.domain.CommVO;
import com.gtone.rba.domain.IndicatorVO;
import com.gtone.rba.domain.MltfVO;
import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.domain.StandardVO;
import com.gtone.rba.domain.SchdVO.ING_STEP;

@Service("RbaService")
public class RbaService {

	private static final Logger logger = LoggerFactory.getLogger("RbaBatchMain");


	@Resource(name="DefaultDAO")
    private DefaultDAO dao;

	private static SqlSession session;

	/**
	 * 총평가회차 및 진행중회차
	 * @return
	 * @throws Exception
	 */
	public SchdVO selectIngStep(SchdVO paramVO)throws Exception
	{
		return dao.selectOne("schd.selectSchdIng_step", paramVO);
	}


	/**
	 * 위험평가일정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SchdVO selectSchd(SchdVO paramVO)throws Exception
	{
		return dao.selectOne("schd.selectSchd", paramVO);
	}


	public void startLog(CommVO commVO)throws Exception
	{
		dao.insert("comm.startLog", commVO);
	}

	public void endLog(CommVO commVO)throws Exception
	{
		dao.update("comm.endLog", commVO);
	}



	/**
	 * 평가회차별 국가,직업(업종) 스냅샷 생성
	 * @param paramVO
	 * @throws Exception
	 */
	public void setNatJobI(StandardVO paramVO)throws Exception
	{
		//국가,직업(업종) 삭제
		dao.delete("standard.deleteNatI", paramVO);
		dao.delete("standard.deleteJobI", paramVO);

		//국가,직업(업종) 등록
		dao.insert("standard.insertNatI", paramVO);
		dao.insert("standard.insertJobI", paramVO);

	}


	/**
	 * 평가회차별 고객 스냅샷 생성
	 * @param paramVO
	 * @throws Exception
	 */
	public void setCustI(StandardVO paramVO)throws Exception{
		//고객 삭제
		dao.delete("standard.deleteCustI", paramVO);

		//ALTER SESSION ENABLE PARALLEL DML;
		//dao.insert("standard.alter_session", paramVO);

		//고객 등록
		dao.insert("standard.insertCustI", paramVO);

	}


	/**
	 * 이벤트별 국가, 고객 생성
	 * @param paramVO
	 * @throws Exception
	 */
	public void setEventNatCustT(StandardVO paramVO)throws Exception{
		//국가 삭제
		dao.delete("standard.deleteNatT", paramVO);
		//고객 삭제
		dao.delete("standard.deleteCustT", paramVO);


		//국가 등록
		dao.insert("standard.insertNatT", paramVO);

		//고객 등록
		dao.insert("standard.insertCustT", paramVO);

	}

	/**
	 * 노출위험추출 STEP1
	 * @param indiVO
	 * @throws Exception
	 */
	public void setIndicatorStep1(MltfVO indiVO)throws Exception
	{

		try
		{
			session = SqlMapClient.getSqlSession();

			//해당년월 평가회차 삭제
			session.delete("mltf.deleteKrbaExpsExtrM", indiVO);
			session.commit();
			
			//해당년월 거래구간 정보 갱신
			session.delete("mltf.deleteEtcI_R5", indiVO);
			session.commit();
			session.insert("mltf.insertEtcI_R5", indiVO); // 
			session.commit();

			//국가,고객,상품, 지표
			logger.info("국가,고객,상품, 지표 start:: ");
			session.insert("mltf.insertIndicatorNatCust1", indiVO); // 
			session.commit();
			logger.info("국가,고객,상품, 지표 end:: ");
			
			//채널 지표
			//logger.info("채널 지표 start:: ");
			//session.insert("mltf.insertIndicatorChannel", indiVO); // 
			//session.commit();
			//logger.info("채널 지표 end:: ");

			//거래 지표
			logger.info("거래 지표 start:: ");
			session.insert("mltf.insertIndicatorTrn", indiVO);
			session.commit();
			logger.info("거래 지표 end:: ");
			
			
			//전사 집계
			logger.info("전사 집계 start:: ");
			session.insert("mltf.insertIndicatorAllBrno", indiVO);
			session.commit();
			logger.info("전사 집계 end:: ");
			
			
			//고유위헙 Score 삭제
			logger.info("고유위헙 Score 삭제 start:: ");
			session.delete("mltf.deleteRiskScore", indiVO);
			session.commit();
			logger.info("고유위헙 Score 삭제 end:: ");
			
			
			//고유위헙 Score 생성
			logger.info("고유위헙 Score 생성 start:: ");
			session.insert("mltf.insertRiskScore", indiVO);
			session.commit();
			logger.info("고유위헙 Score 생성 end:: ");
			
			
			//고유위헙 Score ALL 생성
			//logger.info("고유위헙 Score ALL 생성 start:: ");
			//session.insert("mltf.insertRiskScoreAllBrno", indiVO);
			//session.commit();
			//logger.info("고유위헙 Score ALL 생성 end:: ");
			
			

		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();
		}

	}




	/**
	 * ML/TF 위험추출 STEP2
	 * @param indiVO
	 * @throws Exception
	 */
	public void setIndicatorStep2(MltfVO indiVO)throws Exception
	{

		dao.delete("indicator.deleteExpsExtrT1", indiVO);
		dao.delete("indicator.deleteExpsLstI", indiVO);
		dao.delete("indicator.deleteExpsScorI", indiVO);

		//노출 산출
		dao.insert("indicator.insertIndicatorTemp1",indiVO);

		//노출 최종결과
		dao.insert("indicator.insertIndicatorLst",indiVO);

		//노출 SCORE
		dao.insert("indicator.insertIndicatorScor",indiVO);


		//평가제외된 지점 삭제
		//dao.delete("indicator.deleteBzrskExtrMValtBrno", indiVO);

		//해당월 사업위험 지표 삭제
		dao.delete("indicator.deleteMltfExtrI", indiVO);
		dao.delete("indicator.deleteBzrskLstI", indiVO);
		dao.delete("indicator.deleteBzrskExtrT2", indiVO);
		dao.delete("indicator.deleteBzrskExtrT1", indiVO);

		//사업위험 산출1 등록
		dao.insert("indicator.insertIndicatorBizTemp1",indiVO);

		//사업위험 산출2 등록
		dao.insert("indicator.insertIndicatorBizTemp2",indiVO);

		//사업위험 최종결과 등록
		dao.insert("indicator.insertIndicatorBizLst",indiVO);

		//ML/TF 위험산출 SCOR 등록
		dao.insert("indicator.insertMltfScor",indiVO);

	}



	/**
	 * 노출위험 지표 추출
	 * @param paramVO
	 * @throws Exception
	 */
	public void setIndicator(IndicatorVO indiVO)throws Exception
	{
		System.out.println("#######:::::::::: "+indiVO.getBasYyyy());
		System.out.println("#######:::::::::: "+indiVO.getValtTrn());

		try
		{
			session = SqlMapClient.getSqlSession();

			//해당년월 평가회차 삭제
			session.delete("indicator.deleteKrbaExpsExtrM", indiVO);
			session.delete("indicator.deleteExpsExtrT1", indiVO);
			session.delete("indicator.deleteExpsLstI", indiVO);
			session.delete("indicator.deleteExpsScorI", indiVO);
			session.commit();

			//국가,고객 지표
			logger.info("국가,고객 지표 start:: ");
			session.insert("indicator.insertIndicatorNatCust", indiVO);
			session.commit();
			logger.info("국가,고객 지표 end:: ");

			//상품 지표
			logger.info("상품 지표 start:: ");
			session.insert("indicator.insertIndicatorGds", indiVO);
			session.commit();
			logger.info("상품 지표 end:: ");

			//채널 지표
			logger.info("채널 지표 start:: ");
			session.insert("indicator.insertIndicatorChnnal", indiVO);
			session.commit();
			logger.info("채널 지표 end:: ");


			/**
			 *	지점 통폐합
			 * 1.스코어 산출전 처리
			 * 2.노출추출지표관리 통폐합 여부 업데이트 (폐점된 지점)
			 * 3.고객사마다 다르므로 커스터마이징 한다.
			 */

			//통폐합된 지점 목록
			List<IndicatorVO> list = session.selectList("indicator.selectBrnoList", indiVO);
			List<IndicatorVO> brnoList = new ArrayList<IndicatorVO>(); //최종 통폐합 지점목록

			for(IndicatorVO IDVO :list)
			{
				//최종 통폐합된 지점을 찾는다. - 리커시브
				//System.out.println("없어진 지점 ::: "+indiVO.getBaseOrgNo());
				//System.out.println("없어진 지점] ::: "+indiVO.toString());
				String baseOrgNo = IDVO.getBaseOrgNo();
				String lastBrno = IDVO.getBaseOrgNo();
				while(true)
				{
					lastBrno = baseOrgNo;
					baseOrgNo = session.selectOne("indicator.selectBrno", baseOrgNo);
					//System.out.println("[baseOrgNo] ::: "+baseOrgNo+ "[lastBrno] ::: "+lastBrno);

					if(baseOrgNo == null || baseOrgNo.equals(lastBrno) )
					{
						logger.info("최종 지점 :: "+IDVO.getBaseOrgNo()+ " --> "+lastBrno);

						if(baseOrgNo == null)
						{
							IDVO.setFacOrgNo(lastBrno);
							brnoList.add(IDVO);

						}
						break;
					}
				}
			}

			logger.info("[최종 통폐합된 지점 수] ::: "+brnoList.size());

			if(brnoList.size() > 0)
			{
				for(IndicatorVO t : brnoList)
				{
					logger.info("폐쇄 지점 :: "+t.getBaseOrgNo()+ " --> "+t.getFacOrgNo());

					if(!t.getBaseOrgNo().equals(t.getFacOrgNo()))
					{
						session.insert("indicator.insertExpsExtrT", t);
					}

					session.delete("indicator.deleteEXpsExtrTOrg", t);
					session.delete("indicator.deleteEXpsExtrTFac", t);
				}

				//temp -> 통합된 지표추출관리 등록
				session.insert("indicator.insertExtrM",indiVO);
				//temp 최종결과 삭제
				session.delete("indicator.deleteExpsExtrT",indiVO);
				session.commit();
			}

			//노출 산출
			session.insert("indicator.insertIndicatorTemp1",indiVO);

			//노출 최종결과
			session.insert("indicator.insertIndicatorLst",indiVO);

			//노출 SCORE
			session.insert("indicator.insertIndicatorScor",indiVO);

			session.commit();


		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();
		}

	}




	/**
	 * 사업노출 지표
	 * @param indiVO
	 * @throws Exception
	 */
	public void setBizIndicator(IndicatorVO indiVO)throws Exception
	{


		//해당월 사업위험 지표 삭제
		dao.delete("indicator.deleteMltfExtrI", indiVO);
		dao.delete("indicator.deleteBzrskLstI", indiVO);
		dao.delete("indicator.deleteBzrskExtrT2", indiVO);
		dao.delete("indicator.deleteBzrskExtrT1", indiVO);
		dao.delete("indicator.deleteBzrskExtrM", indiVO);
		logger.info("======= 삭제 -=====");

		//사업위험 지표 등록
		dao.insert("indicator.insertIndicatorBiz1",indiVO);
		logger.info("======= biz1 -=====");
		dao.insert("indicator.insertIndicatorBiz2",indiVO);
		logger.info("======= biz2 -=====");


		/**
		 * 지점 통폐합
		 * 스코어 산출전 병합
		 */
		//통폐합된 지점 목록
		List<IndicatorVO> list = dao.selectList("indicator.selectBzrskBrnoList", indiVO);
		List<IndicatorVO> brnoList = new ArrayList<IndicatorVO>(); //최종 통폐합 지점목록

		for(IndicatorVO IDVO :list)
		{
			String baseOrgNo = IDVO.getBaseOrgNo();
			String lastBrno = IDVO.getBaseOrgNo();
			while(true)
			{
				lastBrno = baseOrgNo;
				baseOrgNo = dao.selectOne("indicator.selectBrno", baseOrgNo);
				//System.out.println("[baseOrgNo] ::: "+baseOrgNo+ "[lastBrno] ::: "+lastBrno);

				if(baseOrgNo == null || baseOrgNo.equals(lastBrno) )
				{
					logger.info("최종 지점 :: "+IDVO.getBaseOrgNo()+ " --> "+lastBrno);

					if(baseOrgNo == null)
					{
						IDVO.setFacOrgNo(lastBrno);
						brnoList.add(IDVO);

					}
					break;
				}
			}
		}

		logger.info("[사업지표 통폐합된 지점 수] ::: "+brnoList.size());


		if(brnoList.size() > 0)
		{
			for(IndicatorVO t : brnoList)
			{
				logger.info("폐쇄 지점 :: "+t.getBaseOrgNo()+ " --> "+t.getFacOrgNo());

				//폐쇄지점과 통합지점이 다를경우에만
				//즉, 폐쇄지점이고 이관지점이 존재하지 않다면 평가하지 않는다.
				if(!t.getBaseOrgNo().equals(t.getFacOrgNo()))
				{
					dao.insert("indicator.insertBzrskExtrT", t);
				}

				dao.delete("indicator.deleteBzrskExtrmOrg", t);
				dao.delete("indicator.deleteBzrskExtrmFac", t);
			}


			//temp -> 통합된 사업지표추출관리 등록
			dao.insert("indicator.insertBzrskExtrM",indiVO);
			//temp 삭제
			dao.delete("indicator.deleteBzrskExtrT",indiVO);
		}


		//사업위험 산출1 등록
		dao.insert("indicator.insertIndicatorBizTemp1",indiVO);

		//사업위험 산출2 등록
		dao.insert("indicator.insertIndicatorBizTemp2",indiVO);

		//사업위험 최종결과 등록
		dao.insert("indicator.insertIndicatorBizLst",indiVO);

		//ML/TF 위험산출 SCOR 등록
		dao.insert("indicator.insertMltfScor",indiVO);
	}


	/**
	 * 지점별 운영평가, 템플링
	 * @param indiVO
	 * @throws Exception
	 */
	public void setBrnoValtTjAct(IndicatorVO indiVO)throws Exception
	{

		dao.delete("indicator.deleteBrnoValtM",indiVO);
		dao.delete("indicator.deleteBrnoValtT",indiVO);

		//운영평가
		dao.insert("indicator.insertBrnoValtM",indiVO);
		dao.insert("indicator.insertAllBrnoValtM",indiVO);

		//템플링
		dao.insert("indicator.insertBrnoValtT",indiVO);
		dao.insert("indicator.insertAllBrnoValtT",indiVO);

		//샘플링
		dao.delete("indicator.deleteSample", indiVO);

		for(int i=1; i < 27; i++)
		{
			dao.insert("indicator.insertSample"+i, indiVO);
		}

	}



	/**
	 * 지점별  샘플링 - 임시
	 * @param indiVO
	 * @throws Exception
	 */
	public void setBrnoSampling(IndicatorVO indiVO)throws Exception
	{
		//샘플링
		try
		{
			session = SqlMapClient.getSqlSession();

			session.delete("indicator.deleteSample", indiVO);
			session.commit();
			//List<IndicatorVO> sList = session.selectList("indicator.selectSamplingList", indiVO);


			for(int i=1; i < 27; i++)
			{
				logger.info("샘플링 파일 :: "+i+" 번째");
				session.insert("indicator.insertSample"+i, indiVO);

				session.commit();

			}


		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();
		}
	}


	/**
	 * 지점별 통제요소 배푼
	 * @param indiVO
	 * @throws Exception
	 */
	public void setTongjeBrno(SchdVO schVO)throws Exception
	{
		System.out.println("#######:::::::::: "+schVO.getBasYyyy());
		System.out.println("#######:::::::::: "+schVO.getBasYymm());
		
		System.out.println("#######:::::::::: "+schVO.getTgtTrnSdt());
		System.out.println("#######:::::::::: "+schVO.getTgtTrnEdt());

		try
		{
			session = SqlMapClient.getSqlSession();
			
			//해당년월 통제요소 부점별 고객 샘플대상 삭제 STEP1
			session.delete("tongje.deleteBrnoSI", schVO);
			session.commit();

			// 통제요소 부점별 고객 샘플대상 생성
			logger.info("통제요소 고객 샘플대상 생성 STEP1 start:: ");
			session.insert("tongje.insertBrnoSI", schVO);
			session.commit();
			logger.info("통제요소 고객 샘플대상 생성 STEP1 end:: ");

			//해당년월 통제요소 부점별 배분항목 삭제 STEP1
			session.delete("tongje.deleteVCntlElmnM", schVO);
			session.commit();

			// 통제요소 부점별 배분
			logger.info("통제요소 부점별 배분 STEP1 start:: ");
			session.insert("tongje.insertVCntlElmnM", schVO);
			session.commit();
			logger.info("통제요소 부점별 배분 STEP1 end:: ");
			
			
			//해당년월 통제요소 부점별 배분항목 삭제 STEP2
			session.delete("tongje.deleteCntlBrnoItem", schVO);
			session.commit();

			// 통제요소 부점별 배분
			logger.info("통제요소 부점별 배분 STEP2 start:: ");
			session.insert("tongje.insertCntlBrnoItem", schVO);
			session.commit();
			logger.info("통제요소 부점별 배분 STEP2 end:: ");
			
			
			
			
			
			// 통제요소 자동산출
			logger.info("통제요소 자동산출 start:: updateCntl_P030504_1");
			session.insert("tongje.updateCntl_P030504_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P030504_1");
			
			
			logger.info("통제요소 자동산출 start:: updateCntl_P030505_1");
			session.insert("tongje.updateCntl_P030505_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P030505_1");
			
			logger.info("통제요소 자동산출 start:: updateCntl_P030505_2");
			session.insert("tongje.updateCntl_P030505_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P030505_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntl_P030506_1");
			session.insert("tongje.updateCntl_P030506_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P030506_1");
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P030506_2");
			session.insert("tongje.updateCntlBrnoItem_P030506_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P030506_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntl_P040204_1");
			session.insert("tongje.updateCntl_P040204_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P040204_1");
			
			
			logger.info("통제요소 자동산출 start:: updateCntl_P040204_2");
			session.insert("tongje.updateCntl_P040204_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P040204_2");
			
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P040205_1");
			session.insert("tongje.updateCntlBrnoItem_P040205_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P040205_1");
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P040205_2");
			session.insert("tongje.updateCntlBrnoItem_P040205_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P040205_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntl_P040301_2");
			session.insert("tongje.updateCntl_P040301_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntl_P040301_2");
			
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050101_1");
			session.insert("tongje.updateCntlBrnoItem_P050101_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050101_1");
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050101_2");
			session.insert("tongje.updateCntlBrnoItem_P050101_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050101_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050102_2");
			session.insert("tongje.updateCntlBrnoItem_P050102_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050102_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050103_1");
			session.insert("tongje.updateCntlBrnoItem_P050103_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050103_1");
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050103_2");
			session.insert("tongje.updateCntlBrnoItem_P050103_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050103_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050105_1");
			session.insert("tongje.updateCntlBrnoItem_P050105_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050105_1");
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050105_2");
			session.insert("tongje.updateCntlBrnoItem_P050105_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050105_2");
			
			
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050201_1");
			session.insert("tongje.updateCntlBrnoItem_P050201_1", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050201_1");
			
			logger.info("통제요소 자동산출 start:: updateCntlBrnoItem_P050201_2");
			session.insert("tongje.updateCntlBrnoItem_P050201_2", schVO);
			session.commit();
			logger.info("통제요소 자동산출 end :: updateCntlBrnoItem_P050201_2");
			
			


		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();
		}

	}
	
	
	
	/**
	 * 지점별 통제요소 자동산출 작업
	 * @param indiVO
	 * @throws Exception
	 */
	public void setTongjeAutoValue(SchdVO schVO)throws Exception
	{
		System.out.println("#######:::::::::: "+schVO.getBasYyyy());
		System.out.println("#######:::::::::: "+schVO.getBasYymm());
		System.out.println("#######:::::::::: "+schVO.getTgtTrnSdt());
		System.out.println("#######:::::::::: "+schVO.getTgtTrnEdt());

		try
		{
			session = SqlMapClient.getSqlSession();

			// 통제요소 자동산출
			
			
			
			
			
			
			
			


		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();
		}

	}
	

	/**
	 * 내부통제 효과성
	 * @param indiVO
	 * @throws Exception
	 */
	public void setTongjePrc(SchdVO schVO)throws Exception
	{

		System.out.println("#######:::::::::: "+schVO.getBasYyyy());
		System.out.println("#######:::::::::: "+schVO.getBasYymm());

		try
		{
			session = SqlMapClient.getSqlSession();

			//해당년월 통제요소 평가 삭제
			session.delete("tongje.deleteVCntlElmnScore", schVO);
			session.commit();

			// 통제요소 평가
			logger.info("통제요소 평가 start:: ");
			session.insert("tongje.insertVCntlElmnScore", schVO);
			session.commit();
			logger.info("통제요소 평가 end:: ");
			
			
			//잔여결과 삭제 STEP3
			session.delete("tongje.deleteFinalEval", schVO);
			session.commit();

			//잔여결과 생성 STEP3
			logger.info("잔여결과 생성 STEP3 start:: ");
			session.insert("tongje.insertFinalEval", schVO);
			session.commit();
			logger.info("잔여결과 생성 STEP3 end:: ");
			
			//잔여결과 전사생성 STEP3
			logger.info("잔여결과 전사생성 STEP3 start:: ");
			session.insert("tongje.insertFinalEvalAll", schVO);
			session.commit();
			logger.info("잔여결과 전사생성 STEP3 end:: ");
			
			
			
			
			//해당년월 RBA결과보고 삭제
			//session.delete("tongje.select_SRBA_VALT_SCHD_R", schVO);
			//session.commit();

			//RBA결과보고 생성
			logger.info("RBA결과보고 start:: ");
			session.insert("tongje.merge_SRBA_VALT_SCHD_R", schVO);
			session.commit();
			logger.info("RBA결과보고 end:: ");

			

		}catch(Exception e){
			e.printStackTrace();
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();
		}

	}


	/**
	 * 진행회차 업데이트
	 * @param schdVO
	 * @throws Exception
	 */
	public void setUpdateIngTrn(SchdVO schdVO)throws Exception
	{
		dao.update("schd.updateSchIng", schdVO);
	}

	/**
	 * 진행상태 업데이트
	 * @param schdVO
	 * @throws Exception
	 */
	public void setUpdateIngStep1(SchdVO schdVO)throws Exception
	{
		dao.update("schd.updateSchIng1", schdVO);
		dao.update("schd.updateSchIngM", schdVO);
	}
	
	public void setUpdateIngStep2(SchdVO schdVO)throws Exception
	{
		dao.update("schd.updateSchIng2", schdVO);
		dao.update("schd.updateSchIngM", schdVO);
	}
	
	public void setUpdateIngStep3(SchdVO schdVO)throws Exception
	{
		dao.update("schd.updateSchIng3", schdVO);
		dao.update("schd.updateSchIngM", schdVO);
	}



	/**
	 * 1년 평균 최종회차
	 * @param paramVO
	 * @throws Exception
	 */
	public void setFinalPrc(MltfVO paramVO)throws Exception{

		//최종평가회차 셋팅
		paramVO.setValtTrn(99);


		dao.delete("final.deleteMltfLstI", paramVO); 		//ML/TF 최종결과 삭제
		dao.delete("final.deleteRemdrRskBrnoI", paramVO); 	//잔여위험 부점별 결과
		dao.delete("final.deleteRemdrRskI", paramVO);		//잔여위험 서비스별 결과
		dao.delete("final.deleteTjeffExtrLstI", paramVO);	//통제효과성 최종결과
		dao.delete("final.deleteTjeffExtrT2", paramVO);		//통제효과성 산출 TEMP2
		dao.delete("final.deleteTjeffExtrT1", paramVO);		//통제효과성 산출 TEMP1

		dao.delete("final.deleteMltfExtrI", paramVO);		//위험산출 SCRORE
		dao.delete("final.deleteBzrskLstI", paramVO);		//사업위험 최종결과
		dao.delete("final.deleteBzrskExtrT2", paramVO);		//사업위험 산출 TEMP2
		dao.delete("final.deleteBzrskExtrT1", paramVO);		//사업위험 산출 TEMP1
		dao.delete("final.deleteBzrskExtrM", paramVO);		//사업위험 지표 추출

		dao.delete("final.deleteExpsScorI", paramVO);		//노출위험 SCRORE
		dao.delete("final.deleteLstI", paramVO);			//노출위험 최종결과
		dao.delete("final.deleteExpsExtrM", paramVO);		//노출위험 산출 템프1
		dao.delete("final.deleteExpsExtrT1", paramVO);		//노출위험 지표추출관리


		//노출위험 지표추출관리 - 1년 합계
		dao.insert("final.insertFinalExpsExtrM",paramVO);



		/**
		 *	지점 통폐합
		 * 1.스코어 산출전 처리
		 * 2.노출추출지표관리 통폐합 여부 업데이트 (폐점된 지점)
		 * 3.고객사마다 다르므로 커스터마이징 한다.
		 */

		//통폐합된 지점 목록
		List<IndicatorVO> list = dao.selectList("indicator.selectBrnoList", paramVO);
		List<IndicatorVO> brnoList = new ArrayList<IndicatorVO>(); //최종 통폐합 지점목록

		for(IndicatorVO IDVO :list)
		{
			//최종 통폐합된 지점을 찾는다. - 리커시브
			//System.out.println("없어진 지점 ::: "+indiVO.getBaseOrgNo());
			//System.out.println("없어진 지점] ::: "+indiVO.toString());
			String baseOrgNo = IDVO.getBaseOrgNo();
			String lastBrno = IDVO.getBaseOrgNo();
			while(true)
			{
				lastBrno = baseOrgNo;
				baseOrgNo = dao.selectOne("indicator.selectBrno", baseOrgNo);
				//System.out.println("[baseOrgNo] ::: "+baseOrgNo+ "[lastBrno] ::: "+lastBrno);

				if(baseOrgNo == null || baseOrgNo.equals(lastBrno) )
				{
					logger.info("최종 지점 :: "+IDVO.getBaseOrgNo()+ " --> "+lastBrno);

					if(baseOrgNo == null)
					{
						IDVO.setFacOrgNo(lastBrno);
						brnoList.add(IDVO);

					}
					break;
				}
			}
		}

		logger.info("[최종 통폐합된 지점 수] ::: "+brnoList.size());

		if(brnoList.size() > 0)
		{
			for(IndicatorVO t : brnoList)
			{
				logger.info("폐쇄 지점 :: "+t.getBaseOrgNo()+ " --> "+t.getFacOrgNo());

				if(!t.getBaseOrgNo().equals(t.getFacOrgNo()))
				{
					dao.insert("indicator.insertExpsExtrT", t);
				}

				dao.delete("indicator.deleteEXpsExtrTOrg", t);
				dao.delete("indicator.deleteEXpsExtrTFac", t);
			}

			//temp -> 통합된 지표추출관리 등록
			dao.insert("indicator.insertExtrM",paramVO);
			//temp 최종결과 삭제
			dao.delete("indicator.deleteExpsExtrT",paramVO);
		}

		//노출위험 산출 TEMP 1 -1년 합계
		dao.insert("final.insertFinalExpsExtrT1",paramVO);

		//노출지표 1년 합계 -노출위험 최종결과
		dao.insert("final.insertFinalLstI",paramVO);

		//노출 스코어
		dao.insert("indicator.insertIndicatorScor",paramVO);


		//사업지표 1년 합계 -사업위험 지표추출관리
		dao.insert("final.insertFinaBzrskExtrM",paramVO);


		/**
		 * 지점 통폐합
		 * 스코어 산출전 병합
		 */
		//통폐합된 지점 목록
		List<IndicatorVO> bizList = dao.selectList("indicator.selectBzrskBrnoList", paramVO);
		List<IndicatorVO> bizBrnoList = new ArrayList<IndicatorVO>(); //최종 통폐합 지점목록

		for(IndicatorVO IDVO :bizList)
		{
			String baseOrgNo = IDVO.getBaseOrgNo();
			String lastBrno = IDVO.getBaseOrgNo();
			while(true)
			{
				lastBrno = baseOrgNo;
				baseOrgNo = dao.selectOne("indicator.selectBrno", baseOrgNo);
				//System.out.println("[baseOrgNo] ::: "+baseOrgNo+ "[lastBrno] ::: "+lastBrno);

				if(baseOrgNo == null || baseOrgNo.equals(lastBrno) )
				{
					logger.info("최종 지점 :: "+IDVO.getBaseOrgNo()+ " --> "+lastBrno);

					if(baseOrgNo == null)
					{
						IDVO.setFacOrgNo(lastBrno);
						bizBrnoList.add(IDVO);

					}
					break;
				}
			}
		}

		logger.info("[사업지표 통폐합된 지점 수] ::: "+bizBrnoList.size());


		if(bizBrnoList.size() > 0)
		{
			for(IndicatorVO t : bizBrnoList)
			{
				logger.info("폐쇄 지점 :: "+t.getBaseOrgNo()+ " --> "+t.getFacOrgNo());

				//폐쇄지점과 통합지점이 다를경우에만
				//즉, 폐쇄지점이고 이관지점이 존재하지 않다면 평가하지 않는다.
				if(!t.getBaseOrgNo().equals(t.getFacOrgNo()))
				{
					dao.insert("indicator.insertBzrskExtrT", t);
				}

				dao.delete("indicator.deleteBzrskExtrmOrg", t);
				dao.delete("indicator.deleteBzrskExtrmFac", t);
			}


			//temp -> 통합된 사업지표추출관리 등록
			dao.insert("indicator.insertBzrskExtrM",paramVO);
			//temp 삭제
			dao.delete("indicator.deleteBzrskExtrT",paramVO);
		}


		//사업위험 산출1 등록
		dao.insert("indicator.insertIndicatorBizTemp1",paramVO);

		//사업위험 산출2 등록
		dao.insert("indicator.insertIndicatorBizTemp2",paramVO);

		//사업위험 최종결과 등록
		dao.insert("indicator.insertIndicatorBizLst",paramVO);

		//ML/TF 위험산출 SCOR 등록
		dao.insert("indicator.insertMltfScor",paramVO);


		//통제효과성 산출TEMP2 평균 등록
		dao.insert("final.insertFinalTjeffExtrT2",paramVO);


		//통제효과성 최종결과 평균 등록
		dao.insert("final.insertFinalTjeffExtrLstI",paramVO);

		//잔여위험 서비스별
		dao.insert("mltf.insertRemdrRsk",paramVO);

		//잔여위험 지점별
		dao.insert("mltf.insertRemdrBrno",paramVO);

		//최종등급
		dao.insert("mltf.insertMltfLst",paramVO);

		//6.1. 전사 위험평가 결과 보고서 작성 실제종료일 업데이트
		dao.update("schd.updateFinalRealDt",paramVO);

	}


}
