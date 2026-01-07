# ---------------------------------------------------------
# 🦍 華爾街黑猩猩專用 - 影音自動化軍火庫 (v2.2.4 Stable)
# ---------------------------------------------------------

# 1. 地基：使用 Node.js 22 (Debian Bookworm)
# 這是最穩定的 Linux 版本，保證 apt-get 可用，FFmpeg 不會缺件
FROM node:22-bookworm-slim

# 2. 安裝核心軍火 (FFmpeg, AWS CLI, Python)
# --no-install-recommends: 只裝必要的，保持輕量
# rm -rf: 裝完清理垃圾，縮小體積
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    awscli \
    curl \
    jq \
    python3 \
    python3-pip \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. 安裝大腦：n8n (鎖定版本 v2.2.4)
# 這是目前經過驗證最穩定的版本
RUN npm install -g n8n@2.2.4

# 4. 安全性設定 (Zeabur/Docker 規範)
USER node
WORKDIR /home/node

# 5. 啟動指令
ENTRYPOINT ["n8n"]
