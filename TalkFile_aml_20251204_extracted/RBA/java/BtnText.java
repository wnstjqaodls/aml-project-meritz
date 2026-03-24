/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.basic.jspeed.base.el;

import java.util.HashMap;

/******************************************************************************************************************************************
 * @Description 버튼 텍스트 정의
 *              - AMLExpress 에서 항상 override 하여 사용하도록 한다
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Java        6.0 이상
 * @Author      박상훈
 * @Since       2017. 10. 12.
 ******************************************************************************************************************************************/

public enum BtnText
{
    /**************************************************************************************************************************************
     * Constants
     **************************************************************************************************************************************/

    // [ A ]
    A                       ("ko-KR,승인","en-US,Approval","ja-JP,承認","zh-CN,核准")
   ,ALL                     ("ko-KR,전체","en-US,All","ja-JP,すべて","zh-CN,全部")
   ,AML001_01_01            ("ko-KR,추출","en-US,Extract","ja-JP,抽出","zh-CN,提取")
   ,AML001_01_02            ("ko-KR,거래내역","en-US,Transaction history")
   ,AML001_01_03            ("ko-KR,마트 테이블 배치","en-US,Allocation of mart table")
   ,AML001_01_05            ("ko-KR,STR룰","en-US,STR Rules")
   ,AML001_01_06            ("ko-KR,케이스룰 쿼리풀","en-US,Case rule query pool")
   ,AML_00_00_00_00_001     ("ko-KR,홈","en-US,Home","ja-JP,ホ―ム","zh-CN,Home")
   ,AML_00_02_01_01_009     ("ko-KR,월","en-US, M","ja-JP,月","zh-CN,月")
   ,AML_00_02_01_01_010     ("ko-KR,당일","en-US,Today")
   ,AML_00_02_01_01_011     ("ko-KR,전일","en-US,Yesterday","ja-JP,前日","zh-CN,前日")
   ,AML_00_02_01_01_012     ("ko-KR,보고대상","en-US,Report target")
   ,AML_00_02_01_01_013     ("ko-KR,보고완료","en-US,Report completion","ja-JP,報告完了")
   ,AML_10_02_01_01_btn_02  ("ko-KR,등록","en-US,Register")
   ,AML_10_03_01_01_btn_04  ("ko-KR,파일 Upload","en-US,Upload")
   ,AML_10_03_01_01_btn_05  ("ko-KR,Batch 실행","en-US,Batch execution")
   ,AML_10_03_02_01_btn_02  ("ko-KR,정확도 기준 변경","en-US,Accuracy Level Change")
   ,AML_10_04_01_02_sbtn_01 ("ko-KR,확인","en-US,Confirm","ja-JP,確認")
   ,AML_10_08_01_01_btn_06  ("ko-KR,거절취소결재요청","en-US,Request-Allowing Transaction")
   ,AML_10_08_01_01_btn_07  ("ko-KR,거래거절결재요청","en-US,Request-Rejecting Transaction")
   ,AML_10_10_01_01_btn_05  ("ko-KR,확정","en-US,Confirmation","ja-JP,確定")
   ,AML_10_11_01_01_sbtn_03 ("ko-KR,파일 Upload","en-US,Upload")
   ,AML_10_22_01_01_btn_01  ("ko-KR,직원등록","en-US,Regist Employee")
   ,AML_20_01_01_01_sbtn_02 ("ko-KR,결재반려","en-US,Delete","ja-JP,削除","zh-CN,批准返回")
   ,AML_20_01_01_01_sbtn_03 ("ko-KR,보고제외","en-US,Confirmation in charge of report")
   ,AML_20_01_01_01_sbtn_04 ("ko-KR,결재처리","en-US,Giving document number")
   ,AML_20_01_01_01_sbtn_05 ("ko-KR,KoFIU보고","en-US,KoFIU report","ja-JP,JAFIC報告")
   ,AML_20_01_01_01_sbtn_06 ("ko-KR,파일생성","en-US,Create","ja-JP,ファイル生成","zh-CN,生成文件")
   ,AML_20_01_01_03_btn_01  ("ko-KR,보고서출력","en-US,Report print out","ja-JP,報告書出力")
   ,AML_20_01_01_03_btn_04  ("ko-KR,보고서전송","en-US,Report transmission","ja-JP,報告書送信")
   ,AML_20_01_01_10_sbtn_01 ("ko-KR,다 음","en-US,Next","ja-JP,次","zh-CN,下一步")
   ,AML_20_01_01_10_sbtn_02 ("ko-KR,파일첨부","en-US,File attachment","ja-JP,ファイル添付","zh-CN,添加文件")
   ,AML_20_01_01_10_sbtn_03 ("ko-KR,결 재","en-US,Approval","ja-JP,決裁","zh-CN,批准")
   ,AML_20_01_01_10_sbtn_04 ("ko-KR,저 장","en-US,Save","ja-JP,保存","zh-CN,保存")
   ,AML_20_01_01_11_sbtn_01 ("ko-KR,확인","en-US,Confirm","ja-JP,確認")
   ,AML_20_01_01_99_sbtn_01 ("ko-KR,저 장","en-US,Save","ja-JP,保存","zh-CN,保存")
   ,AML_20_01_02_01_sbtn_02 ("ko-KR,보고제외","en-US,Except report","ja-JP,報告から除外")
   ,AML_20_01_02_01_sbtn_03 ("ko-KR,보고확인","en-US,Confirm report","ja-JP,報告確認")
   ,AML_20_01_02_01_sbtn_04 ("ko-KR,책임보고확인","en-US,Responsible Report Check","ja-JP,責任報告確認")
   ,AML_20_01_10_01_sbtn_02 ("ko-KR,결재","en-US,Approval","ja-JP,決裁","zh-CN,批准")
   ,AML_20_01_10_01_sbtn_03 ("ko-KR,반려","en-US,Return")
   ,AML_20_01_10_01_sbtn_04 ("ko-KR,병합/해제","en-US,Merge")
   ,AML_20_01_10_03_btn_01  ("ko-KR,보고서출력","en-US,View Report","ja-JP,報告書出力")
   ,AML_20_01_10_03_sbtn_02 ("ko-KR,결재","en-US,Approval","ja-JP,決裁","zh-CN,批准")
   ,AML_20_01_10_03_sbtn_04 ("ko-KR,반려","en-US,Return")
   ,AML_20_01_10_06_sbtn_04 ("ko-KR,병합/해제","en-US,Merge")
   ,AML_20_02_01_01_sbtn_02 ("ko-KR,결재","en-US,Approval","ja-JP,決裁","zh-CN,批准")
   ,AML_20_02_01_01_sbtn_03 ("ko-KR,반려","en-US,Return","zh-CN,返回")
   ,AML_20_02_02_01_sbtn_01 ("ko-KR,조회","en-US,View")
   ,AML_20_02_02_01_sbtn_02 ("ko-KR,재정리 적출","en-US,Rearrange extracting","ja-JP,再整理抽出","zh-CN,再整理提取")
   ,AML_20_02_02_01_sbtn_03 ("ko-KR,파일생성","en-US,Create","ja-JP,ファイル生成","zh-CN,生成文件")
   ,AML_20_02_02_01_sbtn_07 ("ko-KR,취소파일생성","en-US,Cancel","ja-JP,取り消しファイル生成","zh-CN,生成取消文件")
   ,AML_20_02_03_01_sbtn_01 ("ko-KR,전산담당확인","en-US,Confirm in charge of IT")
   ,AML_20_02_03_01_sbtn_03 ("ko-KR,문서번호 부여","en-US,Giving document number")
   ,AML_20_02_03_01_sbtn_04 ("ko-KR,발송승인","en-US,Sending confirm","ja-JP,送信承認")
   ,AML_20_02_03_01_sbtn_05 ("ko-KR,보고 정보 변경","en-US,Report information change")
   ,AML_20_02_02_01_sbtn_04 ("ko-KR,CTR보고내역보기","en-US,CTRKofiuFile","ja-JP,CTRKofiuFile","zh-CN,CTRKofiuFile")
   ,AML_20_02_05_01_sbtn_02 ("ko-KR,취소/정정보고 생성","en-US,Create","ja-JP,ファイル生成","zh-CN,生成文件")
   ,AML_20_02_05_01_sbtn_03 ("ko-KR,파일생성","en-US,Create","ja-JP,ファイル生成","zh-CN,生成文件")
   ,AML_20_01_15_01_sbtn_01 ("ko-KR,보고(전문발송)")
   ,AML_20_01_15_01_sbtn_02 ("ko-KR,재보고")
   ,AML_20_01_15_01_sbtn_03 ("ko-KR,파일생성","en-US,Create","ja-JP,ファイル生成","zh-CN,生成文件")
   ,AML_20_01_16_01_sbtn_01 ("ko-KR,추가보고자료 요청생성")
   ,AML_20_01_16_01_sbtn_02 ("ko-KR,추가보고전문발송")
   ,AML_24_02_06_01_sbtn_01 ("ko-KR,RFI 조회","en-US,View RFI")
   ,AML_24_02_06_01_sbtn_02 ("ko-KR,신규작성","en-US,Create RFI")



