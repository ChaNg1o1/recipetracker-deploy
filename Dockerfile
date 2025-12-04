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

# 创建启动脚本
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'exec java -Djline.terminal=dumb -jar /app/app.jar' >> /app/start.sh && \
    chmod +x /app/start.sh

# 使用 ttyd 启动 Java 应用
# -p 8000: 监听端口
# -W: 允许写入（用户可以输入）
# -c: 基本认证 用户名:密码
# -t: 添加终端选项
CMD ["sh", "-c", "ttyd -p 8000 -W -c ${TTYD_USER}:${TTYD_PASS} -t fontSize=14 -t fontFamily='Consolas,Monaco,monospace' /app/start.sh"]
