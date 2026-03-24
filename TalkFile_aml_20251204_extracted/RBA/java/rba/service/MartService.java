package com.gtone.rba.service;

import java.util.List;
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
import com.gtone.rba.domain.MartVO;
import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.domain.SchdVO.ING_STEP;

@Service("MartService")
public class MartService {

    private static final Logger logger = LoggerFactory.getLogger("MartBatchMain");

    @Resource(name="DefaultDAO")
    private DefaultDAO dao;



    private static SqlSession session;



/*--------------------------------------------------------------------*/
    public void setNICDAILY(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            String strValue1 = session.selectOne("mart.mart_day_check", paramVO);
            if ("1".equals(strValue1))
            {
            
            }
            else 
            {
            	logger.info("입력하신 날자가 영업일이 아닙니다.");
                logger.info("영업일자를 확인후 다시 수행해 주세요.");
                return;
            }

            int check_cnk = 0;
            while (check_cnk < 18 )
            {
            	String strValue = session.selectOne("mart.mart_start_check", paramVO);
                if ("1".equals(strValue))
                {
                	break;
                }
                else
                {
                	check_cnk++ ;
                	logger.info("아직 DW 데이터 적재작업이 완료되지 않아 대기중입니다.");
                	logger.info(check_cnk + " 회 재시도 중... 10분만 기다려 주세요.");
                	Thread.sleep(10 * 60 * 1000);
                }
            }
            if (check_cnk == 18) 
            {
            	return;
            }

                      
            session.insert("mart.insetStartlog", paramVO);
            session.commit();

            logger.info("\n\n");
            
            logger.info("NIC01B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC01B", paramVO);
            session.commit();
            logger.info("NIC01B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC01B", paramVO);
            session.commit();
            logger.info("NIC01B 작업종료\n");

            
            logger.info("NIC02B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC02B", paramVO);
            session.commit();
            logger.info("NIC02B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC02B", paramVO);
            session.commit();
            logger.info("NIC02B 작업종료\n");

            
            logger.info("NIC03B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC03B", paramVO);
            session.commit();
            logger.info("NIC03B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC03B", paramVO);
            session.commit();
            logger.info("NIC03B 작업종료\n");

            
            logger.info("NIC04B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC04B", paramVO);
            session.commit();
            logger.info("NIC04B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC04B", paramVO);
            session.commit();
            logger.info("NIC04B 작업종료\n");
            

            logger.info("NIC05B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC05B", paramVO);
            session.commit();
            logger.info("NIC05B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC05B", paramVO);
            session.commit();
            logger.info("NIC05B 작업종료\n");
            

            logger.info("NIC17B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertNIC17B1", paramVO);
            session.commit();
            logger.info("NIC17B_1 upsert완료");            
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.updateNIC17B", paramVO);
            session.commit();
            logger.info("NIC17B update(최종거래일자)완료");            
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertNIC17B2", paramVO);
            session.commit();
            logger.info("NIC17B_2 upsert완료");
            logger.info("NIC17B 작업종료\n");

            
            logger.info("NIC18B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC18B", paramVO);
            session.commit();
            logger.info("NIC18B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC18B", paramVO);
            session.commit();
            logger.info("NIC18B 작업종료\n");

            
            logger.info("NIC27B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC27B", paramVO);
            session.commit();
            logger.info("NIC27B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC27B", paramVO);
            session.commit();
            logger.info("NIC27B 작업종료\n");

            
            logger.info("NIC35B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC35B", paramVO);
            session.commit();
            logger.info("NIC35B 작업종료\n");

            
            logger.info("NIC40B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC40B", paramVO);
            session.commit();
            logger.info("NIC40B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC40B", paramVO);
            session.commit();
            logger.info("NIC40B 작업종료\n");

            
            logger.info("NIC41B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC41B", paramVO);
            session.commit();
            logger.info("NIC41B 작업종료\n");
            

            logger.info("NIC45B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC45B", paramVO);
            session.commit();            
            logger.info("NIC45B 작업종료\n");
            

            logger.info("NIC61B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC61B", paramVO);
            session.commit();
            logger.info("NIC61B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC61B", paramVO);
            session.commit();
            logger.info("NIC61B 작업종료\n");
            

            logger.info("NIC32B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC32B", paramVO);
            session.commit();
            logger.info("NIC32B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC32B", paramVO);
            session.commit();
            logger.info("NIC32B 작업종료\n");
            

            logger.info("NIC62B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC62B", paramVO);
            session.commit();
            logger.info("NIC62B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC62B", paramVO);
            session.commit();
            logger.info("NIC62B 작업종료\n");
            

            logger.info("NIC63B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC63B", paramVO);
            session.commit();
            logger.info("NIC63B 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC63B", paramVO);
            session.commit();
            logger.info("NIC63B 작업종료\n");
            

            //logger.info("C_USER 작업시작");
            //session.insert("mart.enableParallelDML", paramVO);
            //session.insert("mart.upsertC_USER", paramVO);
            //session.commit();
            //logger.info("C_USER 작업종료\n");
            
            logger.info("C_USER 작업 SKIP (IAM에서 처리)");
            

            logger.info("C_USER_DETAIL 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertC_USER_DETAIL", paramVO);
            session.commit();
            logger.info("C_USER_DETAIL 작업종료\n");
            
            logger.info("C_USER_GROUP_ROLE 작업 SKIP (IAM에서 처리)");

            //logger.info("C_USER_GROUP_ROLE 작업시작");
            //session.insert("mart.enableParallelDML", paramVO);
            //session.delete("mart.deleteC_USER_GROUP_ROLE", paramVO);
            //session.commit();
            //logger.info("C_USER_GROUP_ROLE 삭제완료");
            //session.insert("mart.enableParallelDML", paramVO);
            //session.insert("mart.insertC_USER_GROUP_ROLE", paramVO);
            //session.commit();
            //logger.info("C_USER_GROUP_ROLE 작업종료\n");
            

            logger.info("C_DEP_INFO 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteC_DEP_INFO", paramVO);
            session.commit();
            logger.info("C_DEP_INFO 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertC_DEP_INFO", paramVO);
            session.commit();
            logger.info("C_DEP_INFO 작업종료\n");
            

            logger.info("NIC61B_CTR 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC61B_CTR", paramVO);
            session.commit();
            logger.info("NIC61B_CTR 삭제완료");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC61B_CTR", paramVO);
            session.commit();
            logger.info("NIC61B_CTR 작업종료\n");
            

            logger.info("NIC92B_M008 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC92B_M008", paramVO);
            session.commit();
            logger.info("NIC92B_M008 작업종료\n");
            

            logger.info("NIC95B_M044 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC95B_M044", paramVO);
            session.commit();
            logger.info("NIC95B_M044 작업종료\n");
            

            logger.info("NIC81B_1 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC81B_1", paramVO);
            session.commit();
            logger.info("NIC81B_1 작업종료\n");
            
            
            logger.info("NIC45B 작업시작");
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC45B", paramVO);
            session.commit();
            logger.info("NIC45B 작업종료\n");

            session.insert("mart.insetEndlog", paramVO);
            session.commit();


        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }






