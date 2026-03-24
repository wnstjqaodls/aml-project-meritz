package com.gtone.rba.common.util;

import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

import com.gtone.rba.common.util.PropertyUtil;


public class SqlMapClient {

	private static SqlSession session;

	static{
		try{
			String resource = "META-INF/sqlmap/config/sqlMap-conf.xml";

			//암호화 모듈 추가
			String sp = decryptPassword();
			Properties prop = new Properties();
			prop.setProperty("Globals.BPassword", sp);


			Reader reader = Resources.getResourceAsReader(resource);
			SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader,prop);
			reader.close();

			session = sqlMapper.openSession();


		}catch(IOException e){
			System.out.println("[Conifg setting Error...]");
			e.printStackTrace();
		}
	}

	public static SqlSession getSqlSession(){
		return session;
	}

	public static String decryptPassword(){
		StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();
		standardPBEStringEncryptor.setAlgorithm("PBEWithMD5andDES");
		standardPBEStringEncryptor.setPassword(PropertyUtil.getString("Globals.ENC.KEY"));


		String decryptPass = standardPBEStringEncryptor.decrypt(PropertyUtil.getString("Globals.BPassword"));

		return decryptPass;
	}
}
