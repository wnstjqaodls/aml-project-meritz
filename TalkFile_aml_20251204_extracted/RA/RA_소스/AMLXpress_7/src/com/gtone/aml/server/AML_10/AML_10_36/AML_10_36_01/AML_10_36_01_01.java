/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.server.AML_10.AML_10_36.AML_10_36_01;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.server.AML_10.AML_10_03.AML_10_03_01.AML_10_03_01_01;
import com.gtone.aml.user.SessionAML;
import com.gtone.aml.watchlist.WatchListHelper;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.DateHelper;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description 위험평가항목관리
 *              共通コード管理
 *              Common Code Mgt.
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Since       2024. 8. 16.
 ******************************************************************************************************************************************
	/** 인스턴스 */
public class AML_10_36_01_01 extends GetResultObject {
	private static AML_10_36_01_01 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_36_01_01
	 */
	public static AML_10_36_01_01 getInstance() {
		return instance == null ? (instance = new AML_10_36_01_01()) : instance;
	}

	/**위험오소관리 탭 검색*/
	public DataObj getSearchMaster(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_36_01_01_doSearch", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("RA_ITEM_CD") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**위험요소관리 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchDetail(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			output = MDaoUtilSingle.getData("AML_10_36_01_01_getSearch_RAITEM_Detail", input);

			// grid data
			if ( output.getCount("RISK_CATG1_C") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**위험요소관리 상세정보 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchCodeDetail(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

				output = MDaoUtilSingle.getData("AML_10_36_01_02_getSearch_RAITEM_Detail", input);
			// grid data
			if ( output.getCount("RISK_CATG1_C") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
}