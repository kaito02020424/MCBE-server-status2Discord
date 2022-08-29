#! /bin/bash
#変数定義
webhook=`jq -r '.WebHook' ./config.json`
server=`jq -r '.Server' ./config.json`
online=`curl https://api.mcsrvstat.us/bedrock/2/${server} -sS | jq '.online'`
bot_name=`jq -r '."Bot Name"' ./config.json`
#初期化
if [ $online = "true" ]; then
	old_ping="online"
	echo "初期値:online"
else
	old_ping="offline"
	echo "初期値:offline"
fi
last_time=$((`date +%s%3N`))
cycle_message=$((`date +%s%3N`))

#監視サーバー起動メッセージ
./discord.sh --color 0x003cff --title "監視サーバーを起動しました。" --username "${bot_name}" --webhook-url "${webhook}"
while :
do
	if [ $(($((`date +%s%3N`)) - $last_time)) -ge 30000 ]; then
		online=`curl https://api.mcsrvstat.us/bedrock/2/${server} -sS | jq '.online'`
		last_time=$((`date +%s%3N`))
	fi
	if [ $online = "true" ]; then
		if [ $old_ping = "offline" ]; then
			echo "オンライン復帰検知"
			old_ping="online"
			./discord.sh --color 0x32f224 --title "サーバーがオンラインに復帰しました" --webhook-url "${webhook}" --username "${bot_name}"
		fi
	else
		if [ $old_ping = "online" ]; then
			echo "ダウン検知"
			old_ping="offline"
			./discord.sh --color 0xf71414 --title "サーバーがダウンしました。" --webhook-url "${webhook}" --username "${bot_name}"
		fi
	fi
	if [ $(($((`date +%s%3N`)) - $(($cycle_message)))) -ge $(($((`jq '."Regularly Message".cycle' ./config.json`)) * 60000)) ] && [ `jq '."Regularly Message".enabled' ./config.json` = true ]; then
 		cycle_message=$(($((`date +%s%3N`))))
 		text=`date`
 		./discord.sh --color 0x5fd5d9 --title "監視サーバーはオンラインです。" --description "(${text})" --webhook-url "${webhook}" --username "${bot_name}"
	fi
done
