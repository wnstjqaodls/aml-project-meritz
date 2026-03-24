package com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_03;

import java.awt.font.FontRenderContext;
import java.awt.font.LineBreakMeasurer;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.AttributedString;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.gtone.aml.basic.common.log.Log;


@SuppressWarnings({ "resource", "static-access" })
public class ExcelMain {

    private String inputPath;
    private String outputPath;

    //4.자금세탁 위험평가 방법론 시트에 그리드데이터 카운트값 저장할 변수선언
    private int gridCnt1 = 0;
    private int gridCnt2 = 0;
    private int gridCnt3 = 0;
    private int startColIdx1 = 0;
    private int startColIdx2 = 0;
    private int startColIdx3 = 0;

    public ExcelMain(String inputPath, String outputPath) {
        this.inputPath = inputPath.replace("\\", "/");
        this.outputPath = outputPath.replace("\\", "/");
    }

    public void setGridCnt1(int cnt) {
    	this.gridCnt1 = cnt;
    }
    public void setGridCnt2(int cnt) {
    	this.gridCnt2 = cnt;
    }
    public void setGridCnt3(int cnt) {
    	this.gridCnt3 = cnt;
    }
    public void setStartColIdx1(int idx) {
    	this.startColIdx1 = idx;
    }
    public void setStartColIdx2(int idx) {
    	this.startColIdx2 = idx;
    }
    public void setStartColIdx3(int idx) {
    	this.startColIdx3 = idx;
    }

