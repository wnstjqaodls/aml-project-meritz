/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLKRAB;

import com.gtone.aml.batch.common.Config;

public abstract class KRAB_Sql {
	
	private static KRAB_Sql instance = null;
	public static KRAB_Sql getInstance() {
		if (instance == null) {
			String dbDriver = Config.getInstance().getDB_DRIVER();
	    	//if (dbDriver.contains("mysql")) {
	    	//	instance = new KRAB_Sql_MySQL();
	    	//} else {
	    	instance = new KRAB_Sql_Oracle();
	    	//}
		}
		return instance;
	}
	
	public abstract String getDBType();
	public abstract String KRAB_SELECT_RA_WORK_INFO_001();
	
    public abstract String KRAB_INSERT_RA_CS_RA_RSLT_DTL_001();
    
    public abstract String KRAB_SELECT_RA_CS_RA_RSLT_DTL_001();
    
    public abstract String KRAB_SELECT_RA_CS_RA_RSLT_DTL_002();
    
    public abstract String KRAB_INSERT_RA_CS_RA_RSLT_001();
    
    public abstract String KRAB_INSERT_RA_SMUL_RSLT_001();
    
    public abstract String KRAB_UPDATE_NIC35B_001();
    
    public abstract String KRAB_SELECT_RUN_DATE();
    
    public abstract String KRAB_UPDATE_STRCTR_NIC35B();
    
    public abstract String KRAB_UPDATE_STRCTR_NIC06B();
    
}