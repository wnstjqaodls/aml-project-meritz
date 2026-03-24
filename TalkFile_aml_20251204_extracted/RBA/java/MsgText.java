/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.basic.jspeed.base.el;

import java.util.HashMap;

/******************************************************************************************************************************************
 * @Description 메시지 텍스트 정의
 *              - AMLExpress 에서 항상 override 하여 사용하도록 한다
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Java        6.0 이상
 * @Author      박상훈
 * @Since       2017. 12. 3.
 ******************************************************************************************************************************************/

public enum MsgText {
	/**************************************************************************************************************************************
	 * Constants
	 **************************************************************************************************************************************/

	// [ AML_00 ]
	// [ AML_10 ]
	// [ AML_20 ]
	// [ AML_30 ]
	// [ AML_40 ]
	// [ AML_50 ]
	// [ AML_60 ]
	// [ AML_70 ]
	// [ AML_80 ]
	// [ AML_90 ]
	// [ messages-express ]

	// [ login ]

	 login_00_001("ko-KR,사용자 아이디 또는 패스워드가 올바르지 않습니다.")
	,login_00_002("ko-KR,LDAP 서버의 주소가 유효하지 않거나 서버가 응답하지 않습니다.")
	;
	
	String val;
	
	MsgText(String val){
		this.val = val;
	}
	
	public String getValue()
	{
		return val;
	}
	
	public String getName()
	{
		return name();
	}
	
	
	/**************************************************************************************************************************************
	 * Attributes
	 **************************************************************************************************************************************/

	/** 다국어 처리용 해쉬맵 */
	HashMap<String, String> msgmap = new HashMap<String, String>();

	/**************************************************************************************************************************************
	 * Constructors
	 **************************************************************************************************************************************/

	/**
	 * 언어구분 및 언어구분별 텍스트 입력
	 * <p>
	 * @param   param
	 *              <code>String[]</code>
	 *                  "ko-KR,수정" 
	 */
	private MsgText(final String[] param) {
		String[] vals = null;
		for (String val : param) {
			vals = val.split(",");
			try {
				msgmap.put(vals[0], vals[1]);
			} catch (ArrayIndexOutOfBoundsException e) {
				System.out.println("[" + name() + "] value was wrong."); // 로그 처리 할것
			}
		}
	}

	/**************************************************************************************************************************************
	 * Methods
	 **************************************************************************************************************************************/

	// [ get ]

	/**
	 * 검색대상 아이디에 해당하는 문자열을 반환.
	 * <p>
	 * @param   msgID
	 *              메시지 아이디
	 * @param   langCD
	 *              언어구분
	 * @param   defval
	 *              찾는 문자열이 없는 경우 반환
	 * @return  <code>String</code>
	 *              언어별 버튼 문자열
	 */
	public static String getText(String msgID, String langCD, String defval) {
		try {
			MsgText obj = valueOf(msgID);

			if ( obj == null ) {
				return "[" + defval + "]";
			} else {
				return obj.msgmap.get(langCD);
			}

			// return obj!=null?obj.msgmap.get(langCD):"["+defval+"]";
		} catch (IllegalArgumentException e) {
			System.out.println("[" + msgID + "] does not exist."); // 로그 처리 할것
			return "[" + defval + "]";
		}
	}
}
