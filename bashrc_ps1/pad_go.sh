
#----------------------Manual_Functions--------------------
#----------------------Manual_Functions--------------------
#----------------------Manual_Functions--------------------
#----------------------Manual_Functions--------------------


pg_conn() {
  echo "Открываю SSH-туннель..."
  echo "1 — Test_cnc (5433 ➝ 5433)"
  echo "2 — Prod_cnc (5433 ➝ 5432)"
  read -p "Выбери [1]: " opt
  
  opt=${opt:-1}
  
  if [[ $opt == "1" ]]; then
    pkill -f "ssh.*-L.*:5433:localhost:5433" 2>/dev/null
    sleep 1
    ssh -f -N -L 0.0.0.0:5433:localhost:5433 cnc_postgre@217.146.67.129 -p 12555
    echo "✅ SSH-туннель для Test_cnc создан"
  elif [[ $opt == "2" ]]; then
    pkill -f "ssh.*-L.*:5433:localhost:5432" 2>/dev/null
    sleep 1
    ssh -f -N -L 0.0.0.0:5433:localhost:5432 cnc_postgre@217.146.67.129 -p 12555
    echo "✅ SSH-туннель для Prod_cnc создан"
  else
    echo "❌ Неверный выбор"
    return 1
  fi
  
  # Пауза, чтобы туннель успел создаться
  sleep 2
  
  # Проверка через lsof (более надёжная)
  if lsof -i :5433 >/dev/null 2>&1; then
    echo "✅ Проверка: порт 5433 успешно слушает"
  else
    # Альтернативная проверка через ss
    if ss -tlnp 2>/dev/null | grep -q ":5433"; then
      echo "✅ Проверка: порт 5433 успешно слушает"
    else
      echo "⚠️ Проверка: порт 5433 не обнаружен, но возможно туннель создаётся..."
    fi
  fi
}

pg_conn_one_tunnel() {
    local port_check
    port_check=$(lsof -i :5433 -sTCP:LISTEN -t)

    if [[ -n "$port_check" ]]; then
        echo "SSH-туннель уже запущен (PID: $port_check)."
    else
        echo "Открываю SSH-туннель (5433 ➝ 5432)..."
        ssh -f -N -L 0.0.0.0:5433:localhost:5432 cnc_postgre@217.146.67.129
        if [[ $? -eq 0 ]]; then
            echo "Туннель создан успешно."
        else
            echo "Ошибка при создании туннеля."
        fi
    fi
}

pg_status() {
  echo "🔍 Проверка SSH-туннелей PostgreSQL/PgAdmin..."
  
  local ports=("5433" )
  local tunnel_found=0
  local pids=()

  for port in "${ports[@]}"; do
    if lsof -i TCP:$port -sTCP:LISTEN -n >/dev/null 2>&1; then
      echo "✅ Порт $port — слушает (туннель активен)"
      tunnel_found=1
    else
      echo "❌ Порт $port — не слушает"
    fi
  done

  echo
  echo "📡 Активные SSH-туннели:"
  ps_out=$(ps aux | grep "[s]sh.*-L" | grep -E "5433|5050")
  if [[ -n "$ps_out" ]]; then
    echo "$ps_out"
    echo

    # Сохраним PID процессов
    while read -r line; do
      pid=$(echo "$line" | awk '{print $2}')
      pids+=("$pid")
    done <<< "$ps_out"

    read -p "❓ Завершить эти SSH-соединения? [y/N]: " answer
    if [[ "$answer" == [Yy] ]]; then
      for pid in "${pids[@]}"; do
        kill "$pid" && echo "⛔️ Завершено соединение PID $pid"
      done
    else
      echo "✅ Соединения оставлены без изменений."
    fi
  else
    echo "🟢 Нет активных SSH-туннелей на портах"
  fi
}


