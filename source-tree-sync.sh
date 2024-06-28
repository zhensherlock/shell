#!/bin/bash
#
# Author: MichaelSun
# Date: 2023/12/25
# Description: Sync Code Script
#

echo "正在更新master分支代码..."

git checkout master

# 拉取 master 分支的最新提交
git fetch origin master

git stash

# 重置 master 分支
git rebase origin/master

git push -v --tags gitlab refs/heads/master:refs/heads/master 

git stash pop

echo "master分支代码更新完成"

if git show-ref --verify --quiet refs/heads/dev; then
    echo "正在更新dev分支代码..."
    git checkout dev
    git fetch origin dev
    git stash
    git rebase origin/dev
    git push -v --tags gitlab refs/heads/dev:refs/heads/dev
    git stash pop
    echo "dev分支代码更新完成"
else
  echo "未找到dev分支，无需更新"
fi

echo 'mission complete'