   ,AML_20_07_01_01_btn_02  ("ko-KR,AllExcelDown","en-US,Excel Export","zh-CN,AllExcelDown")
   ,AML_20_08_01_01_sbtn_02 ("ko-KR,登？","en-US,N","ja-JP,登？","zh-CN,注？")
   ,AML_30_01_01_01_sbtn_02 ("ko-KR,연계분석현황","en-US,Link Analysis Status")
   ,AML_30_01_01_07_001     ("ko-KR,고객 정보","en-US,Customer Information","ja-JP,顧客情報")
   ,AML_30_01_01_07_002     ("ko-KR,계좌 정보","en-US,Account Information","ja-JP,口座情報")
   ,AML_30_01_01_07_003     ("ko-KR,거래 정보","en-US,Transaction Information","ja-JP,取引情報","zh-CN,交易信息")
   ,AML_30_01_01_07_004     ("ko-KR,관련혐의거래","en-US,Relative suspicious transaction")
   ,AML_40_03_01_01_HEADER02("ko-KR,상품코드","en-US,Product Code")
   ,AML_40_03_01_01_HEADER03("ko-KR,상품명","en-US,Product Name","ja-JP,商品名","zh-CN,商品名")
   ,AML_40_03_01_01_HEADER04("ko-KR,합계","en-US,Sum","ja-JP,合計")
   ,AML_40_03_01_01_HEADER05("ko-KR,총점","en-US,Total Score")
   ,AML_40_03_01_01_HEADER06("ko-KR,평균","en-US,Average","ja-JP,平均値","zh-CN,平均")
   ,AML_40_03_01_01_HEADER07("ko-KR,환산점수","en-US,Conversion Score")
   ,AML_40_03_01_01_HEADER08("ko-KR,점수","en-US,Score")
   ,AML_40_03_01_01_HEADER09("ko-KR,수정일","en-US,Modification Date","ja-JP,修正日","zh-CN,修改日")
   ,AML_40_03_01_01_HEADER10("ko-KR,수정자","en-US,Modification Owner","ja-JP,修正者","zh-CN,修改人")
   ,AML_40_03_01_01_btn_05  ("ko-KR,파일다운로드","en-US,File Download")
   ,AML_40_03_01_01_btn_06  ("ko-KR,파일업로드","en-US,Upload")
   ,AML_70_01_01_01_sbtn_02 ("ko-KR,등록","en-US,Register")
   ,AML_70_02_01_01_sbtn_02 ("ko-KR,영업점확인요청","en-US,Requesting branch confirmation")
   ,AML_70_02_01_01_sbtn_03 ("ko-KR,영업점결재","en-US,Branch Approval")
   ,AML_70_02_01_01_sbtn_04 ("ko-KR,본점결재","en-US,Head Office Approval","ja-JP,本店決裁")
   ,AML_70_02_01_01_sbtn_05 ("ko-KR,혐의거래신고","en-US,Statement of suspicious transaction")
   ,AML_90_01_01_01_btn_01  ("ko-KR,검색","en-US,View","zh-CN,搜索")
   ,AML_90_01_01_01_btn_02  ("ko-KR,등록","en-US,Register")
   ,AML_90_01_01_02_btn_01  ("ko-KR,수정","en-US,Modify","ja-JP,修正","zh-CN,修改")
   ,AML_90_01_01_02_btn_03  ("ko-KR,목록","en-US,List","ja-JP,リスト")
   ,AML_90_01_01_04_btn_01  ("ko-KR,수정","en-US,Modify","ja-JP,修正","zh-CN,修改")
   ,AML_90_01_02_01_btn_01  ("ko-KR,검색","en-US,View","zh-CN,搜索")
   ,AML_90_01_02_01_btn_02  ("ko-KR,등록","en-US,Register")
   ,AML_90_01_02_03_btn_01  ("ko-KR,수정","en-US,Modify","ja-JP,修正","zh-CN,修改")
   ,AML_90_01_02_03_btn_03  ("ko-KR,답변","en-US,Answer","ja-JP,回答")
   ,AML_90_01_02_03_btn_04  ("ko-KR,목록","en-US,List","ja-JP,リスト")
   ,AML_90_01_02_04_btn_02  ("ko-KR,목록","en-US,List","ja-JP,リスト")
   ,AML_90_01_02_05_btn_02  ("ko-KR,목록","en-US,List","ja-JP,リスト")
   ,AML_90_02_01_01_btn_01  ("ko-KR,프로세스 목록","en-US,Process list")
   ,AML_90_02_01_01_btn_02  ("ko-KR,전체열기","en-US,Open all","ja-JP,全てを展開")
   ,AML_90_02_01_01_btn_03  ("ko-KR,전체닫기","en-US,Close all","ja-JP,全てを折りたたむ")
   ,AML_90_02_01_02_btn_01  ("ko-KR,실행","en-US,Execution")
   ,AML_90_02_01_02_btn_02  ("ko-KR,예약실행","en-US,Schedule Execution")
   ,AML_90_02_04_01_btn_01  ("ko-KR,즉시실행","en-US,Immediate Execution")
   ,AML_90_02_04_01_btn_02  ("ko-KR,새로고침","en-US,Refresh","ja-JP,最新情報に更新","zh-CN,刷新")
   ,AML_90_02_04_01_btn_03  ("ko-KR,새로고침","en-US,Refresh","ja-JP,最新情報に更新","zh-CN,刷新")
   ,AML_90_02_05_01_btn_01  ("ko-KR,즉시실행","en-US,Immediate Execution")
   ,AML_90_02_05_01_btn_02  ("ko-KR,새로고침","en-US,Refresh","ja-JP,最新情報に更新","zh-CN,刷新")
   ,AML_90_02_05_01_btn_03  ("ko-KR,새로고침","en-US,Refresh","ja-JP,最新情報に更新","zh-CN,刷新")
   ,AML_90_05_03_05_002     ("ko-KR,사용할 수 있는 아이디입니다.","en-US,You can use the ID.","ja-JP,使用できるIDです。","zh-CN,ID不能使用。")
   ,AML_90_05_03_05_003     ("ko-KR,이미 존재하는 아이디입니다.","en-US,The ID is already existed.")
   ,AlldeleteBtn            ("ko-KR,전체삭제","en-US,Delete","ja-JP,削除","zh-CN,전체삭제")
   ,accInfoBtn              ("ko-KR,계좌정보","en-US,Account Info.","ja-JP,계좌정보","zh-CN,계좌정보")
   ,aclMappingBtn           ("ko-KR,권한맵핑","en-US,Authority Mapping")
   ,addBtn                  ("ko-KR,추가","en-US,Add","ja-JP,追加","zh-CN,添加")
   ,addChBtn                ("ko-KR,취약점 등록","en-US,Add Vulnerability","ja-JP,취약점 등록","zh-CN,취약점 등록")
   ,addRowBtn               ("ko-KR,행추가","en-US,Add Row","ja-JP,行追加")
   ,allFileDownBtn          ("ko-KR,일괄다운로드","en-US,Batch Download","ja-JP,일괄다운로드","zh-CN,일괄다운로드")
   ,allReportFileDownBtn    ("ko-KR,보고파일일괄다운로드","en-US,Report Files Batch Download","ja-JP,보고파일일괄다운로드","zh-CN,보고파일일괄다운로드")
   ,allModifyBtn            ("ko-KR,전체수정","en-US,Modify All","ja-JP,전체수정","zh-CN,전체수정")
   ,apprBtn                 ("ko-KR,승인","en-US,Approve","ja-JP,승인","zh-CN,승인")
   ,apprRequestBtn          ("ko-KR,결재요청", "en-US,Ask Approval")
   ,apprHistoryBtn          ("ko-KR,결재이력","en-US,Approval History")
   ,approvalBtn             ("ko-KR,결재","en-US, Approval","ja-JP,결재","zh-CN,결재")
   ,attachFile              ("ko-KR,첨부파일","en-US, Attached File","ja-JP,첨부파일","zh-CN,첨부파일")
   ,modifyCSH               ("ko-KR,거래금액수정","en-US,Modify Amount","zh-CN,修改交易金额")
   ,attchFileBtn            ("ko-KR,첨부파일","en-US,Attached File","ja-JP,添付ファイル","zh-CN,附件")
   ,addFileBtn              ("ko-KR,파일추가","en-US,Add File","ja-JP,파일추가","zh-CN,파일추가")
   ,allConditionBtn         ("ko-KR,파일 전체현황", "en-US,All Files Status")
   ,alterationBtn           ("ko-KR,변경", "en-US,Modify")
   ,answerBtn               ("ko-KR,덧글 달기", "en-US, Reply")
   ,trxPlusBtn              ("ko-KR,거래추가 열기", "en-US, Open Add Transaction")
   ,trxMinusBtn             ("ko-KR,거래추가 닫기", "en-US, Close Add Transaction")
   ,AML_20_01_01_08_sbtn_01 ("ko-KR,거래추가 열기", "en-US, Open Add Transaction")
   ,AML_20_01_01_08_sbtn_02 ("ko-KR,거래추가 닫기", "en-US, Close Add Transaction")
   ,transactionAddBtn       ("ko-KR,거래추가", "en-US, Add Transaction")
   ,transactionDelBtn       ("ko-KR,거래삭제", "en-US, Delete Transaction")
   ,transactionSavBtn       ("ko-KR,거래저장", "en-US, Save Transaction")
   //WatchList 이력 소스 추가 20180702
   ,applyBtn                ("ko-KR,적용", "en-US, Apply")
   ,allApplyBtn             ("ko-KR,전체적용", "en-US, Apply")
   ,autoImport				("ko-KR,자동 가져오기", "en-US, Auto. Import")
   ,activeBtn				("ko-KR,활성화모델 변경", "en-US, Active Model Change")
   ,cnlApprBtn				("ko-KR,결재취소", "en-US, Approval Cancel")
   ,rankmodify              ("ko-KR,등급별 구간수정")

