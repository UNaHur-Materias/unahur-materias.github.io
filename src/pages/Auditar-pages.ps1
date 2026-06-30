# Auditar-Pages.ps1
$reportePath = Join-Path $PSScriptRoot "Auditoria-Pages.txt"
$lineaSeparadora = "=" * 80

If (Test-Path $reportePath) { Remove-Item $reportePath }

Add-Content -Path $reportePath -Value "AUDITORIA DE ENRUTAMIENTO Y LOGICA DE PAGES"
Add-Content -Path $reportePath -Value "Generado el: $(Get-Date)"
Add-Content -Path $reportePath -Value $lineaSeparadora
Add-Content -Path $reportePath -Value ""

Add-Content -Path $reportePath -Value "[ESTRUCTURA DE ARCHIVOS EN PAGES]"
$estructuraPages = Get-ChildItem -Path $PSScriptRoot -Recurse | Select-Object @{Name="RutaRelativa"; Expression={$_.FullName.Replace($PSScriptRoot + "\", "")}}
foreach ($file in $estructuraPages) {
    if ($file.RutaRelativa -notlike "*Auditoria-Pages.txt*") {
        Add-Content -Path $reportePath -Value "  $($file.RutaRelativa)"
    }
}
Add-Content -Path $reportePath -Value ""
Add-Content -Path $reportePath -Value $lineaSeparadora
Add-Content -Path $reportePath -Value ""

Add-Content -Path $reportePath -Value "[CODIGO FUENTE DE LOS ARCHIVOS .ASTRO EN PAGES]"
Add-Content -Path $reportePath -Value ""

$archivosAstro = Get-ChildItem -Path $PSScriptRoot -Filter "*.astro" -Recurse

foreach ($archivo in $archivosAstro) {
    $rutaRelativa = $archivo.FullName.Replace($PSScriptRoot + "\", "")
    Add-Content -Path $reportePath -Value "--- ARCHIVO: $rutaRelativa ---"
    
    # Usamos .NET para leer el texto completo de forma retrocompatible
    $contenido = [System.IO.File]::ReadAllText($archivo.FullName)
    
    Add-Content -Path $reportePath -Value $contenido
    Add-Content -Path $reportePath -Value ""
    Add-Content -Path $reportePath -Value $lineaSeparadora
    Add-Content -Path $reportePath -Value ""
}

Write-Host "Ahora si, auditoria completada sin errores." -ForegroundColor Green