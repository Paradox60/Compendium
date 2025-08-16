# <center>Сделать скрипт исполняемым</center>
---
```bash
chmod +x script_name.sh
```
*запуск скрипта*
```bash
./script_name.sh
```

# <center>Генерация ssh ключа</center>
---
```bash
ssh-keygen -t ed25519
```
```bash
ssh-keygen -t rsa -b 4096 
```
# <center>Установка micro</center>
---
```bash
sudo apt update
sudo apt install micro
```
# <center>Добавляем нового пользователя</center>

- ### 1. Создаём пользователя без пароля
```bash
adduser --disabled-password guest
```
- ### 2. Создаём папку для ключей
```bash
mkdir -p /home/guest/.ssh
chmod 700 /home/guest/.ssh
```
- ### 3. Добавляем твой публичный ключ
```bash
nano /home/guest/.ssh/authorized_keys
```
 #### *вставляешь сюда свой ключ (ssh-rsa ...)*
- ### 4. Установка прав
```bash
chmod 600 /home/guest/.ssh/authorized_keys
chown -R guest:guest /home/guest/.ssh
``` 
    
# <center>Удаление пользователя вместе с домашней директорией</center>
```bash
sudo deluser --remove-home имя_пользователя
``` 
# <center>Работа с сервером</center>

#### Файлы конфигураций сервера

- */etc/ssh/sshd_config*


#### Рестарт ssh службы
```bash
sudo systemctl restart sshd
```



#### Проверка параметра входа по паролю

```bash
sudo sshd -T | grep -E 'passwordauthentication|challenge|pam'
```

# <center>Установка OpenVPN скриптом</center>

- #### 1. Создай папку в папке /home vpn_folder и перейди в нее

- #### 2. Скачай скрипт с github

```bash
wget https://git.io/vpn -O openvpn-install.sh
```

- #### 3. Сделай скрипт исполняемым

```bash
chmod +x openvpn-install.sh
```

- #### 4. Запусти скрипт
```bash
sudo ./openvpn-install.sh
```

*Выбираем настройки:*

    Protocol: TCP (важно для stunnel)
    Port: 443 (если не занят, иначе другой, например 4443)
    DNS: Google (8.8.8.8)
    Шифрование: AES-256 (по умолчанию)
    Всё остальное — по умолчанию.

*После установки скрипт создаст клиентский файл (client.ovpn) в этой же папке.*

# <center>Настройка stunnel (маскировка под HTTPS) (Не использовал)</center>
- #### 1. Установка stunnel
```bash
sudo apt install stunnel4 -y
```
- #### 2. Создаём самоподписанный сертификат 

```bash
sudo openssl req -new -x509 -days 365 -nodes -out /etc/stunnel/stunnel.pem -keyout /etc/stunnel/stunnel.pem
```
*Просто жмём Enter на всех вопросах (данные не важны).*

- #### 3. Конфигурация stunnel
	- #### Открываем конфиг:

	```bash
	sudo nano /etc/stunnel/stunnel.conf
	```
	- #### Добавляем:

			ini

			[openvpn]
			accept = 443                # Внешний порт (HTTPS)
			connect = 127.0.0.1:1194    # Порт OpenVPN (если меняли в скрипте — укажите свой)
			cert = /etc/stunnel/stunnel.pem
			key = /etc/stunnel/stunnel.pem

	- #### Включаем автозапуск stunnel:


	```bash
	sudo sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/stunnel4
	sudo systemctl restart stunnel4
	```

- #### 4. Проверка работы
	```bash
	sudo sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/stunnel4
	sudo systemctl restart stunnel4
	```
	```bash
	sudo netstat -tulnp | grep -E '(openvpn|stunnel)'
	```
	*Вывод должен содержать:*
    	stunnel на порту 443 (HTTPS)
    	openvpn на порту 1194 (или ваш кастомный порт)

- #### 5. Скачать файл клиента заменив в нем содержимое
	ini

	    remote ваш_сервер_IP 443  # Порт stunnel (не OpenVPN!)
	    proto tcp

- #### 4. Дополнительная маскировка (опционально)	    
	Если провайдер блокирует HTTPS-прокси, можно добавить obfsproxy:

	```bash
	sudo apt install obfsproxy
	sudo obfsproxy --log-file=/var/log/obfsproxy.log obfs3-server --dest=127.0.0.1:1194
	```
	*В client.ovpn укажите:*
		ini

			socks-proxy 127.0.0.1 1050

	*Если есть ошибки:*

    	Проверьте firewall (sudo ufw allow 443).
    	Убедитесь, что stunnel запущен (sudo systemctl status stunnel4).