   //2020-10-19
   ,AML_20_02_02_01_sbtn_05  ("ko-KR,ExcelDown","en-US,Excel Export","zh-CN,ExcelDown")
   ,AML_24_01_03_01_sbtn_02 ("ko-KR,Alert배정","en-US,Alert Assignments")
   ,AML_24_01_03_01_sbtn_05 ("ko-KR,내부종결","en-US,Internal Termination")
   ,AML_24_01_03_01_sbtn_06 ("ko-KR,Case전환","en-US,Case Transition")
   ,AML_24_01_03_01_sbtn_07("ko-KR,검토대상","en-US,Case Transition")

    // [ B ]
   ,B               ("ko-KR,지점","en-US,Branch","ja-JP,支店","zh-CN,分行")
   ,beforeDataimpBtn("ko-KR,직전 보고데이터 가져오기","en-US, Get Previous Reporting Data","ja-JP,직전 보고데이터 가져오기","zh-CN,직전 보고데이터 가져오기")
   ,BT_BAS_DT_Btn   ("ko-KR,배치기준일등록","en-US, Register Batch Base Date","ja-JP,배치기준일등록","zh-CN,배치기준일등록")
   ,BTHRBA034       ("ko-KR, 통제요소가져오기")

    // [ C ]
   ,CHOICE           ("ko-KR,선택","en-US,Select")
   ,calculateBtn     ("ko-KR,재계산","en-US,Recalculation","ja-JP,再計算")
   ,cancelBtn        ("ko-KR,취소","en-US,Cancel","ja-JP,キャンセル","zh-CN,取消")
   ,checkInBtn       ("ko-KR,체크인","en-US,CheckIn","ja-JP,チェックイン")
   ,checkOutBtn      ("ko-KR,체크아웃","en-US,CheckOut","ja-JP,チェックアウト")
   ,checkOutCancelBtn("ko-KR,체크아웃취소","en-US,CheckOutCancel","ja-JP,チェックアウトの取り消し")
   ,closeBtn         ("ko-KR,닫기","en-US,Close","ja-JP,閉じる")
   ,commentBtn       ("ko-KR,등록","en-US,Register","ja-JP,등록","zh-CN,등록")
   ,confirmBtn       ("ko-KR,확인","en-US, Confirm","ja-JP,확인","zh-CN,확인")
   ,createFileBtn    ("ko-KR,파일생성","en-US, Create File","ja-JP,파일생성","zh-CN,파일생성")
   ,createTransactionFileBtn  ("ko-KR,3개월거래내역파일생성","en-US, Create transaction history file","ja-JP,取引履歴ファイルを作成する","zh-CN,创建交易历史文件")
   ,cusAssessBtn     ("ko-KR,고객 위험평가 이력조회","en-US,View Customer RA History","ja-JP,고객 위험평가 이력조회","zh-CN,고객 위험평가 이력조회")
   ,cusDetlBtn       ("ko-KR,고객상세정보","en-US, Customer Detail Info.","ja-JP,고객상세정보","zh-CN,고객상세정보")
   ,cusFiuDetlBtn    ("ko-KR,고객별 FIU 보고 상세","en-US, Detail FIU Report by Customer","ja-JP,고객별 FIU 보고 상세","zh-CN,고객별 FIU 보고 상세")
   ,commentInBtn     ("ko-KR,덧글 달기","en-US, Reply","ja-JP,덧글 달기","zh-CN,덧글 달기")
   //WatchList 이력 소스 추가 20180702
   ,csvUploadBtn     ("ko-KR,CSV 업로드","en-US,CSV Upload","ja-JP,CSV 업로드","zh-CN,CSV 업로드")
   ,codeSearchBtn     ("ko-KR,공통코드검색","en-US, Code Search","ja-JP,CSV 업로드","zh-CN,CSV 업로드")
   ,createModelBtn	 ("ko-KR,모델생성","en-US, Create Model","ja-JP,모델생성","zh-CN,모델생성")
   ,changeHisBtn	 ("ko-KR,변경이력","en-US, Change Hist")
   ,compareBtn		 ("ko-KR,결과비교","en-US, Compare")
   ,cancelReportBtn  ("ko-KR,취소보고","en-US,Cancel","ja-JP,キャンセル","zh-CN,取消")
   
