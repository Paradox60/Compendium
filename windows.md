# <center>Установка npx</center>

скачай node.js для windows и установи=)


# <center>🚀 Установка Chocolatey</center>

Открой PowerShell

Нажми Win + X → выбери Windows PowerShell (Администратор).

Выполни команду (вставь и нажми Enter):
```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## <center>🚀 Установка Tidy</center>

```shell
choco install html-tidy
```
Установка линтеров:
```shell
choco install html-tidy -y
```
```shell
npm install -g stylelint
```

# <center>🚀 Настройк ssh</center>
```shell
cd .ssh
micro config
```

# <center>🚀 Аналог bashrc</center>
```shell
$PROFILE
```