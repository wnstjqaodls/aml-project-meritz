package com.aml.service;

import com.aml.domain.TmsStatsDaily;
import com.aml.mapper.CtrReportMapper;
import com.aml.mapper.StrReportMapper;
import com.aml.mapper.TmsAlertMapper;
import com.aml.mapper.TmsStatsDailyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class TmsStatsService {

    private final TmsAlertMapper tmsAlertMapper;
    private final StrReportMapper strReportMapper;
    private final CtrReportMapper ctrReportMapper;
    private final TmsStatsDailyMapper tmsStatsDailyMapper;

    @Transactional(readOnly = true)
    public Map<String, Object> getDashboard() {
        Map<String, Object> dashboard = new HashMap<>();

        // Live alert counts by status from tms_alert
        long newCount      = tmsAlertMapper.countByStatusCd("NEW");
        long reviewCount   = tmsAlertMapper.countByStatusCd("REVIEW");
        long closedCount   = tmsAlertMapper.countByStatusCd("CLOSED");
        long escalatedCount = tmsAlertMapper.countByStatusCd("ESCALATED");
        long totalAlerts   = newCount + reviewCount + closedCount + escalatedCount;

        Map<String, Long> alertCounts = new HashMap<>();
        alertCounts.put("NEW", newCount);
        alertCounts.put("REVIEW", reviewCount);
        alertCounts.put("CLOSED", closedCount);
        alertCounts.put("ESCALATED", escalatedCount);
        alertCounts.put("TOTAL", totalAlerts);
        dashboard.put("alertCounts", alertCounts);
        dashboard.put("openAlertCount", newCount + reviewCount);

        // STR report counts by status from str_rpt
        Map<String, Object> strParams = new HashMap<>();
        strParams.put("size", 0);
        strParams.put("offset", 0);
        long strDraft     = buildStrCount("DRAFT");
        long strReview    = buildStrCount("REVIEW");
        long strApproved  = buildStrCount("APPROVED");
        long strSubmitted = buildStrCount("SUBMITTED");
        long strRejected  = buildStrCount("REJECTED");

        Map<String, Long> strCounts = new HashMap<>();
        strCounts.put("DRAFT",     strDraft);
        strCounts.put("REVIEW",    strReview);
        strCounts.put("APPROVED",  strApproved);
        strCounts.put("SUBMITTED", strSubmitted);
        strCounts.put("REJECTED",  strRejected);
        strCounts.put("TOTAL",     strDraft + strReview + strApproved + strSubmitted + strRejected);
        dashboard.put("strCounts", strCounts);

        // CTR report counts by status from ctr_rpt
        long ctrPending   = buildCtrCount("PENDING");
        long ctrApproved  = buildCtrCount("APPROVED");
        long ctrSubmitted = buildCtrCount("SUBMITTED");

        Map<String, Long> ctrCounts = new HashMap<>();
        ctrCounts.put("PENDING",   ctrPending);
        ctrCounts.put("APPROVED",  ctrApproved);
        ctrCounts.put("SUBMITTED", ctrSubmitted);
        ctrCounts.put("TOTAL",     ctrPending + ctrApproved + ctrSubmitted);
        dashboard.put("ctrCounts", ctrCounts);

        // Weekly trend from tms_stats_daily (last 7 stored snapshots)
        List<TmsStatsDaily> weeklyTrend = tmsStatsDailyMapper.findRecentDays(7);
        dashboard.put("weeklyTrend", weeklyTrend);

        // Today's snapshot (if exists)
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        TmsStatsDaily todayStats = tmsStatsDailyMapper.findByDate(today);
        dashboard.put("todayStats", todayStats);

        log.debug("Dashboard stats computed");
        return dashboard;
    }

    @Transactional(readOnly = true)
    public List<TmsStatsDaily> getWeeklyTrend() {
        return tmsStatsDailyMapper.findRecentDays(7);
    }

    @Transactional(readOnly = true)
    public Map<String, Object> getAlertBreakdown() {
        Map<String, Object> breakdown = new HashMap<>();

        Map<String, Long> byStatus = new HashMap<>();
        byStatus.put("NEW",       tmsAlertMapper.countByStatusCd("NEW"));
        byStatus.put("REVIEW",    tmsAlertMapper.countByStatusCd("REVIEW"));
        byStatus.put("CLOSED",    tmsAlertMapper.countByStatusCd("CLOSED"));
        byStatus.put("ESCALATED", tmsAlertMapper.countByStatusCd("ESCALATED"));
        breakdown.put("byStatus", byStatus);

        return breakdown;
    }

    @Transactional(readOnly = true)
    public Map<String, Object> getReportBreakdown() {
        Map<String, Object> breakdown = new HashMap<>();

        Map<String, Long> strByStatus = new HashMap<>();
        strByStatus.put("DRAFT",     buildStrCount("DRAFT"));
        strByStatus.put("REVIEW",    buildStrCount("REVIEW"));
        strByStatus.put("APPROVED",  buildStrCount("APPROVED"));
        strByStatus.put("SUBMITTED", buildStrCount("SUBMITTED"));
        strByStatus.put("REJECTED",  buildStrCount("REJECTED"));
        breakdown.put("strByStatus", strByStatus);

        Map<String, Long> ctrByStatus = new HashMap<>();
        ctrByStatus.put("PENDING",   buildCtrCount("PENDING"));
        ctrByStatus.put("APPROVED",  buildCtrCount("APPROVED"));
        ctrByStatus.put("SUBMITTED", buildCtrCount("SUBMITTED"));
        breakdown.put("ctrByStatus", ctrByStatus);

        return breakdown;
    }

    // Helpers to query report counts by status using existing mapper findByParams
    private long buildStrCount(String statusCd) {
        Map<String, Object> params = new HashMap<>();
        params.put("strStCd", statusCd);
        params.put("size", 1);
        params.put("offset", 0);
        return strReportMapper.countByParams(params);
    }

    private long buildCtrCount(String statusCd) {
        Map<String, Object> params = new HashMap<>();
        params.put("ctrStCd", statusCd);
        params.put("size", 1);
        params.put("offset", 0);
        return ctrReportMapper.countByParams(params);
    }
}