    // [ D ]
   ,D                ("ko-KR,반려","en-US,Return","zh-CN,返回")
   ,dataSearchBtn    ("ko-KR,항목 데이터조회","en-US, View Item Data","ja-JP,항목 데이터조회","zh-CN,항목 데이터조회")
   ,deleteBtn        ("ko-KR,삭제","en-US,Delete","ja-JP,削除")
   ,deleteDataBtn    ("ko-KR,데이터삭제","en-US, Delete Data","ja-JP,데이터삭제","zh-CN,데이터삭제")
   ,deleteRowBtn     ("ko-KR,행삭제","en-US,Delete Row","ja-JP,行削除")
   ,denyBtn          ("ko-KR,반려","en-US,Return","zh-CN,반려")
   ,deployBtn        ("ko-KR,적용","en-US,Apply","ja-JP,適用")
   ,divBtn           ("ko-KR,배분","en-US, Distribute","ja-JP,배분","zh-CN,배분")
   ,doReport         ("ko-KR,보고서출력","en-US,Print Report","ja-JP,보고서출력","zh-CN,보고서출력")
   ,downloadBtn      ("ko-KR,파일 Download","en-US,File Download","ja-JP,파일 Download","zh-CN,파일 Download")
   ,dataAllBtn       ("ko-KR,Data일괄등록", "en-US, Batch Registration of Data")
   ,dataSeleteBtn    ("ko-KR,Data조회", "en-US, View Data")
   ,dataDetailSearch ("ko-KR,상세보기", "en-US,Detail Info")
   ,tmsDetailSearch  ("ko-KR,TMS보고현황", "en-US, TMS Reporting Status")
   ,approvalEndBtn   ("ko-KR,결재종료", "en-US, Approval Completed")
   ,doReadCtrFile("ko-KR,CTR보고내역보기", "en-US, View CTR Reportings")
   ,deleteModelBtn    ("ko-KR,모델 삭제","en-US, Delete Model","ja-JP,모델 삭제","zh-CN,모델 삭제")
   ,doRbaLevel        ("ko-KR,등급별구간설정","en-US, RBA Level","ja-JP,RBA Level","zh-CN,RBA Level")
   ,doIMPV        	("ko-KR,개선조치 요청")

    // [ E ]
   ,earlyCloseBtn   ("ko-KR,조기 종료","en-US,Early close","ja-JP,Early close","zh-CN,Early close")
   ,estimateErlBtn  ("ko-KR,평가등록", "en-US, Register Evaluation")
   ,excelMakeBtn    ("ko-KR,보고파일생성","en-US,Create Report File","ja-JP,Create Report File","zh-CN,Create Report File")
   ,excelDownBtn    ("ko-KR,보고파일다운로드","en-US,Download Report File","ja-JP,Download Report File","zh-CN,Download Report File")
   //WatchList 이력 소스 추가 20180702
   ,excelDownBtn2    ("ko-KR,Excel 다운로드","en-US,Download","ja-JP,Download","zh-CN,Download")
   ,exportBtn       ("ko-KR,파일내리기","en-US,File download")
   ,excuteBtn		("ko-KR,실행","en-US, excute")

    // [ F ]
   ,fileViewBtn("ko-KR,파일보기","en-US,File View","ja-JP,파일보기","zh-CN,파일보기")
   ,fiuSaveBtn ("ko-KR,보고정보저장","en-US,FIU Save","ja-JP,보고정보저장","zh-CN,보고정보저장")
   ,filterBtn ("ko-KR,필터","en-US, Filter","ja-JP, Filter","zh-CN, Filter")
   ,faithCheckBtn ("ko-KR,충실도 체크","en-US, Filter","ja-JP, Filter","zh-CN, Filter")

    // [ G ]
   ,graphBtn("ko-KR,Graph생성","en-US,Generating Graph","ja-JP,グラフ生成","zh-CN,生成Graph")
   ,gridInsertBtn("ko-KR,입력", "en-US,Input")

    // [ H ]
   ,helpBtn   ("ko-KR,도움말","en-US,Help","ja-JP,도움말","zh-CN,도움말")
   ,historyBtn("ko-KR,이력","en-US,History")

