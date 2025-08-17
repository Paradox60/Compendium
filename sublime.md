# <center><span style="color:gold">Фичи для sublime</center>

#### Удаление проекта из списка проектов ctrl+alt+p

Linux: 
```bash
micro ~/.config/sublime-text/Local/Session.sublime_session
```
Windows:
```bash
%APPDATA%\Sublime Text\Local\Session.sublime_session
```
macOS:
```bash
~/Library/Application Support/Sublime Text/Local/Session.sublime_session
```

Открой этот файл (обычно это JSON).

Найди блок "workspaces" → "recent_workspaces". Там будут пути к проектам.

# <center>Список дополнений</center>

- #### *LSP, LSP-pyright* → подсказки по Python.
	*Пропиши в настройках путь к python:*
```js
	{
    "clients": {
        "pyright": {
            "enabled": true,
            "settings": {
                "python.pythonPath": "/usr/bin/python3"
            }
        }
    }
}
```

- #### *Jinja2* → подсветка синтаксиса в Flask/Django/FastAPI-шаблонах.
- #### *Emmet* → быстрое написание HTML/CSS (например: div.container>ul>li\*5 → разворачивается в готовый код).

## Не использовал
- #### *Requester* → прямо из Sublime можно тестировать HTTP-запросы (как мини Postman).