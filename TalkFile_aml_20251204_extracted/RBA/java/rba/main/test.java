package com.gtone.rba.main;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.stereotype.Component;

import com.gtone.rba.common.util.PropertyUtil;

/**
 * KoFIU 지표 보고 데이터 적재 배치 class
 * 
 * @author jekwak
 *
 */
@Component
public class test {
	
	public static void main(String[] args) 
	{
		// 암호화할 비밀번호 입력후 globals.properties에 붙여넣는다.
		
		String targetPassWord = "gtone1234"; // 암호화할 패스워드
		
		if(args.length > 0){
			targetPassWord = args[0]; 
		}
		System.out.println("패스워드="+targetPassWord);
		System.out.println("암호화한 패스워드="+getEncPwd(targetPassWord));
		System.out.println("복호화한 패스워드="+getDecPwd(getEncPwd(targetPassWord)));
		
	}
	
	public static String getEncPwd(String pwd) {
		StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();
		standardPBEStringEncryptor.setAlgorithm("PBEWithMD5andDES");
		standardPBEStringEncryptor.setPassword(PropertyUtil.getString("Globals.ENC.KEY"));
		String encPwd = standardPBEStringEncryptor.encrypt(pwd);
		
		return encPwd;
		
		
	}
	
	public static String getDecPwd(String pwd) {
		StandardPBEStringEncryptor standardPBEStringEncryptor = new StandardPBEStringEncryptor();
		standardPBEStringEncryptor.setAlgorithm("PBEWithMD5andDES");
		standardPBEStringEncryptor.setPassword("GTONE_PASS");
		
		String decPwd = standardPBEStringEncryptor.decrypt(pwd);
		
		return decPwd;
		
	}	
}