    // [ I ]
   ,I        ("ko-KR,결재대기","en-US,Approval Waiting","ja-JP,決裁待ち","zh-CN,等待批准")
   ,importBtn("ko-KR,파일올리기","en-US,Upload")
   ,imsiSave("ko-KR, 임시저장")

    // [ J ]
   ,JBST_E   ("ko-KR,에러","en-US,Error")
   ,JBST_F   ("ko-KR,종료","en-US,Close","ja-JP,終了","zh-CN,退出")
   ,JBST_P   ("ko-KR,진행중","en-US,In Progress","ja-JP,進行中")
   ,JBST_T   ("ko-KR,중단","en-US,Interruption")
   ,JIPYOTest("ko-KR,시뮬레이션","en-US,Simulation","ja-JP,시뮬레이션","zh-CN,시뮬레이션")

    // [ K ]
   ,kycDeciBtn      ("ko-KR,결재요청","en-US,Approval Request","ja-JP,결재요청","zh-CN,결재요청")
   ,kycDeciHistBtn  ("ko-KR,결재이력","en-US,Approval History","ja-JP,결재이력","zh-CN,결재이력")
   ,kycDtlBtn       ("ko-KR,요청상세","en-US,Details of Request","ja-JP,요청상세","zh-CN,요청상세")
   ,kycResultBtn    ("ko-KR,결과판정","en-US,Filtering","ja-JP,결과판정","zh-CN,결과판정")
   ,kycWhiteListBtn ("ko-KR,WhiteList저장","en-US,White List","ja-JP,WhiteList저장","zh-CN,WhiteList저장")

    // [ L ]
   ,LM01("ko-KR,펼침","en-US,Opening,","ja-JP,展開")
   ,LM02("ko-KR,상세정보..","en-US,Further information.","ja-JP,詳細情報..")
   ,LM03("ko-KR,삭제","en-US,Elimination","ja-JP,削除")
   ,LM04("ko-KR,열기","en-US,Heat","ja-JP,開く")
   ,LM05("ko-KR,저장","en-US,Store","ja-JP,保存","zh-CN,保存")
   ,LM06("ko-KR,인쇄","en-US,Printing","ja-JP,印刷","zh-CN,打印")
   ,LM07("ko-KR,확대","en-US,Magnification")
   ,LM08("ko-KR,축소","en-US,Abridgment","ja-JP,縮小")
   ,LM09("ko-KR,화면에 맞춤","en-US,Fixing in the screen,")
   ,LM10("ko-KR,원래크기","en-US,Original size","ja-JP,元のサイズ","zh-CN,原大小")
   ,LM11("ko-KR,아래로 재정렬","en-US,In lower part financial line")
   ,LM12("ko-KR,위로 재정렬","en-US,Comfort financial line")
   ,LM13("ko-KR,오른쪽으로 재정렬","en-US,With the right side financial line")
   ,LM14("ko-KR,왼쪽으로 재정렬","en-US,With the left side financial line")
   ,LM15("ko-KR,라인 색상","en-US,Line color","ja-JP,行の色")
   ,LM16("ko-KR,방사형","en-US,Radiation style","ja-JP,放射型")
   ,LM17("ko-KR,계층형","en-US,Class style","ja-JP,階層型")
   ,LM18("ko-KR,저장/결재","en-US,Store/Approval","ja-JP,保存/決裁","zh-CN,保存")
   ,LM19("ko-KR,결재현황","en-US,Approval List","ja-JP,保存","zh-CN,保存")
   ,logDownBtn("ko-KR,로그파일 다운로드","en-US,Download")

    // [ M ]
   ,M            ("ko-KR,본점","en-US,Head Office","ja-JP,本店")
   ,MART001_01_01("ko-KR,추출","en-US,Extraction","ja-JP,抽出","zh-CN,提取")
   ,MART001_01_02("ko-KR,거래내역","en-US,Transaction history")
   ,MART001_01_03("ko-KR,마트 테이블 배치","en-US,Mart table batch")
   ,MART001_01_05("ko-KR,STR룰","en-US,STR rule")
   ,MART001_01_06("ko-KR,케이스룰 쿼리풀","en-US,Case rule query")
   ,MART001_01_07("ko-KR,동일 이름의 테이블이 존재합니다.","en-US,The same name table is existed.")
   ,MSTR         ("ko-KR,수동STR","en-US,M-STR","ja-JP,手動STR","zh-CN,人工STR")
   ,manualBtn    ("ko-KR,매뉴얼","en-US,Manual","ja-JP,Manual","zh-CN,Manual")
   ,mergeBtn     ("ko-KR,병합/해제","en-US,Merge")

    // [ N ]
   ,newUploadFile ("ko-KR,새로 올릴 파일","en-US,New upload File","ja-JP,확정","zh-CN,확정")
   ,newRiskGetItem("ko-KR,신규위험요소불러오기", "en-US,Import New Risk Item")
   ,noTextBtn ("ko-KR, ","en-US, ","ja-JP, ","zh-CN, ")
    // [ O ]
   ,okBtn("ko-KR,결재","en-US,Approval","ja-JP,決裁")
    // [ P ]

    // [ Q ]
   ,queryBtn("ko-KR,조회","en-US,Search")

