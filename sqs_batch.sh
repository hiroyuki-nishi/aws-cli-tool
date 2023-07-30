#!/bin/bash
# SQSキューのURLを指定してください
QUEUE_URL=""

function send_messages {
  # 関数内で $@ を使用して引数の配列にアクセス
  local my_array=("$@")
  local entries=()

  # 配列の要素を表示
  for i in "${my_array[@]}"; do
    echo "----------START----------"
    data=(${i[@]})
    for x in "${data[@]}"; do
       entry="{\"Id\":\"${x[0]}\",\"MessageBody\":\"TEST!!!\"}"
       entries+=("$entry")
    done
    echo ${entries[@]}
    aws sqs send-message-batch --queue-url "$QUEUE_URL" --entries "${entries[@]}" --region ap-northeast-1 >/dev/null 2>&1
    entries=()
    echo "----------END----------"
  done
}

array1=($(seq 1 100))
splitArray=()
total_elements=${#array1[@]}

for ((i = 0; i < total_elements; i += 10)); do
  slice=("${array1[@]:i:10}")
  # スライスされた配列を文字列に変換して追加
  splitArray+=("$(IFS=' '; echo "${slice[*]}")")
done

# 分割後の配列を表示（デバッグ用）
for ((i = 0; i < ${#splitArray[@]}; i++)); do
  send_messages "${splitArray[@]}"
done
