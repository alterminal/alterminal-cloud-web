# 第一階段：構建應用
FROM node:18-alpine AS builder

WORKDIR /app

# 複製 package.json 和 package-lock.json
COPY package*.json ./

# 安裝依賴
RUN npm install

# 複製所有源代碼
COPY . .

# 構建應用
RUN npm run build

# 第二階段：運行應用
FROM nginx:alpine

# 從構建階段複製構建結果
COPY --from=builder /app/dist /usr/share/nginx/html

# 複製自定義 nginx 配置（可選）
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 啟動 nginx
CMD ["nginx", "-g", "daemon off;"]