    // [ R ]
   ,RBAFix          ("ko-KR,확정","en-US,확정","ja-JP,확정","zh-CN,확정")
   ,RBAFixCancel    ("ko-KR,확정취소","en-US,확정취소","ja-JP,확정취소","zh-CN,확정취소")
   ,RBA001          ("ko-KR,확정/취소","en-US,확정/취소","ja-JP,확정/취소","zh-CN,확정/취소")
   ,RBA002          ("ko-KR,회차관리","en-US,회차관리","ja-JP,회차관리","zh-CN,회차관리")
   ,RBA003          ("ko-KR,신규회차생성","en-US,Copy Schedule","ja-JP,일정복사","zh-CN,신규회차생성")
   ,RBA004          ("ko-KR,등록","en-US,Register","ja-JP,등록","zh-CN,등록")
   ,RBA005          ("ko-KR,미매핑지점","en-US,미매핑지점","ja-JP,미매핑지점","zh-CN,미매핑지점")
   ,RBA006          ("ko-KR,초기화","en-US,초기화","ja-JP,초기화","zh-CN,초기화")
   ,RBA007          ("ko-KR,기준도움말","en-US,기준도움말","ja-JP,기준도움말","zh-CN,기준도움말")
   ,RBA008          ("ko-KR,취약점도움말","en-US,취약점도움말","ja-JP,취약점도움말","zh-CN,취약점도움말")
   ,RBA009          ("ko-KR,업로드","en-US,업로드","ja-JP,업로드","zh-CN,업로드")
   ,RBA010          ("ko-KR,다운로드","en-US,Download","ja-JP,다운로드","zh-CN,다운로드")
   ,RBA011          ("ko-KR,도움말","en-US,도움말","ja-JP,도움말","zh-CN,도움말")
   ,RBA012          ("ko-KR,취약점등록","en-US,취약점등록","ja-JP,취약점등록","zh-CN,취약점등록")
   ,RBA013          ("ko-KR,승인/승인취소","en-US,승인/승인취소","ja-JP,승인/승인취소","zh-CN,승인/승인취소")
   ,RBA014          ("ko-KR,확정/확정취소","en-US,확정/확정취소","ja-JP,확정/확정취소","zh-CN,확정/확정취소")
   ,RBA015          ("ko-KR,상세결과","en-US,상세결과","ja-JP,상세결과","zh-CN,상세결과")
   ,RBA016          ("ko-KR,템플릿 등록","en-US,템플릿 등록","ja-JP,템플릿 등록","zh-CN,템플릿 등록")
   ,RBA017          ("ko-KR,샘플링","en-US,샘플링","ja-JP,샘플링","zh-CN,샘플링")
   ,RBA018          ("ko-KR,설계평가 마감처리","en-US,설계평가 마감처리","ja-JP,설계평가 마감처리","zh-CN,설계평가 마감처리")
   ,RBA019          ("ko-KR,운영평가 마감처리","en-US,운영평가 마감처리","ja-JP,운영평가 마감처리","zh-CN,운영평가 마감처리")
   ,RBA020          ("ko-KR,설계평가 마감","en-US,설계평가 마감","ja-JP,설계평가 마감","zh-CN,설계평가 마감")
   ,RBA021          ("ko-KR,운영평가 마감","en-US,운영평가 마감","ja-JP,운영평가 마감","zh-CN,운영평가 마감")
   ,registerMemo ("ko-KR,메모등록")
   ,refreshBtn      ("ko-KR,원복", "en-US,refresh")
   ,rskDetailBtn ("ko-KR,위험상세정보")
   ,ReqIMPVBtn ("ko-KR,개선조치 요청")


   //2018-04-26 KPMG START
   ,RBA022          ("ko-KR,배치처리","en-US,Schedule Batch","ja-JP,배치처리","zh-CN,배치처리")
   ,RBA023          ("ko-KR,결재대상","en-US,Approval List")
   ,RBA024          ("ko-KR,총위험평가 마감","en-US,Complete Total Risk Assement","ja-JP,총위험평가 마감","zh-CN,총위험평가 마감")
   ,RBA025          ("ko-KR,통제평가 마감","en-US,Complete Control Evaluation","ja-JP,통제평가 마감","zh-CN,통제평가 마감")
   ,RBA026          ("ko-KR,개선 마감","en-US,개선 마감","ja-JP,개선 마감","zh-CN,개선 마감")

   //BSL 추가
   ,RBA027          ("ko-KR,배치관리","en-US,Manage Batch Job","ja-JP,배치관리","zh-CN,배치관리")
   ,RBA028          ("ko-KR,배치재수행","en-US,Re-Perform Batch","ja-JP,배치재수행","zh-CN,배치재수행")
   ,RBA029          ("ko-KR,종료","en-US,종료","ja-JP,종료","zh-CN,종료")
   ,RBA030          ("ko-KR,통제평가 마감","en-US,통제평가 마감\"","ja-JP,통제평가 마감\"","zh-CN,통제평가 마감\"")
   ,RBA031          ("ko-KR,통제평가 재평가","en-US,통제평가 재평가\"","ja-JP,통제평가 재평가\"","zh-CN,통제평가 재평가\"")
   ,RBA032          ("ko-KR,전사위험기준","en-US,전사위험기준\"","ja-JP,전사위험기준\"","zh-CN,전사위험기준\"")
   // KPMG END

   //2025-01-31 KPMG RBA 추가
   ,RBA044          ("ko-KR, 통제평가/통제효과성산출", "en-US, ", "ja-JP, ", "zh-CN, ")
   ,RBA045          ("ko-KR, 직전지표복사", "en-US, ", "ja-JP, ", "zh-CN, ")
   ,RBA046          ("ko-KR, 일정수정", "en-US, ", "ja-JP, ", "zh-CN, ")
   ,RBA047          ("ko-KR, 일정삭제", "en-US, ", "ja-JP, ", "zh-CN, ")

   // TOSS
   ,RBA033          ("ko-KR,종료처리","en-US,종료처리","ja-JP,종료처리","zh-CN,종료처리")
   ,RBA034          ("ko-KR,위험영역매핑","en-US,위험영역매핑","ja-JP,위험영역매핑","zh-CN,위험영역매핑")
   ,RBA035          ("ko-KR,룰매핑","en-US,룰매핑","ja-JP,룰매핑","zh-CN,룰매핑")
   ,RBA036          ("ko-KR,미사용","en-US,미사용","ja-JP,미사용","zh-CN,미사용")
   ,RBA037          ("ko-KR,신규 위험요소 등록","en-US,신규 위험요소 등록","ja-JP,신규 위험요소 등록","zh-CN,신규 위험요소 등록")
   ,RBA038          ("ko-KR,통제평가 마감/취소","en-US,통제평가 마감/취소","ja-JP,통제평가 마감/취소","zh-CN,통제평가 마감/취소")
   ,RBA039          ("ko-KR,종료처리","en-US,End Processing","ja-JP,종료처리","zh-CN,종료처리")
   ,RBA040          ("ko-KR,편집","en-US,Edit","ja-JP,편집","zh-CN,편집")
   ,RBA041          ("ko-KR, 위험평가 마감", "en-US, ", "ja-JP, ", "zh-CN, ")
   ,RBA042          ("ko-KR, 위험 재평가", "en-US, ", "ja-JP, ", "zh-CN, ")
   ,RBA043          ("ko-KR, 통제 재평가", "en-US, ", "ja-JP, ", "zh-CN, ")


