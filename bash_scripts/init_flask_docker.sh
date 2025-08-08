#!/bin/bash

echo "🚀 Flask + Docker Initializer"

# 1. Запрашиваем имя проекта
read -p "Введите название Flask-проекта (папка с кодом): " project_name

# Проверка, что папка не существует
if [ -d "$project_name" ]; then
    echo "❌ Папка '$project_name' уже существует!"
    exit 1
fi

# 2. Создание структуры папок
mkdir -p "$project_name"/{static,templates}

# 3. Создаём app.py
cat > "$project_name"/app.py <<EOF
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# 4. Создаём requirements.txt
cat > requirements.txt <<EOF
Flask>=2.0
EOF

# 5. Создаём index.html
cat > "$project_name"/templates/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>$project_name</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
</head>
<body>
    <h1>Добро пожаловать в $project_name на Flask + Docker!</h1>
    <button onclick="greet()">Кликни</button>
    <script src="{{ url_for('static', filename='script.js') }}"></script>
</body>
</html>
EOF

# 6. CSS и JS
cat > "$project_name"/static/style.css <<EOF
body {
    background-color: #111;
    color: #eee;
    font-family: sans-serif;
    text-align: center;
    padding: 50px;
}
EOF

cat > "$project_name"/static/script.js <<EOF
function greet() {
    alert("Привет от Flask + Docker!");
}
EOF

# 7. Dockerfile
cat > Dockerfile <<EOF
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./$project_name /app

EXPOSE 5000

CMD ["python", "app.py"]
EOF

# 8. docker-compose.yml (без версии!)
cat > docker-compose.yml <<EOF
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - ./$project_name:/app
    env_file:
      - .env
EOF

# 9. .env
cat > .env <<EOF
FLASK_ENV=development
EOF

echo "✅ Проект '$project_name' с Docker успешно создан!"
echo "👉 Запуск: docker compose up"
