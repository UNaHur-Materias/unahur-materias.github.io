$Salida = "estructura.txt"

Get-ChildItem -Recurse |
Where-Object {
    $_.FullName -notmatch "\\vendor\\" -and
    $_.FullName -notmatch "\\node_modules\\" -and
    $_.FullName -notmatch "\\.git\\" -and
    $_.FullName -notmatch "\\files\\_cache\\" -and
    $_.FullName -notmatch "\\files\\_sessions\\"
} |
ForEach-Object {
    $_.FullName.Replace($PWD.Path + "\", "")
} |
Out-File -Encoding UTF8 $Salida

Write-Host "Exportado a $Salida"