#!/bin/bash
# init_fastAPI_react.sh
# Скрипт генерации минимального проекта FastAPI + React Native (Expo)
# Запуск: bash init_fastAPI_react.sh

# === Запрос имени проекта ===
read -p "Введите имя проекта: " PROJECT_NAME

# === Определяем локальный IP ===
LOCAL_IP=$(hostname -I | awk '{print $1}')
echo "📡 Определён локальный IP: $LOCAL_IP"

# === Создаём корневую папку ===
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# === BACKEND (FastAPI) ===
echo "⚙️ Создаём backend (FastAPI)..."
mkdir backend
cat <<EOF > backend/Dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
EOF

cat <<EOF > backend/requirements.txt
fastapi
uvicorn
EOF

cat <<EOF > backend/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/ping")
async def ping():
    return "Соединение с сервером установлено"
EOF

# === FRONTEND (React Native + Expo) ===
echo "📱 Создаём мобильное приложение..."
npx create-expo-app mobile --template blank

# Создаём config.js с IP API
cat <<EOF > mobile/config.js
export const API_URL = "http://$LOCAL_IP:8000";
EOF

# Заменяем App.js на тестовый API-запрос
cat <<EOF > mobile/App.js
import React, { useEffect, useState } from "react";
import { Text, View } from "react-native";
import { API_URL } from "./config";

export default function App() {
  const [response, setResponse] = useState("Загрузка...");

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch(\`\${API_URL}/ping\`);
        const data = await res.text();
        setResponse(\`API ответ: \${data}\`);
      } catch (e) {
        setResponse("API ответ: Ошибка соединения");
        console.log(e);
      }
    };
    fetchData();
  }, []);

  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center" }}>
      <Text>{response}</Text>
    </View>
  );
}
EOF

# === docker-compose.yml ===
cat <<EOF > docker-compose.yml
version: "3"
services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
EOF
# === README.md ===
cat <<EOF > README.md
# $PROJECT_NAME

Минимальный проект **FastAPI + React Native (Expo)**

## Запуск проекта

### Backend (FastAPI + Docker)
Сборка и запуск:
\`\`\`bash
docker-compose up --build
\`\`\`
После запуска API будет доступен по адресу:
\`\`\`
http://Your_ip:8000
\`\`\`
Установи свой ip в mobile/config.js
\`\`\`
### Frontend (React Native + Expo)
Переходим в папку mobile и запускаем Expo:
\`\`\`bash
cd mobile
npx expo start
\`\`\`
Сканируйте QR-код через приложение Expo Go на телефоне. Приложение будет автоматически обращаться к API по адресу, указанному в config.js.

## Как получить IP вашей машины

### Linux
\`\`\`bash
hostname -I | awk '{print $1}'
\`\`\`

### Windows (PowerShell)
\`\`\`powershell
ipconfig | Select-String "IPv4"
\`\`\`



### Примечания
- Если мобильное приложение и сервер на разных устройствах, убедитесь, что они в одной сети.
- В случае ошибок соединения проверьте firewall.
EOF

echo "📄 README.md создан с инструкциями по запуску и получению IP"


echo "✅ Проект $PROJECT_NAME создан!"
echo "📌 Запуск backend: docker-compose up --build"
echo "📌 Запуск mobile: cd mobile && npx expo start"
echo "📱 В Expo Go открой проект и он будет стучаться на http://$LOCAL_IP:8000/ping"
