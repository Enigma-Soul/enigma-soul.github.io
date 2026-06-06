# clean.ps1 - Clear Hugo generated files and empty folders
# Usage: ./clean.ps1

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

# Hugo generated files
$targets = @(
    "$root/public",
    "$root/resources",
    "$root/.hugo_build.lock",
    "$root/hugo_stats.json",
    "$root/assets/jsconfig.json"
)

foreach ($t in $targets) {
    if (Test-Path $t) {
        Remove-Item $t -Recurse -Force
        Write-Host "Removed: $t" -ForegroundColor Green
    }
}

# Remove empty folders under content/
$emptyDirs = Get-ChildItem -Path "$root\content" -Directory -Recurse | Where-Object { $_.GetFiles().Count -eq 0 -and $_.GetDirectories().Count -eq 0 }
foreach ($d in $emptyDirs) {
    Remove-Item $d.FullName -Force
    Write-Host "Removed empty dir: $($d.FullName)" -ForegroundColor Yellow
}

Write-Host "`nDone." -ForegroundColor Cyan