    /**
     * <pre>
     * 엑셀파일에서 지정한 위치에 있는 데이터를 가져온다 (참고용)
     * </pre>
     * @param sheetIdx  : 몇번째 엑셀시트
     * @param rowIdx    : 몇번째 로우
     * @param colIdx   : 몇번째 컬럼
     * @return
     * @throws IOException
     */
    public String getValue(int sheetIdx, int rowIdx, int colIdx) throws IOException {
        String value = "";
        XSSFWorkbook workbook = null;
        FileInputStream fis = null;

        try {
        	fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
            XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);
            XSSFRow row = sheet.getRow(rowIdx-1);
            XSSFCell cell = row.getCell(colIdx-1); // 셀에 담겨있는 값을 읽는다.

	        if (cell != null) {
	        	switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
	        	case FORMULA:
	        		value = cell.getNumericCellValue() + "";
	        		break;
	        	case STRING:
	        		value = cell.getStringCellValue() + "";
	        		break;
	        	case BLANK:
	        		value = cell.getBooleanCellValue() + "";
	        		break;
	        	case ERROR:
	        		value = cell.getErrorCellValue() + "";
	        		break;
	        	default  :
	        	    value ="" ;
	        	    break;
	        	}
	        	//System.out.println(value);
	        }

        } catch (FileNotFoundException e) {
            Log.logAML(Log.ERROR, this, "getValue", e);
        } finally {
            if(workbook != null) {
            	workbook.close();
            }
            if(fis != null) {
            	fis.close();
            }
        }

        return value;
    }

    /**
     * <pre>
     * 엑셀파일에서 지정한 시트와 컬럼 위치에 원하는 문자열값의 컬럼인덱스를 가져온다.
     * 리턴값이 -1인 경우에는 원하는 문자열값이 존재하지 않다는 것이니까 이 매소드 사용시에는 유효값체크 필수.
     * </pre>
     * @param sheetIdx  : 몇번째 엑셀시트
     * @param colIdx    : 몇번째 컬럼
     * @param target   	: 찾을 문자열
     * @return
     */
    public int getValue(int sheetIdx, int colIdx, String target) throws IOException {
        String value;
        int result = -1;
        XSSFWorkbook workbook = null;

        try {
        	FileInputStream fis = new FileInputStream(inputPath);
            workbook = new XSSFWorkbook(fis);
            XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

            int rows = sheet.getPhysicalNumberOfRows(); // 해당 시트의 행의 개수

	        for( int rownum = 0; rownum < rows; rownum++){
	        	XSSFRow row = sheet.getRow(rownum);

	        	if (row != null) {
	        		XSSFCell cell = row.getCell(colIdx-1);

	        		if (cell != null) {
	        			value = "";
	        			switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
		        			case NUMERIC:
		        				value = cell.getNumericCellValue() + "";
		        				break;
		        			case STRING:
		        				value = cell.getStringCellValue() + "";
		        				break;
		        			case BLANK:
		        				value = cell.getBooleanCellValue() + "";
		        				break;
		        			case ERROR:
		        				value = cell.getErrorCellValue() + "";
		        				break;
		        			default  :
		    	        	    value ="" ;
		    	        	    break;
	        			}

	        			if (target.equals(value)) {
	        				//System.out.println(value);
	        				result = rownum + 1;
	        			}
	        		}
	        	}
	        }
        } catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		} finally {
        	if(workbook != null) {
        		workbook.close();
        	}
        }

        return result;
    }

    /**
     * 파일에 존재하는 모든데이터를 가져오는 기능
     * 필요하다면 파라미터 받는부분 수정해야함  (참고용)
     */
    @Deprecated
    public void getValues() throws IOException {
    	XSSFWorkbook workbook = null;
    	try {

    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	int sheetNum = workbook.getNumberOfSheets();

	    	for( int loop = 0; loop < sheetNum; loop++){
	    		XSSFSheet sheet = workbook.getSheetAt(loop);
	    		int rows = sheet.getPhysicalNumberOfRows(); // 해당 시트의 행의 개수

	    		for( int rownum = 0; rownum < rows; rownum++){
	    			XSSFRow row = sheet.getRow(rownum);

	    			if (row != null) {
	    				int cells = row.getPhysicalNumberOfCells();
	    				for (int columnIndex = 0; columnIndex <= cells; columnIndex++) {
	    					XSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
	    					if (cell != null) {
	    						String value = "";

	    						switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
		    						case NUMERIC:
		    							value = cell.getNumericCellValue() + "";
		    							break;
		    						case STRING:
		    							value = cell.getStringCellValue() + "";
		    							break;
		    						case BLANK:
		    							value = cell.getBooleanCellValue() + "";
		    							break;
		    						case ERROR:
		    							value = cell.getErrorCellValue() + "";
		    							break;
		    						default  :
		    			        	    value ="" ;
		    			        	    break;
	    						}

	    						if (!("false").equals(value)) {
	    							System.out.println(value);
	    						}
	    					}
	    				}
	    			}
	    		}
	    	}
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		} finally {
			if(workbook != null) {
				workbook.close();
			}
    	}
    }

    /**
     * <pre>
     * 새로운 시트를 만들고 데이터 입력 (참고용)
     * </pre>
     * @param sheetNm : 생성할 시트명
     * @param rowIdx : 몇번째 행에 작성
     * @param colIdx : 몇번째 컬럼에 작성
     * @param cntnt : 추가된 row에 작성할 내용
     */
    @Deprecated
    public void setValue(String sheetNm, int rowIdx, int colIdx, String cntnt) throws IOException {
    	XSSFWorkbook workbook =null;
    	FileOutputStream outFile = null;
    	try {

    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	//XSSFWorkbook workbook = new XSSFWorkbook();         // 새 엑셀 생성
        	outFile = new FileOutputStream(outputPath);

	    	XSSFSheet sheet = workbook.createSheet(sheetNm);    // 새 시트(Sheet) 생성
	    	XSSFRow row = sheet.createRow(rowIdx);              // 행의 인덱스
	    	XSSFCell cell = row.createCell(colIdx);             // 컬럼의 인덱스
	    	cell.setCellValue(cntnt);                           // 생성한 셀에 데이터 삽입
	    	workbook.write(outFile);
	    }catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
			if(outFile != null) {
				outFile.close();
			}
    	}

    }

    /**
     * <pre>
     * 기존에 존재하는 시트에 데이터 입력 (참고용)
     * </pre>
     * @param sheetIdx : 몇번째 엑셀시트
     * @param rowIdx : 몇번째 행에 작성
     * @param colIdx : 몇번째 컬럼에 작성
     * @param cntnt : 추가된 row에 작성할 내용
     */
    @Deprecated
    public void setValue(int sheetIdx, int rowIdx, int colIdx, String cntnt) throws IOException {
    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;
    	try {

    		FileInputStream fis = new FileInputStream(inputPath);
        	 workbook = new XSSFWorkbook(fis);
        	 outFile = new FileOutputStream(outputPath);

    		XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);   // 사용할 시트 인덱스
        	XSSFRow row = sheet.createRow(rowIdx-1);                    // 행의 인덱스
        	XSSFCell cell = row.createCell(colIdx-1);                   // 컬럼의 인덱스
        	cell.setCellValue(cntnt);                                   // 생성한 셀에 데이터 삽입

        	// 폰트 및 개행 설정
        	try {
				setForm(sheetIdx, sheet, row, workbook, rowIdx, colIdx, cell, cntnt);
        	} catch (RuntimeException e) {
        		Log.logAML(Log.ERROR, this, "getValue", e);
			} catch (Exception e) {
				Log.logAML(Log.ERROR, this, "getValue", e);
			}
        	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(outFile != null) {
				outFile.close();
			}
			if(workbook != null) {
				workbook.close();
			}
    	}
    }


    /**
     * <pre>
     * 같은 행의 데이터를 리스트로 받아서 처리
     * </pre>
     * @param sheetIdx : 몇번째 엑셀시트
     * @param row_arr : 로우인덱스 리스트
     * @param col_arr : 컬럼인덱스 리스트
     * @param cntnt_arr : 추가된 row에 작성할 내용 리스트
     * @throws SQLException
     */
    public void setValues(int sheetIdx, List<Object> row_arr, List<Object> col_arr, List<Object> cntnt_arr) throws IOException {
    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;
    	try {
    		FileInputStream fis = new FileInputStream(inputPath);
        	 workbook = new XSSFWorkbook(fis);
        	 outFile = new FileOutputStream(outputPath);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

        	XSSFRow newRow;
        	XSSFCell cellData;

	    	for (int i = 0; i < row_arr.size(); i++) {
	    		//newRow = sheet.createRow((int)row_arr.get(i)-1);
	    		newRow = sheet.getRow((Integer)row_arr.get(i)-1);

	    		cellData = newRow.createCell((Integer)col_arr.get(i)-1);

	    		if (cntnt_arr.get(i) instanceof Integer) {
	        		cellData.setCellValue((Integer)cntnt_arr.get(i));
	    		} else if (cntnt_arr.get(i) instanceof Double) {
	    			cellData.setCellValue((Double)cntnt_arr.get(i));
	        	} else {
	        		cellData.setCellValue((String)cntnt_arr.get(i));
	        	}


	    		// 폰트 및 개행 설정
	        	try {
					setForm(sheetIdx, sheet, newRow, workbook, (Integer)row_arr.get(i), (Integer)col_arr.get(i), cellData, cntnt_arr.get(i));
	        	} catch (RuntimeException e) {
	        		Log.logAML(Log.ERROR, this, "getValue", e);
				} catch (Exception e) {
					Log.logAML(Log.ERROR, this, "getValue", e);
				}
	    	}


	    	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(outFile != null) {
				outFile.close();
			}
			if(workbook != null) {
				workbook.close();
			}
    	}
    }

    /**
     * <pre>
     * CTR 보고항목 내용 엑셀 생성
     * </pre>
     * @param sheetIdx : 몇번째 엑셀시트
     * @param row_arr : 로우인덱스 리스트
     * @param col_arr : 컬럼인덱스 리스트
     * @param cntnt_arr : 추가된 row에 작성할 내용 리스트
     * @throws SQLException
     */
    public void setValues2(int sheetIdx, List<Object> row_arr, List<Object> col_arr, List<Object> cntnt_arr) throws IOException {
    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;
    	try {
    		FileInputStream fis = new FileInputStream(inputPath);
    		workbook = new XSSFWorkbook(fis);
    		outFile = new FileOutputStream(outputPath);

        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);
        	XSSFRow newRow;
        	XSSFCell cellData;
            XSSFCellStyle cs = workbook.createCellStyle();

            //테두리 설정
            cs.setBorderTop(BorderStyle.THIN);
            cs.setBorderRight(BorderStyle.THIN);
            cs.setBorderBottom(BorderStyle.THIN);
            cs.setBorderLeft(BorderStyle.THIN);

	    	for (int i = 0; i < row_arr.size(); i++) {
	    		int row = (Integer)row_arr.get(i)-1;
	    		int col = (Integer)col_arr.get(i)-1;

	    		newRow = sheet.getRow(row);
	    		if (newRow == null) {
	    			newRow = sheet.createRow(row);
	    		}

	    		cellData = newRow.createCell(col);
	    		cellData.setCellStyle(cs);

	    		if (cntnt_arr.get(i) instanceof Integer) {
	        		cellData.setCellValue((Integer)cntnt_arr.get(i));
	    		} else if (cntnt_arr.get(i) instanceof Double) {
	    			cellData.setCellValue((Double)cntnt_arr.get(i));
	        	} else {
	        		cellData.setCellValue((String)cntnt_arr.get(i));
	        	}
	    	}
	    	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "setValues2", e);
		}finally {
			if(outFile != null) {
				outFile.close();
			}
			if(workbook != null) {
				workbook.close();
			}
    	}
    }

    /**
     * <pre>
     * 엑셀 셀 병합 (참고용)
     * </pre>
     * @param sheetIdx : 엑셀시트 인덱스
     * @param rowIdx : 시작 행 인덱스
     * @param colIdx : 시작 컬럼 인덱스
     * @param gubun : 셀병합방향 ('row' | 'col')
     * @param lst : 셀병합사이즈 (0: 1cell, 1: 2cell병합)
     * @throws SQLException
     */
    @Deprecated
    public void mergeCell(int sheetIdx, int rowIdx2, int colIdx2, String gubun, List<Object> lst) throws IOException {
    	int rowIdx = rowIdx2;
    	int colIdx = colIdx2;

    	rowIdx -= 1;
    	colIdx -= 1;
    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;

    	try {
    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	outFile = new FileOutputStream(outputPath);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);



	    	for (int i = 0; i < lst.size(); i++) {
	    		//병합 영역 설정
	    		if ((Integer)lst.get(i) > 0) {
	    			if("row".equals(gubun)) {
	    				sheet.addMergedRegion(new CellRangeAddress(
	    						rowIdx 						//시작 행번호
	    						,rowIdx+(Integer)lst.get(i) 	//마지막 행번호
	    						,colIdx 					//시작 열번호
	    						,colIdx  					//마지막 열번호
	    						));
	    			} else if ("col".equals(gubun)) {
	    				sheet.addMergedRegion(new CellRangeAddress(
	    						rowIdx 						//시작 행번호
	    						,rowIdx 					//마지막 행번호
	    						,colIdx 					//시작 열번호
	    						,colIdx+(Integer)lst.get(i)  	//마지막 열번호
	    						));
	    			}
	    		}

	    		colIdx += (Integer)lst.get(i)+1;
	    	}

	    	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
			if(outFile != null) {
				outFile.close();
			}
    	}

    }

    /**
     * <pre>
     * 엑셀 행과 행사이에 새로운 행을 삽입 (참고용)
     * </pre>
     * @param sheetIdx : 엑셀시트 인덱스
     * @param rowIdx : 시작 행 인덱스
     * @throws SQLException
     */
    @Deprecated
    public void addRow(int sheetIdx, int rowIdx2) throws IOException {
    	int rowIdx = rowIdx2;

    	rowIdx = rowIdx - 1;
    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;

    	try {
    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	outFile = new FileOutputStream(outputPath);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

	    	//int createNewRowAt = 9; //Add the new row between row 9 and 10
	    	sheet.shiftRows(rowIdx, sheet.getLastRowNum(), 1, true, false); //중간에 파라미터값 1은 추가될 행의 개수
	    	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
    		if(outFile != null) {
    			outFile.close();
    		}
    	}

    }

    /**
     * <pre>
     * 엑셀 행과 행사이에 새로운 행을 삽입
     * 웹 Dev_Grid데이터를 엑셀파일에 저장할때 사용
     * </pre>
     * @param sheetIdx : 엑셀시트 인덱스
     * @param rowIdx : 시작 행 인덱스
     * @param colIdx : 시작 컬럼 인덱스
     * @param arr : 추가된 row에 작성할 내용 리스트
     * @throws SQLException
     */
    public void addRow(int sheetIdx, int rowIdx2, int colIdx2, List<Object> arr) throws IOException {
    	int rowIdx = rowIdx2;
    	int colIdx = colIdx2;
    	rowIdx = rowIdx - 1;

    	FileOutputStream outFile = null;
    	FileInputStream fis = null;
    	XSSFWorkbook workbook = null;

    	try {

    	 fis = new FileInputStream(inputPath);
    	 workbook = new XSSFWorkbook(fis);
    	 XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

    	//int createNewRowAt = 9; //Add the new row between row 9 and 10
    	 sheet.shiftRows(rowIdx, sheet.getLastRowNum(), 1, true, false); //중간에 파라미터값 1은 추가될 행의 개수

    	// sheet부분에 행을 새로 생성한다.
    	XSSFRow newRow = sheet.createRow(rowIdx);
    	newRow = sheet.getRow(rowIdx);

    	XSSFCell cellData;
    	 outFile = new FileOutputStream(outputPath);

	    	for (int i = 0; i < arr.size(); i++) {
	    		cellData = newRow.createCell((short)colIdx-1);
	    		if (arr.get(i) instanceof Integer) {
	        		cellData.setCellValue((Integer)arr.get(i));
	        	} else if (arr.get(i) instanceof Double) {
	    			cellData.setCellValue((Double)arr.get(i));
	        	} else {
	        		cellData.setCellValue((String)arr.get(i));
	        	}

	    		// 폰트 및 개행 설정
	    		try {
					setForm(sheetIdx, sheet, newRow, workbook, rowIdx, colIdx, cellData, arr.get(i));
	    		} catch (RuntimeException e) {
	    			Log.logAML(Log.ERROR, this, "getValue", e);
				} catch (Exception e) {
					Log.logAML(Log.ERROR, this, "getValue", e);
				}
	    		colIdx++;
	    	}

	    	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
			if(outFile != null) {
				outFile.close();
			}
    	}

    }
    /**
     * <pre>
     * 엑셀 행과 행사이에 새로운 행을 삽입
     * 웹 Dev_Grid데이터를 엑셀파일에 저장할때 사용
     * </pre>
     * @param sheetIdx : 엑셀시트 인덱스
     * @param rowIdx : 시작 행 인덱스
     * @param colIdx : 시작 컬럼 인덱스
     * @param lst : 추가된 row에 작성할 내용 리스트
     * @param gubun : 셀병합방향 ('row' | 'col')
     * @param mergeSizeList : 셀병합사이즈 (0: 1cell, 1: 2cell병합)
     * @throws SQLException
     */
    public void addRow(int sheetIdx, int rowIdx2, int colIdx2, List<Object> lst, String gubun, List<Object> mergeSizeList) throws IOException {
    	int rowIdx = rowIdx2;
    	int colIdx = colIdx2;

    	rowIdx -= 1;
    	colIdx -= 1;
    	FileInputStream fis = null;
    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;
    	try {
    		fis = new FileInputStream(inputPath);

        	workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

        	//int createNewRowAt = 9; //Add the new row between row 9 and 10
        	sheet.shiftRows(rowIdx, sheet.getLastRowNum(), 1, true, false); //중간에 파라미터값 1은 추가될 행의 개수

        	XSSFRow newRow = sheet.createRow(rowIdx);
        	XSSFCell cellData;
        	for (int i = 0; i < lst.size(); i++) {
        		//병합 영역 설정
        		if ((Integer)mergeSizeList.get(i) > 0) {
        			if("row".equals(gubun)) {
        				sheet.addMergedRegion(new CellRangeAddress(
        						rowIdx 						//시작 행번호
        						,rowIdx+(Integer)mergeSizeList.get(i) 	//마지막 행번호
        						,colIdx 					//시작 열번호
        						,colIdx  					//마지막 열번호
        						));
        			} else if ("col".equals(gubun)) {
        				sheet.addMergedRegion(new CellRangeAddress(
        						rowIdx 						//시작 행번호
        						,rowIdx 					//마지막 행번호
        						,colIdx 					//시작 열번호
        						,colIdx+(Integer)mergeSizeList.get(i)  	//마지막 열번호
        						));
        			}
        		}

        		newRow = sheet.getRow(rowIdx);
        		cellData = newRow.createCell((short)colIdx);
        		if (lst.get(i) instanceof Integer) {
            		cellData.setCellValue((Integer)lst.get(i));
            	} else if (lst.get(i) instanceof Double) {
        			cellData.setCellValue((Double)lst.get(i));
            	} else {
            		cellData.setCellValue((String)lst.get(i));
            	}

        		// 폰트 및 개행 설정
        		try {
    				setForm(sheetIdx, sheet, newRow, workbook, rowIdx, colIdx, cellData, lst.get(i));
        		} catch (RuntimeException e) {
        			Log.logAML(Log.ERROR, this, "addRow", e);
    			} catch (Exception e) {
    				Log.logAML(Log.ERROR, this, "addRow", e);
    			}
        		colIdx += (Integer)mergeSizeList.get(i)+1;
        	}

        	outFile = new FileOutputStream(outputPath);
        	workbook.write(outFile);
    	}catch(IOException e){
    	    Log.logAML(Log.ERROR, this, "addRow", e);
    	    throw e;
    	}finally {
    	    if(outFile != null) {
    		outFile.close();
    	    }
    	    if(workbook != null) {
    		workbook.close();
    	    }
    	    if(fis != null) {
    		fis.close();
    	    }
    	}
    }

    /**
     * <pre>
     * 엑셀 데이터 중간에 존재하는 행을 삭제 (참고용)
     * </pre>
     * @param sheetIdx : 몇번째 엑셀시트
     * @param delIdx : 삭제할 행의 인덱스
     * @param rowCnt : 삭제할 행의 카운트 (선택한 행의 위쪽으로 지워나간다, 값 : '음수(-) + 삭제한 행 카운트')
     */
    @Deprecated
    public void delRow(int sheetIdx, int delIdx, int rowCnt) throws IOException {

    	XSSFWorkbook workbook = null;
    	FileOutputStream outFile = null;


    	try {

        	FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);
        	outFile = new FileOutputStream(outputPath);


	    	int lastRowNum=sheet.getLastRowNum();
	    	if(delIdx>=0 && delIdx<lastRowNum){
	    		sheet.shiftRows(delIdx, lastRowNum, rowCnt);  //마지막 파라미터 -1은 삭제할 행의 개수
	    	}
	    	if(delIdx==lastRowNum){
	    		XSSFRow removingRow=sheet.getRow(delIdx);
	    		if(removingRow!=null){
	    			sheet.removeRow(removingRow);
	    		}
	    	}
	    	workbook.write(outFile);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		} finally {
			if(workbook != null) {
				workbook.close();
			}
			if(outFile != null) {
				outFile.close();
			}
    	}

    }

    /**
     * <pre>
     * 셀의 병합여부를 확인
     * 병합 : true
     * 일반 셀 : false
     * </pre>
     * @param sheet
     * @param rowIdx
     * @param colIdx
     * @return
     */
