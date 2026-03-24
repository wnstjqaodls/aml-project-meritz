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
import com.gtone.rba.domain.CddVO;

@Service("CddService")
public class CddService {

    private static final Logger logger = LoggerFactory.getLogger("CddBatchMain");

    @Resource(name="DefaultDAO")
    private DefaultDAO dao;



    private static SqlSession session;

 
    public void setCdd_ALL(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            
            session.insert("cdd.insetStartlog", paramVO);
            session.commit();
            
            
            
            session.delete("cdd.delete_CDD_101", paramVO);
            session.insert("cdd.insert_CDD_101", paramVO);
            session.commit();
            logger.info("CDD_101 작업종료");

            session.delete("cdd.delete_CDD_102", paramVO);
            session.insert("cdd.insert_CDD_102", paramVO);
            session.commit();
            logger.info("CDD_102 작업종료");

            session.delete("cdd.delete_CDD_103", paramVO);
            session.insert("cdd.insert_CDD_103", paramVO);
            session.commit();
            logger.info("CDD_103 작업종료");

            session.delete("cdd.delete_CDD_104", paramVO);
            session.insert("cdd.insert_CDD_104", paramVO);
            session.commit();
            logger.info("CDD_104 작업종료");

            session.delete("cdd.delete_CDD_105", paramVO);
            session.insert("cdd.insert_CDD_105", paramVO);
            session.commit();
            logger.info("CDD_105 작업종료");

            session.delete("cdd.delete_CDD_106", paramVO);
            session.insert("cdd.insert_CDD_106", paramVO);
            session.commit();
            logger.info("CDD_106 작업종료");

            session.delete("cdd.delete_CDD_107", paramVO);
            session.insert("cdd.insert_CDD_107", paramVO);
            session.commit();
            logger.info("CDD_107 작업종료");

            session.delete("cdd.delete_CDD_108", paramVO);
            session.insert("cdd.insert_CDD_108", paramVO);
            session.commit();
            logger.info("CDD_108 작업종료");

            session.delete("cdd.delete_CDD_109", paramVO);
            session.insert("cdd.insert_CDD_109", paramVO);
            session.commit();
            logger.info("CDD_108 작업종료");

            session.delete("cdd.delete_CDD_110", paramVO);
            session.insert("cdd.insert_CDD_110", paramVO);
            session.commit();
            logger.info("CDD_110 작업종료");

            session.delete("cdd.delete_CDD_111", paramVO);
            session.insert("cdd.insert_CDD_111", paramVO);
            session.commit();
            logger.info("CDD_111 작업종료");

            session.delete("cdd.delete_CDD_112", paramVO);
            session.insert("cdd.insert_CDD_112", paramVO);
            session.commit();
            logger.info("CDD_112 작업종료");

            session.delete("cdd.delete_CDD_113", paramVO);
            session.insert("cdd.insert_CDD_113", paramVO);
            session.commit();
            logger.info("CDD_113 작업종료");

            session.delete("cdd.delete_CDD_114", paramVO);
            session.insert("cdd.insert_CDD_114", paramVO);
            session.commit();
            logger.info("CDD_114 작업종료");

            session.delete("cdd.delete_CDD_115", paramVO);
            session.insert("cdd.insert_CDD_115", paramVO);
            session.commit();
            logger.info("CDD_115 작업종료");

            session.delete("cdd.delete_CDD_116", paramVO);
            session.insert("cdd.insert_CDD_116", paramVO);
            session.commit();
            logger.info("CDD_116 작업종료");

            session.delete("cdd.delete_CDD_117", paramVO);
            session.insert("cdd.insert_CDD_117", paramVO);
            session.commit();
            logger.info("CDD_117 작업종료");

            session.delete("cdd.delete_CDD_118", paramVO);
            session.insert("cdd.insert_CDD_118", paramVO);
            session.commit();
            logger.info("CDD_118 작업종료");

            session.delete("cdd.delete_CDD_119", paramVO);
            session.insert("cdd.insert_CDD_119", paramVO);
            session.commit();
            logger.info("CDD_118 작업종료");

            session.delete("cdd.delete_CDD_120", paramVO);
            session.insert("cdd.insert_CDD_120", paramVO);
            session.commit();
            logger.info("CDD_120 작업종료");

            session.delete("cdd.delete_CDD_121", paramVO);
            session.insert("cdd.insert_CDD_121", paramVO);
            session.commit();
            logger.info("CDD_121 작업종료");

            session.delete("cdd.delete_CDD_122", paramVO);
            session.insert("cdd.insert_CDD_122", paramVO);
            session.commit();
            logger.info("CDD_122 작업종료");

            session.delete("cdd.delete_CDD_123", paramVO);
            session.insert("cdd.insert_CDD_123", paramVO);
            session.commit();
            logger.info("CDD_123 작업종료");

            session.delete("cdd.delete_CDD_124", paramVO);
            session.insert("cdd.insert_CDD_124", paramVO);
            session.commit();
            logger.info("CDD_124 작업종료");

            session.delete("cdd.delete_CDD_125", paramVO);
            session.insert("cdd.insert_CDD_125", paramVO);
            session.commit();
            logger.info("CDD_125 작업종료");

            session.delete("cdd.delete_CDD_126", paramVO);
            session.insert("cdd.insert_CDD_126", paramVO);
            session.commit();
            logger.info("CDD_126 작업종료");

            session.delete("cdd.delete_CDD_127", paramVO);
            session.insert("cdd.insert_CDD_127", paramVO);
            session.commit();
            logger.info("CDD_127 작업종료");

            session.delete("cdd.delete_CDD_128", paramVO);
            session.insert("cdd.insert_CDD_128", paramVO);
            session.commit();
            logger.info("CDD_128 작업종료");

            session.delete("cdd.delete_CDD_129", paramVO);
            session.insert("cdd.insert_CDD_129", paramVO);
            session.commit();
            logger.info("CDD_128 작업종료");

            session.delete("cdd.delete_CDD_130", paramVO);
            session.insert("cdd.insert_CDD_130", paramVO);
            session.commit();
            logger.info("CDD_130 작업종료");

            session.delete("cdd.delete_CDD_131", paramVO);
            session.insert("cdd.insert_CDD_131", paramVO);
            session.commit();
            logger.info("CDD_131 작업종료");

            session.delete("cdd.delete_CDD_132", paramVO);
            session.insert("cdd.insert_CDD_132", paramVO);
            session.commit();
            logger.info("CDD_132 작업종료");

            session.delete("cdd.delete_CDD_133", paramVO);
            session.insert("cdd.insert_CDD_133", paramVO);
            session.commit();
            logger.info("CDD_133 작업종료");

            session.delete("cdd.delete_CDD_134", paramVO);
            session.insert("cdd.insert_CDD_134", paramVO);
            session.commit();
            logger.info("CDD_134 작업종료");

            session.delete("cdd.delete_CDD_135", paramVO);
            session.insert("cdd.insert_CDD_135", paramVO);
            session.commit();
            logger.info("CDD_135 작업종료");
            
            session.delete("cdd.delete_CDD_136", paramVO);
            session.insert("cdd.insert_CDD_136", paramVO);
            session.commit();
            logger.info("CDD_136 작업종료");
            
            session.delete("cdd.delete_CDD_137", paramVO);
            session.insert("cdd.insert_CDD_137", paramVO);
            session.commit();
            logger.info("CDD_137 작업종료");
            
            session.delete("cdd.delete_CDD_138", paramVO);
            session.insert("cdd.insert_CDD_138", paramVO);
            session.commit();
            logger.info("CDD_138 작업종료");
            
            session.delete("cdd.delete_CDD_140", paramVO);
            session.insert("cdd.insert_CDD_140", paramVO);
            session.commit();
            logger.info("CDD_140 작업종료");
            
            session.delete("cdd.delete_CDD_190", paramVO);
            session.insert("cdd.insert_CDD_190", paramVO);
            session.commit();
            logger.info("CDD_190 작업종료");
            
            
            
            
            
          
            session.delete("cdd.delete_CDD_201", paramVO);
            session.insert("cdd.insert_CDD_201", paramVO);
            session.commit();
            logger.info("CDD_201 작업종료");

            session.delete("cdd.delete_CDD_202", paramVO);
            session.insert("cdd.insert_CDD_202", paramVO);
            session.commit();
            logger.info("CDD_202 작업종료");
            
            session.delete("cdd.delete_CDD_203", paramVO);
            session.insert("cdd.insert_CDD_203", paramVO);
            session.commit();
            logger.info("CDD_203 작업종료");
                        
            session.delete("cdd.delete_CDD_204", paramVO);
            session.insert("cdd.insert_CDD_204", paramVO);
            session.commit();
            logger.info("CDD_204 작업종료");
            
    		session.delete("cdd.delete_CDD_206", paramVO);
    		session.insert("cdd.insert_CDD_206", paramVO);
    		session.commit();
    		logger.info("CDD_206 작업종료");
    		
    		session.delete("cdd.delete_CDD_207", paramVO);
    		session.insert("cdd.insert_CDD_207", paramVO);
    		session.commit();
    		logger.info("CDD_207 작업종료");
    		
    		session.delete("cdd.delete_CDD_208", paramVO);
    		session.insert("cdd.insert_CDD_208", paramVO);
    		session.commit();
    		logger.info("CDD_208 작업종료");
    		
    		session.delete("cdd.delete_CDD_209", paramVO);
    		session.insert("cdd.insert_CDD_209", paramVO);
    		session.commit();
    		logger.info("CDD_208 작업종료");
    		
    		session.delete("cdd.delete_CDD_210", paramVO);
    		session.insert("cdd.insert_CDD_210", paramVO);
    		session.commit();
    		logger.info("CDD_210 작업종료");

    		session.delete("cdd.delete_CDD_211", paramVO);
    		session.insert("cdd.insert_CDD_211", paramVO);
    		session.commit();
    		logger.info("CDD_211 작업종료");
            
    		session.delete("cdd.delete_CDD_212", paramVO);
    		session.insert("cdd.insert_CDD_212", paramVO);
    		session.commit();
    		logger.info("CDD_212 작업종료");
    		
    		session.delete("cdd.delete_CDD_213", paramVO);
    		session.insert("cdd.insert_CDD_213", paramVO);
    		session.commit();
    		logger.info("CDD_213 작업종료");
    		
    		/* 20241024_CDD_214룰 삭제
    	    session.delete("cdd.delete_CDD_214", paramVO);
    	    session.insert("cdd.insert_CDD_214", paramVO);
    	    session.commit();
    	    logger.info("CDD_214 작업종료");
    	    */  
    	    session.delete("cdd.delete_CDD_215", paramVO);
    	    session.insert("cdd.insert_CDD_215", paramVO);
    	    session.commit();
    	    logger.info("CDD_215 작업종료");
    	    
    	    session.delete("cdd.delete_CDD_216", paramVO);
    	    session.insert("cdd.insert_CDD_216", paramVO);
    	    session.commit();
    	    logger.info("CDD_216 작업종료");    	    
    	    
            session.delete("cdd.delete_CDD_301", paramVO);
            session.insert("cdd.insert_CDD_301", paramVO);
            session.commit();
            logger.info("CDD_301 작업종료");

            session.delete("cdd.delete_CDD_302", paramVO);
            session.insert("cdd.insert_CDD_302", paramVO);
            session.commit();
            logger.info("CDD_302 작업종료");

            session.delete("cdd.delete_CDD_303", paramVO);
            session.insert("cdd.insert_CDD_303", paramVO);
            session.commit();
            logger.info("CDD_303 작업종료");

            session.delete("cdd.delete_CDD_304", paramVO);
            session.insert("cdd.insert_CDD_304", paramVO);
            session.commit();
            logger.info("CDD_304 작업종료");

            session.delete("cdd.delete_CDD_305", paramVO);
            session.insert("cdd.insert_CDD_305", paramVO);
            session.commit();
            logger.info("CDD_305 작업종료");

            session.delete("cdd.delete_CDD_306", paramVO);
            session.insert("cdd.insert_CDD_306", paramVO);
            session.commit();
            logger.info("CDD_306 작업종료");

            session.delete("cdd.delete_CDD_307", paramVO);
            session.insert("cdd.insert_CDD_307", paramVO);
            session.commit();
            logger.info("CDD_307 작업종료");

            session.delete("cdd.delete_CDD_308", paramVO);
            session.insert("cdd.insert_CDD_308", paramVO);
            session.commit();
            logger.info("CDD_308 작업종료");
            
            //session.delete("cdd.delete_CDD_309", paramVO);
            //session.insert("cdd.insert_CDD_309", paramVO);
            //session.commit();
            //logger.info("CDD_309 작업종료");
    		
            session.insert("cdd.insetEndlog", paramVO);
            session.commit();
    		

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }

    
    public void setCdd_Online(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();
            
            session.insert("cdd.insetStartlog", paramVO);
            session.commit();
            
            
            
            session.delete("cdd.delete_CDD_301", paramVO);
            session.insert("cdd.insert_CDD_301", paramVO);
            session.commit();
            logger.info("CDD_301 작업종료");

            session.delete("cdd.delete_CDD_302", paramVO);
            session.insert("cdd.insert_CDD_302", paramVO);
            session.commit();
            logger.info("CDD_302 작업종료");

            session.delete("cdd.delete_CDD_303", paramVO);
            session.insert("cdd.insert_CDD_303", paramVO);
            session.commit();
            logger.info("CDD_303 작업종료");

            session.delete("cdd.delete_CDD_304", paramVO);
            session.insert("cdd.insert_CDD_304", paramVO);
            session.commit();
            logger.info("CDD_304 작업종료");

            session.delete("cdd.delete_CDD_305", paramVO);
            session.insert("cdd.insert_CDD_305", paramVO);
            session.commit();
            logger.info("CDD_305 작업종료");

            session.delete("cdd.delete_CDD_306", paramVO);
            session.insert("cdd.insert_CDD_306", paramVO);
            session.commit();
            logger.info("CDD_306 작업종료");

            session.delete("cdd.delete_CDD_307", paramVO);
            session.insert("cdd.insert_CDD_307", paramVO);
            session.commit();
            logger.info("CDD_307 작업종료");

            session.delete("cdd.delete_CDD_308", paramVO);
            session.insert("cdd.insert_CDD_308", paramVO);
            session.commit();
            logger.info("CDD_308 작업종료");

            session.delete("cdd.delete_CDD_309", paramVO);
            session.insert("cdd.insert_CDD_309", paramVO);
            session.commit();
            logger.info("CDD_309 작업종료");
    		
            session.insert("cdd.insetEndlog", paramVO);
            session.commit();
    		

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }
    
    

