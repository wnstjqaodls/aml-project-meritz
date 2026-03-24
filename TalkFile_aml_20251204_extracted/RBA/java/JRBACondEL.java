/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.basic.jspeed.base.el;

import java.util.HashMap;

import javax.servlet.jsp.PageContext;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.server.common.commonUtil;

import jspeed.base.util.StringHelper;

/******************************************************************************************************************************************
 * @Description 콤보 박스(<select></select> 및 <option></option>) 반환용 EL
 * @Group       GTONE, AML서비스팀
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Java        6.0 이상
 * @Author      이용진
 * @Since       2017. 10. 17.
 ******************************************************************************************************************************************
 * @Modifier    박상훈
 * @Update      2018. 4. 2.
 * @Addendum    1. 암복호화 및 마스킹 예외적용 기능 추가
 *              2. 코드정리
 ******************************************************************************************************************************************/

public class JRBACondEL extends AbsEL
{
    /**************************************************************************************************************************************
     * Constructors
     **************************************************************************************************************************************/

    /** Default constructor */
    public JRBACondEL(){super();}

    /**
     * <code>PageContext</code> 설정.
     * <p>
     * @param   pageContext
     *              <code>PageContext</code>
     */
    public JRBACondEL(PageContext pageContext) { super(pageContext); }

    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/

    public final static String COMMON_COMBO_ALL_CODE = "ALL";



