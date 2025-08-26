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