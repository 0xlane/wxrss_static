# PowerShell 脚本，每隔 10 分钟下载多个网页内容到 Git 并提交

# 设置要下载的网页 URLs (使用数组)
$urls = @(
    "http://localhost:8080"
    "http://localhost:8080/rss.xml"
)

# 设置保存文件的路径和文件名 (使用数组，与 URLs 对应)
$savePaths = @(
    "index.html"
    "rss.xml"
)

# 循环执行，直到脚本被手动停止
while ($true) {
    Write-Host "----------------------------------"
    Write-Host "开始新一轮下载和 Git 操作..."

    # 循环遍历 URLs 和 SavePaths 数组
    for ($i = 0; $i -lt $urls.Count; $i++) {
        $url = $urls[$i]
        $savePath = $savePaths[$i]

        try {
            Write-Host "开始下载网页内容: $($url)"
            # 使用 Invoke-WebRequest 下载网页内容
            $content = Invoke-WebRequest -Uri $url -UseBasicParsing

            # 将网页内容保存到文件 (使用 UTF8 编码)
            $content.Content | Out-File -FilePath $savePath -Encoding UTF8

            Write-Host "网页内容下载成功，保存到 $($savePath)"

        } catch {
            # 如果下载失败，捕获错误信息
            Write-Warning "下载网页内容失败: $($url) - $_"
            Write-Warning "跳过此 URL 的 Git 操作"
            continue # 跳过当前 URL 的后续 Git 操作，继续下一个 URL
        }
    } # for 循环结束 (URLs 遍历完成)

    # 检查是否有任何网页下载成功 (这里简化处理，只要循环没有完全失败就执行 Git)
    # 更严谨的判断可以记录下载成功次数，如果至少成功一次再执行 Git

    Write-Host "执行 git add, commit, push..."

    # 假设脚本在 Git 项目的根目录下运行，直接执行 Git 命令
    git add .
    git commit -m "update"
    git push

    Write-Host "Git 操作完成"
    Write-Host "----------------------------------"


    # 等待 10 分钟 (600 秒)
    Write-Host "等待 10 分钟..."
    Start-Sleep -Seconds 600
    Write-Host "10 分钟已过，准备下一次下载"
}

Write-Host "脚本已启动，每 10 分钟运行一次。按 Ctrl+C 停止脚本。"