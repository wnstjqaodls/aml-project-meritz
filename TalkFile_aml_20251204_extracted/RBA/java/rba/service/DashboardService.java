package com.gtone.rba.service;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.gtone.rba.common.util.SqlMapClient;
import com.gtone.rba.dao.DefaultDAO;
import com.gtone.rba.domain.DashboardVO;

/*삼성증권 KRBA_BATCH > DashboardService.java */

@Service("DashboardService")
public class DashboardService {

	private static final Logger logger = LoggerFactory.getLogger("DashboardBatchMain");
	
	@Resource(name="DefaultDAO")
    private DefaultDAO dao;
	
	
	
	private static SqlSession session;  

	/*--------------------------------------------------------------------*/	
	public void setDashboardDAILY(DashboardVO paramVO)throws Exception
	{
		try
		{ 
			session = SqlMapClient.getSqlSession();                  

			session.insert("dashboard.mergeInsertKYC", paramVO);			
			session.commit();
			logger.info("DashBoard KYC DATA 작업종료");   
			
			dao.insert("dashboard.mergeInsertCDD", paramVO);		
			session.commit();
			logger.info("DashBoard CDD DATA 작업종료");
			
			session.insert("dashboard.mergeInsertCDD_R", paramVO);			
			session.commit();
			logger.info("DashBoard CDD 재이행 도래 DATA 작업종료");
			
			session.delete("dashboard.deleteCTR", paramVO);
			session.insert("dashboard.insertCTR", paramVO);			
			session.commit();
			logger.info("DashBoard CTR DATA 작업종료");
			
			session.delete("dashboard.deleteSTR", paramVO);
			//2025.09.22 merge로 변경
			paramVO.setYyyy(paramVO.getYyyymm().substring(0,4));
			session.insert("dashboard.insertSTR", paramVO);			
			session.commit();
			logger.info("DashBoard STR DATA 작업종료");
			 
			
		}catch(Exception e){
			e.printStackTrace();			
			/*
			 * session.rollback(); if(session !=null) session.close();
			 */	
			throw e;
		}finally{
			/* if(session !=null) session.close(); */
		}
	}

	/*--위험등급별고객현황-------------------------------------------------*/
	public void setDashboardKYC(DashboardVO paramVO) throws Exception
	{
		try
		{
			session = SqlMapClient.getSqlSession();			
			
			session.insert("dashboard.mergeInsertKYC", paramVO);			
			session.commit();
		
		}catch(Exception e){
			e.printStackTrace();			
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();			
		}
	}

	/*--월별고객확인(CDD)현황----------------------------------------------*/
	public void setDashboardCDD(DashboardVO paramVO) throws Exception
	{
		try
		{
			session = SqlMapClient.getSqlSession();			
			
			session.insert("dashboard.mergeInsertCDD", paramVO);			
			session.commit();
		
		}catch(Exception e){
			e.printStackTrace();			
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();			
		}
	}

	/*--CDD 재이행 도래자료------------------------------------------------*/
	public void setDashboardCDD_R(DashboardVO paramVO) throws Exception
	{
		try
		{
			session = SqlMapClient.getSqlSession();			
			
			session.insert("dashboard.mergeInsertCDD_R", paramVO);			
			session.commit();
		
		}catch(Exception e){
			e.printStackTrace();			
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();			
		}
	}
	
	/*--------------------------------------------------------------------*/	
	public void setDashboardCTR(DashboardVO paramVO) throws Exception
	{
		try
		{
			session = SqlMapClient.getSqlSession();			
			
			session.delete("dashboard.deleteCTR", paramVO);
			session.insert("dashboard.insertCTR", paramVO);			
			session.commit();
		
		}catch(Exception e){
			e.printStackTrace();			
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();			
		}
	}

	/*--------------------------------------------------------------------*/	
	public void setDashboardSTR(DashboardVO paramVO)throws Exception
	{
		try
		{
			session = SqlMapClient.getSqlSession();			
			
			session.delete("dashboard.deleteSTR", paramVO);
			session.insert("dashboard.insertSTR", paramVO);			
			session.commit();
		
		}catch(Exception e){
			e.printStackTrace();			
			session.rollback();
			throw e;
		}finally{
			if(session !=null) session.close();			
		}
	}
}