    public void setCdd_101(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_101", paramVO);
    		session.insert("cdd.insert_CDD_101", paramVO);
    		session.commit();
    		logger.info("CDD_101 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_102(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_102", paramVO);
    		session.insert("cdd.insert_CDD_102", paramVO);
    		session.commit();
    		logger.info("CDD_102 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_103(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_103", paramVO);
    		session.insert("cdd.insert_CDD_103", paramVO);
    		session.commit();
    		logger.info("CDD_103 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_104(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_104", paramVO);
            session.insert("cdd.insert_CDD_104", paramVO);
            session.commit();
            logger.info("CDD_104 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }


    public void setCdd_105(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_105", paramVO);
            session.insert("cdd.insert_CDD_105", paramVO);
            session.commit();
            logger.info("CDD_105 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }   

    
    public void setCdd_106(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_106", paramVO);
    		session.insert("cdd.insert_CDD_106", paramVO);
    		session.commit();
    		logger.info("CDD_106 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_107(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_107", paramVO);
    		session.insert("cdd.insert_CDD_107", paramVO);
    		session.commit();
    		logger.info("CDD_107 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_108(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_108", paramVO);
    		session.insert("cdd.insert_CDD_108", paramVO);
    		session.commit();
    		logger.info("CDD_108 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_109(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_109", paramVO);
    		session.insert("cdd.insert_CDD_109", paramVO);
    		session.commit();
    		logger.info("CDD_109 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_110(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_110", paramVO);
    		session.insert("cdd.insert_CDD_110", paramVO);
    		session.commit();
    		logger.info("CDD_110 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }


    
    public void setCdd_111(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_111", paramVO);
    		session.insert("cdd.insert_CDD_111", paramVO);
    		session.commit();
    		logger.info("CDD_111 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_112(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_112", paramVO);
    		session.insert("cdd.insert_CDD_112", paramVO);
    		session.commit();
    		logger.info("CDD_112 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_113(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_113", paramVO);
    		session.insert("cdd.insert_CDD_113", paramVO);
    		session.commit();
    		logger.info("CDD_113 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_114(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_114", paramVO);
            session.insert("cdd.insert_CDD_114", paramVO);
            session.commit();
            logger.info("CDD_114 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }


    public void setCdd_115(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_115", paramVO);
            session.insert("cdd.insert_CDD_115", paramVO);
            session.commit();
            logger.info("CDD_115 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }   

    
    public void setCdd_116(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_116", paramVO);
    		session.insert("cdd.insert_CDD_116", paramVO);
    		session.commit();
    		logger.info("CDD_116 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_117(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_117", paramVO);
    		session.insert("cdd.insert_CDD_117", paramVO);
    		session.commit();
    		logger.info("CDD_117 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_118(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_118", paramVO);
    		session.insert("cdd.insert_CDD_118", paramVO);
    		session.commit();
    		logger.info("CDD_118 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_119(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_119", paramVO);
    		session.insert("cdd.insert_CDD_119", paramVO);
    		session.commit();
    		logger.info("CDD_119 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_120(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_120", paramVO);
    		session.insert("cdd.insert_CDD_120", paramVO);
    		session.commit();
    		logger.info("CDD_120 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }


    
    public void setCdd_121(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_121", paramVO);
    		session.insert("cdd.insert_CDD_121", paramVO);
    		session.commit();
    		logger.info("CDD_121 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_122(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_122", paramVO);
    		session.insert("cdd.insert_CDD_122", paramVO);
    		session.commit();
    		logger.info("CDD_122 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_123(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_123", paramVO);
    		session.insert("cdd.insert_CDD_123", paramVO);
    		session.commit();
    		logger.info("CDD_123 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_124(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_124", paramVO);
            session.insert("cdd.insert_CDD_124", paramVO);
            session.commit();
            logger.info("CDD_124 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }


    public void setCdd_125(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_125", paramVO);
            session.insert("cdd.insert_CDD_125", paramVO);
            session.commit();
            logger.info("CDD_125 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }   

    
    public void setCdd_126(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_126", paramVO);
    		session.insert("cdd.insert_CDD_126", paramVO);
    		session.commit();
    		logger.info("CDD_126 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_127(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_127", paramVO);
    		session.insert("cdd.insert_CDD_127", paramVO);
    		session.commit();
    		logger.info("CDD_127 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_128(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_128", paramVO);
    		session.insert("cdd.insert_CDD_128", paramVO);
    		session.commit();
    		logger.info("CDD_128 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_129(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_129", paramVO);
    		session.insert("cdd.insert_CDD_129", paramVO);
    		session.commit();
    		logger.info("CDD_129 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_130(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_130", paramVO);
    		session.insert("cdd.insert_CDD_130", paramVO);
    		session.commit();
    		logger.info("CDD_130 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }


    
    public void setCdd_131(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_131", paramVO);
    		session.insert("cdd.insert_CDD_131", paramVO);
    		session.commit();
    		logger.info("CDD_131 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_132(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_132", paramVO);
    		session.insert("cdd.insert_CDD_132", paramVO);
    		session.commit();
    		logger.info("CDD_132 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_133(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_133", paramVO);
    		session.insert("cdd.insert_CDD_133", paramVO);
    		session.commit();
    		logger.info("CDD_133 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_134(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_134", paramVO);
            session.insert("cdd.insert_CDD_134", paramVO);
            session.commit();
            logger.info("CDD_134 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }


    public void setCdd_135(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_135", paramVO);
            session.insert("cdd.insert_CDD_135", paramVO);
            session.commit();
            logger.info("CDD_135 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }   
    

    public void setCdd_136(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_136", paramVO);
    		session.insert("cdd.insert_CDD_136", paramVO);
    		session.commit();
    		logger.info("CDD_136 작업종료");
    	
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    	  if (session != null) session.close();
    	}
   }
    
    public void setCdd_137(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_137", paramVO);
    		session.insert("cdd.insert_CDD_137", paramVO);
    		session.commit();
    		logger.info("CDD_137 작업종료");
      
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    
    public void setCdd_138(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_138", paramVO);
    		session.insert("cdd.insert_CDD_138", paramVO);
    		session.commit();
    		logger.info("CDD_138 작업종료");
      
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    
    public void setCdd_140(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_140", paramVO);
    		session.insert("cdd.insert_CDD_140", paramVO);
    		session.commit();
    		logger.info("CDD_140 작업종료");
      
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    
    public void setCdd_190(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_190", paramVO);
            session.insert("cdd.insert_CDD_190", paramVO);
            session.commit();
            logger.info("CDD_190 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }   
    
    
    
    
    
    
    
    
    
    
    public void setCdd_201(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_201", paramVO);
    		session.insert("cdd.insert_CDD_201", paramVO);
    		session.commit();
    		logger.info("CDD_201 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_202(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_202", paramVO);
    		session.insert("cdd.insert_CDD_202", paramVO);
    		session.commit();
    		logger.info("CDD_202 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_203(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_203", paramVO);
    		session.insert("cdd.insert_CDD_203", paramVO);
    		session.commit();
    		logger.info("CDD_203 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_204(CddVO paramVO)throws Exception
    {
        try
        {
            session = SqlMapClient.getSqlSession();

            session.delete("cdd.delete_CDD_204", paramVO);
            session.insert("cdd.insert_CDD_204", paramVO);
            session.commit();
            logger.info("CDD_204 작업종료");

        }catch(Exception e){
            e.printStackTrace();
            session.rollback();
            throw e;
        }finally{
            if(session !=null) session.close();
        }
    }
    
    public void setCdd_206(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_206", paramVO);
    		session.insert("cdd.insert_CDD_206", paramVO);
    		session.commit();
    		logger.info("CDD_206 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_207(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_207", paramVO);
    		session.insert("cdd.insert_CDD_207", paramVO);
    		session.commit();
    		logger.info("CDD_207 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_208(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_208", paramVO);
    		session.insert("cdd.insert_CDD_208", paramVO);
    		session.commit();
    		logger.info("CDD_208 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_209(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_209", paramVO);
    		session.insert("cdd.insert_CDD_209", paramVO);
    		session.commit();
    		logger.info("CDD_209 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_210(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_210", paramVO);
    		session.insert("cdd.insert_CDD_210", paramVO);
    		session.commit();
    		logger.info("CDD_210 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_211(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_211", paramVO);
    		session.insert("cdd.insert_CDD_211", paramVO);
    		session.commit();
    		logger.info("CDD_211 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_212(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_212", paramVO);
    		session.insert("cdd.insert_CDD_212", paramVO);
    		session.commit();
    		logger.info("CDD_212 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    
    public void setCdd_213(CddVO paramVO)throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
    		
    		session.delete("cdd.delete_CDD_213", paramVO);
    		session.insert("cdd.insert_CDD_213", paramVO);
    		session.commit();
    		logger.info("CDD_213 작업종료");
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if(session !=null) session.close();
    	}
    }
    

    public void setCdd_214(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_214", paramVO);
    		session.insert("cdd.insert_CDD_214", paramVO);
    		session.commit();
    		logger.info("CDD_214 작업종료");
    	
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    
    public void setCdd_215(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_215", paramVO);
    		session.insert("cdd.insert_CDD_215", paramVO);
    		session.commit();
    		logger.info("CDD_215 작업종료");
    	
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    public void setCdd_216(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_216", paramVO);
    		session.insert("cdd.insert_CDD_216", paramVO);
    		session.commit();
    		logger.info("CDD_216 작업종료");
    	
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    public void setCdd_309(CddVO paramVO) throws Exception
    {
    	try
    	{
    		session = SqlMapClient.getSqlSession();
        
    		session.delete("cdd.delete_CDD_309", paramVO);
    		session.insert("cdd.insert_CDD_309", paramVO);
    		session.commit();
    		logger.info("CDD_309 작업종료");
    	
    	}catch (Exception e){
    		e.printStackTrace();
    		session.rollback();
    		throw e;
    	}finally{
    		if (session != null) session.close();
        }
    }
    
    
}