    public void setNIC01B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC01B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC01B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC02B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC02B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC02B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC03B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC03B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC03B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC04B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC04B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC04B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC05B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC05B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC05B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC17B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertNIC17B1", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.updateNIC17B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertNIC17B2", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC18B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC18B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC18B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC27B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC27B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC27B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC32B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC32B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC32B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC35B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC35B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC40B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC40B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC40B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC41B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
          //session.delete("mart.deleteNIC41B", paramVO);
            session.insert("mart.insertNIC41B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC45B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC45B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC61B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();            
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC61B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC61B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC61B_CTR(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC61B_CTR", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC61B_CTR", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC62B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC62B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC62B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setNIC63B(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteNIC63B", paramVO);
            session.commit();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC63B", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setC_USER(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertC_USER", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setC_USER_DETAIL(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.upsertC_USER_DETAIL", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setC_USER_GROUP_ROLE(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteC_USER_GROUP_ROLE", paramVO);
            session.insert("mart.insertC_USER_GROUP_ROLE", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void setC_DEP_INFO(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.delete("mart.deleteC_DEP_INFO", paramVO);
            session.insert("mart.insertC_DEP_INFO", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }


    public void setNIC92B_M008(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC92B_M008", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void NIC95B_M044(MartVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            session.insert("mart.enableParallelDML", paramVO);
            session.insert("mart.insertNIC95B_M044", paramVO);
            session.commit();

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    public void NIC81B_1(MartVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		session.insert("mart.enableParallelDML", paramVO);
    		session.insert("mart.insertNIC81B_1", paramVO);
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