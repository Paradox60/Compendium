## <center><span style="color:red">Установка docker compose:</span></center>
---

```bash
1. sudo snap docker compose
```

<br><br>
### Полезные команды:
---

-  ### Запуск в фоне
```bash
docker-compose up -d 
```

- ### Удаление всех контейнеров
```bash
docker compose down --remove-orphans
```
- ### Для перезапуска контейнера после ребута сервера
  *В файле docker-composer.yml*
```bash
restart: unless-stopped  
```