/*    @SuppressWarnings("unused")
	private boolean isMerged(int sheetIdx, int rowIdx, int colIdx) throws IOException {
    	XSSFWorkbook workbook =null;
    	try {

    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

	    	for(int i = 0; i < sheet.getNumMergedRegions(); ++i) {
	    		CellRangeAddress range = sheet.getMergedRegion(i);

	//            String message = String.format("%d - %d - %d - %d", range.getFirstRow(), range.getLastRow(), range.getFirstColumn(), range.getLastColumn());
	//            System.out.println(message);

	    		if(rowIdx >= range.getFirstRow() && rowIdx <= range.getLastRow() && colIdx >= range.getFirstColumn() && colIdx <= range.getLastColumn()) {
	    			return true;
	    		}
	    	}
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
    	}
	    return false;
    }
*/
    /**
     * <pre>
     * 병합된 셀의 row와 column 인덱스를 리턴
     *
     * @return
     * result[0]	병합셀의 첫번째행
     * result[1]	병합셀의 마지막행
     * result[2]	병합셀의 첫번째컬럼
     * result[3]	병합셀의 마지막컬럼
     * </pre>
     */
/*	@SuppressWarnings("unused")
	private int[] mergedCellIndex(int sheetIdx, int rowIdx, int colIdx) throws IOException {
		int[] result = null;
		XSSFWorkbook workbook = null;

    	try {
    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);

	    	for(int i = 0; i < sheet.getNumMergedRegions(); ++i) {
	    		CellRangeAddress range = sheet.getMergedRegion(i);

	//            String message = String.format("%d - %d - %d - %d", range.getFirstRow(), range.getLastRow(), range.getFirstColumn(), range.getLastColumn());
	//            System.out.println(message);

	    		if(rowIdx >= range.getFirstRow() && rowIdx <= range.getLastRow() && colIdx >= range.getFirstColumn() && colIdx <= range.getLastColumn()) {
	    			result = new int[4];

					result[0] = range.getFirstRow();
					result[1] = range.getLastRow();
					result[2] = range.getFirstColumn();
					result[3] = range.getLastColumn();
	    		}
	    	}
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
    	}

    	return result;
    }
*/
    /**
     * 10개의 파라미터를 받아서 ArrayList에 담아서 리턴 (널값은 체크해서 없애준다)
     */
    public List<Object> setList(Object param1, Object param2, Object param3, Object param4, Object param5
    		, Object param6, Object param7, Object param8, Object param9, Object param10) throws IOException {

    	List<Object> arr = new ArrayList<Object>();
    	arr.add(param1);
    	arr.add(param2);
    	arr.add(param3);
    	arr.add(param4);
    	arr.add(param5);
    	arr.add(param6);
    	arr.add(param7);
    	arr.add(param8);
    	arr.add(param9);
    	arr.add(param10);

    	for (int i = 0; i < arr.size(); i++) {
    		if (arr.get(i) == null) {
				arr.remove(i);
				i--;
			}
		}
    	return arr;
    }

    //파일복사
    public void fileCopy(String inFilePath2, String outFilePath2) throws IOException {

    	String inFilePath = inFilePath2;
    	String outFilePath = outFilePath2;
    	FileInputStream fis = null;
    	FileOutputStream fos = null;

    	if(inFilePath!=null && !"".equals(inFilePath)) {
    		inFilePath = inFilePath.replaceAll("/", "/");
    	}

    	if(outFilePath!=null && !"".equals(outFilePath)) {
    		outFilePath = outFilePath.replaceAll("/", "/");
    	}
    	try {
    		 fis = new FileInputStream(inFilePath);
        	 fos = new FileOutputStream(outFilePath);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			Log.logAML(Log.ERROR, this, "fileCopy", e);
		}

    	try{
    		int data = 0;

        	while (true){
        		data = fis.read();
            	if(data == -1){
            		break;
            	}
            	fos.write(data);
            }

    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
    		fis.close();
        	fos.close();
    	}

    }

    //파일삭제
    public void fileDelete(String filePath2) throws IOException {

    	String filePath = filePath2;
    	if(filePath!=null && !"".equals(filePath)) {
    		filePath = filePath.replaceAll("/", "/");
    	}
		File file = new File(filePath);
		if (file.isFile()) {
			file.delete();
			System.out.println("Deleted File==>"+filePath);
		} else {
			System.out.println("Not Exist==>" + filePath);
		}
    }

    /**
     * <pre>
     * 폰트,정렬 및 개행 설정
     * </pre>
     */
    public void setForm(int sheetIdx, XSSFSheet sheet, XSSFRow row, XSSFWorkbook workbook, int rowIdx, int colIdx, XSSFCell cell, Object cntnt) throws IOException {
    	boolean flag = false;
    	int nextPos = 0;
		int lineCnt = 1;
		int bColor = IndexedColors.GREY_25_PERCENT.getIndex();

    	CellStyle style = workbook.createCellStyle();
    	XSSFFont font1 = workbook.createFont();

//--------------------- dafault 포맷 셋팅 -------------------------------------------------------------------------
    	/*테두리 설정
    	if (isMerged(sheetIdx, rowIdx, colIdx)) {	//병합셀여부 체크
    		int[] mergeCell = mergedCellIndex(sheetIdx, rowIdx, colIdx);	//병합된 셀의 row, column의 인덱스범위 리턴
    		int nRowIdx = 0;
    		int nColIdx = 0;
    		for (int i = mergeCell[0]; i <= mergeCell[1]; i++) {
    			nRowIdx = i;
    			for (int j = mergeCell[2]; j <= mergeCell[3]; j++) {
    				nColIdx = j;
    				setForm2(sheetIdx, nRowIdx, nColIdx);	//병합셀에 테두리 만들어줌
				}
			}
    	}*/

    	style.setBottomBorderColor((short)bColor);
    	style.setLeftBorderColor((short)bColor);
    	style.setRightBorderColor((short)bColor);
    	style.setTopBorderColor((short)bColor);
    	style.setBorderTop(BorderStyle.THIN);
    	style.setBorderRight(BorderStyle.THIN);
    	style.setBorderBottom(BorderStyle.THIN);
    	style.setBorderLeft(BorderStyle.THIN);

    	//배경색 설정
    	//style.setFillForegroundColor(IndexedColors.LAVENDER.getIndex()); //주의: 반드시 ForegroundColor를 사용(BackgroundColor가 아님)
    	//style.setFillPattern(CellStyle.SOLID_FOREGROUND);

    	// font 설정
		font1.setColor(Font.COLOR_NORMAL);  				// 검정
		font1.setFontHeight((short)(10*20));  				// 크기
		//font1.setBoldweight((short)font1.BOLDWEIGHT_BOLD); 	// bold
		font1.setFontName("맑은 고딕");  					// 글씨체
		style.setFont(font1);

		//정렬 설정
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.TOP);