# Функция для выбора проекта 
function projects() {
    PS3="Select project to start or enter 'q' to quit: "

    # Include additional paths directly in the list of virtual environments
    options=(
		"cnc-wisdom(docker_solution)"
        # Add more environments with additional paths and directories as needed
    )

    select opt in "${options[@]}" "Quit"; do
        case $opt in
            "Quit")
                break
                ;;
           
	   		"cnc-wisdom(docker_solution)")
				pg_conn_one_tunnel
				cd "$HOME/Documents/PROG/Projects/cnc-wisdom"
				docker compose up -d
				break
				;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done
}

function vpn_conn(){
	cd ~/Documents
	sudo openvpn --config Ma.ovpn
	
}

create_project() {
    PS3="Выберите тип проекта для создания: "
	COLUMNS=1 

    options=(
        "Django project with Docker"
        "Flask project with Docker"

        # Здесь можно добавить другие типы проектов
    )

    select opt in "${options[@]}" "Quit"; do
        case $REPLY in
            1)
                echo "▶️ Запуск скрипта создания Django-проекта с Docker..."
                
                # Указываем путь к скрипту
                SCRIPT="$HOME/Documents/PROG/Compendium/bash_scripts/init_django_docker.sh"

                # Проверяем, существует ли скрипт
                if [[ -x "$SCRIPT" ]]; then
                    "$SCRIPT"
                else
                    echo "❌ Скрипт не найден или не исполняемый: $SCRIPT"
                fi
                break
                ;;
           
			2)
	            echo "▶️ Запуск скрипта создания Flask-проекта с Docker..."
			                
			    # Указываем путь к скрипту
			    SCRIPT="$HOME/Documents/PROG/Compendium/bash_scripts/init_flask_docker.sh"
			
			    # Проверяем, существует ли скрипт
			    if [[ -x "$SCRIPT" ]]; then
			        "$SCRIPT"
			    else
			    	echo "❌ Скрипт не найден или не исполняемый: $SCRIPT"
			    fi
			    break
			    ;;

			$((${#options[@]} + 1)))
				echo "👋 Выход."
			    break
			    ;;
                
            *)
                echo "❌ Неверный выбор. Попробуйте снова."
                ;;
        esac
    done
}

start_flask_project(){
	SCRIPT="$HOME/Documents/PROG/Compendium/bash_scripts/create_flask_project.sh"
	# Проверяем, существует ли скрипт
		if [[ -x "$SCRIPT" ]]; then
	    	"$SCRIPT"
	    	else
	        	echo "❌ Скрипт не найден или не исполняемый: $SCRIPT"
	        fi
	
}
comp(){
	nohup xdg-open "obsidian://open?vault=Compendium&file=index" >/dev/null 2>&1 &
	
}
#-f-unc_list----------------------------------------------------
func_list(){
	echo "Список доступных функций:"
	echo "-------------------------------------------"
	echo "func_list (Список доступных функций)"
	echo "variables_list (Список переменных)"
	echo "pg_conn (Проброс порта c выбором вариантов)"
	echo "pg_conn_one_tunnel (Проброс порта 5433 на 5432 в Zone)"
	echo "pg_status (Статус проброса порта)"
	echo "projects (Запуск проектов по выбору)"
	echo "vpn_conn (Включение vpn от Zone)"
	echo "create_project (Создание проекта из списка)"
	echo "start_flask_project (Скрипт для создания начального состояния для Flask)"
	echo "comp (Запуск index.md в marktext начальная страница для Компендиума)"
}

variables_list(){
	echo "Список активных переменных:"
	echo "-------------------------------------------"
	echo "serv (@uvn-67-129.tll01.zonevs.eu)"
	echo "serv_ru (@62.181.53.198)"
	echo "Compendium ($HOME/Documents/PROG/Compendium)"
	echo "Projects ($HOME/Documents/PROG/Projects)"
}


#---------------------------Manual variables-------------

export serv=@uvn-67-129.tll01.zonevs.eu
export serv_ru=@62.181.53.198
export Compendium="$HOME/Documents/PROG/Compendium"
export Projects="$HOME/Documents/PROG/Projects"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

