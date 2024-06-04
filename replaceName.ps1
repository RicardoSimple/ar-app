# 检查输入参数
if ($args.Count -ne 1) {
    exit 1
}

# 定义要替换的原始字符串
$original_string = "flutter_template"

# 定义要替换成的新字符串
$new_string = $args[0]

# 定义要搜索的文件类型
$file_types = @("*.dart", "*.json", "*.yaml")

# 使用循环遍历文件类型
foreach ($file_type in $file_types) {
    # 使用Get-ChildItem命令查找所有匹配的文件，并对每个文件进行替换操作
    Get-ChildItem -Recurse -Filter $file_type | ForEach-Object {
        (Get-Content $_.FullName) -replace $original_string, $new_string | Set-Content $_.FullName
    }
}

Write-Host "end"