   ,RBA_10_05_01_010("ko-KR,고유위험 DATA계산","en-US,고유위험 DATA계산","ja-JP,고유위험 DATA계산","zh-CN,고유위험 DATA계산")
   ,RBA_10_05_01_020("ko-KR,일괄 다운로드","en-US,일괄 다운로드","ja-JP,일괄 다운로드","zh-CN,일괄 다운로드")
   ,RBA_10_05_01_021("ko-KR,평가점수 계산","en-US,평가점수 계산","ja-JP,평가점수 계산","zh-CN,평가점수 계산")
   ,RBA_10_05_01_023("ko-KR,파일업로드","en-US,파일업로드","ja-JP,파일업로드","zh-CN,파일업로드")
   ,RBA_10_05_01_026("ko-KR,수정","en-US,수정","ja-JP,수정","zh-CN,수정")
   ,RBA_10_05_01_027("ko-KR,업로드","en-US,업로드","ja-JP,업로드","zh-CN,업로드")
   ,RBA_10_05_01_047("ko-KR,보고파일생성","en-US,보고파일생성","ja-JP,보고파일생성","zh-CN,보고파일생성")
   ,RBA_10_05_01_048("ko-KR,평가점수 계산","en-US,평가점수 계산","ja-JP,평가점수 계산","zh-CN,평가점수 계산")
   ,RBA_10_05_01_056("ko-KR,목표값 평가","en-US,목표값 평가","ja-JP,목표값 평가","zh-CN,목표값 평가")
   ,RT3A_4_1        ("ko-KR,작업주기","en-US,Cycle","ja-JP,作業周期","zh-CN,工作周期")
   ,RT3A_4_2        ("ko-KR,고객구분","en-US,Customer Type")
   ,RT3A_4_3        ("ko-KR,비교값","en-US,Comparison Value","ja-JP,比較値")
   ,refuseBtn       ("ko-KR,반려","en-US, Return","ja-JP,반려","zh-CN,반려")
   ,reportConfirm   ("ko-KR,보고확정","en-US,Confirm Report","ja-JP,보고확정","zh-CN,보고확정")
   ,reportUploadBtn ("ko-KR,보고항목 업로드","en-US, Upload Reporting Items","ja-JP,보고항목 업로드","zh-CN,보고항목 업로드")
   ,reqApprBtn      ("ko-KR,승인요청","en-US,Ask Approval","ja-JP,승인요청","zh-CN,승인요청")
   ,registerBtn     ("ko-KR,등록","en-US, Register")
   ,resetBtn        ("ko-KR,초기화","en-US, Reset")
   ,registerCodeBtn ("ko-KR,소속코드등록","en-US,RegisterCode")
   ,registerAllScoreBtn("ko-KR,전사점수등록","en-US,RegisterAllScore")
   ,RBA_APP_REQ_ALL_BTN("ko-KR,일괄승인","en-US,Batch Approval","ja-JP,일괄승인","zh-CN,일괄승인")
   ,RBA_Detail_Search  ("ko-KR,상세조회","en-US,상세조회","ja-JP,승인요청","zh-CN,상세조회")
   ,RBA_10_05_01_057   ("ko-KR,본부개선현황","en-US,본부개선현황","ja-JP,본부개선현황","zh-CN,본부개선현황")
   ,remainWarnRateBtn  ("ko-KR,잔여위험등급 도움말", "en-US, Help for Remaining Risk Level")
   ,RBA_APP_REQ_ONE_BTN("ko-KR,건별승인","en-US,건별승인","ja-JP,건별승인","zh-CN,건별승인")
   ,RBA_BRNO           ("ko-KR,지점관리")
   ,RBA_APP_REQ_BTN    ("ko-KR,승인요청", "en-US, Ask Approval")
   ,RBA_10_05_01_047_01("ko-KR,엑셀양식다운로드","en-US,엑셀양식다운로드","ja-JP,엑셀양식다운로드","zh-CN,엑셀양식다운로드")
   ,RBA_10_05_01_047_02("ko-KR,엑셀업로드","en-US,엑셀업로드","ja-JP,엑셀업로드","zh-CN,엑셀업로드")
   ,RBA_10_01_01_187("ko-KR,항목별 컬럼 수정")
   ,RBA_10_05_08_03("ko-KR,템플릿다운로드", "en-US,Download Template")
   ,RBA_50_01_01_01("ko-KR,마감/취소", "en-US,Finish")
   ,RBA_50_03_03_01("ko-KR,RA가중치 불러오기", "en-US,RA Weight Scroe")
   ,RBA_50_05_03_02("ko-KR,구간균등분할", "en-US,RA Weight Scroe")
   ,excelUplode37("ko-KR,엑셀 업로드")
   ,excelDown37("ko-KR,엑셀 다운로드")
   ,riskrecal("ko-KR,위험점수 재계산")


    // [ S ]
   ,sendMailBtn("ko-KR,메일전송","en-US,Mail")
   ,SMSG_AD01("ko-KR,스케줄 셋팅이 잘못되었습니다","en-US,The schedule setting is wrong.")
   ,SMSG_AD02("ko-KR,지난 날짜를 지정할 수 없습니다.","en-US,The past date cannot be assigned.","ja-JP,過去の日付は指定できません。")
   ,saveBtn  ("ko-KR,저장","en-US,Save","ja-JP,保存")
   ,saveBtn_1  ("ko-KR,승인","en-US,Approval","ja-JP,承認","zh-CN,核准")
   ,selBtn   ("ko-KR,선택","en-US,Select")
   ,saveFileBtn ("ko-KR,파일저장","en-US,save File")
   ,saveAddBtn("ko-KR,추가저장","en-US,saveAdd")
   ,searchRstBtn("ko-KR,검사결과조회","en-US,searchResult")
   ,searchAllBtn("ko-KR,일괄조회", "en-US, Batch Inquiry")
   ,searchItemBtn("ko-KR,검사항목조회","en-US,searchItem")
   ,simulBtn    ("ko-KR,시뮬레이션","en-US,Simulation","ja-JP,シミュレーション")
   ,simulHisBtn    ("ko-KR,시뮬레이션 이력", "en-US,Simulation History")
   ,simulRegBtn    ("ko-KR,시뮬레이션 등록", "en-US,Registration of simulation")
   ,simulRsltBtn    ("ko-KR,시뮬레이션 결과", "en-US,Simulation results")
   ,simulCustRsltBtn    ("ko-KR,고객별 시뮬레이션 결과", "en-US,Customer Simulation results")
   ,srchRstTransBtn("ko-KR,검사결과전송","en-US,searchItem")
   ,selectedConfirmBtn("ko-KR,변경", "en-US, Modify")
   ,strManualReg("ko-KR,STR 임의보고", "en-US,STR Manual Registration")
   ,simulexcute("ko-KR,시뮬레이션 수행")

    // [ T ]
   ,TEMPLATE_EXIST           ("ko-KR,사용중인 template이 존재합니다.","en-US,A used template is existed.","zh-CN,template正在使用。")
   ,TERM_CU                  ("ko-KR,특정일","en-US,Anniversary","ja-JP,特定日","zh-CN,特定日期")
   ,TERM_DD                  ("ko-KR,매일","en-US,Every Day","zh-CN,每日")
   ,TERM_MM                  ("ko-KR,매월","en-US,Every Month","zh-CN,每月")
   ,TERM_WD                  ("ko-KR,매주","en-US,Every Week","zh-CN,每周")
   ,TGTP_E                   ("ko-KR,실행파일","en-US,Execution File")
   ,TGTP_S                   ("ko-KR,배치소스","en-US,Batch Source","zh-CN,batch source")
   ,tempSave                 ("ko-KR,임시저장","en-US,Temporary Save","ja-JP,임시저장","zh-CN,임시저장")
   ,templateGenerator_sbtn_03("ko-KR,파일올리기","en-US,Upload")
   ,templateGenerator_sbtn_04("ko-KR,파일내리기","en-US,File download")
   ,templateGenerator_sbtn_05("ko-KR,재계산","en-US,Recalculation","ja-JP,再計算")
   ,templateGenerator_sbtn_06("ko-KR,Graph생성","en-US,Generating Graph","ja-JP,グラフ生成","zh-CN,生成Graph")
   ,templateDownload("ko-KR, 템플릿 다운로드", "en-US,Download Template")
   ,tblSearchBtn     ("ko-KR,테이블검색","en-US,CSV Upload","ja-JP,CSV 업로드","zh-CN,CSV 업로드")
   ,transBtn     ("ko-KR, 추이 조회")
   ,tempConfirm ("ko-KR, 검토완료")
   ,tempConFirmCharge ("ko-KR, 내부종결")
   ,tempAssign ("ko-KR, 배정")

