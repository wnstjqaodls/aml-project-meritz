package com.aml.service;

import com.aml.domain.Code;
import com.aml.mapper.CodeMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class CodeService {

    private final CodeMapper codeMapper;

    public List<Code> getCodesByGroup(String codeGrp) {
        log.debug("Getting codes for group: {}", codeGrp);
        return codeMapper.findByGroup(codeGrp);
    }

    public List<Code> getAllCodes() {
        return codeMapper.findAll();
    }
}
