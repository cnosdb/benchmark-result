#!/bin/bash

# 说明：该脚本用于将指定文件复制到指定目录，并将更改提交到git仓库，该脚步只能在benchmark-result目录下执行

# 检查参数数量
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <absolute_file_path> <relative_directory_path>"
    exit 1
fi

# 获取参数
file_path=$1
directory_path=$2

# 检查文件是否存在
if [ ! -f "$file_path" ]; then
    echo "File $file_path does not exist."
    exit 1
fi

# 检查目录是否存在
if [ ! -d "$directory_path" ]; then
    echo "Directory $directory_path does not exist, <relative_directory_path> only supports benchmark-hits and benchmark-tsbs."
    exit 1
fi

# 复制文件到目标目录
cp "$file_path" "$directory_path"

# 更新git仓库
git pull

# 添加文件到git
git add .

# 提交更改
git commit -m "Add file $(basename "$file_path")"

# 推送到远程仓库（假设已经配置了远程仓库）
git push

echo "File copied and changes committed and pushed to git repository."