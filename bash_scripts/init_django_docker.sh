#!/bin/bash

echo "🔧 Инициализация Django-проекта в Docker"

# Спрашиваем имя проекта Django
read -p "Введите имя Django-проекта (например: cnc_wisdom): " DJANGO_PROJECT

# Надёжный выбор базы данных
while true; do
  echo "Выберите базу данных:"
  echo "  1) SQLite (по умолчанию)"
  echo "  2) PostgreSQL"
  read -p "Введите номер [1-2]: " DB_OPTION

  if [[ "$DB_OPTION" == "1" || -z "$DB_OPTION" ]]; then
    DB_CHOICE="sqlite"
    break
  elif [[ "$DB_OPTION" == "2" ]]; then
    DB_CHOICE="postgres"
    break
  else
    echo "❌ Неверный выбор. Пожалуйста, введите 1 или 2."
  fi
done

echo "✅ Выбрана база данных: $DB_CHOICE"


echo "📦 Создаём Dockerfile..."
cat > Dockerfile <<EOF
FROM python:3.12-slim

RUN apt-get update && apt-get install -y \\
    build-essential \\
    libpq-dev \\
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

CMD ["gunicorn", "${DJANGO_PROJECT}.wsgi:application", "--bind", "0.0.0.0:8000"]
EOF

echo "📦 Создаём requirements.txt..."

cat > requirements.txt <<EOF
Django>=5.0,<6.0
gunicorn
EOF

if [ "$DB_CHOICE" = "postgres" ]; then
  echo "psycopg2-binary" >> requirements.txt
fi

echo "📦 Создаём .env..."

cat > .env <<EOF
DEBUG=1
SECRET_KEY=$(openssl rand -hex 32)
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]
EOF

echo "📦 Создаём docker-compose.yml..."

if [ "$DB_CHOICE" = "postgres" ]; then
cat > docker-compose.yml <<EOF
services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
    env_file:
      - .env
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: ${DJANGO_PROJECT}_db
      POSTGRES_USER: ${DJANGO_PROJECT}_user
      POSTGRES_PASSWORD: password
    volumes:
      - pg_data:/var/lib/postgresql/data

volumes:
  pg_data:
EOF
else
cat > docker-compose.yml <<EOF
services:
  web:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - .:/app
    env_file:
      - .env
EOF
fi

# Сборка образа
echo "🔨 Собираем Docker-образ..."
docker build -t $DJANGO_PROJECT .

# Генерация Django-проекта
echo "🚀 Генерируем Django-проект внутри контейнера..."
docker run -v $(pwd):/app $DJANGO_PROJECT django-admin startproject $DJANGO_PROJECT .

echo "✅ Django-проект '$DJANGO_PROJECT' создан."

echo "💡 Готово к запуску:"
echo "  docker-compose up --build"
