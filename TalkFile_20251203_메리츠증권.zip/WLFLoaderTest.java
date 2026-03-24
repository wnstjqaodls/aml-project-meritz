

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.wlf.core.common.WLFConstant;
import com.gtone.wlf.core.data.SData;
import com.gtone.wlf.core.search.LuceneFactivaSearch;
import com.gtone.wlf.wlfloader.index.WatchListLoaderIndexer;

public class WLFLoaderTest {
	
	
	
	 private static final String DB_URL = "jdbc:oracle:thin:@172.16.21.49:1521:orcl";
	    private static final String DB_USER = "jbbank";
	    private static final String DB_PASSWORD = "WAT31";

	    // --- 랜덤 데이터 생성을 위한 샘플 데이터 배열 ---
	    private static final String[] HJE_YNS = {"0", "0", "1", "0", "0", "0"};
	    private static final String[] LAST_NAMES = {"Smith", "Jones", "Williams", "Brown", "Davis", "Miller"};
	    private static final String[] FIRST_NAMES = {"James", "Mary", "John", "Patricia", "Robert", "Jennifer"};
	    private static final String[] MIDDLE_NAMES = {"William", "Anne", "", "Rose", "", ""};
	    private static final String[] ISO_CODES = {"United States", "United Kingdom", "France", "Germany", "Japan", "China", "South Korea"};
	    private static final String[] WLF_NTNT_CNTT = {"484", "710", "250", "504", "840", "076", "410"};
	    private static final String[] DOB = {"20020101", "1997", "1998", "2001", "19731002", "1972", "1968", "198001", "1990", "1971", "19710101", "1975"};
	    // WLF_INF_G 값으로 1 또는 4를 랜덤하게 선택하기 위한 배열
	    private static final String[] CATEGORIES = {"SIE", "UN", "RCA", "SIP", "KFSC","W180","UN-FINCEN", "EURO", "FATF", "KFIU", "PEPs","ETC","OFAC"};
//	    private static final String[] LAST_NAMES = {"Smith", "Jones", "Williams", "Brown", "Davis", "Miller", "Wilson", "Moore"};
//	    private static final String[] FIRST_NAMES = {"James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda"};
	    private static final String[] EI_VALUES = {"Y", "N"};
	    private static final String[] PLACES = {"New York", "London", "Paris", "Tokyo", "Sydney", "Berlin", "Moscow"};
	    private static final int[] WLF_INF_G_TYPES = {1, 4,9};
	    private static final String[] WLF_RSPS_CNTT = {"See previous Roles", "Deceased", ""};
	    
	    private static final String[] SPLM_DATE = {"20251124", "20251125"};


	    
	        /**
	         * 이름(WCL_DTL_INF_U=1)을 기준으로 마스터 정보와 국가코드/생년월일 목록을 조인하여 조회하는 쿼리.
	         */
	    	public static final String SELECT_WCL_DATA_QUERY_OLD_JAVA =
	    			"SELECT "
	    				      + "    WLF_UNIQ_NO AS SQ, WLF_ISTU_CLS_CNTT AS WC_LIST_CCD, WLF_FLNM_CNTT AS CS_NM, "
	    				      + "    WLF_RLNM_CNTT, WLF_FCNM_CNTT, WLF_RSPS_CNTT AS WLF_RSPS_CNTT, "
	    				      + "    WLF_FIRST_NAME_CNTT AS CS_NM_FIRST, WLF_MIDDLE_NAME_CNTT AS CS_NM_MIDDLE, "
	    				      + "    WLF_LAST_NAME_CNTT AS CS_NM_LAST, "
	    				      + "    WLF_NTNT_CNTT AS NTN_CD_N, WLF_ADDR_CNTT, WLF_RGNO_CNTT AS WC_UID, "
	    				      + "    WLF_POB_CNTT AS DOB_N, WLF_BRTH_NTNL_CNTT, WLF_BRTH_CITY_CNTT, WLF_SPLM_INFO_CNTT, "
	    				      + "    FLXB_YN, SPLM_DATE AS REG_DT, DEL_DATE, MNPL_YMDH "
	    				      + "FROM "
	    				      + "    NIC19B_FACTIVA_UA";
	    	
	    	
	    	public static final String SELECT_WCL_DATA_QUERY_OLD_JAVA_DAILY =
	    			"SELECT "
	    				      + "    WLF_UNIQ_NO AS SQ, WLF_ISTU_CLS_CNTT AS WC_LIST_CCD, WLF_FLNM_CNTT AS CS_NM, "
	    				      + "    WLF_RLNM_CNTT, WLF_FCNM_CNTT, WLF_RSPS_CNTT AS WLF_RSPS_CNTT, "
	    				      + "    WLF_FIRST_NAME_CNTT AS CS_NM_FIRST, WLF_MIDDLE_NAME_CNTT AS CS_NM_MIDDLE, "
	    				      + "    WLF_LAST_NAME_CNTT AS CS_NM_LAST, "
	    				      + "    WLF_NTNT_CNTT AS NTN_CD_N, WLF_ADDR_CNTT, WLF_RGNO_CNTT AS WC_UID, "
	    				      + "    WLF_POB_CNTT AS DOB_N, WLF_BRTH_NTNL_CNTT, WLF_BRTH_CITY_CNTT, WLF_SPLM_INFO_CNTT, "
	    				      + "    FLXB_YN, SPLM_DATE AS REG_DT, DEL_DATE, MNPL_YMDH "
	    				      + "FROM "
	    				      + "    NIC19B_FACTIVA_UA"
	    				      + "    WHERE SPLM_DATE='20251124'";
	    //NAW
	    

