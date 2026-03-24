package com.gtone.rba.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.SimpleTimeZone;


/**
 * 
*<pre>
* 날짜 관련 Utility
* 日付関連のUtility
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class DateUtil {
	public static final int KOREA = 1;
	public static final int USA = 2;

	private static final String[] whichDay = { "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" };

	/**
	 * <pre>
	 * 오늘 날짜를 yyyy-MM-dd 포맷으로 반환한다.
	 * 当日の日付をyyyy-MM-ddフォーマットで返す。
	 * @en
	 *</pre>
	 *@return
	 */
	public static String getDateString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy-MM-dd", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}

	/**
	 * <pre>
	 * 오늘 날짜를 yyyyMMdd 포맷으로 반환한다.
	 * 当日の日付をyyyyMMddフォーマットで返す。
	 * @en
	 *</pre>
	 *@return
	 */
	public static String getShortDateString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyyMMdd", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}

	/**
	 * <pre>
	 * 현재 시간을 HH:mm:ss:SSS 포맷으로 반환한다.
	 * 現在時刻をHH:mm:ss:SSSフォーマットで返す。
	 * @en
	 *</pre>
	 *@return
	 */
	public static String getTimeString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"HH:mm:ss:SSS", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}

	/**
	 *  <pre>
	 * 현재 시간을 HH:mm:ss:SSS 포맷으로 반환한다.
	 * 現在時刻をHH:mm:ss:SSSフォーマットで返す。
	 * @en
	 *</pre>
	 *@return
	 */
	public static String getShortTimeString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"HHmmssSSS", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}

	/**
	 *  <pre>
	 * 현재 시간을 yyyy-MM-dd-HH:mm:ss:SSS 포맷으로 반환한다.
	 * 現在時刻をyyyy-MM-dd-HH:mm:ss:SSSフォーマットで返す。
	 * @en
	 *</pre>
	 *@return
	 */
	public static String getTimeStampString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy-MM-dd-HH:mm:ss:SSS", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}

	/**
	 *  <pre>
	 * 현재 시간을 yyyyMMddHHmmssSSS 포맷으로 반환한다.
	 * 現在時刻をyyyyMMddHHmmssSSSフォーマットで返す。
	 * @en
	 *</pre>
	 *@return
	 */
	public static String getShortTimeStampString() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyyMMddHHmmssSSS", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}

	/**
	 *  <pre>
	 * 주어진 날짜를  yyyyMMddHHmmssSSS 포맷으로 반환한다.
	 * 与えられた日付をyyyyMMddHHmmssSSSフォーマットで返す。
	 * @en
	 *</pre>
	 *@param y year
	 *@param m month
	 *@param d	day
	 *@param h	hour
	 *@param M	minute
	 *@param s  second
	 *@return
	 */
	public static String getShortTimeStampString(int y, int m, int d, int h,
			int M, int s) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyyMMddHHmmssSSS", java.util.Locale.KOREA);
		return formatter.format(new java.util.Date());
	}
	
	/**
	 *<pre>
	 * 19000101을 반환한다.
	 * 19000101を返す。
	 * @en
	 *</pre> 
	 *@return
	 */
	public static String getMinDate() {
		return "19000101";
	}
	
	
	/**
	 * <pre>
	 * 29991231을 반환한다.
	 * 29991231を返す。
	 * @en
	 *</pre> 
	 *@return
	 */
	public static String getMaxDate() {
		return "29991231";
	}
	

	/**
	 * <pre>
	 * 주어진 String을 yyyy/MM/dd HH:mm:ss 형태로 반환한다.
	 * 与えられたStringをyyyy/MM/dd HH:mm:ssフォーマットで返す。
	 * @en
	 *</pre> 
	 *@param date
	 *@return
	 */
	public static String parseDate(String date) {
		try {
			return date.substring(0, 4) + "/" + date.substring(4, 6) + "/"
					+ date.substring(6, 8) + " " + date.substring(8, 10) + ":"
					+ date.substring(10, 12) + ":" + date.substring(12, 15);
		} catch (Exception e) {
			e.printStackTrace(System.out);
			return date;
		}
	}

	
	/**
	 * <pre>
	 * 두 날짜간의 간격일을 반환한다.
	 * 二つの日付の間の日数を返す。
	 * @en
	 *</pre>
	 *@param strDate
	 *@param strComp
	 *@return
	 */
	public static long compareDay(String strDate, String strComp) {
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		int year = Integer.parseInt(strDate.substring(0, 4));
		int month = Integer.parseInt(strDate.substring(4, 6));
		int day = Integer.parseInt(strDate.substring(6, 8));
		int compYear = Integer.parseInt(strComp.substring(0, 4));
		int compMonth = Integer.parseInt(strComp.substring(4, 6));
		int compDay = Integer.parseInt(strComp.substring(6, 8));
		cal1.set(year, month - 1, day);
		cal2.set(compYear, compMonth - 1, compDay);
		long cal1sec = cal1.getTime().getTime();
		long cal2sec = cal2.getTime().getTime();
		long gap = cal2sec - cal1sec;
		long gapday = (gap / 86400) / 1000;
		return gapday;
	}

	/**
	 * check date string validation with the default format "yyyyMMdd".
	 * 
	 * @param s
	 *            date string you want to check with default format "yyyyMMdd".
	 * @return date java.util.Date
	 */
	public static java.util.Date check(String s)
			throws java.text.ParseException {
		return check(s, "yyyyMMdd");
	}

	/**
	 * check date string validation with an user defined format.
	 * 
	 * @param s
	 *            date string you want to check.
	 * @param format
	 *            string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return date java.util.Date
	 */
	public static java.util.Date check(String s, String format)
			throws java.text.ParseException {
		if (s == null)
			throw new java.text.ParseException("date string to check is null",
					0);
		if (format == null)
			throw new java.text.ParseException(
					"format string to check date is null", 0);

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		} catch (java.text.ParseException e) {
			/*
			 * throw new java.text.ParseException( e.getMessage() +
			 * " with format \"" + format + "\"", e.getErrorOffset() );
			 */
			throw new java.text.ParseException(" wrong date:\"" + s
					+ "\" with format \"" + format + "\"", 0);
		}

		if (!formatter.format(date).equals(s))
			throw new java.text.ParseException("Out of bound date:\"" + s
					+ "\" with format \"" + format + "\"", 0);
		return date;
	}

	public static String whichDay(String s) throws ParseException {
		return whichDay(s, "yyyyMMdd");
	}

	/**
	 * <pre>
	 * 오늘의 요일을 반환한다.
	 * 当日の曜日を返す。
	 * @en
	 * </pre>
	 * @return  a day of the week
	 */
	public static String whichDay(String s, String format)
			throws java.text.ParseException {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);

		java.util.Calendar calendar = formatter.getCalendar();
		calendar.setTime(date);

		return whichDay[calendar.get(java.util.Calendar.DAY_OF_WEEK) - 1];
	}

	
	/**
	 * <pre>
	 * String을 주어진 format을 참고하여 날짜로 변환한다.
	 * Stringを与えられたフォーマットを参考して日付に変換する。
	 * @en
	 * </pre>
	 *@param date
	 *@param format
	 *@return
	 */
	public static String String2Date(String date, String format) {
		StringBuffer result = new StringBuffer();
		try {
			char[] d = date.toCharArray();
			int year = 0;
			int year2 = 2;
			int month = 4;
			int day = 6;
			int hour = 8;
			int minute = 10;
			int second = 12;
			int millisecond = 14;
			for (int i = 0; i < format.length(); i++) {
				switch (format.charAt(i)) {
				case 'y':
					result.append(d[year++]);
					break;
				case 'Y':
					result.append(d[year2++]);
					break;
				case 'M':
					result.append(d[month++]);
					break;
				case 'd':
					result.append(d[day++]);
					break;
				case 'H':
					result.append(d[hour++]);
					break;
				case 'm':
					result.append(d[minute++]);
					break;
				case 's':
					result.append(d[second++]);
					break;
				case 'S':
					result.append(d[millisecond++]);
					break;
				default:
					result.append(format.charAt(i));
				}
			}
		} catch (Exception e) {
		}
		return result.toString();
	}

	/**
	 * <pre>
	 * 현재의 날짜를 기준으로 yyyyMMddHHmmss 형태로 변환
	 * 現在の日付を基準にyyyyMMddHHmmss形式に変換
	 * @en
	 * </pre>
	 * @return  
	 */
	public static String getDate() {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyyMMddHHmmss");
		java.util.Date currentdate = new java.util.Date();
		return formatter.format(currentdate);
	}

	/**
	 * <pre>
	 * 해당시간("hhmm")에 따라 "오전" 또는 "오후"를 리턴한다.
	 * 該当時間("hhmm")に応じて「午前」または「午後」を返す。
	 * @en
	 * </pre>
	 * @param str date(yyyyMMdd)
	 * @return  
	 */
	public static String getNoon(String str) {
		if (str == null)
			return str;
		if (str.length() != 4)
			return str;

		int noon = Integer.parseInt(str);
		if (noon < 1200)
			return "오전";

		return "오후";
	}

	/**
	 * <pre>
	 * 년월일 사이에 구분자 sep를 첨가한다. 구분자가 "/"인 경우 "yyyyMMdd" -> "yyyy/MM/dd"가 된다.
	 * 年月日の間の区切り文字sepを付ける。区切り文字が「/」であれば、「yyyyMMdd」 -> 「yyyy/MM/dd」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str date(yyyyMMdd)
	 */
	public static String date(String str, String sep) {
		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 8)
			return str;
		if ((str.equals("00000000")) || (str.equals("       0"))
				|| (str.equals("        ")))
			return "";
		temp = str.substring(0, 4) + sep + str.substring(4, 6) + sep
				+ str.substring(6, 8);

		return temp;
	}

	/**
	 * <pre>
	 * 년월일(년도는 2자리 형식) 사이에 구분자 sep를 첨가한다. 구분자가 "/"인 경우 "yymmdd" -> "yy/mm/dd"가 된다.
	 * 年月日(年度は2桁形式)の間に区切り文字sepを付ける。区切り文字が「/」であれば、「yymmdd」 -> 「yy/mm/dd」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str Date(yyyyMMdd)
	 */
	public static String date2(String str, String sep) {
		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 6)
			return str;
		if ((str.equals("000000")) || (str.equals("     0")))
			return "";
		temp = str.substring(0, 2) + sep + str.substring(2, 4) + sep
				+ str.substring(4, 6);

		return temp;
	}

	/**
	 * <pre>
	 * 년월일 사이에 '.'를 첨가한다. "yyyyMMdd" -> "yyyy.MM.dd"
	 * 年月日の間に「.」を付ける。「yyyyMMdd」 -> 「yyyy.MM.dd」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str Date(yyyyMMdd)
	 */
	public static String dotDate(String str) {
		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 8)
			return str;
		if ((str.equals("00000000")) || (str.equals("       0")))
			return "";
		temp = str.substring(0, 4) + "." + str.substring(4, 6) + "."
				+ str.substring(6, 8);

		return temp;
	}

	/**
	 * <pre>
	 * 월일 사이에 '.'를 첨가한다. "mmdd" -> "mm.dd"
	 * 月日の間に「.」を付ける。「mmdd」 -> 「mm.dd」になる。
	 * @en
	 * </pre>
	 * @return java.lang.String
	 * @param str MMdd
	 */
	public static String dotMM(String str) {
		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 4)
			return str;
		if ((str.equals("0000")) || (str.equals("   0")))
			return "";
		temp = str.substring(0, 2) + "." + str.substring(2, 4);
		return temp;
	}

	/**
	 * <pre>
	 * 년월일 사이에 '.'와 ':'를 첨가한다. "yyyyMMddHHmmss" -> "yyyy.MM.dd HH:mm:ss"
	 * 年月日の間に「.」と「:」を付ける。「yyyyMMddHHmmss」 -> yyyy.MM.dd HH:mm:ss」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str (yyyyMMddhhmmss)
	 */
	public static String dotDateTime(String str) {

		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 14)
			return str;
		if ((str.equals("00000000")) || (str.equals("       0")))
			return "";
		temp = str.substring(0, 4) + "." + str.substring(4, 6) + "."
				+ str.substring(6, 8) + " " + str.substring(8, 10) + ":"
				+ str.substring(10, 12) + ":" + str.substring(12, 14);

		return temp;
	}

	/**
	 * <pre>
	 * 년월 사이에 '.'를 첨가한다. "yyyyMM" -> "yyyy.MM"
	 * 年月の間に「.」を付ける。「yyyyMM」 -> yyyy.MM」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str yyyyMM
	 */
	public static String dotYM(String str) {

		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 6)
			return str;
		if ((str.equals("000000")) || (str.equals("     0")))
			return "";
		temp = str.substring(0, 4) + "." + str.substring(4, 6);

		return temp;
	}

	/**
	 * <pre>
	 * 년월일 사이에 '-'를 첨가한다. "yyyyMMdd" -> "yyyy-MM-dd"
	 * 年月日の間に「-」を付ける。「yyyyMMdd」 -> 「yyyy-MM-dd」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str yyyyMMdd 
	 */
	public static String dashDate(String str) {

		String temp = null;
		if (str == null)
			str = "";

		int len = str.length();

		if (len != 8 || str.equals("        "))
			return str;
		if ((str.equals("00000000")) || (str.equals("       0")))
			return "";
		temp = str.substring(0, 4) + "-" + str.substring(4, 6) + "-"
				+ str.substring(6, 8);

		return temp;
	}

	/**
	 * <pre>
	 * 년월 사이에 '-'를 첨가한다. "yyyyMM" -> "yyyy-MM"
	 * 年月の間に「-」を付ける。「yyyyMM」 -> yyyy-MM」になる。
	 * @en
	 * </pre>
	 * @return  
	 * @param str yyyyMMdd
	 */
	public static String dashYM(String str) {

		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len != 6)
			return str;
		if ((str.equals("000000")) || (str.equals("     0")))
			return "";
		temp = str.substring(0, 4) + "-" + str.substring(4, 6);

		return temp;
	}

	 
	/**
	 * <pre>
	 * 시분초 사이에 ':'를 첨가한다. HHmmss -> HH:mm:ss
	 * 時分秒の間に「:」を付ける。HHmmss -> HH:mm:ss
	 * @en
	 * </pre>
	 * @return java.lang.String
	 * @param str (HHmmss)
	 */
	public static String dotTime(String str) {

		String temp = null;
		// Hjun edit.. 2000.11.1
		if (str == null)
			return "";
		int len = str.length();

		if (len != 6)
			return str;

		temp = str.substring(0, 2) + ":" + str.substring(2, 4) + ":"
				+ str.substring(4, 6);

		return temp;
	}

	/**
	 * <pre>
	 * 시분 사이에 ':'를 첨가한다. HHmm -> HH:mm
	 * 時分の間に「:」を付ける。HHmm -> HH:mm
	 * @en
	 * </pre>
	 * @return  
	 * @param str HHmm
	 */
	public static String dotHM(String str) {

		String temp = null;
		if (str == null)
			return "";
		int len = str.length();

		if (len < 4)
			return str;

		temp = str.substring(0, 2) + ":" + str.substring(2, 4);

		return temp;
	}

	 


	/**
	 * 
	 
	 * <pre>
	 * 파라미터로 받은값을 8자리의 년도 형태로 반환
	 * パラメータで引き渡された値を8桁の年度で返す。
	 * @en
	 * </pre>
	 * @return  yyyyMMdd
	 *@param y year
	 *@param m	month
	 *@param d	day
	 *@return
	 */
	public static String fixDate(int y, int m, int d) {

		String mm = null;
		String dd = null;

		mm = "" + m;
		dd = "" + d;

		if (m < 10)
			mm = "0" + mm;
		if (d < 10)
			dd = "0" + dd;

		return y + mm + dd;

	}

	 

	 

	 

	/**
	 * <pre>
	 * dd-MM-yyyy 날짜포맷으로 변환. 예) 20010414 --> 04-14-2001
	 * dd-MM-yyyy日付フォーマットに変換。例) 20010414 --> 04-14-2001
	 * @en
	 * </pre>
	 * @param date 
	 * @return dd-MM-yyyy
	 */
	public static String dateForSQL(String date) throws Exception {
		if (date == null)
			return "";
		if (date.length() != 8)
			return "";
		String tempDate = "";
		tempDate = date.substring(4, 6) + "-" + date.substring(6, 8) + "-"
				+ date.substring(0, 4);
		return tempDate;
	}

	 

	 

	 

	 

	/**
	 * <pre>
	 * 날자 문자열에 해당 일수를 더하여 리턴한다.
	 * 日付文字列に該当日数を足して返す。
	 * @en
	 * </pre>
	 * @param s date string(yyyyMMdd)
	 * @param day  
	 * 
	 * @return  yyyyMMdd 
	 */
	public static String addDays(String s, int day)
			throws java.text.ParseException {
		return addDays(s, day, "yyyyMMdd");
	}

	/**
	 * return add day to date strings with user defined format.
	 * 
	 * @param s date string
	 * @param day	  
	 * @param format string representation of the date format. For example,
	 *            "yyyy-MM-dd".
	 * @return   
	 */
	public static String addDays(String s, int day, String format)
			throws java.text.ParseException {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);

		date.setTime(date.getTime() + ((long) day * 1000 * 60 * 60 * 24));
		return formatter.format(date);
	}

	/**
	 * <pre>
	 * 요일을 반환한다.
	 * 曜日を返す。
	 * @en
	 * </pre>
	 * @param datestr yyyyMMdd
	 * @return  
	 */
	public static int getDayOfWeek(String datestr) {
		int yyyy = Integer.parseInt(datestr.substring(0, 4));
		int mm = Integer.parseInt(datestr.substring(4, 6)) - 1;
		int dd = Integer.parseInt(datestr.substring(6, 8));

		Calendar cal = Calendar.getInstance();
		cal.set(yyyy, mm, dd);

		return cal.get(Calendar.DAY_OF_WEEK);
	}

	 
	
	
	/**
	 * <pre>
	 * 해당 연월의 말일을 리턴한다.
	 * 該当年月の末日を返す。
	 * @en
	 * </pre>
	 * @param yyyy year
	 * @param mm	month
	 * @return  
	 */
	public static int lastDay(int yyyy, int mm) {
		int lastDay = 31;
		if (mm == 4 || mm == 6 || mm == 9 || mm == 11)
			lastDay = 30;
		if (mm == 2) {
			lastDay = 28;
			if ((yyyy % 4 == 0) && (yyyy % 100 != 0))
				lastDay = 29;
			if (yyyy % 400 == 0)
				lastDay = 29;
		}
		return lastDay;
	}

	/**
	 * <pre>
	 * 해당 일자를 기준으로 l년 m월 n일 전의 일자를 리턴한다.
	 * 該当日付を基準に1年m月n日前の日付を返す。
	 * @en
	 * </pre>
	 */
	public static String ntermDate(String datestr, int l, int m, int n) {

		if (datestr == null)
			return null;
		if (datestr.length() != 8)
			return datestr;

		int yy = Integer.parseInt(datestr.substring(0, 4));
		int mm = Integer.parseInt(datestr.substring(4, 6));
		int dd = Integer.parseInt(datestr.substring(6, 8));

		// l년 전
		yy = yy - l;
		// m개월 전
		mm = mm - m;
		if (mm <= 0) {
			yy--;
			mm = mm + 12;
		}
		// n일 전
		dd = dd - n;
		if (dd <= 0) {
			mm--;
			if (mm == 0) {
				yy--;
				mm = mm + 12;
			}
			dd = dd + DateUtil.lastDay(yy, mm);
		}

		if (dd > DateUtil.lastDay(yy, mm))
			dd = DateUtil.lastDay(yy, mm);

		return DateUtil.fixDate(yy, mm, dd);
	}
	
	/**
	 * 현재 년도 반환
	 * @param src
	 * @return
	 */
	public static String getYear() {
		Calendar aCalendar = Calendar.getInstance();
		
		int year = aCalendar.get(Calendar.YEAR);
		return Integer.toString(year);
	}
	
	
	/**
	 * 현재 월 반환
	 * @param src
	 * @return
	 */
	public static String getMonth() {
		int m = Calendar.getInstance().get(Calendar.MONTH)+1;
		String ret = String.valueOf(m);
		
		if(m < 10) ret = "0"+m;
		
		return ret;
	}
	
	
	/**
	 * 현재 일 반환
	 * @param src
	 * @return
	 */
	public static String getDay() {
		int d = Calendar.getInstance().get(Calendar.DATE);
		String ret = String.valueOf(d);
		
		if(d < 10) ret = "0"+d;
		
		return ret;
	}
	
	
	/**
     * 현재(한국기준) 날짜정보를 얻는다.                     <BR>
     * 표기법은 yyyy-mm-dd                                  <BR>
     * @return  String      yyyymmdd형태의 현재 한국시간.   <BR>
     */
    public static String getToday(){
        return getCurrentDate("");
    }

    /**
     * 현재(한국기준) 날짜정보를 얻는다.                     <BR>
     * 표기법은 yyyy-mm-dd                                  <BR>
     * @return  String      yyyymmdd형태의 현재 한국시간.   <BR>
     */
    public static String getCurrentDate(String dateType) {
        Calendar aCalendar = Calendar.getInstance();

        int year = aCalendar.get(Calendar.YEAR);
        int month = aCalendar.get(Calendar.MONTH) + 1;
        int date = aCalendar.get(Calendar.DATE);
        String strDate = Integer.toString(year) +
                ((month<10) ? "0" + Integer.toString(month) : Integer.toString(month)) +
                ((date<10) ? "0" + Integer.toString(date) : Integer.toString(date));

        return  strDate;
    }
    
    public static String getCurrentTime(String format)
	{

		format = "HH" + format + "mm" + format + "ss";
		String tz = "KST";

		int millisPerHour = 60 * 60 * 1000;
		SimpleDateFormat fmt = new SimpleDateFormat(format);
		SimpleTimeZone timeZone = new SimpleTimeZone(9 * millisPerHour, tz);
		fmt.setTimeZone(timeZone);

		String str = fmt.format(new java.util.Date(System.currentTimeMillis()));

		return str;
	}
	
    
    /**
     * 현재 날짜시간정보 가져오기
     * @return
     */
	public static String getSysdate(){
		return getCurrentDate("")+getCurrentTime("");
	}

}
