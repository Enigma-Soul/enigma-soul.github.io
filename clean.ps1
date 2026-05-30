# clean.ps1 — 清除 Hugo 生成文件和空文件夹
# 用法: ./clean.ps1

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

# Hugo 生成产物
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
        Write-Host "已删除: $t" -ForegroundColor Green
    }
}

# 清除 content/ 下的空文件夹
$emptyDirs = Get-ChildItem -Path "$root\content" -Directory -Recurse | Where-Object { $_.GetFiles().Count -eq 0 -and $_.GetDirectories().Count -eq 0 }
foreach ($d in $emptyDirs) {
    Remove-Item $d.FullName -Force
    Write-Host "已删除空文件夹: $($d.FullName)" -ForegroundColor Yellow
}

Write-Host "`n清理完成" -ForegroundColor Cyan
