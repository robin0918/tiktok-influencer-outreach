# GitHub Pages 自动启用脚本
# 使用方法：powershell -ExecutionPolicy Bypass -File enable-pages.ps1

Write-Host "正在获取 GitHub Token..."
$token = gh auth token

Write-Host "正在启用 GitHub Pages..."
$headers = @{
    "Authorization" = "token $token"
    "Accept" = "application/vnd.github.v3+json"
}

$body = @{
    source = @{
        branch = "master"
    }
}

try {
    $response = Invoke-RestMethod -Uri "https://api.github.com/repos/robin0918/tiktok-influencer-outreach/pages" -Method PUT -Headers $headers -Body ($body | ConvertTo-Json) -ContentType "application/json"

    Write-Host "Pages 启用请求已发送"
    Write-Host "响应：" $response

    if ($response -match '"status":"200"') {
        Write-Host "`n====================" -ForegroundColor Green
        Write-Host "Pages 启用成功！" -ForegroundColor Green
        Write-Host "====================" -ForegroundColor Green
        Write-Host "`n访问地址：" -ForegroundColor Cyan
        Write-Host "https://robin0918.github.io/tiktok-influencer-outreach/" -ForegroundColor Cyan
        Write-Host "`n等待 1-2 分钟生效..."
    } else {
        Write-Host "`n====================" -ForegroundColor Red
        Write-Host "Pages 启用失败，请手动操作" -ForegroundColor Red
        Write-Host "====================" -ForegroundColor Red
    }

} catch {
    Write-Host "`n发生错误：" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host "`n请手动访问：https://github.com/robin0918/tiktok-influencer-outreach/settings/pages" -ForegroundColor Yellow
}

Write-Host "`n按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
