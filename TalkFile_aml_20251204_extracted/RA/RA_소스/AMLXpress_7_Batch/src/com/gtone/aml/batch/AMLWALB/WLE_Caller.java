package com.gtone.aml.batch.AMLWALB;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.batch.common.Config;
import com.gtone.wlf.core.common.WLFConstant;
import com.gtone.wlf.core.data.SData;
import com.gtone.wlf.core.search.LuceneFactivaSearch;

/**
 * 
*<pre>
* 필터링을 실행하는 class
* フィルタリングを実行するクラス
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class WLE_Caller {
  	//private final String localIndexPath = Config.getInstance().getProperty("WATCHLIST_INDEX_DIR") + Config.getInstance().getProperty("LOCALIDXPATH");
  	private final String stopWords = Util.nvl(Config.getInstance().getProperty("WACTHLIST_STOPWORDS"),"");
  	public static LuceneFactivaSearch wlfSearch = null;
  	//public static LuceneFactivaSearch wlfLocalSearch = null;
  	private boolean chkIndexPath = false;

    /**
     *<pre>
     * 필터링을 실행한다.
     * フィルタリングを実行する。
     * @en
     *</pre>
     *@param conn
     *@param parms 필터링에 필요한 변수들
     *              フィルタリングに必要な変数
     *              @en
     *@return    filtering result object
     *@throws Exception
     */
	List<SData> resultList;

    public WLE_IO_Object execute(java.sql.Connection conn, String[] parms, String SDWL, String wc_grp_list_ccd, String indexPath, String MAXROW) throws Exception {
        WLE_IO_Object obj = new WLE_IO_Object();
        obj.getInputData().setParm(parms);

        String searchField = "CS_NM";
        DataObj searchConditions = new DataObj();

        String krgubun  =  obj.getInputData().getNTN_CD();
        String percode  =  obj.getInputData().getWL_RELATED_PER_CODE();
        
        String INDEX_FIELD = Config.getInstance().getProperty("INDEX_FIELD", "NOT");
        
        indexPath = indexPath + "/" + Config.getInstance().getProperty("FULLIDXPATH");
        
        if("KR".equals(krgubun)) {
        	if(!"1".equals(percode)) {
        		INDEX_FIELD = "NOT";
        	}
        }else if(!"KR".equals(krgubun)) {
        	INDEX_FIELD = "NOT";
        }
        
        //if ("INDV_CORP_CCD".contains(INDEX_FIELD) && isNotNull(obj.getInputData().getINDV_CORP_CCD())) {
        //    searchConditions.put(WLFConstant.SF_INDV_CORP_CCD, obj.getInputData().getINDV_CORP_CCD());
        //}
        
        if (INDEX_FIELD.contains("NTN_CD") && isNotNull(obj.getInputData().getNTN_CD())) {
        	searchConditions.put(WLFConstant.SF_NTN_CD, obj.getInputData().getNTN_CD());
        }
        
        if (INDEX_FIELD.contains("DOB") && isNotNull(obj.getInputData().getDOB())) {
        	searchConditions.put(WLFConstant.SF_DOB, obj.getInputData().getDOB());
        }
        
        //if ("SEX".contains(INDEX_FIELD) && isNotNull(obj.getInputData().getSEX_CD())) {
        //	searchConditions.put(WLFConstant.SF_SEX, obj.getInputData().getSEX_CD());
        //}

        int sdwl = Integer.parseInt(WALB_Main.SDWL);
        int maxRow = Integer.parseInt(MAXROW);

        
        //System.out.println("searchConditions : " + searchConditions);
        //System.out.println("indexPath : " + indexPath);
            try {

            	search2( wc_grp_list_ccd
            			,searchField
            			,obj.getInputData().getCS_NM()
            			,searchConditions
            			,sdwl
            			,maxRow
            			,indexPath);
            }
            catch(Exception e) {
                throw e;
            }

            try {
                obj.getOutputData().setWLE_Output_Rec(resultList);
            }catch(Exception e) {
                throw e;
            }


        return obj;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void search2(String searchGrpCd, String searchField, String searchKeyword, DataObj searchConditions, int ii_score, int ii_maxRows, String indexPath) throws Exception {
    	List<SData>results = null;
    	List<SData>localResults = null;
    	
    	try {
    			if (!chkIndexPath ) {
    				String[] chkPath = {indexPath}; //, localIndexPath 
    				for (String path : chkPath ) {
    					File file = new File(path);
    					
    					
    					if( ! file.isDirectory()) {
    						throw new Exception ("Invalid Index dir");
    					}
    				}
    			}

    			if(wlfSearch == null ){

    					wlfSearch = new LuceneFactivaSearch(indexPath, "RN", "KR");
    					//wlfSearch = new LuceneFactivaSearch(indexPath);
    					System.out.println("wlfSearch : " + wlfSearch);
    					//wlfSearch = new LuceneFactivaSearch(indexPath);	
    				
    				
    				HashMap<String,Object> searchConfig = new HashMap<>();
					searchConfig.put("SEARCH_LUCENE_COUNT", 300); // 인덱스 탐색 건수

					wlfSearch.setConfig(searchConfig);
    				wlfSearch.setdefaultStopWords(stopWords);
    			}
				results = wlfSearch.search(searchGrpCd, searchField, searchKeyword, searchConditions, ii_score, ii_maxRows);

				//locallist
				//if(wlfLocalSearch == null) {
					
					//if("KR".equals(krgubun)) {
						//wlfLocalSearch = new LuceneFactivaSearch(localIndexPath, "RN", "KR");
						
						//System.out.println("wlfLocalSearch : " + wlfLocalSearch);
						
					//}else {
						//wlfLocalSearch = new LuceneFactivaSearch(localIndexPath);
					//}
					 
					//HashMap<String,Object> searchConfig = new HashMap<>();
					//searchConfig.put("SEARCH_LUCENE_COUNT", 300); // 인덱스 탐색 건수

					//wlfLocalSearch.setConfig(searchConfig);
					//wlfLocalSearch.setdefaultStopWords(stopWords);
				//}
				//localResults = wlfLocalSearch.search(searchGrpCd, searchField, searchKeyword, searchConditions, ii_score, ii_maxRows);


				//if(localResults!=null && localResults.size()>0) {
					//results.addAll(localResults);
                    //Collections.sort(results, Collections.reverseOrder());
				//}

			    if (results.size() > 0 ) {

			    	resultList = results;
			    }
    	} catch (Exception e) {
    		throw e;
    	}

	}
    
    private Boolean isNotNull(String val) {
    	boolean isNotNull = true;
        if ("".equals(val)) {
        	isNotNull = false;
        }

        return isNotNull;
    }


}