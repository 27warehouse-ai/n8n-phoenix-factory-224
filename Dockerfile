FROM node:22-bookworm-slim

# 安裝系統依賴
RUN apt-get update && apt-get install -y \
    ffmpeg \
    awscli \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安裝最新版 n8n
RUN npm install -g n8n

# 設定環境變數（保險起見還是加上）
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV N8N_DEFAULT_BINARY_DATA_MODE=

# 設定工作目錄
WORKDIR /data

# 啟動 n8n worker
CMD ["n8n", "worker"]

