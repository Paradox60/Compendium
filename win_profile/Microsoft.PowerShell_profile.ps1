# Переменные ------------------------------------------------------------------------------------------
$Projects = "A:\PROG\Projects"
$Compendium = "A:\PROG\Compendium"
$cnc = "A:\PROG\Projects\cnc-wisdom"
$serv = "@uvn-67-129.tll01.zonevs.eu"
$serv_ru = "@62.181.53.198"
$ProjectsDir = "A:\PROG\Projects"


# Функции--------------------------------------------------------------------------------------

function start-cnc {
    Write-Host "OPEN SSH-tunnel..." -ForegroundColor Cyan

    # Запуск SSH-туннеля в фоне
    Start-Process ssh -ArgumentList @(
        "-N",
        "-L", "0.0.0.0:5433:localhost:5432",
        "-o", "ServerAliveInterval=60",
        "-o", "ServerAliveCountMax=5",
        "cnc_postgre@217.146.67.129"
    ) -WindowStyle Hidden
    docker compose up -d
}

function projects {
    # Define available projects
    $projects = @(
        @{ Name = "cnc-wisdom"; Path = "$Projects\cnc-wisdom" },
        @{ Name = "site-blog";   Path = "$Projects\site-blog" },
        @{ Name = "client-app";  Path = "$Projects\client-app" }
    )

    Write-Host "`nSelect a project to start:`n" -ForegroundColor Yellow

    # Display numbered list
    for ($i = 0; $i -lt $projects.Count; $i++) {
        $num = $i + 1
        Write-Host "$num. $($projects[$i].Name)"
    }

    # User input
    $choice = Read-Host "`nEnter project number"

    if ($choice -match '^\d+$' -and $choice -ge 1 -and $choice -le $projects.Count) {
        $selected = $projects[$choice - 1]

        Write-Host "`n[+] Setting up SSH tunnel..." -ForegroundColor Cyan
        
        # Спрашиваем какой туннель нужен
        Write-Host "1 - Test_cnc (5433 -> 5433)"
        Write-Host "2 - Prod_cnc (5433 -> 5432)"
        $tunnelChoice = Read-Host "Select tunnel type [2]"
        if ([string]::IsNullOrWhiteSpace($tunnelChoice)) { $tunnelChoice = "2" }
        
        # Создаем туннель
        pg_conn -Opt $tunnelChoice

        # Change to project directory
        Set-Location $selected.Path

        # Start docker-compose
        Write-Host "`n[+] Starting docker-compose for '$($selected.Name)'..." -ForegroundColor Green
        docker compose up -d
        
        Write-Host "`n[+] Project '$($selected.Name)' is running!" -ForegroundColor Green
        Write-Host "Location: $($selected.Path)" -ForegroundColor Gray
    }
    else {
        Write-Host "[-] Invalid selection!" -ForegroundColor Red
    }
}

function pg_conn {
    param(
        [ValidateSet('1', '2')]
        [string]$Opt = "2"
    )
    
    $target = if ($Opt -eq "1") { "Test_cnc" } else { "Prod_cnc" }
    $remotePort = if ($Opt -eq "1") { "5433" } else { "5432" }
    
    Write-Host "`n[+] Opening SSH tunnel for $target..." -ForegroundColor Cyan
    
    # Закрываем старые туннели на порту 5433
    $existingProcesses = Get-NetTCPConnection -LocalPort 5433 -State Listen -ErrorAction SilentlyContinue
    if ($existingProcesses) {
        Write-Host "[-] Closing existing tunnel on port 5433..." -ForegroundColor Yellow
        foreach ($conn in $existingProcesses) {
            try {
                Stop-Process -Id $conn.OwningProcess -Force -ErrorAction SilentlyContinue
            } catch {}
        }
        Start-Sleep -Seconds 1
    }
    
    # Запускаем новый туннель
    $sshArgs = @(
        "-N",
        "-L", "0.0.0.0:5433:localhost:$remotePort",
        "-p", "12555",
        "-o", "ServerAliveInterval=60",
        "-o", "ServerAliveCountMax=5",
        "cnc_postgre@217.146.67.129"
    )
    
    try {
        Start-Process ssh -ArgumentList $sshArgs -WindowStyle Hidden
        Start-Sleep -Seconds 2
        
        # Проверяем
        $portCheck = Get-NetTCPConnection -LocalPort 5433 -State Listen -ErrorAction SilentlyContinue
        if ($portCheck) {
            Write-Host "[+] SSH tunnel for $target is ready on port 5433" -ForegroundColor Green
        } else {
            Write-Host "[-] Tunnel started, but port check failed" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "[-] Error creating tunnel: $_" -ForegroundColor Red
    }
}

# Import the Chocolatey Profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}