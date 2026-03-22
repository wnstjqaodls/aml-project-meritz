# ─── Build stage ───────────────────────────────────
FROM maven:3.9-eclipse-temurin-17-alpine AS builder
WORKDIR /build

# pom.xml 먼저 복사 (레이어 캐싱 최적화)
COPY pom.xml .
RUN mvn dependency:go-offline -q 2>/dev/null || true

COPY src ./src

# Oracle 프로필로 빌드 (테스트 스킵)
RUN mvn package -DskipTests -q

# ─── Runtime stage ─────────────────────────────────
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# 타임존 설정 (한국 표준시)
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    echo "Asia/Seoul" > /etc/timezone

COPY --from=builder /build/target/aml-backend-*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]
