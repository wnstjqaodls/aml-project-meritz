package com.gtone.rba.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.gtone.rba.common.util.SqlMapClient;
import com.gtone.rba.dao.DefaultDAO;
import com.gtone.rba.domain.SchdVO;
import com.gtone.rba.domain.KriVO;

import org.apache.ibatis.session.SqlSession;

@Service("KriService")
public class KriService {

	private static final Logger logger = LoggerFactory.getLogger("KriBatchMain");
	
	@Resource(name="DefaultDAO")
    private DefaultDAO dao;
	private static SqlSession session;
	
	
	public void excuteKri(SchdVO paramVO)throws Exception{		
		
		session = SqlMapClient.getSqlSession();
		
		KriVO kVO = new KriVO();
		kVO.setbasLong(paramVO.getbasLong());
		kVO.setBasYymm(paramVO.getBasYymm());
		kVO.setTgtTrnSdt(paramVO.getTgtTrnSdt());
		kVO.setTgtTrnEdt(paramVO.getTgtTrnEdt());
		kVO.setPgtTrnSdt(paramVO.getPgtTrnSdt());
		kVO.setPgtTrnEdt(paramVO.getPgtTrnEdt());
		kVO.setextrBasAmt(paramVO.getextrBasAmt());
		
		kVO.setBasYyyy(paramVO.getBasYymm().substring(0,4)); //년도 셋팅
		kVO.setTgtTrnEdtYymm(paramVO.getTgtTrnEdt().substring(0, 6));
		

		
		
		
		if( paramVO.getbasLong() == "00" ) {
			//국가,직업,고객 기초정보 삭제
			session.delete("standard.deleteNatI", kVO);
			session.delete("standard.deleteJobI", kVO);
			session.delete("standard.deleteCustI", kVO);
			session.delete("standard.deleteNatT", kVO);
			session.delete("standard.deleteCustT", kVO);
			session.commit();

			//국가,고객 지표
			logger.info("국가 standard.insertNatI start:: ");
			session.insert("standard.insertNatI", kVO);
			session.commit();
			
			logger.info("직업 업종 standard.insertJobI start:: ");
			session.insert("standard.insertJobI", kVO);
			session.commit();
			
			//해당년월 거래구간 정보 갱신
			session.delete("standard.deleteEtcI", kVO);
			session.commit();
			session.insert("standard.insertEtcI", kVO); //
			session.commit();
			logger.info("상품 standard.insertEtcI_GOOD start:: ");
			session.insert("standard.insertEtcI_GOOD", kVO);
			
			session.commit();
			
			logger.info("고객 standard.insertCustI start:: ");
			session.insert("standard.insertCustI", kVO);
			session.commit();
			
			logger.info("국가 standard.insertNatT start:: ");
			session.insert("standard.insertNatT", kVO);
			session.commit();
			
			logger.info("고객 standard.insertCustT start:: ");
			session.insert("standard.insertCustT", kVO);
			session.commit();
			
			logger.info("고객 standard.insertCustT_KOFIU start:: ");
			session.insert("standard.insertCustT_KOFIU", kVO); 
			session.commit();
			
			
			
			logger.info("상품 standard.insertCustT_GOOD start:: ");
			session.insert("standard.insertCustT_GOOD", kVO);
			session.commit();
			
			logger.info("채널 standard.insertCustT_Channel start:: ");
			session.insert("standard.insertCustT_Channel", kVO);
			session.commit();
			
			/*   insertCustT_Channel 로 사용함
			 * logger.info("채널 standard.insertCustIbyChannel_CHECK1_YN start:: ");
			 * session.insert("standard.insertCustIbyChannel_CHECK1_YN", kVO);
			 * session.commit();
			 * logger.info("채널 standard.insertCustIbyChannel_CHECK2_YN start:: ");
			 * session.insert("standard.insertCustIbyChannel_CHECK2_YN", kVO);
			 * session.commit();
			 * logger.info("채널 standard.insertCustIbyChannel_CHECK3_YN start:: ");
			 * session.insert("standard.insertCustIbyChannel_CHECK3_YN", kVO);
			 * session.commit();
			 */
			
			
			
			//kri 삭제	
			session.delete("kri.deleteKriD", kVO);
			session.commit();
						
			//기준년월 KRI 등록 [국가]
			session.insert("kri.insertNatKri", kVO);
			session.commit();
			
			//기준년월 KRI 등록 [고객]
			session.insert("kri.insertCustomKri", kVO);
			session.commit();
			
			//기준년월 KRI 등록 [상품]
			logger.info("[거래] kri.insertGoodKri start:: ");
			session.insert("kri.insertGoodKri", kVO);
			session.commit();
			
			//기준년월 KRI 등록 [거래]
			logger.info("[거래] kri.insertTriKri start:: ");
			session.insert("kri.insertTriKri", paramVO);
			session.commit();
			
		} else if ( paramVO.getbasLong() == "01" || paramVO.getbasLong() == "02") {
			
			session.delete("kri.deleteKriD", kVO);
			session.commit();
			
			session.insert("kri.insertNatKri_6M", kVO);
			session.commit();
		} else if ( paramVO.getbasLong() == "91" || paramVO.getbasLong() == "92") {
			
			session.delete("kri.deleteKriD", kVO);
			session.commit();
			
			session.insert("kri.insertNatKri_6M_99999", kVO);
			session.commit();  
		}

	}
}
