package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.domain.User;
import com.aml.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserMapper userMapper;

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<Map<String, Object>>> login(@RequestBody Map<String, String> body) {
        String userId = body.get("userId");
        String pwd = body.getOrDefault("password", body.get("pwd"));

        if (userId == null || userId.isBlank() || pwd == null || pwd.isBlank()) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error("사용자 ID와 비밀번호를 입력하세요."));
        }

        User user = userMapper.findByIdAndPwd(userId, pwd);
        if (user == null) {
            return ResponseEntity.status(401)
                    .body(ApiResponse.error("아이디 또는 비밀번호가 올바르지 않습니다."));
        }

        // Return user info without password
        Map<String, Object> userInfo = new HashMap<>();
        userInfo.put("userId", user.getUserId());
        userInfo.put("userName", user.getUserNm());
        userInfo.put("userNm", user.getUserNm());
        userInfo.put("deptCd", user.getDeptCd());
        userInfo.put("email", user.getEmail());
        userInfo.put("role", user.getRoleCd());
        userInfo.put("roleCd", user.getRoleCd());

        log.info("User logged in: {}", userId);
        return ResponseEntity.ok(ApiResponse.ok(userInfo, "로그인 성공"));
    }

    @PostMapping("/logout")
    public ResponseEntity<ApiResponse<Void>> logout(
            @RequestHeader(value = "X-User-Id", required = false) String userId) {
        log.info("User logged out: {}", userId);
        return ResponseEntity.ok(ApiResponse.ok(null, "로그아웃 성공"));
    }
}
