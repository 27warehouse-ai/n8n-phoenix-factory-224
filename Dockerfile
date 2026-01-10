# ==========================================
# Stage 1: 取得 Alpine 的 apk 工具
# ==========================================
FROM alpine:latest AS alpine

# ==========================================
# Stage 2: 建立 n8n with FFmpeg
# ==========================================
FROM n8nio/n8n:latest

# 複製 apk 及其依賴（解決 n8n 2.1.0+ 移除 apk 的問題）
COPY --from=alpine /sbin/apk /sbin/apk
COPY --from=alpine /usr/lib/libapk.so* /usr/lib/

# 切換到 root 使用者以安裝套件
USER root

# 安裝 FFmpeg, AWS CLI, Python3 及其他工具
RUN apk add --no-cache \
    ffmpeg \
    aws-cli \
    python3 \
    py3-pip \
    curl \
    bash \
    git \
    && rm -rf /var/cache/apk/*

# ==========================================
# 環境變數設定（針對每日 100 支影片優化）
# ==========================================

# 安全性設定
ENV NODE_FUNCTION_ALLOW_BUILTIN=*
ENV NODE_FUNCTION_ALLOW_EXTERNAL=*
ENV N8N_RUNNERS_DISABLED_MODULES=""

# Binary Data 設定
ENV N8N_DEFAULT_BINARY_DATA_MODE=default
ENV N8N_BINARY_DATA_TTL=60

# 執行歷史清理
ENV EXECUTIONS_DATA_PRUNE=true
ENV EXECUTIONS_DATA_MAX_AGE=168

# Payload 大小限制
ENV N8N_PAYLOAD_SIZE_MAX=256

# 時區設定
ENV GENERIC_TIMEZONE=America/Vancouver

# Node.js 記憶體優化
ENV NODE_OPTIONS="--max-old-space-size=4096"

# 切換回 node 使用者（安全性最佳實踐）
USER node

# 使用預設的 n8n 啟動指令
CMD ["n8n"]
