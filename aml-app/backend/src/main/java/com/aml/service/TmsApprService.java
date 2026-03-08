package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.TmsAppr;
import com.aml.mapper.TmsApprMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TmsApprService {

    private final TmsApprMapper tmsApprMapper;

    @Transactional(readOnly = true)
    public PageResult<TmsAppr> getApprovals(String apprStCd, String apprTpCd, int page, int size) {
        int offset = (page - 1) * size;
        List<TmsAppr> content = tmsApprMapper.findAll(apprStCd, apprTpCd, offset, size);
        int total = tmsApprMapper.countAll(apprStCd, apprTpCd);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public TmsAppr getApproval(Long apprId) {
        TmsAppr appr = tmsApprMapper.findById(apprId);
        if (appr == null) {
            throw new IllegalArgumentException("결재를 찾을 수 없습니다: " + apprId);
        }
        return appr;
    }

    @Transactional
    public void approve(Long apprId, String comment, String userId) {
        TmsAppr appr = tmsApprMapper.findById(apprId);
        if (appr == null) {
            throw new IllegalArgumentException("결재를 찾을 수 없습니다: " + apprId);
        }
        if (!"REQUESTED".equals(appr.getApprStCd())) {
            throw new IllegalStateException("결재 대기 상태인 건만 승인할 수 있습니다. 현재 상태: " + appr.getApprStCd());
        }
        appr.setApprStCd("APPROVED");
        appr.setApprUsrId(userId);
        appr.setApprDt(LocalDateTime.now());
        appr.setApprCmnt(comment);
        appr.setUpdId(userId);
        tmsApprMapper.update(appr);
        log.info("Approval approved: apprId={} by {}", apprId, userId);
    }

    @Transactional
    public void reject(Long apprId, String reason, String userId) {
        TmsAppr appr = tmsApprMapper.findById(apprId);
        if (appr == null) {
            throw new IllegalArgumentException("결재를 찾을 수 없습니다: " + apprId);
        }
        if (!"REQUESTED".equals(appr.getApprStCd())) {
            throw new IllegalStateException("결재 대기 상태인 건만 반려할 수 있습니다. 현재 상태: " + appr.getApprStCd());
        }
        appr.setApprStCd("REJECTED");
        appr.setApprUsrId(userId);
        appr.setApprDt(LocalDateTime.now());
        appr.setRejectRsn(reason);
        appr.setUpdId(userId);
        tmsApprMapper.update(appr);
        log.info("Approval rejected: apprId={} by {}", apprId, userId);
    }

    @Transactional
    public void createApproval(String apprTpCd, String refId, String apprNo,
                                String title, String content, String userId) {
        TmsAppr appr = new TmsAppr();
        appr.setApprNo(apprNo);
        appr.setApprTpCd(apprTpCd);
        appr.setRefId(refId);
        appr.setApprTitle(title);
        appr.setApprContent(content);
        appr.setApprStCd("REQUESTED");
        appr.setReqId(userId);
        appr.setReqDt(LocalDateTime.now());
        appr.setRegId(userId);
        tmsApprMapper.insert(appr);
        log.info("Approval created: apprNo={}, type={}, refId={}", apprNo, apprTpCd, refId);
    }
}
