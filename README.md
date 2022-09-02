# MCBE-server-status2Discord
現在編集中...

### **依存関係**

・bash

・[Discord.sh](https://github.com/ChaoticWeg/discord.sh)

・curl

・jq

・bats
　(Discord.sh内で使用されているため)
 
 ##### **依存しているものの入手**
 

bashはほとんどのログインシェルであるので省略。

Discord.shはgit cloneなどで入手する。

jq、bats、jqなどはaptなどのパッケージリポジトリから入手する。

### **このプロジェクトの使用方法**

Discord.shのリポジトリをわかりやすい場所にgit cloneしておく。

そして、このリポジトリをgit cloneする。

このプロジェクトのローカルリポジトリのディレクトリに移動し、
・server_ping.sh
・config.json
をコピーし、Discord.shのディレクトリに貼り付ける。

Discord.shのディレクトリに移動し、
./server_ping.sh
と打ち込み起動完了。
