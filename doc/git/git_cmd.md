# Git CMD

## remote

1. Be a little more verbose and show remote url after name.

```shell
git remote -v
```

2. Changes URLs for the remote. Sets first URL for remote <name> that matches regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If <oldurl> doesn’t match any URL, an error occurs and nothing is changed.

```shellgit remote set-url origin git://mirrors.tuna.tsinghua.edu.cn/homebrew.git
git remote set-url origin git://mirrors.tuna.tsinghua.edu.cn/homebrew.git
```

3. Add a remote named <name> for the repository at <url>.

``` shell
git remote add origin https://github.com/potteryorchid/jupyter-notebooks.git
```



Mac查看安装目录: which git

$ git add “filename”    // Add one file

$ git add .    // Add all flies in the drectory

$ git commit -m “msg”    // commit a mission

$ git push origin local_branch:remote_branch    // 提交本地分支到远程库

$ git branch    // 查看本地分支

$ git branch branch_name    // 创建新分支

$ git branch -a    // 查看本地和远程分支

$ git checkout branchname   // 切换到已有分支

$ git checkout -b dev    // 建立并切换到新分支

$ git checkout -b local_branch_name origin/remote_branch_name    // 拉取远程分支并建立新分支，同时切换到新分支

$ git merge branch_name    // 合并分支

$ git merge --no-ff -m "merge with no-ff" dev    // 合并分支，同时将合并分支作为一次commit提交

$ git branch -d branch_name    // 删除分支

$ git log --graph --pretty=oneline --abbrev-commit    // 查看提交历史

$ git checkout branch_name    // 切换已有分支

$ git remote    // 显示远程仓库名称

$ git remote -v    // 显示远程仓库克隆地址



# 将本地当前分支和远程分支建立连接

$ git push -u origin master

$ git fetch remote_repo_name    // 从远程仓库抓取数据

$ git remote show branch_name    // 查看远程仓库信息

$ git remote rename branch_name new_name    // 修改远程分支名称

$ git remote rm branch_name    // 删除远程分支

$ git fetch origin master    // 获取远程分支

$ git pull origin master    // 拉取远程分支

//——————同步代码 start———————

$ git fetch origin master:tmp    // 拉取远程分支到本地 建立临时分支

$ git diff tmp    // 查看临时分支与当前分支区别

$ git merge tmp    // 将临时分支合并到当前分支

$ git push origin local_master:remote_master    // 将同步好的当前分支推送到远程仓库

$ git branch -d tmp    // 删除临时分支

//——————同步代码 end————————

$ git checkout -- “filename”    // 执行 “git add” 命令前放弃本地丢改

$ git rm --cached <file>    // 执行 “git add” 命令后，执行 “git commit” 命令前撤销 “commit” 提交

$ git rm -r --cached <file path>    // 撤销一个文件夹内提交，执行 “git add” 命令后，执行 “git commit” 命令前撤销 “commit” 提交

$ git reset readme.txt    // 执行 “git add” 命令后，执行 “git commit” 命令前撤销 “commit” 提交

$ git reset -- readme.txt    // 执行 “git add” 命令后，执行 “git commit” 命令前撤销 “commit” 提交

$ git reset HEAD -- readme.txt    // 执行 “git add” 命令后，执行 “git commit” 命令前撤销 “commit” 提交

$ git reset <last good SHA>    // commit后，push到远端前撤销提交，<last good SHA>：commit生成提交码，撤销后保留本地修改纪录

$ git reset --hard <last good SHA>    // commit后，push到远端前撤销提交，<last good SHA>：commit生成提交码，撤销后不保留本地修改纪录

$ git revert <SHA>    // push操作后撤销，git revert 会产生一个新的 commit，它和指定 SHA 对应的 commit 是相反的

**tag**

git tag -d `git tag --list '3.2.*'`