   ,btnTest01    ("ko-KR,임계값분석내역")
   ,btnTest02    ("ko-KR,조사분석")
    // [ U ]
   ,uncompleteBtn ("ko-KR,완료해제","en-US,Uncomplete")
   ,updateAllBtn("ko-KR,전체수정","en-US,Modification (All)","ja-JP,전체수정","zh-CN,전체수정")
   ,updateBtn   ("ko-KR,수정","en-US,Modify","ja-JP,修正","zh-CN,修改")
   ,updateBtn_D ("ko-KR,설계","en-US,Design")
   ,updateBtn_O ("ko-KR,운영","en-US,Operation")
   ,uploadBtn   ("ko-KR,파일 Upload","en-US, File Upload","ja-JP,파일 Upload","zh-CN,파일 Upload")
   ,updateScheduleBtn("ko-KR,업무일정수정","en-US,Work Schedule Modification")

    // [ V ]
   ,verifyDataBtn ("ko-KR,검증배치실행","en-US,verifyData")
   ,verifyDataHisDelBtn	("ko-KR,이력삭제", "en-US, verifyDataHistoryDelete")
   ,verifyQueryBtn("ko-KR,추출쿼리검증실행","en-US,verifyQuery")

    // [ W ]
   ,WEEK_FRI("ko-KR,금요일","en-US,Friday"     ,"ja-JP,金曜日","zh-CN,星期五")
   ,WEEK_MON("ko-KR,월요일","en-US,Monday"     ,"ja-JP,月曜日","zh-CN,星期一")
   ,WEEK_SAT("ko-KR,토요일","en-US,Saturday"   ,"ja-JP,土曜日","zh-CN,星期六")
   ,WEEK_SUN("ko-KR,일요일","en-US,Sunday"     ,"ja-JP,日曜日","zh-CN,星期日")
   ,WEEK_THU("ko-KR,목요일","en-US,Thursday"   ,"ja-JP,木曜日","zh-CN,星期四")
   ,WEEK_TUE("ko-KR,화요일","en-US,Tuesday "   ,"ja-JP,火曜日","zh-CN,星期二")
   ,WEEK_WED("ko-KR,수요일","en-US,Wednesday"  ,"ja-JP,水曜日","zh-CN,星期三")
   //WatchList 이력 소스 추가 20180702
   ,wlVariationBtn("ko-KR,Watch List 변경분 처리", "en-US,Process Watch List Changes")
   ,wlExcelBtn("ko-KR,변경분 Excel 다운로드", "en-US,Excel Download Changes")
   ,wlBatchBtn("ko-KR,변경분 일괄 처리", "en-US,Batch Process of Changes")
   ,wlfConBtn("ko-KR,WLF조건","en-US,WLF Condition","ja-JP,WLF조건","zh-CN,WLF조건")
   ,wlfExecBtn("ko-KR,WLF수행","en-US,WLF Execution","ja-JP,WLF수행","zh-CN,WLF수행")
   ,wlfTranBtn("ko-KR,전송정보","en-US,Save","ja-JP,전송정보","zh-CN,전송정보")
   ,warnInfoBtn("ko-KR,위험체계 도움말", "en-US,Help for Risk Category")
   ,warnEnrBtn("ko-KR,위험별 등록", "en-US,Registration by Risk")
   ,withdrawBtn("ko-KR,회수", "en-US,Withdrawal")
   ,whiteApplyBtn("ko-KR,WhiteList 일괄적용", "en-US,apply")

   ,beforeDate		("ko-KR,직전보고가져오기", "en-US,Import Last Report")
   ,fileSave   ("ko-KR,증빙자료첨부", "en-US,Attach Doc.")
   ,maxValue	 ("ko-KR,MAX값입력", "en-US,Input Max Value")
   , BatchConfirmCancelBtn      ("ko-KR,확정/취소","en-US,Confirm/Cancel","ja-JP,확정/취소","zh-CN,확정/취소")
   , simpleReportCreateBtn      ("ko-KR,샘플보고파일","en-US,Sample Report File","ja-JP,샘플보고파일","zh-CN,샘플보고파일")
   , evalStdBtn      			("ko-KR,평가기준","en-US,Evaluation Criteria","ja-JP,평가기준","zh-CN,평가기준")
   ,rbaConfirmBtn	   ("ko-KR,확정/취소", "en-US,Confirm/Cancel")
   ,userhisBtn("ko-KR,정보변경이력", "en-US,Information change history")
   ,grouprolehisBtn("ko-KR,권한변경이력", "en-US,Permission change history")
   ,loadBtn		("ko-KR,불러오기", "en-US,Load")
    // [ X ]

    // [ Y ]

    // [ Z ]
   	// [ AI ]
   ,toGraphBtn("ko-KR,그래프로 결과보기")
   ,toDetailBtn("ko-KR,상세 결과보기")
   ,excelDownBtn_AI("ko-KR,EXCEL 다운로드", "en-US,Download Excel")
   ,valueSampleSearch("ko-KR,임계치 샘플링 조사분석")
   ,confirmFinalValue("ko-KR,최종임계치설정")
    ;

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/

    /** 다국어 처리용 해쉬맵 */
    HashMap<String,String> textmap = new HashMap<String,String>();

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
    private BtnText(final String...param)
    {
        String[] vals = null;
        for (String val:param) {
            vals = val.split(",");
            try {
                textmap.put(vals[0], vals[1]);
            } catch (ArrayIndexOutOfBoundsException e) {
                System.out.println(name()+": value was wrong.");
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
     * @param   cdID
     *              버튼 아이디
     * @param   langCD
     *              언어구분
     * @param   defval
     *              찾는 문자열이 없는 경우 반환
     * @return  <code>String</code>
     *              언어별 버튼 문자열
     */
    public static String getText(String cdID, String langCD, String defval)
    {
        try {
            BtnText obj = valueOf(cdID);
            return (obj==null) ==false?obj.textmap.get(langCD):":"+defval;
        } catch (IllegalArgumentException e) {
            System.out.println(cdID+": does not exist.");
            return "val:"+defval;
        }
    }
}
