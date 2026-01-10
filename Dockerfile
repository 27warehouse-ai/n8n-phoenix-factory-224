FROM n8nio/n8n:latest

USER root

# 複製 Task Runner 配置檔
COPY n8n-task-runners.json /etc/n8n-task-runners.json
RUN chmod 644 /etc/n8n-task-runners.json

# 更新套件列表並安裝 FFmpeg, Python3, AWS CLI 等工具
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    awscli \
    && rm -rf /var/lib/apt/lists/*

USER node

# 環境變數
ENV N8N_DEFAULT_BINARY_DATA_MODE=default
ENV NODE_OPTIONS="--max-old-space-size=4096"
ENV EXECUTIONS_DATA_PRUNE=true
ENV EXECUTIONS_DATA_MAX_AGE=168
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_RUNNERS_MODE=external
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
