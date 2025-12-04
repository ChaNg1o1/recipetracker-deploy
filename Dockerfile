FROM eclipse-temurin:17-jdk-alpine

# 安装 ttyd 和终端工具
RUN apk add --no-cache ttyd util-linux

# 设置工作目录
WORKDIR /app

# 复制 JAR 文件
COPY RecipeTracker-1.0-SNAPSHOT.jar app.jar

# 暴露端口（Koyeb 默认使用 8000）
EXPOSE 8000

# 设置终端环境变量
ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# 设置默认的认证凭据（可通过环境变量覆盖）
ENV TTYD_USER=admin
ENV TTYD_PASS=1024

# 创建启动脚本（带自动重启）
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'stty -echo 2>/dev/null || true' >> /app/start.sh && \
    echo 'while true; do' >> /app/start.sh && \
    echo '  echo "=== RecipeTracker 启动中 ===" ' >> /app/start.sh && \
    echo '  java -Djline.terminal=dumb -jar /app/app.jar 2>&1' >> /app/start.sh && \
    echo '  EXIT_CODE=$?' >> /app/start.sh && \
    echo '  echo ""' >> /app/start.sh && \
    echo '  echo "程序退出 (代码: $EXIT_CODE)，3秒后重启..."' >> /app/start.sh && \
    echo '  sleep 3' >> /app/start.sh && \
    echo 'done' >> /app/start.sh && \
    chmod +x /app/start.sh

# 使用 ttyd 启动 Java 应用
# -p 8000: 监听端口
# -W: 允许写入（用户可以输入）
# -m 5: 允许最多5个客户端同时连接
# -t: 终端选项
# 注意：移除了 -c 认证参数以兼容 Safari
# 如需认证，可使用 Koyeb 的私有应用功能或 Cloudflare Access
CMD ["sh", "-c", "ttyd -p 8000 -W -m 5 -t fontSize=14 /app/start.sh"]