    /**
     * sqlID의 쿼리로 조회 된 내용으로 <select> 및 <option> 엘리먼트를 생성하여 반환.
     * <p>
     * @param   selectID
     *              <select> 엘리먼트의 id 및 name
     * @param   width
     *              가로 px 길이
     * @param   sqlID
     *              쿼리 아이디
     * @param   code
     *              코드(NIC92B.CD)
     * @param   initValue
     *              초기값
     * @param   firstComboWord
     *              첫번째 콤보박스 단어(전체 or 선택 등등...)
     * @param   eventFunction
     *              function onchang
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     *
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    //rptGjdt -> 보고기준일자
    //selectID -> ID
    public String getJRBASelect(
    		  String param1
    		, String selectID
    		, String code
    		, String width
    		, String sqlID
    		, String initValue
    		, String firstComboWord
    		, String eventFunction)
    {
    	String html = "";
        if (this.sessionAML!=null && this.request!=null) {
        	html += "<div class='content'>";
            html += "<select id='"+selectID+"' name='"+selectID+"' groupCode='"+code+"' class='dropdown' "+(eventFunction!=null&&!"".equals(eventFunction.trim())?"onchange='"+eventFunction+"'":" ")+(width!=null&&!"".equals(width.trim())?"style='width:"+width+"'":" ")+">";
            html += getJRBASelectOption(param1 , sqlID, code, initValue, firstComboWord);
            html += "</select>";
            html += "</div>";
        }
        return html;
    }


    public String getSRBASelect(
  		  String param1
  		, String selectID
  		, String code
  		, String width
  		, String sqlID
  		, String initValue
  		, String firstComboWord
  		, String eventFunction)
  {
  	  String html = "";
      if (this.sessionAML!=null && this.request!=null) {
      	html += "<div class='content'>";
          html += "<select id='"+selectID+"' name='"+selectID+"' groupCode='"+code+"' class='dropdown' "+(eventFunction!=null&&!"".equals(eventFunction.trim())?"onchange='"+eventFunction+"'":" ")+(width!=null&&!"".equals(width.trim())?"style='width:"+width+"'":" ")+">";
          html += getSRBASelectOption(param1 , sqlID, code, initValue, firstComboWord);
          html += "</select>";
          html += "</div>";
      }
      return html;
  }


    public String getSRBASelectOption(String param1 ,String sqlID, String code, String initValue, String firstComboWord)
    { return getSRBASelectOption(param1 ,sqlID, code, initValue, firstComboWord, ""); }


    public String getSRBASelectOption(String param1 ,String sqlID, String code, String initValue, String firstComboWordParam, String firstComboVal)
    {
        String html = "";
        if (this.sessionAML!=null && this.request!=null) {
            //String locale = Util.getLangCD(this.request.getLocale().toString());
        	String firstComboWord = firstComboWordParam;
            firstComboWord = getHelperMsg(firstComboWord, firstComboWord);
            if (sqlID!=null) {
                html += setSRBAComboHtml(param1 ,sqlID, code, initValue, firstComboWord, firstComboVal);
            } else if (code!=null) {
                html += commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
            }
        }
        return html;
    }


    @SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
    public static String setSRBAComboHtml(
    		String param1
           ,String sqlID
           ,String CODE_GROUP
           ,String initValue
           ,String firstComboWord
           ,String firstComboVal
  ){

      DataObj output = new DataObj();
      StringBuffer sb = new StringBuffer(256);
      HashMap param = new HashMap();
      try{

          // 초값 설정 여부
          if(firstComboWord!=null && !"".equals(firstComboWord)) {
              sb.append("<option class='dropdown-option' value='");
              sb.append(firstComboVal==null?"ALL":firstComboVal);
              sb.append("' >::");
              sb.append(firstComboWord);
              sb.append("::</option> \n");
          }

          if ("".equals(sqlID)){

	          if(CODE_GROUP!=null && !"".equals(CODE_GROUP)){
		            param.put("GRP_C", CODE_GROUP);
		            param.put("HGRK_GRP_C", param1);
		            output = MDaoUtilSingle.getData("RBA_common_getComboData_SRBA_DTL_C", param);
	          }

          }else if(!"".equals(sqlID)){
        	   param.put("GRP_C", CODE_GROUP);
        	   output = MDaoUtilSingle.getData(sqlID, param);
          }

          String CODE = "";
          String NAME = "";

          if(output.getCount("CD") > 0){

              for(int i=0; i<output.getCount("CD"); i++){
                  CODE = StringHelper.trim(StringHelper.nvl(output.getText("CD",i), ""));
                  NAME = StringHelper.nvl(output.getText("CD_NM",i), "");

                  sb.append("<option class='dropdown-option' value='");
                  sb.append(CODE);
                  sb.append("' ");
                  sb.append(initValue.equals(CODE) ? "selected":"");
                  sb.append('>');
                  sb.append(NAME);
                  sb.append("</option> \n");

              }
          }

          return sb.toString();

      }catch(AMLException e){
          Log.logAML(
                  Log.ERROR
                 , new commonUtil()
                 ,"setJRBAComboHtml"
                 ,e.getMessage()
         );
         return sb.toString();
     }catch(Exception e){
          Log.logAML(
                   Log.ERROR
                  , new commonUtil()
                  ,"setJRBAComboHtml"
                  ,e.getMessage()
          );
          return sb.toString();
      }
  }


    /**
     * sqlID의 쿼리로 조회 된 내용을 <option/> 태그로 변환하여 반환.
     * <p>
     * @param   sqlID
     *              쿼리 아이디
     *              아래의 code를 사용할 경우, sqlID는 "" 여야 한다
     * @param   code
     *              코드(NIC92B.CD)
     * @param   initValue
     *              초기값
     * @param   firstComboWord
     *              첫번째 콤보박스 단어(전체 or 선택 등등...)
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getJRBASelectOption(String rptGjdt ,String sqlID, String code, String initValue, String firstComboWord)
    { return getJRBASelectOption(rptGjdt ,sqlID, code, initValue, firstComboWord, ""); }


    /**
     * sqlID의 쿼리로 조회 된 내용을 <select/> 태그의 <option/> 태그로 변환하여 반환.
     * <p>
     * @param   sqlID
     *              쿼리 아이디
     *              아래의 code를 사용할 경우, sqlID는 "" 여야 한다
     * @param   code
     *              코드(NIC92B.CD)
     * @param   initValue
     *              초기값
     * @param   firstComboWord
     *              첫번째 콤보박스 단어(전체 or 선택 등등...)
     * @param   firstComboVal
     *              첫번째 콤보박스 값
     * @param   mapGroupCode
     *              mapGroupCode
     * @param   mapCode
     *              mapCode
     * @return  <code>String</code>
     *              <select><option/>...</select> 태그 html
     * @return  defaultSelct
     *              쿼리 Where절 해당 컬럼 XXX 초기셋팅
     */
    public String getJRBASelectOption(String rptGjdt ,String sqlID, String code, String initValue, String firstComboWordParam, String firstComboVal)
    {
        String html = "";
        if (this.sessionAML!=null && this.request!=null) {
            //String locale = Util.getLangCD(this.request.getLocale().toString());
        	String firstComboWord = firstComboWordParam;
            firstComboWord = getHelperMsg(firstComboWord, firstComboWord);
            if (sqlID!=null) {
                html += setJRBAComboHtml(rptGjdt ,sqlID, code, initValue, firstComboWord, firstComboVal);
            } else if (code!=null) {
                html += commonUtil.setComboHtmlJspeed(sqlID, code, initValue, firstComboWord, firstComboVal);
            }
        }
        return html;
    }


