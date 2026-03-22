package com.aml.config;

import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.mapping.VendorDatabaseIdProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * MyBatis DatabaseIdProvider 설정.
 *
 * 이 설정을 통해 mapper XML에서 databaseId 속성으로
 * DB 종류별 SQL 분기 가능:
 *
 * <select id="findList" databaseId="h2">   -- H2 전용 (LIMIT/OFFSET)
 * <select id="findList" databaseId="oracle"> -- Oracle 전용 (ROWNUM)
 * <select id="findList">                   -- 공통 (databaseId 없으면 모든 DB에 적용,
 *                                              단 전용 버전이 있으면 전용 버전 우선)
 *
 * 감지 규칙:
 * - H2    → databaseId = "h2"
 * - Oracle → databaseId = "oracle"
 */
@Configuration
public class MybatisConfig {

    @Bean
    public DatabaseIdProvider databaseIdProvider() {
        VendorDatabaseIdProvider provider = new VendorDatabaseIdProvider();
        Properties props = new Properties();
        props.setProperty("H2", "h2");
        props.setProperty("Oracle", "oracle");
        provider.setProperties(props);
        return provider;
    }
}
