package com.gtone.rba.common.util;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;


/**
 * 암호화 관련 각 고객사별로 암호화 한 후 globals.properties 파일에 암호화된 값 등록한다.
 * @author jacky
 *
 */
public class JasyptUtil {

	public static void main(String[] args) {
		StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();  
		standardPBEStringEncryptor.setAlgorithm("PBEWithMD5AndDES");  
		standardPBEStringEncryptor.setPassword("GTONE_PASS"); // 키 값   
		
		//암호화 할 비밀번호
		String encodedPass = standardPBEStringEncryptor.encrypt("GTONE");  
		System.out.println("Encrypted Password for admin is : "+encodedPass); 

		
		//복호화
		String deCodedPass = standardPBEStringEncryptor.decrypt("NUYuT3syq5TP27IApdplBLHrmAd6fLGF");  
		System.out.println("복원 값 : "+deCodedPass);  

		
	}

}
