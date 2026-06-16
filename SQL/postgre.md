# Накатить таблицы и сразу их востановить в Postgre

```sql
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
```

# Команда на проверку логов подключения к бд
```bash
docker logs pg-docker-test | grep -E "connection authorized|FATAL" | grep -oE "host=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
```

# Полезные команды для диагностики
```bash
# Посмотреть логи контейнера
docker logs pg-docker-test --tail 30

# Посмотреть логи с фильтром ошибок
docker logs pg-docker-test --tail 50 | grep -E "FATAL|ERROR"

# Посмотреть логи с временем
docker logs pg-docker-test --tail 20 --timestamps

# Следить за логами в реальном времени
docker logs -f pg-docker-test

# Проверить статус контейнера
docker ps -a | grep pg-docker-test
```