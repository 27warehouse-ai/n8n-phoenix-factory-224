FROM n8nio/n8n:latest

# 切換到 root 使用者以安裝套件
USER root

# 安裝 FFmpeg, AWS CLI, Python3, 以及效能優化工具
RUN apk add --no-cache \
    ffmpeg \
    aws-cli \
    python3 \
    py3-pip \
    curl \
    bash \
    git

# 設定環境變數 - 針對高負載優化
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV N8N_DEFAULT_BINARY_DATA_MODE=default
ENV N8N_RUNNERS_DISABLED_MODULES=""

# 效能優化設定（針對每日 100 支影片）
ENV EXECUTIONS_DATA_PRUNE=true
ENV EXECUTIONS_DATA_MAX_AGE=168
ENV N8N_PAYLOAD_SIZE_MAX=256
ENV N8N_BINARY_DATA_TTL=60
ENV GENERIC_TIMEZONE=America/Vancouver

# Node.js 記憶體優化（避免 OOM）
ENV NODE_OPTIONS="--max-old-space-size=4096"

# 切換回 node 使用者（安全性）
USER node

# 使用預設的 n8n 啟動指令
CMD ["n8n"]
