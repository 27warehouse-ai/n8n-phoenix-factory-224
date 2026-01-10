FROM node:22-bookworm-slim

# 安裝系統依賴
RUN apt-get update && apt-get install -y \
    ffmpeg \
    awscli \
    python3 \
    python3-pip \
    curl \
    bash \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安裝最新版 n8n
RUN npm install -g n8n

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

# 設定工作目錄
WORKDIR /data

# 啟動 n8n worker
CMD ["n8n", "worker"]