    @SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
    public static String setJRBAComboHtml(
    		String rptGjdt
           ,String sqlID
           ,String CODE_GROUP
           ,String initValue
           ,String firstComboWord
           ,String firstComboVal
  ){

      DataObj output = new DataObj();
      StringBuffer sb = new StringBuffer(256);
      HashMap param = new HashMap();
      try{

          // 초값 설정 여부
          if(firstComboWord!=null && !"".equals(firstComboWord)) {
              sb.append("<option class='dropdown-option' value='");
              sb.append(firstComboVal==null?"ALL":firstComboVal);
              sb.append("' >::");
              sb.append(firstComboWord);
              sb.append("::</option> \n");
          }

          if ("".equals(sqlID)){

	          if((CODE_GROUP!=null && !"".equals(CODE_GROUP))&& (rptGjdt!=null && !"".equals(rptGjdt))){
		            param.put("GRP_CD", CODE_GROUP);
		            param.put("RPT_GJDT", rptGjdt);
		            output = MDaoUtilSingle.getData("RBA_common_getComboData_JRBA_DTL_C", param);
	          }

          }else if(!"".equals(sqlID)){
        	   output = MDaoUtilSingle.getData(sqlID, param);
          }

          String CODE = "";
          String NAME = "";

          if(output.getCount("CD") > 0){

              for(int i=0; i<output.getCount("CD"); i++){
                  CODE = StringHelper.trim(StringHelper.nvl(output.getText("CD",i), ""));
                  NAME = StringHelper.nvl(output.getText("CD_NM",i), "");

                  sb.append("<option class='dropdown-option' value='");
                  sb.append(CODE);
                  sb.append("' ");
                  sb.append(initValue.equals(CODE) ? "selected":"");
                  sb.append('>');
                  sb.append(NAME);
                  sb.append("</option> \n");

              }
          }

          return sb.toString();

      }catch(AMLException e){
          Log.logAML(
                  Log.ERROR
                 , new commonUtil()
                 ,"setJRBAComboHtml"
                 ,e.getMessage()
         );
         return sb.toString();
     }catch(Exception e){
          Log.logAML(
                   Log.ERROR
                  , new commonUtil()
                  ,"setJRBAComboHtml"
                  ,e.getMessage()
          );
          return sb.toString();
      }
  }

    // [ setup ]

    /**
     * EL로 사용할 수 있도록 셋업.
     * <P>
     * @param   pageContext
     *              <code>PageContext</code>
     */
    public static void setup(PageContext pageContext) { setup("JRBACondEL", pageContext, JRBACondEL.class); }
}