	public static void main(String[] args) throws Exception{
		// TODO Auto-generated method stub
		int gubun = 4; 
		//1 - 색인(full) 
		//3 - 조회/색인(daily  4//검색 
		
		  System.out.println("Oracle 데이터베이스에 성공적으로 연결되었습니다.");
		  WatchListLoaderIndexer watchListLoaderIndexer = null;
		if(gubun==1) {
			 // 조회할 부서 ID
	        int departmentIdToQuery = 50;

	        // SQL 쿼리 (PreparedStatement를 위해 파라미터는 '?'로 처리)
//	        String query = "SELECT * from  NAW_WCL_MAS";
	         try {
	             Class.forName("oracle.jdbc.driver.OracleDriver");
	         } catch (ClassNotFoundException e) {
	             System.err.println("Oracle JDBC 드라이버를 찾을 수 없습니다.");
	             e.printStackTrace();
	             return;
	         }    

	        // try-with-resources 구문: 여기서 선언된 자원들은 try 블록이 끝나면 자동 해제됨
	        try {
	        	String[] indexfields  = {
	        			"SQ",
	        	        "WC_LIST_CCD",
	        	        "CS_NM",
	        	        "WLF_RLNM_CNTT",
	        	        "WLF_FCNM_CNTT",
	        	        "WLF_RSPS_CNTT",
	        	        "CS_NM_FIRST",
	        	        "CS_NM_MIDDLE",
	        	        "CS_NM_LAST",
	        	        "NTN_CD_N",
	        	        "WLF_ADDR_CNTT",
	        	        "WC_UID",
	        	        "DOB_N",
	        	        "WLF_BRTH_NTNL_CNTT",
	        	        "WLF_BRTH_CITY_CNTT",
	        	        "WLF_SPLM_INFO_CNTT",
	        	        "FLXB_YN",
	        	        "REG_DT",
	        	        "DEL_DATE",
	        	        "MNPL_YMDH"
	                };
	        		
	        	Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	             PreparedStatement pstmt = conn.prepareStatement(SELECT_WCL_DATA_QUERY_OLD_JAVA);
                 
	            System.out.println("Oracle 데이터베이스에 성공적으로 연결되었습니다.");
	            System.out.println("query:"+SELECT_WCL_DATA_QUERY_OLD_JAVA);
	            
	            
	            

	            // PreparedStatement에 파라미터 설정
//	            pstmt.setInt(1, departmentIdToQuery); // 첫 번째 '?'에 값을 정수(int)형으로 설정
	             watchListLoaderIndexer = new WatchListLoaderIndexer("C:\\ijs\\meriz\\index",false,indexfields,null);
	            watchListLoaderIndexer.init();
	            // 쿼리 실행 및 결과 받기
	            ResultSet rs = pstmt.executeQuery();
	            
	                int sq = 0;

//	                System.out.println("\n--- 부서 ID " + departmentIdToQuery + " 직원 목록 ---");
	                // 결과(ResultSet) 순회
	                while (rs.next()) {
	                	// 각 행의 데이터를 저장할 새로운 HashMap 생성
	                    HashMap<String, Object> h = new HashMap<>();

	                    // ResultSet에서 컬럼명으로 데이터 추출하여 HashMap에 저장
	                    // SQL 쿼리의 SELECT 절에 있는 모든 컬럼을 가져옵니다.
	                    h.put("SQ", rs.getString("SQ"));
	                    h.put("WC_LIST_CCD", rs.getString("WC_LIST_CCD"));
	                    h.put("CS_NM", rs.getString("CS_NM"));
	                    h.put("WLF_RLNM_CNTT", rs.getString("WLF_RLNM_CNTT"));
	                    h.put("WLF_FCNM_CNTT", rs.getString("WLF_FCNM_CNTT"));
	                    h.put("WLF_RSPS_CNTT", rs.getString("WLF_RSPS_CNTT"));
	                    h.put("CS_NM_FIRST", rs.getString("CS_NM_FIRST"));
	                    h.put("CS_NM_MIDDLE", rs.getString("CS_NM_MIDDLE"));
	                    h.put("CS_NM_LAST", rs.getString("CS_NM_LAST"));
	                    h.put("NTN_CD_N", rs.getString("NTN_CD_N"));
	                    h.put("WLF_ADDR_CNTT", rs.getString("WLF_ADDR_CNTT"));
	                    h.put("WC_UID", rs.getString("WC_UID"));
	                    h.put("DOB_N", rs.getString("DOB_N"));
	                    h.put("WLF_BRTH_NTNL_CNTT", rs.getString("WLF_BRTH_NTNL_CNTT"));
	                    h.put("WLF_BRTH_CITY_CNTT", rs.getString("WLF_BRTH_CITY_CNTT"));
	                    h.put("WLF_SPLM_INFO_CNTT", rs.getString("WLF_SPLM_INFO_CNTT"));
	                    h.put("FLXB_YN", rs.getString("FLXB_YN"));
	                    h.put("REG_DT", rs.getString("REG_DT"));
	                    h.put("DEL_DATE", rs.getString("DEL_DATE"));
	                    h.put("MNPL_YMDH", rs.getString("MNPL_YMDH"));
	                    
//	                    watchListLoaderIndexer.
	                   // Thread.sleep(1000);
	                    watchListLoaderIndexer.addLoaderIndex(h);

//	                    System.out.printf("CS_NM:"+WC_UID);
	                }
//	                watchListLoaderIndexer.closeIndexer();
	               
	            
	            

	        } catch (Exception e) {
	            System.err.println("데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.");
	            e.printStackTrace();
	            throw new Exception(e);
	        }
	        finally {
	        	  try {
	        	if(watchListLoaderIndexer!=null) {
	        		watchListLoaderIndexer.closeIndexer();
	        		System.out.println("색인 생성 완료");
	        	}
	        	  }
	        	  catch(Exception e) {
	        		  e.printStackTrace();
	        	  }
	        }

	        
//	    }
		}
		else if(gubun==2) {
			int recordCount = 100;
	        Random random = new Random();

	        // NAW_WCL_MAS 테이블에 대한 INSERT 쿼리
//	        String sql = "INSERT INTO NIC19B_FACTIVA_UA ("
//	                   + "WLF_INQ_NO, WLF_ISTU_CLS_CNTT, WLF_APPR_CNTT, WLF_RLNM_CNTT, WLF_RCNM_CNTT, "
//	                   + "WLF_PSPS_CNTT, WLF_INTNT_CNTT, WLF_ADDR_CNTT, WLF_RGNO_CNTT, WLF_JOB_CNTT, "
//	                   + "WLF_BRTH_NATL_CNTT, WLF_BRTH_CITY_CNTT, WLF_SPLM_INFO_CNTT, FLXB_YN, SPLM_DATE, "
//	                   + "DEL_DATE, MNPL_YMDH"
//	                   + ") VALUES ("
//	                   + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
//	                   + "?, ?, ?, ?, ?, ?, ?"
//	                   + ")";
	        
	        String sql = "INSERT INTO NIC19B_FACTIVA_UA (WLF_UNIQ_NO, WLF_ISTU_CLS_CNTT, WLF_FLNM_CNTT, WLF_RLNM_CNTT, "
	                + "WLF_FCNM_CNTT, WLF_RSPS_CNTT, WLF_NTNT_CNTT, WLF_ADDR_CNTT, WLF_RGNO_CNTT, "
	                + "WLF_POB_CNTT, WLF_BRTH_NTNL_CNTT, WLF_BRTH_CITY_CNTT, WLF_SPLM_INFO_CNTT, "
	                + "FLXB_YN, SPLM_DATE, DEL_DATE, MNPL_YMDH,WLF_FIRST_NAME_CNTT,WLF_MIDDLE_NAME_CNTT,WLF_LAST_NAME_CNTT"
	                + ") VALUES ("
	                + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE,?,?,?)";

	        Connection conn = null;
	        PreparedStatement pstmt = null;

	        try {
	            // 1. 데이터베이스 연결
	            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	            System.out.println("데이터베이스 연결 성공!");

	            // 2. 트랜잭션 수동 관리 설정
	            conn.setAutoCommit(false);

	            // 3. PreparedStatement 생성
	            pstmt = conn.prepareStatement(sql);
	            DateTimeFormatter yyyyMMdd = DateTimeFormatter.ofPattern("yyyyMMdd");
	            DateTimeFormatter yyyy_MM_dd = DateTimeFormatter.ofPattern("yyyy/MM/dd");
	            DateTimeFormatter hhmmss = DateTimeFormatter.ofPattern("HHmmss");
//	            Random random = new Random();
	            
	           // --

	            // 4. 지정된 건수만큼 반복하며 배치에 데이터 추가
	            for (int i = 1; i <= recordCount; i++) {
	                // --- 랜덤 데이터 생성 ---
	            	 LocalDate today = LocalDate.now();
	                 LocalDateTime now = LocalDateTime.now();
	                 
	                 // Not Null 컬럼들
	                 pstmt.setLong(1, i); // WC_UID (PK)
	                 pstmt.setString(2, CATEGORIES [random.nextInt(CATEGORIES .length)]); // HJE_YN
	                 
	                 String firstName ="";
                     String lastName = "";
                     String middleName = "";
//	                    if (wlfInfG == 1) {
	                         firstName = FIRST_NAMES[random.nextInt(FIRST_NAMES.length)];
	                         lastName = LAST_NAMES[random.nextInt(LAST_NAMES.length)];
	                         middleName = MIDDLE_NAMES[random.nextInt(MIDDLE_NAMES.length)];
//	                         if(middleName)
	                     String   name = firstName+" "+ middleName+" "+ lastName; // 영문 Full Name
//	                    } else  if (wlfInfG == 4) { // wlfInfG == 4
//	                        wclDtlCtnt = ISO_CODES[random.nextInt(ISO_CODES.length)]; // ISO 2자리 국가코드
//	                    } else  if (wlfInfG == 9) {
//	                    	 wclDtlCtnt = DOB[random.nextInt(DOB.length)];
//	                    }
	                 pstmt.setString(3, name); // WC_ENTERED
	                 pstmt.setString(4, name); // WC_EI (Entity/Individual -> P or E)
	                 pstmt.setString(5, name); // WC_EI (Entity/Individual -> P or E)
	                 pstmt.setString(6, WLF_RSPS_CNTT [random.nextInt(WLF_RSPS_CNTT.length)]); // HJE_YN
	                 pstmt.setString(7, WLF_NTNT_CNTT [random.nextInt(WLF_NTNT_CNTT.length)]); // HJE_YN
	                 pstmt.setString(8, ""); // WC_ENTERED
	                 DecimalFormat dfLeft = new DecimalFormat("00000000000"); // 11자리
	                 DecimalFormat dfRight = new DecimalFormat("0000000001");  // 10자리, 이 패턴은 예시와 동일한 포맷을 만듭니다.

//	                 long leftNumber = 352578;
	                 long rightNumber = 1;

	                 // 포맷팅 적용
	                 String formattedLeft = dfLeft.format(i);
	                 String formattedRight = dfRight.format(rightNumber);

	                 // 결과 출력 (예시 이미지와 유사한 포맷)
	                 String result = formattedLeft + "-" + formattedRight;
	                 // Nullable 컬럼들 (필요에 따라 더미 데이터 추가)
	                 pstmt.setString(9, result); // WC_SUB_CATEGORY
	                
//	                 pstmt.setString(13, String.valueOf(age)); // WC_AGE
//	                 pstmt.setString(14, today.format(yyyy_MM_dd)); // WC_AGE_DATE
	                 pstmt.setString(10, DOB[random.nextInt(DOB.length)]); // HJE_YN
	                 pstmt.setString(11, PLACES[random.nextInt(PLACES .length)]); // HJE_YN
	                 pstmt.setString(12, PLACES[random.nextInt(PLACES .length)]); // HJE_YN
	                 pstmt.setString(13, ""); // WC_SSN
//	                 pstmt.setString(13,  CATEGORIES [random.nextInt(CATEGORIES .length)]); // HJE_YN
	                 pstmt.setString(14, "Y"); // WC_POSITION
	                
	                 String  SPLM_DATE_str= SPLM_DATE[random.nextInt(SPLM_DATE .length)];
	                 System.out.println(SPLM_DATE_str);
	                 pstmt.setString(15, SPLM_DATE_str); // HJE_YN
	  	           pstmt.setString(16, ""); // DRDT
	  	           pstmt.setString(17, firstName); // DRDT
	  	           pstmt.setString(18, middleName); // DRDT
	  	           pstmt.setString(19, lastName); // DRDT
	  	      // 17. MNPL_YMDH (DATE) - 시스템 현재 시각
	  	           
//	  	         SPLM_DATE
	  	           
//	  	            pstmt.setTimestamp(17, new Timestamp(System.currentTimeMillis()));
//	                 pstmt.setString(24, "BATCH_JOB"); // DR_OP_JKW_NO
	                

	                // 5. 준비된 쿼리를 배치에 추가
	                pstmt.addBatch();

	                // 100건 마다 중간 실행 (메모리 관리)
	                if (i % 100 == 0) {
	                    pstmt.executeBatch();
	                    System.out.println(i + " records have been added to the batch...");
	                    pstmt.clearBatch(); // 배치 클리어
	                }
	            }
	            
	            // 6. 남아있는 나머지 배치 실행
	            pstmt.executeBatch();
	            System.out.println("Executing the remaining batch...");

	            // 7. 모든 작업이 성공했으면 트랜잭션 커밋
	            conn.commit();
	            System.out.println(recordCount + " records were successfully inserted.");

	        } catch (SQLException e) {
	            System.err.println("An error occurred during the database operation.");
	            e.printStackTrace();
	            // 8. 오류 발생 시 롤백
	            if (conn != null) {
	                try {
	                    conn.rollback();
	                    System.err.println("Transaction has been rolled back.");
	                } catch (SQLException ex) {
	                    ex.printStackTrace();
	                }
	            }
	        } finally {
	            // 9. 자원 해제
	            try {
	                if (pstmt != null) pstmt.close();
	                if (conn != null) conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
			
		}
	   else if(gubun==3) {
			 // 조회할 부서 ID
	        int departmentIdToQuery = 50;

	        // SQL 쿼리 (PreparedStatement를 위해 파라미터는 '?'로 처리)
//	        String query = "SELECT * from  NAW_WCL_MAS";
	         try {
	             Class.forName("oracle.jdbc.driver.OracleDriver");
	         } catch (ClassNotFoundException e) {
	             System.err.println("Oracle JDBC 드라이버를 찾을 수 없습니다.");
	             e.printStackTrace();
	             return;
	         }    

	        // try-with-resources 구문: 여기서 선언된 자원들은 try 블록이 끝나면 자동 해제됨
	        try {
	        	String[] indexfields  = {
	        			"SQ",
	        	        "WC_LIST_CCD",
	        	        "CS_NM",
	        	        "WLF_RLNM_CNTT",
	        	        "WLF_FCNM_CNTT",
	        	        "WLF_RSPS_CNTT",
	        	        "CS_NM_FIRST",
	        	        "CS_NM_MIDDLE",
	        	        "CS_NM_LAST",
	        	        "NTN_CD_N",
	        	        "WLF_ADDR_CNTT",
	        	        "WC_UID",
	        	        "DOB_N",
	        	        "WLF_BRTH_NTNL_CNTT",
	        	        "WLF_BRTH_CITY_CNTT",
	        	        "WLF_SPLM_INFO_CNTT",
	        	        "FLXB_YN",
	        	        "REG_DT",
	        	        "DEL_DATE",
	        	        "MNPL_YMDH"
	                };
	        		
	        	Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	             PreparedStatement pstmt = conn.prepareStatement(SELECT_WCL_DATA_QUERY_OLD_JAVA_DAILY);

	            System.out.println("Oracle 데이터베이스에 성공적으로 연결되었습니다.");
	            

	            // PreparedStatement에 파라미터 설정
//	            pstmt.setInt(1, departmentIdToQuery); // 첫 번째 '?'에 값을 정수(int)형으로 설정
	            
	             watchListLoaderIndexer = new WatchListLoaderIndexer("C:\\ijs\\meriz\\index",true,indexfields);
	            watchListLoaderIndexer.initDaily("20250904");
	            // 쿼리 실행 및 결과 받기
	            ResultSet rs = pstmt.executeQuery();
	            
	                int sq = 0;

//	                System.out.println("\n--- 부서 ID " + departmentIdToQuery + " 직원 목록 ---");
	                // 결과(ResultSet) 순회
	                while (rs.next()) {
	                	// 각 행의 데이터를 저장할 새로운 HashMap 생성
	                    HashMap<String, Object> h = new HashMap<>();

	                    // ResultSet에서 컬럼명으로 데이터 추출하여 HashMap에 저장
	                    // SQL 쿼리의 SELECT 절에 있는 모든 컬럼을 가져옵니다.
	                    h.put("SQ", rs.getString("SQ"));
	                    h.put("WC_LIST_CCD", rs.getString("WC_LIST_CCD"));
	                    h.put("CS_NM", rs.getString("CS_NM"));
	                    h.put("WLF_RLNM_CNTT", rs.getString("WLF_RLNM_CNTT"));
	                    h.put("WLF_FCNM_CNTT", rs.getString("WLF_FCNM_CNTT"));
	                    h.put("WLF_RSPS_CNTT", rs.getString("WLF_RSPS_CNTT"));
	                    h.put("CS_NM_FIRST", rs.getString("CS_NM_FIRST"));
	                    h.put("CS_NM_MIDDLE", rs.getString("CS_NM_MIDDLE"));
	                    h.put("CS_NM_LAST", rs.getString("CS_NM_LAST"));
	                    h.put("NTN_CD_N", rs.getString("NTN_CD_N"));
	                    h.put("WLF_ADDR_CNTT", rs.getString("WLF_ADDR_CNTT"));
	                    h.put("WC_UID", rs.getString("WC_UID"));
	                    h.put("DOB_N", rs.getString("DOB_N"));
	                    h.put("WLF_BRTH_NTNL_CNTT", rs.getString("WLF_BRTH_NTNL_CNTT"));
	                    h.put("WLF_BRTH_CITY_CNTT", rs.getString("WLF_BRTH_CITY_CNTT"));
	                    h.put("WLF_SPLM_INFO_CNTT", rs.getString("WLF_SPLM_INFO_CNTT"));
	                    h.put("FLXB_YN", rs.getString("FLXB_YN"));
	                    h.put("REG_DT", rs.getString("REG_DT"));
	                    h.put("DEL_DATE", rs.getString("DEL_DATE"));
	                    h.put("MNPL_YMDH", rs.getString("MNPL_YMDH"));
	                    
//	                    watchListLoaderIndexer.
	                    watchListLoaderIndexer.addLoaderIndex(h);

//	                    System.out.printf("CS_NM:"+WC_UID);
	                }
//	                watchListLoaderIndexer.closeIndexer();
	               
	            
	            

	        } catch (Exception e) {
	            System.err.println("데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.");
	            e.printStackTrace();
	            throw new Exception(e);
	        }
	        finally {
	        	  try {
	        	if(watchListLoaderIndexer!=null) {
	        		watchListLoaderIndexer.closeIndexer();
	        		System.out.println("색인 생성 완료");
	        	}
	        	  }
	        	  catch(Exception e) {
	        		  e.printStackTrace();
	        	  }
	        }

	        
//	    }
		}
	else if(gubun==4) {  //search 
			
//			String indexPath = "C:/ijs/sh_inter/index/WPEP01/";
			
			String indexPath = "C:/ijs/meriz/index/WPEP01/";
			
//			LuceneFactivaSearch wlfSearch = new LuceneFactivaSearch("C:/ijs/sh_inter/test/index/WPEP01");
			LuceneFactivaSearch wlfSearch = new LuceneFactivaSearch(indexPath);
			
			String searchField = WLFConstant.SF_CS_NM;
			String searchGrpCd = WLFConstant.WC_GRP_LIST_CCD_C;	
			String searchKeyword ="Jennifer Anne Davis";
			String searchIndvCorpCcd ="";
			String searchNtnCd ="250";//|    KP
			String searchDob ="2002";//19840108,19661107
			String searchSex ="";
			float score = 90F;
				        
		       long beforeTime_1 = System.currentTimeMillis(); //코드 실행 전에 시간 받아오기
//				result = wlfSearch.search(searchGrpCd, searchField, searchKeyword, searchConditions, score, rows);
//				if(i%1000==0) {
//					long afterTime_1 = System.currentTimeMillis();
//					System.out.println("count="+i+ "건, 총 검색 소요시간 =" + (afterTime_1 - beforeTime_1) + "ms");
//					 beforeTime_1 = System.currentTimeMillis(); //코드 실행 전에 시간 받아오기
//				}
			
			 //set coonfig values
			HashMap<String,Object> searchConfig = new HashMap<>();
//			searchConfig.put("CONVERT_KO_EN", false);
//			searchConfig.put("SEARCH_KO_ENABLE", true);
//			searchConfig.put("MAX_ROWS", 1000);
//			searchConfig.put("MULTI", true);
			searchConfig.put(LuceneFactivaSearch.SEARCH_LUCENE_COUNT_KEY, 300);
//			searchConfig.put(LuceneFactivaSearch.ISO2_NTN_CD_KEY, countryIsoMap);
			wlfSearch.setConfig(searchConfig);
			
			DataObj searchConditions = new DataObj();
			searchConditions.put(WLFConstant.SF_INDV_CORP_CCD, searchIndvCorpCcd);
			searchConditions.put(WLFConstant.SF_NTN_CD, searchNtnCd);
			searchConditions.put(WLFConstant.SF_DOB, searchDob);
			searchConditions.put(WLFConstant.SF_SEX, searchSex);
//			searchConditions.put(WLFConstant.MULTI, true);
			
			List<SData> result = wlfSearch.search(searchGrpCd, searchField, searchKeyword, searchConditions, score, 90);
			System.out.println("* result : " + result);
			
			long afterTime_1 = System.currentTimeMillis();
			System.out.println("count=1 건, 총 검색 소요시간 =" + (afterTime_1 - beforeTime_1) + "ms");
//			log.info("* result : " + result);
			/*
			 *  설정 정보 
			 *  - indexPath:
			 */
			
		}
		
	
			
		}

//	}

private static String getRandomDate(Random random, int startYear, int endYear) {
    int year = startYear + random.nextInt(endYear - startYear + 1);
    int month = 1 + random.nextInt(12);
    int day = 1 + random.nextInt(28); // 간단하게 28일까지만 처리
    return String.format("%04d-%02d-%02d", year, month, day);
}

}
