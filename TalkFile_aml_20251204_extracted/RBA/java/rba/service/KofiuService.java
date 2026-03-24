package com.gtone.rba.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.gtone.rba.common.util.SqlMapClient;
import com.gtone.rba.dao.DefaultDAO;
import com.gtone.rba.domain.KofiuVO;


@Service("KofiuService")
public class KofiuService {
private static final Logger logger = LoggerFactory.getLogger("KofiuBatchMain");
	
	@Resource(name="DefaultDAO")
    private DefaultDAO dao;
	
	private static SqlSession session;

	/**
	 *  STEP0
	 *  보고기준일자 및 배치기준일자 가져오기
	 * @param paramVO
	 * @throws Exception
	 */
	public void excuteStep0(KofiuVO paramVO)throws Exception{
		logger.info("[KoFIU 보고기준일자] RPT_GJDT: "+paramVO.getRptGjdt());
		
		if(paramVO.getBatGjdt()==null){
			HashMap<String, String> map = dao.selectOne("kofiu.fiuSelectBtBasDt",paramVO);
			paramVO.setBatGjdt(map.get("BT_BAS_DT").toString());
			
			

		}
		// 해당일자로 kofiu.xml 에 with 문으로 계산.
		logger.info("[ KoFIU 데이터 기준일자  ] BT_BAS_DT: "+paramVO.getBatGjdt());
		
	}
	
	
	/**
	 *  STEP1
	 *  FIU자동지표 데이터 추출및적재
	 * @param paramVO
	 * @throws Exception
	 */
	public void excuteStep1(KofiuVO paramVO)throws Exception{
		//배치기준일자 존재 시 지표추출 수행
		
		try {
			session = SqlMapClient.getSqlSession();
			if (paramVO.getBatGjdt() != null && paramVO.getBatGjdt().length() == 8) {

				List<HashMap<String, String>> list = dao.selectList("kofiu.fiuSelectAutoCdList", paramVO);
				int cnt = 1;
				for(int i = 0; i < list.size(); i++){
					long startTime = System.currentTimeMillis();
					
					paramVO.setHmCd(list.get(i).get("JIPYO_IDX").toString());
					paramVO.setJ1_S_DT(list.get(i).get("J1_S_DT").toString());
					paramVO.setJ1_E_DT(list.get(i).get("J1_E_DT").toString());
					paramVO.setYYYYMM(list.get(i).get("YYYYMM").toString());
					
					logger.info("[ KoFIU 집계 기준 시작일   ] J1_S_DT  : "+paramVO.getJ1_S_DT());
					logger.info("[ KoFIU 집계 기준 종료일   ] J1_E_DT : "+paramVO.getJ1_E_DT());
					logger.info("[ KoFIU 집계 기준 종료년월 ] YYYYMM : "  +paramVO.getYYYYMM());
					
					logger.info("[START] KoFIU 배치 "+paramVO.getHmCd()+" 해당 지표의 추출이 시작 되었습니다. ");
					session.delete("kofiu.fiuDeleteJrbaRptBasV", paramVO);
					session.commit();
					
					session.insert("kofiu.fiuInsertBatch_"+paramVO.getHmCd(), paramVO);
					session.commit();

					long endTime = System.currentTimeMillis();
					long resutTime = endTime - startTime;
					logger.info("[END] KoFIU 배치 " +paramVO.getHmCd()+" 해당 지표의 추출이 종료 되었습니다. ");
					logger.info("[ENDTIME] " + paramVO.getHmCd() + " 소요시간  ::: " + (resutTime / 1000) + "(s)");
					
					cnt++;	
				}
				
				// 배치종료일자 업데이트
				session.update("kofiu.fiuUpdateJrbaJobEndDt", paramVO);	
				
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

	
}
