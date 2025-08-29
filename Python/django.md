### Запуск проекта
```bash
django-admin startproject myproject
```

### Запуск сервера
```bash
python manage.py runserver
```

### Запуск нового приложения
```bash
python manage.py startapp myapp
```

### Запуск созданеие миграция
```bash
python manage.py makemigrations
```

### Показать изменения миграций
```bash
python manage.py showmigrations
```

### Создать суперпользователя
```bash
python manage.py createsuperuser
```

### Сбрасывает базу данных (удаляет все данные, но оставляет структуру)
```bash
python manage.py flush
```

### Проверяет проект на ошибки без запуска сервера
```bash
python manage.py check
```

## При работе в Docker

```bash
docker-compose exec web
```

# Работа с базами данных:
| Django Field Type | Postgres Type   | Описание                                                                 |
|-------------------|-----------------|--------------------------------------------------------------------------|
| AutoField         | SERIAL          | Поле для хранения айдишников. Базовая модель уже имеет одно такое поле id |
| BooleanField      | BOOLEAN         | Логическое поле (True/False)                                            |
| CharField         | VARCHAR(255)    | Текстовое поле фиксированной длины (n - максимум)                       |
| DateField         | DATE            | Поле для хранения даты                                                  |
| TimeField         | TIME            | Поле для хранения времени                                               |
| DateTimeField     | TIMESTAMP       | Поле для хранения даты и времени                                        |
| DurationField     | INTERVAL        | Поле для хранения промежутка времени                                    |
| DecimalField      | DECIMAL         | Числа с фиксированной точностью                                         |
| FloatField        | REAL            | Числа с плавающей точкой                                                |
| TextField         | TEXT            | Текстовое поле неограниченной длины                                     |