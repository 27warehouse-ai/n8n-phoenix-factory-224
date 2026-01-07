# 1. 繼承官方 v2.2.4 版本 (保持與主程式一致)
FROM n8nio/n8n:2.2.4

# 2. 切換成 root 權限來安裝工具
USER root

# 3. 安裝影音與雲端神器 (FFmpeg + AWS CLI)
# 同時補齊 python3, bash, curl 等常用工具
RUN apk add --no-cache \
    ffmpeg \
    aws-cli \
    python3 \
    py3-pip \
    bash \
    curl \
    jq

# 4. 安裝完後，切換回 node 使用者 (這是 n8n 的安全規範)
USER node
