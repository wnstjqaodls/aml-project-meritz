package com.aml.mapper;

import com.aml.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    User findById(@Param("userId") String userId);

    User findByIdAndPwd(@Param("userId") String userId, @Param("pwd") String pwd);

    List<User> findAll();

    int insert(User user);

    int update(User user);
}
