package com.gtone.rba.common.util;

import java.util.Properties;


/**
 * <pre>
 * 프로퍼티 관련 Utility Class
 * </pre>
 * @author jacky
 * @version 1.0
 * @history 1.0 2017-06-07
 */
public class PropertyUtil
{
	private Properties  properties;
	
	static PropertyUtil pros;
	static 
	{
		pros = new PropertyUtil();		
	}
	
	private PropertyUtil()
	{
		try
		{
			properties = new Properties();
			
			properties.load(getClass().getResourceAsStream("/META-INF/props/globals.properties"));
		}
		catch(Exception e)
		{
			System.out.println("[Check out the Java path]-globals.properties can not read the file.");
		}
	}
	
	public static PropertyUtil getInstance()
	{
		return pros;
	}
	
	public static String getString(String str)
	{
		String ret="";
		try
		{
			ret = pros.getInstance().properties.getProperty(str);
		}
		catch(Exception e)
		{
			ret = str+" not find";
		}
		return ret;
	}
	
}
