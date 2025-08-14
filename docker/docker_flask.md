# <center><span style="color:darkgreen;">Создание проекта на FLask через Docker:</span></center>
---

### 1. Создать директорию и перейти в нее 
```bash
mkdir project_folder
cd project_folder
```

### 2. Создать Dockerfile и наполнить:
```text
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./$project_name /app

EXPOSE 5000

```

### 3. Создать docker-compose.yml и наполнить:

```yml
services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - FLASK_APP=app.py
      - FLASK_ENV=development
      - FLASK_DEBUG=1
    volumes:
      - ./$project_name:/app
    env_file:
      - .env
    command: flask run --host=0.0.0.0 --reload
```      

### 4. Создать requirement.txt и наполнить:

```text
Flask>=2.0
```
### 5. Создать файл .env и наполинть:
```textt
FLASK_ENV=development
```
### 6. Выполнить команду 
```bash
start_flask_project
```
  - #### *Назвать папку проекта $project_name*


