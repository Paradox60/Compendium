# <center><span style="color:goldenrod;">BeeWare с django для мобильного приложения через WebView</span></center>

### 1. Перейти по ссылке и выполнить все пункты до "1.develop your app from here" 

### <center>[Ссылка](https://github.com/Cheukting/briefcase-positron-template)</center>

#### Или просто выполни эти шаги:
```bash
python -m pip install briefcase toga cookiecutter Django
```
```bash
cookiecutter https://github.com/Cheukting/briefcase-positron-template.git
```
```bash  
python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
```
   Вставить полученный ключ в src/webapp/webapp/settings.py

---
### 2. Создаешь новое приложение "App_name" согласно пункту:
 - #### *"1. develop your app from here"*
---


### 3. В файле src/App_name/app.py Меняешь строку

self.web_view.url = f"http://{host}:{port}/"
На
self.web_view.url = f"http://{host}:{port}/My_APP"

---
### 4. В файле src/webapp/webapp/settings.py. Добавляешь строки
```python
import os

INSTALLED_APPS = [
......
.....
......
'webapp.My_APP.apps.My_APPConfig',
]

STATIC_URL = 'static/'
STATICFILES_DIRS = [
    BASE_DIR /'webapp/static/'
]
STATIC_ROOT = os.path.join(BASE_DIR, 'webapp/assets')
```
---
### 5. В файле src/webapp/webapp/urls.py. Добавляешь строки

```python
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('My_APP/', include("webapp.My_APP.urls")),
    #path('admin/', admin.site.urls),
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
```
---
### 6. В scr/webapp/App_name/

- *Папку templates*
- *Создаешь файл urls.py*
- *Файл views.py*

В папку templates создаешь папку и в ней App_name/home.html

urls.py

```python
from django.urls import path
from .views import *

urlpatterns = [
   path('', home, name="home"),
]
```

views.py
```python
def home(request):
    return render (request, 'My_APP/home.html')
```
---
### 7. В scr/webapp/My_APP/apps.py
```python
class SamiToolsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'My_APP'
Заменить на
class SamiToolsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'webapp.My_APP'
```

