# Ruta del directorio de simulación
$folder = "$env:USERPROFILE\Documents\SimulacionRansom"
New-Item -ItemType Directory -Path $folder -Force | Out-Null

# Crear 100 archivos falsos .txt
1..100 | ForEach-Object {
    $file = Join-Path $folder ("documento$_.txt")
    "Archivo de prueba número $_" | Out-File $file
}

# Simular cifrado: renombrar, codificar en base64 y eliminar el original
Get-ChildItem -Path $folder -Filter *.txt | ForEach-Object {
    $originalPath = $_.FullName
    $newPath = $originalPath + ".enc"

    $content = Get-Content $originalPath
    $encoded = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($content))

    $encoded | Out-File $newPath
    Remove-Item $originalPath
}

Write-Host "Simulación de cifrado completada. Archivos renombrados a .enc"

# Ejecutarlo de forma remota
# psexec \\nombre_del_equipo_remoto -s powershell -ExecutionPolicy Bypass -File "C:\ruta\al\script\simulador_ransomware.ps1"
#psexec \\nombre_equipo_remoto -s powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/tu_usuario/tu_repositorio/main/simulador_ransomware.ps1' -OutFile 'C:\Windows\Temp\ransom_sim.ps1'; Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File C:\Windows\Temp\ransom_sim.ps1' -WindowStyle Hidden"
# con logs
# psexec \\nombre_equipo_remoto -s powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Defend3rX/AV-Testing-Scripts/main/simulador_ransomware.ps1' -OutFile 'C:\Windows\Temp\ransom_sim.ps1'; powershell -ExecutionPolicy Bypass -File 'C:\Windows\Temp\ransom_sim.ps1'; 'Simulación ejecutada correctamente en ' + (Get-Date) | Out-File -FilePath 'C:\simulador_ransomware.log' -Encoding UTF8 -Append; Remove-Item -Path $env:USERPROFILE\Documents\SimulacionRansom -Recurse -Force -ErrorAction SilentlyContinue; Remove-Item 'C:\Windows\Temp\ransom_sim.ps1' -Force -ErrorAction SilentlyContinue"
# url
#https://raw.githubusercontent.com/Defend3rX/AV-Testing-Scripts/main/simulador_ransomware.ps1
