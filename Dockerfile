# ⚠️ 專用於 Runners 服務 (剪輯師)
# 使用官方 Runner 映像檔作為地基 (通常是 Alpine 架構，支援 apk)
FROM n8nio/runners:latest

# 切換成 root 來安裝工具
USER root

# 安裝 FFmpeg 與 AWS CLI
# 因為是 runners 映像檔，這裡的 apk 指令通常是有效的
RUN apk add --no-cache \
    ffmpeg \
    aws-cli \
    bash \
    curl \
    jq

# 切換回 node 使用者 (符合 n8n 安全規範)
USER node
