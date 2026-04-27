If you need to install this panel again, you can use below command:
Для установки веб панели 
```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```

Панель менеджер в bash
```bash
x-ui
```

Эти команды удалят Xray, AmneziaWG, WireGuard и все их следы.
```bash
# 1. Останавливаем всё, что может работать
sudo systemctl stop xray awg-quick@awg0 wg-quick@wg0 2>/dev/null
sudo systemctl disable xray awg-quick@awg0 wg-quick@wg0 2>/dev/null

# 2. Убиваем процессы, если остались
sudo pkill -9 xray 2>/dev/null
sudo pkill -9 awg 2>/dev/null

# 3. Удаляем пакеты
sudo apt-get remove --purge -y xray amneziawg amneziawg-dkms amneziawg-tools wireguard wireguard-tools wireguard-dkms 2>/dev/null
sudo apt-get autoremove --purge -y

# 4. Удаляем конфиги и ключи
sudo rm -rf /usr/local/etc/xray /etc/amnezia /etc/wireguard /root/awg /usr/local/bin/xray

# 5. Чистим правила iptables (от VPN и прокси)
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F

# 6. Чистим маршруты (если что-то осталось)
sudo ip link delete awg0 2>/dev/null
sudo ip link delete wg0 2>/dev/null

# 7. Удаляем правила UFW (чтобы не было сюрпризов)
sudo ufw --force reset
sudo ufw --force disable
```