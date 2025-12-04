FROM eclipse-temurin:17-jdk-alpine

RUN apk add --no-cache ttyd util-linux

WORKDIR /app

COPY RecipeTracker-1.0-SNAPSHOT.jar app.jar

EXPOSE 8000

ENV TERM=xterm-256color
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'while true; do' >> /app/start.sh && \
    echo '  echo "PaaS端消息:RecipeTracker 启动中" ' >> /app/start.sh && \
    echo '  java -Djline.terminal=dumb -jar /app/app.jar 2>&1' >> /app/start.sh && \
    echo '  EXIT_CODE=$?' >> /app/start.sh && \
    echo '  echo ""' >> /app/start.sh && \
    echo '  echo "PaaS端消息:程序退出 (代码: $EXIT_CODE) 3秒后重启..."' >> /app/start.sh && \
    echo '  sleep 3' >> /app/start.sh && \
    echo 'done' >> /app/start.sh && \
    chmod +x /app/start.sh

CMD ["sh", "-c", "ttyd -p 8000 -W -m 200 -t fontSize=14 /app/start.sh"]
