# 1. 選擇基底：使用 Node.js 20 的 Alpine 版本 (輕量、穩定、有 apk)
FROM node:20-alpine

# 2. 系統層安裝：FFmpeg, Curl, Python3, AWS CLI
RUN apk add --no-cache \
    ffmpeg \
    curl \
    python3 \
    py3-pip \
    aws-cli \
    bash \
    findutils \
    && rm -rf /var/cache/apk/*

# 3. 應用層安裝：全域安裝 n8n
RUN npm install -g n8n

# 4. 準備工作目錄
RUN mkdir -p /tmp/render && chmod 777 /tmp/render

# 5. 安全性：切換回 node 使用者
USER node

# 6. 啟動指令 (智慧導航版) 🔴 重點改這裡
# 我們用 find 指令直接找出啟動檔在哪裡，不管官方怎麼改名都抓得到
CMD ["sh", "-c", "RUNNER_FILE=$(find /usr/local/lib/node_modules -type f -path '*/@n8n/task-runner/dist/*/index.js' | head -n 1); echo \"🚀 Starting Runner from: $RUNNER_FILE\"; node $RUNNER_FILE"]
