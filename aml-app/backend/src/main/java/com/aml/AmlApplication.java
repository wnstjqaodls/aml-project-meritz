package com.aml;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.aml.mapper")
public class AmlApplication {

    public static void main(String[] args) {
        SpringApplication.run(AmlApplication.class, args);
    }
}
