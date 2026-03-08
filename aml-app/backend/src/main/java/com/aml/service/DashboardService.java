package com.aml.service;

import com.aml.mapper.CaseMapper;
import com.aml.mapper.CustomerMapper;
import com.aml.mapper.KycMapper;
import com.aml.mapper.TmsAlertMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class DashboardService {

    private final TmsAlertMapper tmsAlertMapper;
    private final CaseMapper caseMapper;
    private final KycMapper kycMapper;
    private final CustomerMapper customerMapper;

    @Transactional(readOnly = true)
    public Map<String, Object> getStats() {
        Map<String, Object> stats = new HashMap<>();

        // Alert counts by status
        Map<String, Long> alertCounts = new HashMap<>();
        alertCounts.put("NEW", tmsAlertMapper.countByStatusCd("NEW"));
        alertCounts.put("REVIEW", tmsAlertMapper.countByStatusCd("REVIEW"));
        alertCounts.put("CLOSED", tmsAlertMapper.countByStatusCd("CLOSED"));
        alertCounts.put("ESCALATED", tmsAlertMapper.countByStatusCd("ESCALATED"));
        stats.put("alertCounts", alertCounts);

        // Case counts by status
        Map<String, Long> caseCounts = new HashMap<>();
        caseCounts.put("OPEN", caseMapper.countByStatusCd("OPEN"));
        caseCounts.put("REVIEW", caseMapper.countByStatusCd("REVIEW"));
        caseCounts.put("CLOSED", caseMapper.countByStatusCd("CLOSED"));
        caseCounts.put("PENDING", caseMapper.countByStatusCd("PENDING"));
        stats.put("caseCounts", caseCounts);

        // Pending KYC count
        stats.put("pendingKycCount", kycMapper.countPending());

        // High-risk customer count
        stats.put("highRiskCustomerCount", customerMapper.findHighRisk().size());

        // Total alerts open (NEW + REVIEW)
        long openAlerts = alertCounts.get("NEW") + alertCounts.get("REVIEW");
        stats.put("openAlertCount", openAlerts);

        // Total open cases
        stats.put("openCaseCount", caseCounts.get("OPEN") + caseCounts.get("REVIEW"));

        log.debug("Dashboard stats retrieved");
        return stats;
    }
}
