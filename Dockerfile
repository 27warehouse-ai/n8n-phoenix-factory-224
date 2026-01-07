# 1. 繼承官方 v2.2.4 版本
FROM n8nio/n8n:2.2.4

# 2. 切換成 root 權限安裝工具
USER root

# 3. 使用 apt-get 安裝影音與雲端神器 (Debian 版指令)
# update: 更新套件清單
# install -y: 自動確認安裝
# rm -rf: 安裝完清理暫存減小體積
RUN apt-get update && apt-get install -y \
    ffmpeg \
    awscli \
    python3 \
    python3-pip \
    bash \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# 4. 切換回 node 使用者
USER node
