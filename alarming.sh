#!/bin/bash
. creds.sh
curl -s -X POST -H 'Content-Type:application/json' -d'{"params": {"password": "'$PASS'", "user": "'$LOGIN'"}, "jsonrpc": "2.0", "method": "user.login", "id": 0}' https://zabbix.merchantry.net/api_jsonrpc.php| jq .result| while read AUTH
do  
curl -s -X POST -H 'Content-Type:application/json' -d'{"params": {"only_true": true, "monitored": true, "filter": {"value": 1}, "withLastEventUnacknowledged": true, "groupids": {"groupid": 32}, "output": "extend", "expandData": true}, "jsonrpc": "2.0", "method": "trigger.get", "auth": '$AUTH', "id": 1}' https://zabbix.merchantry.net/api_jsonrpc.php|jq .result[].priority|grep 5 && mpg321 -o oss  -a /dev/dsp1 /tmp/high.mp3
curl -s -X POST -H 'Content-Type:application/json' -d'{"params": {"only_true": true, "monitored": true, "filter": {"value": 1}, "withLastEventUnacknowledged": true, "groupids": {"groupid": 32}, "output": "extend", "expandData": true}, "jsonrpc": "2.0", "method": "trigger.get", "auth": '$AUTH', "id": 2}' https://zabbix.merchantry.net/api_jsonrpc.php|jq .result[].priority|grep 4 && mpg321 -o oss  -a /dev/dsp1 /tmp/high.mp3
done && mpg321 -o oss  -a /dev/dsp1 /tmp/dog.mp3
