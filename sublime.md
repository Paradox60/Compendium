# <center><span style="color:gold">Фичи для sublime</center>

#### Удаление проекта из списка проектов ctrl+alt+p

Linux: 
```bash
micro ~/.config/sublime-text/Local/Session.sublime_session
```
Windows: %APPDATA%\Sublime Text\Local\Session.sublime_session

macOS: ~/Library/Application Support/Sublime Text/Local/Session.sublime_session

Открой этот файл (обычно это JSON).

Найди блок "workspaces" → "recent_workspaces". Там будут пути к проектам.