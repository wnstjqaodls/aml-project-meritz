package com.aml.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class User {
    private String userId;
    private String userNm;
    private String deptCd;
    private String email;
    private String pwd;
    private String roleCd;
    private String useYn;
    private LocalDateTime regDt;
}
