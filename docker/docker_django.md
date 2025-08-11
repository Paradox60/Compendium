# <center><span style="color:blue">Создание докер контейнера для Django</span></center>
---
<br>

### 1. Создать папку проекта project_folder

### 2. Создать в папке проекта файл "Dockerfile"
  *Наполнить файл содержимым:*

```text  
# Dockerfile
FROM python:3.12-slim
  
# Установка зависимостей системы
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*
  
# Установка рабочей директории
WORKDIR /app
  
# Копируем файлы проекта
COPY requirements.txt /app/
  
# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt
  
# Копируем остальную часть проекта
COPY . /app/
  
# Открываем порт
EXPOSE 8000

# Команда по умолчанию
CMD ["gunicorn", "cnc_wisdom.wsgi:application", "--bind", "0.0.0.0:8000"]
```

### 3. Создать в папку проекта файл "docker-compose.yml"  
  *Наполнить файл содржимым:*
```yml
# docker-compose.yml
  
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
      POSTGRES_DB: cncwisdom
      POSTGRES_USER: cncuser
      POSTGRES_PASSWORD: cncpwd
    volumes:
      - postgres_data:/var/lib/postgresql/data
  
volumes:
  postgres_data:
```

### 4. Создать в папку проекта файл "requirments.txt":
  *Наполнить файл содержимым:*
```text  
Django>=5.0,<6.0
gunicorn
psycopg2-binary
```

### 5. Создать в папке проекта файл ".env"
  *Наполнить файл содержимым:*
```text
DEBUG=1
SECRET_KEY=your-secret-key
DJANGO_ALLOWED_HOSTS=localhost 127.0.0.1 [::1]
```

### 6. Создать Django-проект внутри Docker:
```bash
docker-compose run web django-admin startproject cnc_wisdom .
```

### 7. Запуск:
```bash
docker-compose up --build
```

#### После выгрузки последней версии:
---
- git pull
- docker-compose down
- docker-compose up --build

#### Инициализация git репозитория:
---

- git init
- echo -e "venv/\n__pycache__/\n*.pyc\n*.sqlite3\n.env\n.env.*\n.docker\n*.log" > .gitignore
- git add .
- git commit -m "initial dockerized Django project"
   
