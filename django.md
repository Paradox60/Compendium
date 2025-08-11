# Создание проекта на Django:
---

### 1. Создать папку проекта project_folder
### 2. Перейди в папку проекта
```bash
cd project_folder
```
### 3. Создай виртуальное окружение 
```bash
python3 -m venv venv
```
### 4. Активируй виртуальное окружение 
```bash
source venv/bin/activate
```
### 5. Установи джанго в виртуальное окружение 
```bash
pip install django
```
---

# Редактирование проекта под запуск:
---

###  1. Создаем сам проект

```bash
django-admin startproject project_name .
```

###  2. Создаем приложение проекта

```bash
python3 manage.py startapp app_name
```

### 3. Редактируем файл project_name/settings.py

```python
LANGUAGE_CODE = 'ru-ru'
TIME_ZONE = 'Europe/Moscow'
ALLOWED_HOSTS = ['127.0.0.1', 'localhost']

INSTALLED_APPS = [
    ...
    'app_name',
]
```
### 4. Редактируем файл project_name/urls.py

```python
from django.contrib import admin
from django.urls import path
from app_name.views import home

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home),
]
```
### 5. Редактируем файл app_name/view.py

```python
from django.http import HttpResponse

def home(request):
    return HttpResponse("Привет от Django!")
```
### 6. Иницилизируем миграциид для БД

```bash
python manage.py migrate
```
### 7. Создаем супер пользователя для админки

```bash
python manage.py createsuperuser
```

### 8. Запуск сервера

```bash
python manage.py runserver
```
---
# Работа с базами данных в Django:
---

- python manage.py migrate - По умолчанию создает таблицы и записывает
необходимые изменения в BD

- python manage.py createsuperuser - Создает суперпользователя для работы в админке

- python manage.py showmigrations - Показывает уже проведенные миграции