//----------------------------------------------------------------------------------------------------------------

		/*
		 * 가운데정렬이 필요한 셀.
		 *
		 * 1. 2.자금세탁 위험평가 개요 시트에 2개 그리드의 4개컬럼 (출처, 최근 개정일, 담당부서, 수행 일자)
		 * 2. 5.자금세탁 위험평가 시트 첫번째 그리드
		 * 3. 6.결과 시트
		 * 4. 7.주요 발견사항 및 개선사항시트 그리드의 1개컬럼 (입력 날짜)
		 */
    	if ( (sheetIdx==4&&(colIdx==5||colIdx==6)) || (sheetIdx==7&&rowIdx<8) || sheetIdx==8  || (sheetIdx==9&&colIdx==26) ) {
    		style.setAlignment(HorizontalAlignment.CENTER);

    	/*
    	 * 가운데정렬 + 수직정렬.
    	 *
    	 * 1. 3.회사 현황 시트에서 '1.회사 연혁'데이터를 제외한 모든 셀
    	 */
    	} else if ( (sheetIdx==5&&rowIdx!=4) ) {
    		style.setAlignment(HorizontalAlignment.CENTER);
    		style.setVerticalAlignment(VerticalAlignment.CENTER);

    	/*
    	 * 	개행이 필요한 셀.
    	 *
    	 * 1. 1.Executive Summary 시트
    	 * 2. 2.자금세탁 위험평가 개요 시트에 '■ 자금세탁 위험평가 수행을 위한 배경 및 목적'데이터셀
    	 * 3. 2.자금세탁 위험평가 개요 시트에 2번째그리드 '상세 수행 내용'컬럼
    	 * 4. 3.회사 현황 시트에서 '1.회사 연혁'데이터셀
    	 * 5. 7.주요 발견사항 및 개선사항 시트
    	 * 6. 8.별첨 시트
    	 */
    	} else if ( sheetIdx==3 || (sheetIdx==4&&rowIdx==4) || (sheetIdx==4&&colIdx==4&&rowIdx>10) || (sheetIdx==5&&rowIdx==4) || sheetIdx==9 || sheetIdx==10 ) {
    		//높이 계산
    		if (cntnt.toString().length() > 1){
    			AttributedString attrStr = new AttributedString(cntnt.toString());
    			FontRenderContext frc = new FontRenderContext(null, true, true);
    			LineBreakMeasurer measurer = new LineBreakMeasurer(attrStr.getIterator(), frc);

    			float columnWidthInPx = sheet.getColumnWidthInPixels(colIdx);
    			while (measurer.getPosition() < cntnt.toString().length()) {
    				nextPos = measurer.nextOffset(columnWidthInPx);
    				lineCnt++;
    				measurer.setPosition(nextPos);
    			}
    		}

    		//줄 높이 설정
    		if (lineCnt >= 1){
    			flag = true;
    			row.setHeightInPoints(sheet.getDefaultRowHeightInPoints() * (lineCnt/2) * /* fudge factor */ 1f);
    		}

    		// 여러줄 표시 (개행)
    		style.setWrapText(flag);
		} else if (sheetIdx==2 && rowIdx >= 57 && colIdx ==2) {
			  style.setAlignment(HorizontalAlignment.LEFT);
			  style.setWrapText(true);
		}


    	// cell 설정  실행
    	cell.setCellStyle(style);
    }

    /**
     * <pre>
     * 병합셀 테두리 설정
     * </pre>
     */
    public void setForm2(int sheetIdx, int rowIdx, int colIdx) throws IOException {
    	XSSFWorkbook workbook = null;
    	try {

    		FileInputStream fis = new FileInputStream(inputPath);
        	workbook = new XSSFWorkbook(fis);
        	XSSFSheet sheet = workbook.getSheetAt((short)sheetIdx-1);   // 사용할 시트 인덱스
        	XSSFRow row = sheet.createRow(rowIdx-1);                    // 행의 인덱스
        	XSSFCell cell = row.createCell(colIdx-1);                   // 컬럼의 인덱스

        	int bColor = IndexedColors.GREY_25_PERCENT.getIndex();
        	CellStyle style = workbook.createCellStyle();


	    	style.setBottomBorderColor((short) bColor);
	    	style.setLeftBorderColor((short)bColor);
	    	style.setRightBorderColor((short)bColor);
	    	style.setTopBorderColor((short)bColor);
	    	style.setBorderTop(BorderStyle.THIN );
			style.setBorderRight(BorderStyle.THIN );
			style.setBorderBottom(BorderStyle.THIN );
			style.setBorderLeft(BorderStyle.THIN );

			cell.setCellStyle(style);
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally{
			if(workbook != null) {
				workbook.close();
			}
    	}
    }

    //4.자금세탁 위험평가 방법론시트 인쇄영역 설정
    public void setExcelPrintArea() throws IOException {
    	FileInputStream fis = null;
    	try {
   		 fis = new FileInputStream(inputPath);

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			Log.logAML(Log.ERROR, this, "setExcelPrintArea", e);
		}
    	XSSFWorkbook workbook = new XSSFWorkbook(fis);

    	System.out.println("startColIdx1==>"+startColIdx1);
    	System.out.println("startColIdx2==>"+startColIdx2);
    	System.out.println("startColIdx3==>"+startColIdx3);
    	System.out.println("gridCnt1==>"+gridCnt1);
    	System.out.println("gridCnt2==>"+gridCnt2);
    	System.out.println("gridCnt3==>"+gridCnt3);
    	try {
	    	if ("[별첨 1] AML 업무 프로세스 목록".equals(getValue(6, startColIdx1, 2))) {
	    		workbook.setPrintArea(6, 0, 13, startColIdx1-1, startColIdx1+2+gridCnt1-1);	//파라미터 sheetIdx, startColumn, endColumn, startRow, endRow
	    	} else if ("[별첨 2] 자금세탁 위험요소 목록".equals(getValue(6, startColIdx2, 2))) {
	    		workbook.setPrintArea(6, 0, 13, startColIdx2-1, startColIdx2+3+gridCnt2-1);
	    	} else if ("[별첨 3] 내부통제 점검항목 목록".equals(getValue(6, startColIdx3, 2))) {
	    		workbook.setPrintArea(6, 0, 13, startColIdx3-1, startColIdx3+3+gridCnt3-1);
	    	}
    	}catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, this, "getValue", e);
		}finally {
			if(workbook != null) {
				workbook.close();
			}
    	}
    }

    /**
     * <pre>
     * 폰트 및 정렬 설정2 (참고용)
     * </pre>
     */
    @Deprecated
    public void setCell2(XSSFSheet sheet, XSSFWorkbook workbook, XSSFCell cellData) throws IOException {
    	CellStyle style_2 = workbook.createCellStyle();
    	XSSFFont font2 = workbook.createFont();

    	// font2 설정
    	font2.setColor(Font.COLOR_RED);  // 색
    	font2.setFontHeight((short)(10*20));  // 크기
    	font2.setBold(true); // bold
    	font2.setFontName("맑은 고딕");  // 글씨체
    	style_2.setFont(font2);

    	//정렬 설정
    	style_2.setAlignment(HorizontalAlignment.CENTER);
    	style_2.setVerticalAlignment(VerticalAlignment.CENTER);
    	// cell 설정  실행
    	cellData.setCellStyle(style_2);
    }

    //jsw (참고용)
    @Deprecated
    public void setCell2(XSSFRow row, int nCell, Font font, XSSFColor bgColor, String cellValue)
    {

        XSSFSheet sheet = row.getSheet();
        XSSFWorkbook wb = sheet.getWorkbook();

        int nCount = 0;
        String[] remark = cellValue.split("\\|");   //분리자 |
        String description = "";

        //줄 높이 계산
        for (int k = 0; k < remark.length; k++)
        {
            if (remark[k].length() > 0)
            {
                if (nCount == 0) {
                    description += remark[k];
                }
                else {
                    description += "\r\n"+ remark[k];
                }

                nCount++;
            }
        }

        //줄 높이 설정
        if (nCount > 1) {
            row.setHeightInPoints((nCount * sheet.getDefaultRowHeightInPoints()));
        }

        //스타일 설정
        XSSFCellStyle cs = wb.createCellStyle();
        cs.setFont(font);

        //배경색 설정
        cs.setFillForegroundColor(bgColor); //주의: 반드시 ForegroundColor를 사용(BackgroundColor가 아님)
        cs.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        
        //정렬 설정
        cs.setAlignment(HorizontalAlignment.LEFT);
        cs.setVerticalAlignment(VerticalAlignment.CENTER);

        //테두리 설정
        cs.setBorderTop(BorderStyle.THIN);
        cs.setBorderRight(BorderStyle.THIN);
        cs.setBorderBottom(BorderStyle.THIN);
        cs.setBorderLeft(BorderStyle.THIN);

        //여러 줄 표시할 경우 꼭 true
        cs.setWrapText(true);

        //Cell 생성
        XSSFCell cell = row.createCell(nCell);
        cell.setCellStyle(cs);
        cell.setCellValue(new XSSFRichTextString(description));

        sheet.autoSizeColumn(nCell);    //너비를 자동으로 다시 설정
    }

}
