# Команды для git
---

- ### git init
- ### git status
- ### git remote add origin git$serv:git/your_project.git
- ### git remote -v
- ### git remote set-url --add --push origin git.....

- ### git push
- ### git pull
- ### git add
- ### git commit -m "Your commit"
- ### git config --global user.name "Your_name"
- ### git config --global user.email "Your_e-mail"
- ### git branch -m main 
- ### git rm -r --cached folder/ (рекурсивное удаление файла из всего репозитория) 

# Cоздание голового репозитория на сервере:
---

- ### mkdir repository.git
- ### cd repository.git
- ### git init --bare


# Универсальный .gitignore:
---

```python
______
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Virtual environments
venv/
env/
.venv/
.env/
ENV/
Pipfile.lock

# Environment variables
*.env
*.env.*
!.env.example

# VS Code
.vscode/

# PyCharm
.idea/

# macOS
.DS_Store

# Jupyter Notebook checkpoints
.ipynb_checkpoints

# Logs and debug
*.log
*.pot
*.pyc

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Docker
*.pid
*.tar
*.log
docker-compose.override.yml

# Node (if used for frontend)
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build artifacts
build/
dist/
*.egg-info/
.eggs/

# Markdown cache or temp files
*.md~
.obsidian/

# Temporary files
*.swp
*.swo
*.bak
*.tmp

# Compiled static
staticfiles/

# Articles or generated content
content/__pycache__/

# Sublime files
*.sublime-workspace
```


