FROM eclipse-temurin:17-jre-alpine

# 安装 ttyd
RUN apk add --no-cache ttyd

# 设置工作目录
WORKDIR /app

# 复制 JAR 文件
COPY RecipeTracker-1.0-SNAPSHOT.jar app.jar

# 暴露端口（Koyeb 默认使用 8000）
EXPOSE 8000

# 设置默认的认证凭据（可通过环境变量覆盖）
ENV TTYD_USER=admin
ENV TTYD_PASS=1024

# 使用 ttyd 启动 Java 应用
# -p 8000: 监听端口
# -W: 允许写入（用户可以输入）
# -c: 基本认证 用户名:密码
CMD ttyd -p 8000 -W -c ${TTYD_USER}:${TTYD_PASS} java -jar app.jar
