package com.gtone.aml.batch.AMLDATAB;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import com.gtone.aml.batch.common.util.DBUtil;

/**
 *<pre>
 * 운영초기데이터 적재
 * @en
 *</pre>
 *@author 
 *@version 1.0
 *@history 1.0
 */
public class DATAB_Sql {

    public static void insertDATA() throws SQLException {
    	Connection conn = null;
    	try {
    		conn = DBUtil.getConnection();
    		conn.setAutoCommit(false);
    		
    		
    		DBUtil.executeUpdate(conn,"DELETE FROM SSQ.AML_APPR WHERE APP_NO = 'PRD0200036'");
    		conn.commit();
    		
    		
    		DBUtil.executeUpdate(conn,"UPDATE SSQ.AML_APPR_HIST SET APP_NO = 'PRD0200036' WHERE APP_NO = 'PRD0200040'");
    		DBUtil.executeUpdate(conn,"UPDATE SSQ.AML_APPR SET APP_NO = 'PRD0200036' WHERE APP_NO = 'PRD0200040'");
    		DBUtil.executeUpdate(conn,"UPDATE SSQ.KYC_PRD_EVLTN SET APP_NO = 'PRD0200036' WHERE PRD_EVLTN_ID = 'PF016'");
    		
    		
    		conn.commit();
    		
    	} catch (SQLException e) {
    		if(conn != null) conn.rollback();
    		throw e;
    	} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidAlgorithmParameterException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		}finally {
    		if (conn != null) conn.close();
    	}
    }
                                                                                                 
}