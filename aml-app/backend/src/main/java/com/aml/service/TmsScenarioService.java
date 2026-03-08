package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.TmsScenario;
import com.aml.domain.TmsSetVal;
import com.aml.mapper.TmsScenarioMapper;
import com.aml.mapper.TmsSetValMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TmsScenarioService {

    private final TmsScenarioMapper tmsScenarioMapper;
    private final TmsSetValMapper tmsSetValMapper;
    private final TmsApprService tmsApprService;

    @Transactional(readOnly = true)
    public PageResult<TmsScenario> getScenarios(String scnrTpCd, String useYn, int page, int size) {
        int offset = (page - 1) * size;
        List<TmsScenario> content = tmsScenarioMapper.findAll(scnrTpCd, useYn, offset, size);
        int total = tmsScenarioMapper.countAll(scnrTpCd, useYn);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public TmsScenario getScenario(String scnrId) {
        TmsScenario scenario = tmsScenarioMapper.findById(scnrId);
        if (scenario == null) {
            throw new IllegalArgumentException("시나리오를 찾을 수 없습니다: " + scnrId);
        }
        return scenario;
    }

    @Transactional
    public void createScenario(TmsScenario scenario, String userId) {
        if (scenario.getUseYn() == null) {
            scenario.setUseYn("Y");
        }
        if (scenario.getAlertYn() == null) {
            scenario.setAlertYn("Y");
        }
        scenario.setRegId(userId);
        tmsScenarioMapper.insert(scenario);
        log.info("TMS Scenario created: {} by {}", scenario.getScnrId(), userId);
    }

    @Transactional
    public void updateScenario(TmsScenario scenario, String userId) {
        TmsScenario existing = tmsScenarioMapper.findById(scenario.getScnrId());
        if (existing == null) {
            throw new IllegalArgumentException("시나리오를 찾을 수 없습니다: " + scenario.getScnrId());
        }
        scenario.setUpdId(userId);
        tmsScenarioMapper.update(scenario);

        String apprNo = generateApprNo("SCN");
        String title = "[시나리오 변경] " + existing.getScnrNm();
        String content = String.format(
                "시나리오 ID: %s, 시나리오명: %s - 설정 변경 결재 요청",
                scenario.getScnrId(), scenario.getScnrNm());
        tmsApprService.createApproval("SCENARIO", scenario.getScnrId(), apprNo, title, content, userId);
        log.info("TMS Scenario updated: {} by {}, approval created: {}", scenario.getScnrId(), userId, apprNo);
    }

    @Transactional(readOnly = true)
    public List<TmsSetVal> getSetVals(String scnrId) {
        return tmsSetValMapper.findByScnrId(scnrId);
    }

    @Transactional(readOnly = true)
    public PageResult<TmsSetVal> getAllSetVals(String scnrId, int page, int size) {
        int offset = (page - 1) * size;
        List<TmsSetVal> content = tmsSetValMapper.findAll(scnrId, offset, size);
        int total = tmsSetValMapper.countAll(scnrId);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional
    public void updateSetVal(TmsSetVal setVal, String userId) {
        TmsSetVal existing = tmsSetValMapper.findById(setVal.getSetId());
        if (existing == null) {
            throw new IllegalArgumentException("설정값을 찾을 수 없습니다: " + setVal.getSetId());
        }
        setVal.setUpdId(userId);
        tmsSetValMapper.update(setVal);

        String apprNo = generateApprNo("SV");
        String title = "[설정값 변경] " + existing.getScnrId() + " - " + existing.getSetKey();
        String content = String.format(
                "시나리오: %s, 설정키: %s, 변경전: %s -> 변경후: %s",
                existing.getScnrId(), existing.getSetKey(), existing.getSetVal(), setVal.getSetVal());
        tmsApprService.createApproval("SETVAL", existing.getScnrId(), apprNo, title, content, userId);
        log.info("TMS SetVal updated: setId={} by {}, approval: {}", setVal.getSetId(), userId, apprNo);
    }

    private String generateApprNo(String prefix) {
        String ts = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        return "APPR-" + prefix + "-" + ts;
    }
}
