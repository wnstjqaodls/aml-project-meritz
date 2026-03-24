package com.gtone.rba.service;

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
import com.gtone.rba.domain.MltfVO;
import com.gtone.rba.domain.SchdVO;


@Service("RbaTrnService")
public class RbaTrnService {

	private static final Logger logger = LoggerFactory.getLogger("RbaTrnBatchMain");

	@Resource(name="DefaultDAO")
    private DefaultDAO dao;

	private static SqlSession session;

	public void excuteTrn(SchdVO paramVO)throws Exception{

		try
		{
			session = SqlMapClient.getSqlSession();

			//기준년월 거래원장 삭제
			//paramVO.setPtrYymm("PTR_"+paramVO.getBasYymm());
			paramVO.setPtrYymm("PTRM"+paramVO.getBasYymm());
			logger.info("PtrYymm"+paramVO.getPtrYymm());
			System.out.println("PtrYymm :::::::::::::::::::::::::::: "+paramVO.getPtrYymm());
			System.out.println("TgtTrnSdt :::::::::::::::::::::::::::: "+paramVO.getTgtTrnSdt());
			System.out.println("TgtTrnEdt :::::::::::::::::::::::::::: "+paramVO.getTgtTrnEdt());
			session.delete("trn.deleteTrnI", paramVO);
			session.commit();
			logger.info("거래원장 삭제 완료");


			//기준년월 계좌상품 거래원장 등록
			session.insert("trn.insertGnlGdsTrnI", paramVO);
			session.commit();
			logger.info("계좌상품 등록 완료");

			//기준년월 금융상품 거래원장 등록
			session.insert("trn.insertFinanceGdsTrnI", paramVO);
			session.commit();
			logger.info("금융상품 등록 완료");

			//기준년월 금융서비스 거래원장 등록
			session.insert("trn.insertFinanceServiceTrnI", paramVO);
			session.commit();
			logger.info("금융서비스 등록 완료");

			/*
			 * session.delete("trn.deleteTrnIBrno", paramVO); session.commit();
			 * logger.info("21070 ,23070 지점 삭제 완료");
			 */

		}
		catch(Exception e)
		{
			e.printStackTrace();
			session.rollback();
			throw e;
		}
		finally
		{
			if(session !=null) session.close();
		}


	}


	/**
	 * 초기적재용
	 * @param paramVO
	 * @throws Exception
	 */
	public void excuteFirstTrn(SchdVO paramVO)throws Exception{

		try
		{
			session = SqlMapClient.getSqlSession();


			//기준년월 계좌상품 거래원장 등록
			session.insert("trn.insertGnlGdsTrnI", paramVO);
			session.commit();
			logger.info("계좌상품 등록 완료");

			//기준년월 금융상품 거래원장 등록
			session.insert("trn.insertFinanceGdsTrnI", paramVO);
			session.commit();
			logger.info("금융상품 등록 완료");

			//기준년월 금융서비스 거래원장 등록
			session.insert("trn.insertFinanceServiceTrnI", paramVO);
			session.commit();
			logger.info("금융서비스 등록 완료");

		}
		catch(Exception e)
		{
			e.printStackTrace();
			session.rollback();
			throw e;
		}
		finally
		{
			if(session !=null) session.close();
		}


	}


	/**
	 * 거래원장 삭제 배치
	 * @throws Exception
	 */
	public void excuteDelDayTrnI()throws Exception
	{
		SchdVO paramVO = new SchdVO();
		dao.insert("trn.deleteDayTrnI",paramVO);

	}
}
